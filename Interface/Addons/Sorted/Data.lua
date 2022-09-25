local _, S = ...

S.DataTooltip = CreateFrame("GameTooltip", "SortedDataTooltip", nil, "GameTooltipTemplate")
S.DataTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

local playerGUID = UnitGUID("player")

-- Custom item subclass IDs to add additional categorisation over Blizzard's
S.CONDUIT_SUBCLASSID = 100
S.ANIMA_SUBCLASSID = 101

-- One data table to hold them all, one table to find them, one table to bring them all, and in the darkness bind them.
Sorted_Data = {}

function Sorted_GetBankCached() 
    if not Sorted_Data[Sorted_SelectedPlayerGUID] then return false end
    return not Sorted_Data[Sorted_SelectedPlayerGUID].bankNotCached 
end
function Sorted_SetBankCached() Sorted_Data[playerGUID].bankNotCached = nil end
function Sorted_GetReagentUnlocked() return not Sorted_Data[Sorted_SelectedPlayerGUID].reagentNotUnlocked end
function Sorted_SetReagentUnlocked() Sorted_Data[playerGUID].reagentNotUnlocked = nil end

local function Sorted_GetDataWrapped(guid)
    local data = Sorted_Data[guid]
    if not data then return nil end

    -- Ensure data tables exist for more recent Sorted features
    if not data.trashItems then data.trashItems = {} end
    if not data.equipSets then data.equipSets = {} end
    return data
end

function Sorted_GetData(guid)
    if not guid then
        return Sorted_GetDataWrapped(Sorted_SelectedPlayerGUID)
    else 
        return Sorted_GetDataWrapped(guid)
    end
end

function Sorted_DeleteData(guid)
    Sorted_Data[guid] = nil
end

function Sorted_InitialiseData()
    if not Sorted_Data[playerGUID] then
        Sorted_Data[playerGUID] = {}
        Sorted_Data[playerGUID].bankNotCached = true
        Sorted_Data[playerGUID].containers = {}
        for bag = BANK_CONTAINER, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
            if not Sorted_Data[playerGUID].containers[bag] then
                Sorted_Data[playerGUID].containers[bag] = {}
                for slot = 1, 36 do
                    Sorted_Data[playerGUID].containers[bag][slot] = {}
                end
            end
        end
        if not Sorted_IsClassic() then
            Sorted_Data[playerGUID].containers[REAGENTBANK_CONTAINER] = {}
            for slot = 1, 98 do
                Sorted_Data[playerGUID].containers[REAGENTBANK_CONTAINER][slot] = {}
            end
        end
        Sorted_Data[playerGUID].containers[-4] = {}
        for slot = 1, NUM_BANKBAGSLOTS do
            Sorted_Data[playerGUID].containers[-4][slot] = {}
        end
        Sorted_Data[playerGUID].favoritedItems = {}
    end
    if not Sorted_Data[playerGUID].trashItems then
        Sorted_Data[playerGUID].trashItems = {}
    end
    -- Check these fields individually for characters which last loaded an older version of the addon
    if not Sorted_Data[playerGUID].timeItemsAdded then
        Sorted_Data[playerGUID].timeItemsAdded = {}
    end
    if not Sorted_Data[playerGUID].newItems then
        Sorted_Data[playerGUID].newItems = {}
    end
    if not Sorted_Data[playerGUID].equipSets then
        Sorted_Data[playerGUID].equipSets = {}
    end
    if Sorted_Data[playerGUID].categories then
        Sorted_Data[playerGUID].categories = nil
    end
    if not Sorted_Data[playerGUID].settingsProfile then
        --Sorted_Data[playerGUID].settingsProfile = Sorted_CreateNewSettingsProfile()
    end
end

function Sorted_LoadData()
    Sorted_Data[playerGUID].lastLogged = time()
    Sorted_Data[playerGUID].name = UnitName("player")
    Sorted_Data[playerGUID].level = UnitLevel("player")
    _, _, Sorted_Data[playerGUID].race = UnitRace("player")
    Sorted_Data[playerGUID].faction = UnitFactionGroup("player")
    Sorted_Data[playerGUID].realm = GetRealmName()
    _, Sorted_Data[playerGUID].class = UnitClass("player")
    if not Sorted_IsClassic() and not IsReagentBankUnlocked() then
        Sorted_Data[playerGUID].reagentNotUnlocked = true
    else
        Sorted_Data[playerGUID].reagentNotUnlocked = nil
    end
    
    -- Clear characters after 1 month of inactivity, or if they have the same name as the current character. The alt is probably deleted
    local toDelete = {}
    for GUID, v in pairs(Sorted_Data) do
        if GUID ~= playerGUID then
            if ((v.lastLogged and time() - v.lastLogged > 2678400) or (v.name == UnitName("player") and v.realm == GetRealmName())) then
                table.insert(toDelete, GUID)
            end
        end
    end
    for k, GUID in pairs(toDelete) do
        Sorted_DeleteData(GUID)
    end

    -- Calculate total Alliance and Horde money on each realm, excluding the currently logged character since its money can change
    Sorted_totalMoney = {}
    for GUID, v in pairs(Sorted_Data) do
        if v.realm then
            if not Sorted_totalMoney[v.realm] then
                Sorted_totalMoney[v.realm] = {}
                Sorted_totalMoney[v.realm].alliance = 0
                Sorted_totalMoney[v.realm].horde = 0
            end
            if GUID ~= playerGUID then
                if v.faction == "Alliance" then
                    Sorted_totalMoney[v.realm].alliance = Sorted_totalMoney[v.realm].alliance + v.money
                else
                    Sorted_totalMoney[v.realm].horde = Sorted_totalMoney[v.realm].horde + v.money
                end
            end
        end
    end

    -- Load sorting buttons
    if not Sorted_enabledColumns.version then
        Sorted_enabledColumns.version = 0
    end
    if Sorted_enabledColumns.version < 102023 then
        Sorted_enabledColumns[SORTED_SORTBUTTON_UPGRADE] = true
        Sorted_enabledColumns.version = 102023
    end
    local count = 0
    for i,v in ipairs(Sorted_sortButtons) do
        if Sorted_enabledColumns[v.uniqueID] and v:Enabled() then
            Sorted_EnableSortButton(v.uniqueID)
        else
            Sorted_DisableSortButton(v.uniqueID)
        end
        if Sorted_sortButtonOrder[v.uniqueID] then
            count = count + 1
        end
    end
    for i,v in ipairs(Sorted_sortButtons) do
        if not Sorted_sortButtonOrder[v.uniqueID] then
            count = count + 1
            Sorted_sortButtonOrder[v.uniqueID] = count
        end
    end
    table.sort(Sorted_sortButtons, function(a,b)
        return Sorted_sortButtonOrder[a.uniqueID] < Sorted_sortButtonOrder[b.uniqueID]
    end)
    Sorted_GetSortButton(SORTED_SORTBUTTON_ICON).width = Sorted_GetSetting("iconSize") * 1.1
    Sorted_GetSortButton(SORTED_SORTBUTTON_FAVORITES).width = Sorted_GetSetting("iconSize") * 1.1
    Sorted_UpdateSortButtons()

    -- Load settings
    Sorted_ReloadAllSettings()
end

function Sorted_UpdateBagContents(container, dontUpdateTimes)
    -- Bags
    for k, bagID in pairs(Sorted_ContainersOfType("BAGS")) do 
        if not container or bagID == container then
            for slotID = 1, 36 do
                SortedContainerItemInfo_Update(bagID, slotID)
            end
        end
    end
    -- Container buttons
    for i = 1, NUM_BAG_SLOTS do
        local slotID = -NUM_BAG_SLOTS + i
        SortedContainerItemInfo_Update(0, slotID)
    end

    -- Bank
    if Sorted_bankIsOpened then
        for k, bagID in pairs(Sorted_ContainersOfType("BANK")) do 
            if not container or bagID == container then
                for slotID = 1, 36 do
                    SortedContainerItemInfo_Update(bagID, slotID)
                end
            end
        end
        -- Container buttons
        for slotID = 1, NUM_BANKBAGSLOTS do
            SortedContainerItemInfo_Update(-4, slotID)
        end
    end

    -- Reagent bank
    if not Sorted_IsClassic() then
        if not container or REAGENTBANK_CONTAINER == container then
            for slotID = 1, 98 do
                SortedContainerItemInfo_Update(REAGENTBANK_CONTAINER, slotID)
            end
        end

    -- Keyring
    else
        if not container or KEYRING_CONTAINER == container then
            for slotID = 1,32 do
                SortedContainerItemInfo_Update(KEYRING_CONTAINER, slotID)
            end
        end
    end
    
    -- Update number of slots
    local slots, freeSlots = 0, 0
    for k, bagID in pairs(Sorted_ContainersOfType("BAGS")) do 
        slots = slots + GetContainerNumSlots(bagID)
        freeSlots = freeSlots + GetContainerNumFreeSlots(bagID)
    end
    Sorted_Data[playerGUID].bagsUsedSlots = slots - freeSlots
    Sorted_Data[playerGUID].bagsNumSlots = slots
    if Sorted_bankIsOpened then
        slots, freeSlots = 0, 0
        for k, bagID in pairs(Sorted_ContainersOfType("BANK")) do 
            slots = slots + GetContainerNumSlots(bagID)
            freeSlots = freeSlots + GetContainerNumFreeSlots(bagID)
        end
        Sorted_Data[playerGUID].bankUsedSlots = slots - freeSlots
        Sorted_Data[playerGUID].bankNumSlots = slots
        if not Sorted_IsClassic() then
            Sorted_Data[playerGUID].reagentUsedSlots = 
                GetContainerNumSlots(REAGENTBANK_CONTAINER) - GetContainerNumFreeSlots(REAGENTBANK_CONTAINER)
            Sorted_Data[playerGUID].reagentNumSlots = GetContainerNumSlots(REAGENTBANK_CONTAINER)
        end
    end

    -- Update time items added
    if not (dontUpdateTimes) then
        C_Timer.After(0.05, function() 
            Sorted_UpdateTimeItemsAdded() 
            Sorted_SortItems()
        end)
    end

    -- Update equipment sets
    Sorted_UpdateEquipmentSets()
end

function Sorted_UpdateTimeItemsAdded()
    -- Populate a new table
    local currentItems = {}
    local function UpdateItemCount(key, count)
        if currentItems[key] then
            currentItems[key].count = currentItems[key].count + count
        else
            currentItems[key] = { ["count"] = count }
        end
    end
    for k, bag in pairs(Sorted_ContainersOfType("ALL")) do
        local numSlots = 36
        if bag == REAGENTBANK_CONTAINER then
            numSlots = 98
        end
        for slot = 1, numSlots do
            local info = Sorted_GetContainerItemInfo(bag, slot, playerGUID)
            if info.link then
                UpdateItemCount(Sorted_ItemKey(info.link), info.count)
            end
        end
    end
    for invID = 1, 23 do
        local link = GetInventoryItemLink("player", invID)
        --local link = GetInventoryItemID("player", invID)
        if link then
            UpdateItemCount(Sorted_ItemKey(link), 1)
        end
    end
    -- Compare item counts with the older table in player data. If an item count has increased, update the time
    local previousItems = Sorted_GetData(playerGUID).timeItemsAdded
    local newItems = Sorted_GetData(playerGUID).newItems
    Sorted_newItemsPerCategory = {}
    local markedForDelete = {}
    for link, item in pairs(previousItems) do
        if currentItems[link] then
            if currentItems[link].count > item.count then
                item.time = time()
                if not newItems[link] then
                    newItems[link] = currentItems[link].count - item.count
                else
                    newItems[link] = newItems[link] + currentItems[link].count - item.count
                end
            end
            item.count = currentItems[link].count
        else
            table.insert(markedForDelete, link)
        end
    end
    for k,v in pairs(markedForDelete) do previousItems[v] = nil end
    -- Add any new items to the player data
    for link, item in pairs(currentItems) do
        if not previousItems[link] then
            previousItems[link] = {
                ["count"] = item.count,
                ["time"] = time()
            }
            newItems[link] = item.count
        end
    end
    -- Update slot frames. Usually slot frames are updated in SortedItemButton_Update(), but in this case,
    -- all of the timeAddedStrings need to be updated simultaneously to keep the order correct
    local tabEnabled = Sorted_enabledColumns[SORTED_SORTBUTTON_ADDED]
    if not S.IsCurrentPlayerSelected() then
        local data = Sorted_GetData()
        if not data.timeItemsAdded then data.timeItemsAdded = {} end
        previousItems = data.timeItemsAdded
    end
    for _, itemList in pairs(Sorted_itemLists) do
        for l, itemButton in pairs(itemList.itemButtons) do
            local itemData = itemButton:GetData()
            if itemData.link then
                local key = Sorted_ItemKey(itemData.link)
                if previousItems[key] then
                    itemData.timeAdded = previousItems[key].time
                    local timeDif = time() - previousItems[key].time
                    itemButton.timeAddedString:SetText(Sorted_FormatTime(timeDif))
                    local alpha = 1 / (1 + timeDif / 10000)
                    alpha = 0.4 + alpha * 0.6
                    itemButton.timeAddedString:SetAlpha(alpha)
                    if tabEnabled then
                        itemButton.timeAddedString:Show()
                    else
                        itemButton.timeAddedString:Hide()
                    end
                else
                    itemButton.timeAddedString:Hide()
                end
            end
        end
    end
    Sorted_UpdateItemButtons()
    Sorted_UpdateNewItemsPerCategory()
end

local function OnDataAvailable(bag, slot, guid)
    local self
    if not guid then
        self = Sorted_GetContainerItemInfo(bag, slot, playerGUID)
        if bag ~= KEYRING_CONTAINER then
            self.texture, self.count, _, self.quality, _, _, 
                self.link, _, self.hasNoValue, self.itemID = GetContainerItemInfo(bag, slot)
        else
            local invSlotID = KeyRingButtonIDToInvSlotID(slot)
            self.texture, self.count, self.quality, self.link, self.hasNoValue, self.itemID =
                GetInventoryItemTexture("player", invSlotID),
                GetInventoryItemCount("player", invSlotID),
                GetInventoryItemQuality("player", invSlotID),
                GetInventoryItemLink("player", invSlotID),
                false,
                GetInventoryItemID("player", invSlotID)
        end
    else
        self = Sorted_GetContainerItemInfo(bag, slot, guid)
    end

    if not self.categories then
        self.categories = {}
    end

    if self.itemID then
        if not Sorted_IsClassic() and C_Item.IsItemKeystoneByID(self.itemID) then -- Mythic Keystone
            self.minLevel = 60
            self.equipLoc = nil
            self.value = 0
            self.classID = LE_ITEM_CLASS_MISCELLANEOUS
            self.subClassID = LE_ITEM_MISCELLANEOUS_REAGENT
            self.bindType = 1
            self.expacID = 8
            self.quality = 8
            if not guid then
                self.level = C_MythicPlus.GetOwnedKeystoneLevel()
                local mapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
                if (not mapID) then
                    mapID = C_MythicPlus.GetOwnedKeystoneMapID()
                end
                if (mapID) then
                    local name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(mapID)
                    if (name) then
                        self.name = string.format(Sorted.Localize("ITEM_MYTHIC_KEYSTONE"), name.." ("..self.level..")")
                    else
                        self.name = Sorted.Localize("ITEM_UNKNOWN_KEYSTONE")
                    end
                else
                    self.name = Sorted.Localize("ITEM_UNKNOWN_KEYSTONE")
                end
            else
                self.level = 1
                self.name = Sorted.Localize("ITEM_UNKNOWN_KEYSTONE")
            end
            self.effectiveILvl = self.level
        else
            self.name = nil
            if self.link then
                self.name, _, _, self.level, self.minLevel, _, _, _, self.equipLoc,
                _, self.value, self.classID, self.subClassID, self.bindType, self.expacID = GetItemInfo(self.link)
            end
            if not self.name then
                self.name, _, _, self.level, self.minLevel, _, _, _, self.equipLoc,
                _, self.value, self.classID, self.subClassID, self.bindType, self.expacID = GetItemInfo(self.itemID)
                self.effectiveILvl = self.level
            else
                self.effectiveILvl = GetDetailedItemLevelInfo(self.link)
            end
            if not self.expacID then
                self.expacID = 0
            elseif self.expacID > 253 then
                self.expacID = self.expacID - 254
            end
            if not Sorted_IsClassic() then
                if C_Soulbinds.IsItemConduitByItemInfo(self.link) then
                    self.subClassID = S.CONDUIT_SUBCLASSID
                end
            end
        end
        self.type = nil

        if not guid then
            local item = ItemLocation:CreateFromBagAndSlot(bag, slot)
            self.bound = C_Item.IsBound(item)

            if self.itemID == 82800 then -- Pet cages
                if bag == BANK_CONTAINER  then
                    _, _, _, self.speciesID, self.level, _, _, _, _, self.name = GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(slot))
                elseif (not Sorted_IsClassic() and bag == REAGENTBANK_CONTAINER) then
                    _, _, _, self.speciesID, self.level, _, _, _, _, self.name = GameTooltip:SetInventoryItem("player", ReagentBankButtonIDToInvSlotID(slot))
                else
                    _, _, self.speciesID, self.level, _, _, _, _, self.name = GameTooltip:SetBagItem(bag, slot);
                end
                _, self.texture, self.subClassID = C_PetJournal.GetPetInfoBySpeciesID(self.speciesID)
                self.name = string.format(Sorted.Localize("ITEM_PET_CAGED"), self.name)
                self.effectiveILvl = self.level
            else
                self.speciesID, self.cageName = nil, nil
            end
        end

        --Sorted Categories
        local categories = Sorted_GetSetting("categories")
        for categoryID, category in ipairs(categories) do
            if Sorted_CategoryFilter(categoryID, self, true) then
                self.categories[categoryID] = 1
            else
                self.categories[categoryID] = 0
            end
        end
    end
    return self.itemID
end

function SortedContainerItemInfo_Update(bag, slot, guid)
    local item = Item:CreateFromBagAndSlot(bag, slot)
    if item:IsItemDataCached() then
        OnDataAvailable(bag, slot, guid)
    else
        item:ContinueOnItemLoad(function()
            local itemID = OnDataAvailable(bag, slot, guid)
            Sorted_UpdateItemButtons(nil, itemID)
        end)
    end
end

-- Returns a reference to a table with elements: texture, count, quality, link, hasNoValue, itemID
function Sorted_GetContainerItemInfo(bag, slot, guid)
    local data = Sorted_GetData(guid)
    if not data.containers[bag] then data.containers[bag] = {} end
    if not data.containers[bag][slot] then data.containers[bag][slot] = {} end
    data.containers[bag][slot].bag = bag
    data.containers[bag][slot].slot = slot
    return data.containers[bag][slot]
end

function Sorted_GetNumSlots(type, guid)
    local data = Sorted_GetData(guid)
    if not data then return 0,0 end
    return data[type:lower().."UsedSlots"], data[type:lower().."NumSlots"]
end

function Sorted_UpdateEquipmentSets()
    if Sorted_WoWMajorVersionNumber() >= 3 then
        local data = Sorted_GetData(playerGUID)
        for id, _ in pairs(data.equipSets) do
            data.equipSets[id].deleted = true
        end
        for _, id in pairs(C_EquipmentSet.GetEquipmentSetIDs()) do
            if not data.equipSets[id] then
                data.equipSets[id] = {}
                data.equipSets[id].locations = {}
            end
            data.equipSets[id].deleted = nil
            data.equipSets[id].name, data.equipSets[id].icon = C_EquipmentSet.GetEquipmentSetInfo(id)
            -- Clear current locations table, ignoring the bank if the player doesn't have it opened
            local toClear = {}
            for k,v in pairs(data.equipSets[id].locations) do
                if Sorted_bankIsOpened or not v.bag or v.bag <= NUM_BAG_SLOTS then
                    table.insert(toClear, k)
                end
            end
            for _,k in pairs(toClear) do
                data.equipSets[id].locations[k] = nil
            end
            -- Populate locations table
            local itemLocations = C_EquipmentSet.GetItemLocations(id)
            if itemLocations then
                for _, location in pairs(itemLocations) do
                    local player, bank, bags, voidStorage, slot, bag
                    if Sorted_WoWMajorVersionNumber() == 3 then
                        player, bank, bags, slot, bag = EquipmentManager_UnpackLocation(location)
                    else
                        player, bank, bags, voidStorage, slot, bag = EquipmentManager_UnpackLocation(location)
                    end
                    if (bags or bank) and bag ~= nil then
                        table.insert(data.equipSets[id].locations, {
                            ["bag"] = bag,
                            ["slot"] = slot
                        })
                    end
                end
            end
        end
        -- Clear deleted equipment sets
        local toClear = {}
        for id, equipSet in pairs(data.equipSets) do
            if equipSet.deleted then
                table.insert(toClear, id)
            end
        end
        for _, id in pairs(toClear) do
            data.equipSets[id] = nil
        end
        -- Toggle the equipment sets dropdown button
        SortedEquipmentSetsDropdownButton_Update()
    end
end

-- Takes itemData and return a number, 0 for grey, 1 for manually marked trash, 2 for not-grey or marked not-trash
function Sorted_GetTrash(itemData)
    local data = Sorted_GetData()
    if not data.trashItems then
        data.trashItems = {}
    end
    if data.trashItems[itemData.itemID] then
        return data.trashItems[itemData.itemID]
    elseif itemData.quality == 0 then
        return 0
    else
        return 2
    end
end
function Sorted_ToggleTrash(itemData)
    local data = Sorted_GetData()
    if not data.trashItems then
        data.trashItems = {}
    end
    if data.trashItems[itemData.itemID] then
        if data.trashItems[itemData.itemID] == 1 then
            data.trashItems[itemData.itemID] = 2
        else
            data.trashItems[itemData.itemID] = 1
        end
    else
        if itemData.quality == 0 then
            data.trashItems[itemData.itemID] = 2
        else
            data.trashItems[itemData.itemID] = 1
        end
    end
end

-- Takes itemData and returns a number 1-8 for the raid marker icon, or nil if none
function Sorted_GetFavorited(itemData)
    local data = Sorted_GetData()
    -- Convert to new table key format
    if data.favoritedItems[itemData.itemID] then
        data.favoritedItems[Sorted_ItemKey(itemData.link)] = data.favoritedItems[itemData.itemID]
        data.favoritedItems[itemData.itemID] = nil
    end

    if itemData.link then
        return data.favoritedItems[Sorted_ItemKey(itemData.link)]
    end
    return nil
end

function Sorted_ToggleFavorite(itemData, value)
    local key = Sorted_ItemKey(itemData.link)
    local data = Sorted_GetData()
    if data.favoritedItems[key] then
        if value then
            data.favoritedItems[key] = value
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        else
            data.favoritedItems[key] = data.favoritedItems[key] + 1
            if data.favoritedItems[key] > 8 then
                data.favoritedItems[key] = nil
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
            else
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            end
        end
    else
        if value then
            data.favoritedItems[key] = value
        else
            data.favoritedItems[key] = 1
        end
        PlaySound(SOUNDKIT.IG_CHAT_SCROLL_UP)
    end
end

function Sorted_Unfavorite(itemData)
    local key = Sorted_ItemKey(itemData.link)
    Sorted_GetData().favoritedItems[key] = nil
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
end