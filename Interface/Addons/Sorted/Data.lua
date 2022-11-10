local _, S = ...
local pairs, ipairs, string, type, time = pairs, ipairs, string, type, time

-- Use new APIs
local useNewContainerAPI = false
local ContainerIDToInventoryID, GetContainerItemInfo, PickupContainerItem, GetContainerNumSlots, GetContainerNumFreeSlots = ContainerIDToInventoryID, GetContainerItemInfo, PickupContainerItem, GetContainerNumSlots, GetContainerNumFreeSlots
if C_Container then
    if C_Container.ContainerIDToInventoryID then ContainerIDToInventoryID = C_Container.ContainerIDToInventoryID end
    if C_Container.GetContainerItemInfo then useNewContainerAPI = true; GetContainerItemInfo = C_Container.GetContainerItemInfo end
    if C_Container.PickupContainerItem then PickupContainerItem = C_Container.PickupContainerItem end
    if C_Container.GetContainerNumSlots then GetContainerNumSlots = C_Container.GetContainerNumSlots end
    if C_Container.GetContainerNumFreeSlots then GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots end
end

S.Data = {}

S.DataTooltip = CreateFrame("GameTooltip", "SortedDataTooltip", nil, "GameTooltipTemplate")
S.DataTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

local playerGUID = UnitGUID("player")
local totalMoney = {}
function S.Data.GetTotalMoney()
    return totalMoney
end

local INVENTORY_IDS_TO_UPDATE = {}
local BANK_INVENTORY_IDS = {}
for _, containerID in pairs(S.Utils.ContainersOfType("ALL")) do
    if containerID ~= BACKPACK_CONTAINER and containerID ~= BANK_CONTAINER and containerID ~= REAGENTBANK_CONTAINER and containerID ~= KEYRING_CONTAINER then
        table.insert(INVENTORY_IDS_TO_UPDATE, ContainerIDToInventoryID(containerID))
    end
end
for _, containerID in pairs(S.Utils.ContainersOfType("BANK")) do
    if containerID ~= BANK_CONTAINER then
        BANK_INVENTORY_IDS[ContainerIDToInventoryID(containerID)] = true
    end
end

-- Converts item link into a key for the data table
function S.Data.ItemKey(itemLink)
    if string.find(itemLink, "|Hitem") then
        local a,b = string.match(itemLink, "|Hitem:(%d*:)[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:(.-)|h")
        return a..b
    else
        local a = string.match(itemLink, "|H(.-)|h")
        return a
    end
end
local ItemKey = S.Data.ItemKey



-- One data table to hold them all, one table to find them, one table to bring them all, and in the darkness bind them.
Sorted_Data = {}
local sortedData = Sorted_Data -- Make local for performance. This table gets used a lot


-- Player selection
local selectedCharacterGUID = UnitGUID("player")
function S.GetSelectedCharacter()
    return selectedCharacterGUID
end
function S.SelectCharacter(guid)
    selectedCharacterGUID = guid
    S.Utils.TriggerEvent("CharacterSelected")
end
function S.IsPlayingCharacterSelected()
    return selectedCharacterGUID == UnitGUID("player")
end

-- Equipment set selection
local selectedEquipmentSetID = -1 -- -1 for no selection, -2 to filter items not in any equipment set
function S.GetSelectedEquipmentSet()
    return selectedEquipmentSetID
end
function S.SelectEquipmentSet(id)
    selectedEquipmentSetID = id
    S.Utils.TriggerEvent("EquipmentSetSelected")
end


-- Return the data table for a player
local function GetData(guid)
    if not guid then
        return sortedData[selectedCharacterGUID]
    else 
        return sortedData[guid]
    end
end
function S.GetData(guid)
    return GetData(guid)
end

function S.Data.DeleteCharacter(guid)
    if S.GetSelectedCharacter() == guid then
        S.SelectCharacter(UnitGUID("player"))
    end
    sortedData[guid] = nil
end

-- On login, creates the data table if the current player is new
local function InitialiseData()
    if not sortedData[playerGUID] then
        sortedData[playerGUID] = {}
        sortedData[playerGUID].bankNotCached = true
        sortedData[playerGUID].containers = {}
        sortedData[playerGUID].favoritedItems = {}
    end
    -- Check these fields individually for characters which last loaded an older version of the addon
    if not sortedData[playerGUID].trashItems then
        sortedData[playerGUID].trashItems = {}
    end
    if not sortedData[playerGUID].currencies then
        sortedData[playerGUID].currencies = {}
    end
    if not sortedData[playerGUID].favoritedCurrencies then
        sortedData[playerGUID].favoritedCurrencies = {}
    end
    if not sortedData[playerGUID].timeItemsAdded then
        sortedData[playerGUID].timeItemsAdded = {}
    end
    if not sortedData[playerGUID].newItems then
        sortedData[playerGUID].newItems = {}
    end
    if not sortedData[playerGUID].equipSets then
        sortedData[playerGUID].equipSets = {}
    end
    if not sortedData[playerGUID].containerNumSlots then
        sortedData[playerGUID].containerNumSlots = {}
    end
    if not sortedData[playerGUID].inventoryItems then
        sortedData[playerGUID].inventoryItems = {}
    end
end
-- Updates any info available on login
local function UpdatePlayerData()
    local playerData = sortedData[playerGUID]
    playerData.lastLogged = time()
    playerData.name = UnitName("player")
    playerData.level = UnitLevel("player")
    _, _, playerData.race = UnitRace("player")
    playerData.faction = UnitFactionGroup("player")
    playerData.realm = GetRealmName()
    _, playerData.class = UnitClass("player")
    if S.WoWVersion() >= 6 and not IsReagentBankUnlocked() then
        playerData.reagentNotUnlocked = true
    else
        playerData.reagentNotUnlocked = nil
    end
end

local function UpdateCurrencies()
    if S.WoWVersion() > 1 then
        local i = 1
        local headingInfo

        -- Classic doesn't use the new C_CurrencyInfo namespace
        if not C_CurrencyInfo.GetCurrencyListSize then
            -- Iterate through the currency list, updating the currency table in sortedData
            while i <= GetCurrencyListSize() do
                local name, isHeader, isExpanded, isUnused, isWatched, count, icon, maximum, hasWeeklyLimit, currentWeeklyAmount, unknown, currencyID = GetCurrencyListInfo(i)
                if isHeader then
                    if not isExpanded then
                        ExpandCurrencyList(i, true)
                    end
                    headingInfo = name
                else
                    local currencyLink = GetCurrencyListLink(i)
                    local currenciesTable = GetData(playerGUID).currencies
                    if not currenciesTable[currencyID] then
                        currenciesTable[currencyID] = {}
                    end
                    local data = currenciesTable[currencyID]
                    data.id = currencyID
                    data.name = name
                    data.texture = icon
                    data.quality = 1
                    data.count = count
                    data.maxQuantity = maximum
                    data.canEarnPerWeek = hasWeeklyLimit
                    data.maxWeeklyQuantity = maxWeeklyQuantity -- TODO
                    data.quantityEarnedThisWeek = currentWeeklyAmount
                    data.heading = headingInfo
                end
                i = i + 1
            end


        -- Retail
        else
            -- Iterate through the currency list, updating the currency table in sortedData
            while i <= C_CurrencyInfo.GetCurrencyListSize() do
                local currencyInfo = C_CurrencyInfo.GetCurrencyListInfo(i)
                if currencyInfo.isHeader then -- It's a header, so make sure it's expanded before continuing through the list
                    if not currencyInfo.isHeaderExpanded then
                        C_CurrencyInfo.ExpandCurrencyList(i, true)
                    end
                    headingInfo = currencyInfo
                else -- It's not a header, so it's actually a currency! Update the data table, using the currencyID as the table key
                    local currencyLink = C_CurrencyInfo.GetCurrencyListLink(i)
                    local currencyID = C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink)
                    local currenciesTable = GetData(playerGUID).currencies
                    if not currenciesTable[currencyID] then
                        currenciesTable[currencyID] = {}
                    end
                    --S.Utils.PrintTable(currencyInfo)
                    local data = currenciesTable[currencyID]
                    data.id = currencyID
                    data.name = currencyInfo.name
                    data.texture = currencyInfo.iconFileID
                    data.quality = currencyInfo.quality
                    data.count = currencyInfo.quantity
                    data.maxQuantity = currencyInfo.maxQuantity
                    data.canEarnPerWeek = currencyInfo.canEarnPerWeek
                    data.maxWeeklyQuantity = currencyInfo.maxWeeklyQuantity
                    data.quantityEarnedThisWeek = currencyInfo.quantityEarnedThisWeek
                    data.heading = headingInfo.name
                end
                i = i + 1
            end
        end
    end
    S.Utils.TriggerEvent("CurrenciesUpdated")
end
function S.Data.GetCurrency(currencyID)
    local data = GetData()
    if data.currencies then
        if data.currencies[currencyID] then
            return data.currencies[currencyID]
        end
    end
end

local function UpdateTimeItemsAdded()
    local time = time()
    local data = GetData(playerGUID)
    -- Make a table of every item in the player's bags
    local items = {}
    for _, bag in pairs(S.Utils.ContainersOfType("ALL")) do
        for slot = 1, S.Utils.GetContainerMaxSlots(bag) do
            local itemData = S.Data.GetItem(bag, slot, playerGUID)
            if itemData.link then
                local key = itemData.key
                if not items[key] then
                    items[key] = {}
                    items[key].time = time
                    items[key].count = itemData.count
                else
                    items[key].count = items[key].count + itemData.count
                end
            end
        end
    end
    -- Include equipment slots
    for invID = 1, 23 do
        local link = GetInventoryItemLink("player", invID)
        if link then
            local key = S.Data.ItemKey(link)
            if not items[key] then
                items[key] = {}
                items[key].time = time
                items[key].count = 1
            else
                items[key].count = items[key].count + 1
            end
        end
    end
    -- Replace times with any times from the existing table
    if data.timeItemsAdded then
        for key, timeItemAdded in pairs(data.timeItemsAdded) do
            if items[key] and items[key].count <= timeItemAdded.count then
                items[key].time = timeItemAdded.time
            end
        end
    end
    -- Replace with new table
    data.timeItemsAdded = items
end
function S.Data.GetItemAge(itemData)
    local key = itemData.key
    local timeItemAdded = GetData().timeItemsAdded[key]
    if timeItemAdded then
        return time() - timeItemAdded.time
    end
end

local function UpdateEquipmentSets()
    if S.WoWVersion() >= 3 then
        local data = GetData(playerGUID)
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
                if S.IsBankOpened() or not v.bag or v.bag <= NUM_BAG_SLOTS then
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
                    if S.WoWVersion() == 3 then
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
        --SortedEquipmentSetsDropdownButton_Update()
    end
    S.Utils.TriggerEvent("EquipmentSetsUpdated")
end

local function UpdateBagContents(container)
    -- Bags
    for k, bagID in pairs(S.Utils.ContainersOfType("BAGS")) do 
        if not container or bagID == container then
            for slotID = 1, S.Utils.MaxBagSlots() do
                S.Data.UpdateItem(bagID, slotID)
            end
        end
    end
    -- Container buttons
    --[[for i = 1, NUM_BAG_SLOTS do
        local slotID = -NUM_BAG_SLOTS + i
        S.Data.UpdateItem(0, slotID)
    end]]

    -- Bank
    if S.IsBankOpened() then
        GetData(playerGUID).bankNotCached = nil
        for k, bagID in pairs(S.Utils.ContainersOfType("BANK")) do 
            if not container or bagID == container then
                for slotID = 1, S.Utils.MaxBagSlots() do
                    S.Data.UpdateItem(bagID, slotID)
                end
            end
        end
        -- Container buttons
        for slotID = 1, NUM_BANKBAGSLOTS do
            S.Data.UpdateItem(-4, slotID)
        end
    end

    -- Reagent bank
    if S.WoWVersion() >= 6 and S.IsBankOpened() then
        if not container or REAGENTBANK_CONTAINER == container then
            for slotID = 1, 98 do
                S.Data.UpdateItem(REAGENTBANK_CONTAINER, slotID)
            end
        end
    end

    -- Keyring
    if S.WoWVersion() <= 3 then
        if not container or KEYRING_CONTAINER == container then
            for slotID = 1,32 do
                S.Data.UpdateItem(KEYRING_CONTAINER, slotID)
            end
        end
    end

    -- Inventory items
    for _, inventoryID in pairs(INVENTORY_IDS_TO_UPDATE) do
        if not BANK_INVENTORY_IDS[inventoryID] or S.IsBankOpened() then
            S.Data.UpdateInventoryItem(inventoryID)
        end
    end
    
    -- Update number of slots
    for k, bagID in pairs(S.Utils.ContainersOfType("ALL")) do
        if S.IsBankOpened() or not (S.Utils.ContainerIsType(bagID, "BANK") or S.Utils.ContainerIsType(bagID, "REAGENT")) then
            sortedData[playerGUID].containerNumSlots[bagID] = {
                ["numSlots"] = GetContainerNumSlots(bagID),
                ["numFreeSlots"] = GetContainerNumFreeSlots(bagID)
            }
        end
    end

    UpdateEquipmentSets()

    UpdateTimeItemsAdded()

    S.Utils.TriggerEvent("BagsUpdated")
end
S.Data.UpdateBagContents = UpdateBagContents

local function OnDataAvailable(bag, slot, inventory, guild)
    local self, newLink
    if inventory then
        self = S.Data.GetInventoryItem(bag, playerGUID)
        self.texture, self.count, self.quality, newLink, self.hasNoValue, self.itemID =
            GetInventoryItemTexture("player", bag),
            GetInventoryItemCount("player", bag),
            GetInventoryItemQuality("player", bag),
            GetInventoryItemLink("player", bag),
            false,
            GetInventoryItemID("player", bag)
    elseif guild then
        self = S.Data.GetGuildItem(bag, slot, playerGUID)
        self.texture, self.count, _, _, self.quality = GetGuildBankItemInfo(bag, slot)
        newLink = GetGuildBankItemLink(bag, slot)
    else
        self = S.Data.GetItem(bag, slot, playerGUID)
        if S.WoWVersion() >= 4 or bag ~= KEYRING_CONTAINER then
            if useNewContainerAPI then
                local t = GetContainerItemInfo(bag, slot)
                if t then
                    self.texture = t.iconFileID
                    self.count = t.stackCount
                    self.quality = t.quality
                    newLink = t.hyperlink
                    self.hasNoValue = t.hasNoValue
                    self.itemID = t.itemID
                else
                    self.texture, self.count, self.quality, newLink, self.hasNoValue, self.itemID = 
                        nil, nil, nil, nil, nil, nil
                end
            else
                self.texture, self.count, _, self.quality, _, _, 
                newLink, _, self.hasNoValue, self.itemID = GetContainerItemInfo(bag, slot)
            end
        else
            local invSlotID = KeyRingButtonIDToInvSlotID(slot)
            self.texture, self.count, self.quality, newLink, self.hasNoValue, self.itemID =
                GetInventoryItemTexture("player", invSlotID),
                GetInventoryItemCount("player", invSlotID),
                GetInventoryItemQuality("player", invSlotID),
                GetInventoryItemLink("player", invSlotID),
                false,
                GetInventoryItemID("player", invSlotID)
        end
    end

    -- Only update the key when the item changes
    if self.link ~= newLink then
        self.link = newLink
        if newLink then
            self.key = ItemKey(self.link)
        end
    end

    if not self.categories then
        self.categories = {}
    end

    if self.link then

        -- Replaced with self.invSlotID
        self.equipLoc = nil

        if S.WoWVersion() >= 7 and self.itemID and C_Item.IsItemKeystoneByID(self.itemID) then -- Mythic Keystone
            self.minLevel = 60
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
                        self.name = string.format(S.Localize("ITEM_MYTHIC_KEYSTONE"), name.." ("..self.level..")")
                    else
                        self.name = S.Localize("ITEM_UNKNOWN_KEYSTONE")
                    end
                else
                    self.name = S.Localize("ITEM_UNKNOWN_KEYSTONE")
                end
            else
                self.level = 1
                self.name = S.Localize("ITEM_UNKNOWN_KEYSTONE")
            end
            self.effectiveILvl = self.level
        else
            self.name = nil

            -- Get more info from the link using GetItemInfo
            self.name, _, _, self.level, self.minLevel, _, _, self.stackCount, _,
            _, self.value, self.classID, self.subClassID, self.bindType, self.expacID = GetItemInfo(self.link)

            -- If that didn't work, try using the itemID instead
            if not self.name then
                self.name, _, _, self.level, self.minLevel, _, _, self.stackCount, _,
                _, self.value, self.classID, self.subClassID, self.bindType, self.expacID = GetItemInfo(self.itemID)
                self.effectiveILvl = self.level
            else
                -- Get the actual item level, after any scaling is applied
                self.effectiveILvl = GetDetailedItemLevelInfo(self.link)
            end

            self.invSlotID = C_Item.GetItemInventoryTypeByID(self.link)

            if not self.expacID then
                self.expacID = 0
            elseif self.expacID > 253 then
                self.expacID = self.expacID - 254
            end
            --[[if S.WoWVersion() >= 9 and self.link then
                if C_Soulbinds.IsItemConduitByItemInfo(self.link) then
                    self.subClassID = S.CONDUIT_SUBCLASSID
                end
            end]]
        end
        self.type = nil

        self.isEquippable = IsEquippableItem(self.link)

        local item
        if inventory then
            item = ItemLocation:CreateFromEquipmentSlot(bag)
        else
            item = ItemLocation:CreateFromBagAndSlot(bag, slot)
        end
        if guild then
            self.bound = false
        else
            self.bound = C_Item.IsBound(item)
        end

        if self.itemID == 82800 then -- Pet cages
            if bag == BANK_CONTAINER  then
                _, _, _, self.speciesID, self.level, _, _, _, _, self.name = GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(slot))
            elseif (S.WoWVersion() >= 6 and bag == REAGENTBANK_CONTAINER) then
                _, _, _, self.speciesID, self.level, _, _, _, _, self.name = GameTooltip:SetInventoryItem("player", ReagentBankButtonIDToInvSlotID(slot))
            else
                _, _, self.speciesID, self.level, _, _, _, _, self.name = GameTooltip:SetBagItem(bag, slot);
            end
            _, self.texture, self.subClassID = C_PetJournal.GetPetInfoBySpeciesID(self.speciesID)
            self.name = string.format(S.Localize("ITEM_PET_CAGED"), self.name)
            self.effectiveILvl = self.level
        else
            self.speciesID, self.cageName = nil, nil
        end

        -- TODO:
        --Sorted Categories
        --[[local categories = S.Settings.Get("categories2")
        for categoryID, category in ipairs(categories) do
            if Sorted_CategoryFilter(categoryID, self, true) then
                self.categories[categoryID] = 1
            else
                self.categories[categoryID] = 0
            end
        end]]
    end
    return self.itemID
end

function S.Data.UpdateItem(bag, slot)
    local item = Item:CreateFromBagAndSlot(bag, slot)
    if item:IsItemDataCached() then
        OnDataAvailable(bag, slot)
    else
        item:ContinueOnItemLoad(function()
            local itemID = OnDataAvailable(bag, slot)
        end)
    end
end
function S.Data.UpdateInventoryItem(inventoryID)
    local item = Item:CreateFromEquipmentSlot(inventoryID)
    if item:IsItemDataCached() then
        OnDataAvailable(inventoryID, nil, true)
    else
        item:ContinueOnItemLoad(function()
            local itemID = OnDataAvailable(inventoryID, nil, true)
        end)
    end
end

-- Returns a reference to a table with elements: texture, count, quality, link, hasNoValue, itemID, key, bag, slot
function S.Data.GetItem(bag, slot, guid)
    local data = GetData(guid)
    if not data.containers[bag] then
        data.containers[bag] = {}
    end
    if not data.containers[bag][slot] then
        data.containers[bag][slot] = {}
    end
    local itemData = data.containers[bag][slot]
    itemData.bag = bag
    itemData.slot = slot
    if not itemData.key and itemData.link then
        itemData.key = ItemKey(itemData.link)
    end
    return itemData
end

-- Returns a reference to a table with elements: texture, count, quality, link, hasNoValue, itemID, key, bag, slot
function S.Data.GetInventoryItem(inventoryID, guid)
    local data = GetData(guid)
    if not data.inventoryItems then
        data.inventoryItems = {}
    end
    if not data.inventoryItems[inventoryID] then
        data.inventoryItems[inventoryID] = {}
    end
    local itemData = data.inventoryItems[inventoryID]
    if not itemData.key and itemData.link then
        itemData.key = ItemKey(itemData.link)
    end
    return itemData
end

-- Returns two numbers, number of filled slots of the given type, and total number available
function S.Data.GetNumSlots(type, guid)
    local data = GetData(guid)
    if not data then return 0,0 end
    return data[type:lower().."UsedSlots"], data[type:lower().."NumSlots"]
end

-- GUILD BANK FUNCTIONS
function S.Data.UpdateGuildInfo()
    local data = GetData(playerGUID)
    if not IsInGuild() then
        data.guild = nil
    else
        -- Initialise guild table
        if not data.guild then
            data.guild = {}
            data.guild.tabs = {}
            for i = 1, 8 do
                data.guild.tabs[i] = {}
                data.guild.tabs[i].slots = {}
                for slot = 1, 98 do
                    data.guild.tabs[i].slots[slot] = {
                        ["isGuild"] = true,
                        ["bag"] = i,
                        ["slot"] = slot
                    }
                end
            end
        end
        -- Update guild info
        data.guild.name, data.guild.rank, data.guild.rankID = GetGuildInfo("player")
    end
end
function S.Data.UpdateGuildMoney()
    local data = GetData(playerGUID)
    if data.guild then
        data.guild.money = GetGuildBankMoney()
        data.guild.withdrawLimit = GetGuildBankWithdrawMoney()
    end
end
local defaultTabIcon = "Interface\\Icons\\INV_Misc_QuestionMark"
local defaultTabNames = {"Tab 1","Tab 2","Tab 3","Tab 4","Tab 5","Tab 6","Tab 7","Tab 8"}
function S.Data.UpdateGuildBankTabs()
    local data = GetData(playerGUID)
    if data.guild then
        local guild = data.guild

        for i = 1, 8 do
            local name, icon, canView, canDeposit, numWithdrawals, remainingWithdrawals, filtered = GetGuildBankTabInfo(i)
            local tab = guild.tabs[i]
            -- Only update name and icon if the info is available
            if name == defaultTabNames[i] and icon == defaultTabIcon then
                if not tab.name then
                    -- Tab doesn't have a name or icon set anyway, so set them to the default values
                    tab.name, tab.icon = name, icon
                end
                tab.canView, tab.canDeposit, tab.numWithdrawals, tab.remainingWithdrawals, tab.filtered = canView, canDeposit, numWithdrawals, remainingWithdrawals, filtered
            else
                -- All info is available, update all of the tab data
                tab.name, tab.icon, tab.canView, tab.canDeposit, tab.numWithdrawals, tab.remainingWithdrawals, tab.filtered = 
                    name, icon, canView, canDeposit, numWithdrawals, remainingWithdrawals, filtered
            end
        end
    end
    S.Utils.TriggerEvent("GuildBankTabsUpdated")
end

function S.Data.UpdateGuildItem(tab, slot, link)
    if link then
        local item = Item:CreateFromItemLink(link)
        if item:IsItemDataCached() then
            OnDataAvailable(tab, slot, false, true)
        else
            item:ContinueOnItemLoad(function()
                OnDataAvailable(tab, slot, false, true)
            end)
        end
    else
        -- There's no item in this slot, so clear anything existing
        local data = S.Data.GetGuildItem(tab, slot, playerGUID)
        if data.link then
            GetData(playerGUID).guild.tabs[tab].slots[slot] = {
                ["isGuild"] = true,
                ["bag"] = tab,
                ["slot"] = slot
            }
        end
    end
end

-- Updating the guild bank completely requires querying the server. Don't do this too often.
function S.Data.UpdateGuildBank(tab)
    local data = GetData(playerGUID)

    if data.guild then
        local guild = data.guild


        -- Update one specific tab
        if tab then
            if guild.tabs[tab].canView then
                QueryGuildBankTab(tab)
            end


            local count = 0
            if guild.tabs[tab].canView then

                -- Figure out if tab is empty, or if the data isn't available yet
                local dataUnavailable = true
                local slot = 1
                while dataUnavailable and slot <= 98 do
                    if GetGuildBankItemLink(tab, slot) then
                        dataUnavailable = false
                    end
                    slot = slot + 1
                end
                if dataUnavailable then
                    -- No items found
                    -- Count the number of times the tab has updated and been empty
                    if not guild.tabs[tab].emptyUpdates then
                        guild.tabs[tab].emptyUpdates = 1
                    else
                        guild.tabs[tab].emptyUpdates = guild.tabs[tab].emptyUpdates + 1
                    end
                    -- If it's still empty after several (3) updates, give in, let it update already
                    if guild.tabs[tab].emptyUpdates > 3 then
                        guild.tabs[tab].emptyUpdates = nil
                        dataUnavailable = false
                    end
                end

                -- Update data
                if not dataUnavailable then
                    for slot = 1, 98 do
                        local link = GetGuildBankItemLink(tab, slot)
                        S.Data.UpdateGuildItem(tab, slot, link)
                        if link then
                            count = count + 1
                        end
                    end
                    guild.tabs[tab].count = count
                end

            else
                -- Can't be viewed
                guild.tabs[tab].count = 0
            end


        -- Update everything
        else
            for tab = 1, 8 do
                if guild.tabs[tab].canView then
                    QueryGuildBankTab(tab)
                end

                local count = 0
                if guild.tabs[tab].canView then
                    for slot = 1, 98 do
                        local link = GetGuildBankItemLink(tab, slot)
                        S.Data.UpdateGuildItem(tab, slot, link)
                        if link then
                            count = count + 1
                        end
                    end
                end
                guild.tabs[tab].count = count
            end
        end
    end
end
function S.Data.GetGuildItem(tab, slot, guid)
    local guild = GetData(guid).guild
    if not guild then
        return {}
    else
        return guild.tabs[tab].slots[slot]
    end
end


-- ITEM DATA FUNCTIONS
-- Takes itemData and return a number, 0 for grey, 1 for manually marked trash, 2 for not-grey or marked not-trash
function S.Data.GetTrash(itemData)
    local data = GetData()
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
function S.Data.ToggleTrash(itemData)
    local data = GetData()
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
function S.Data.GetFavorited(itemData)
    if itemData.key then
        local data = GetData()
        return data.favoritedItems[itemData.key]
    end
    return nil
end

function S.Data.ToggleFavorited(itemData, value)
    local key = itemData.key
    local data = GetData()
    if data.favoritedItems[key] then
        if value then
            data.favoritedItems[key] = value
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        else
            if data.favoritedItems[key] and data.favoritedItems[key] > 0 then
                data.favoritedItems[key] = nil
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
            else
                data.favoritedItems[key] = 1
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

function S.Data.Unfavorite(itemData)
    local key = itemData.key
    GetData().favoritedItems[key] = nil
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
end

-- CURRENCY FUNCTIONS
-- Takes currency and returns a number 1-8 for the raid marker icon, or nil if none
function S.Data.GetCurrencyFavorited(currency)
    local data = GetData()
    if data.favoritedCurrencies then
        return data.favoritedCurrencies[currency.id]
    end
end

function S.Data.ToggleCurrencyFavorited(currency, value)
    local key = currency.id
    local data = GetData()
    -- If viewing another character which was last played before Sorted 2.0, create a table for them
    if not data.favoritedCurrencies then 
        data.favoritedCurrencies = {}
    end
    if data.favoritedCurrencies[key] then
        if value then
            data.favoritedCurrencies[key] = value
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        else
            if data.favoritedCurrencies[key] and data.favoritedCurrencies[key] > 0 then
                data.favoritedCurrencies[key] = nil
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
            else
                data.favoritedCurrencies[key] = 1
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            end
        end
    else
        if value then
            data.favoritedCurrencies[key] = value
        else
            data.favoritedCurrencies[key] = 1
        end
        PlaySound(SOUNDKIT.IG_CHAT_SCROLL_UP)
    end
end

function S.Data.UnfavoriteCurrency(currency)
    local key = currency.id
    GetData().favoritedCurrencies[key] = nil
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
end



-- S.IsBankOpened() returns true when the player is currently using the bank and the bank contents are available
local bankOpen = false
function S.IsBankOpened()
    return bankOpen
end


-- EVENT HANDLING

-- Creates a frame to perform initialisation at appropriate points in WoW's loading process and handle other events
local eventHandlerFrame = CreateFrame("FRAME")
eventHandlerFrame:RegisterEvent("ADDON_LOADED")
eventHandlerFrame:RegisterEvent("PLAYER_LOGIN")
eventHandlerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventHandlerFrame:RegisterEvent("BAG_UPDATE_DELAYED")
eventHandlerFrame:RegisterEvent("BANKFRAME_OPENED")
eventHandlerFrame:RegisterEvent("BANKFRAME_CLOSED")
eventHandlerFrame:RegisterEvent("GUILDBANK_UPDATE_TABS")
eventHandlerFrame:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED")
if S.WoWVersion() >= 3 then
    eventHandlerFrame:RegisterEvent("EQUIPMENT_SETS_CHANGED")
end
if S.WoWVersion() >= 6 then
    eventHandlerFrame:RegisterEvent("REAGENTBANK_PURCHASED")
end
eventHandlerFrame:RegisterEvent("PLAYER_GUILD_UPDATE")
eventHandlerFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
eventHandlerFrame:SetScript("OnEvent", function(self, event, param1, param2, param3)
    if event == "ADDON_LOADED" then
        if param1 == "Sorted" then
            sortedData = Sorted_Data -- Update the local sortedData variable once Sorted_Data gets loaded from SavedVariables
            InitialiseData()
        end
    elseif event == "PLAYER_LOGIN" then
        UpdatePlayerData()
    
        -- Clear characters after 1 month of inactivity, or if they have the same name as the current character. The alt is probably deleted
        local toDelete = {}
        for GUID, v in pairs(sortedData) do
            if GUID ~= playerGUID then
                if ((v.lastLogged and time() - v.lastLogged > 2678400) or (v.name == UnitName("player") and v.realm == GetRealmName())) then
                    table.insert(toDelete, GUID)
                end
            end
        end
        for k, GUID in pairs(toDelete) do
            S.Data.DeleteCharacter(GUID)
        end

        -- Calculate total Alliance and Horde money on each realm, excluding the currently logged character since its money can change
        totalMoney = {}
        for GUID, v in pairs(sortedData) do
            if v.realm then
                if not totalMoney[v.realm] then
                    totalMoney[v.realm] = {}
                    totalMoney[v.realm].alliance = 0
                    totalMoney[v.realm].horde = 0
                end
                if GUID ~= playerGUID then
                    if v.money then
                        if v.faction == "Alliance" then
                            totalMoney[v.realm].alliance = totalMoney[v.realm].alliance + v.money
                        else
                            totalMoney[v.realm].horde = totalMoney[v.realm].horde + v.money
                        end
                    end
                end
            end
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        S.SelectCharacter(UnitGUID("player"))
        S.Settings.ReloadAll()
        S.Data.UpdateGuildInfo()
        UpdateCurrencies()
        UpdateBagContents()
        S.Utils.TriggerEvent("EnteredWorld")
        S.Utils.TriggerEvent("Resized")
    elseif event == "BAG_UPDATE_DELAYED" then
        UpdateBagContents()
    elseif event == "BANKFRAME_OPENED" then
        bankOpen = true
        UpdateBagContents()
        S.Utils.TriggerEvent("BankOpened")
    elseif event == "BANKFRAME_CLOSED" then
        bankOpen = false
        S.Utils.TriggerEvent("BankClosed")
    elseif event == "EQUIPMENT_SETS_CHANGED" then
        UpdateEquipmentSets()
    elseif event == "REAGENTBANK_PURCHASED" then
        UpdateBagContents()
        S.Utils.TriggerEvent("ReagentsPurchased")
    elseif event == "CURRENCY_DISPLAY_UPDATE" then
        UpdateCurrencies()
    elseif event == "PLAYER_GUILD_UPDATE" then
        S.Data.UpdateGuildInfo()
    elseif event == "GUILDBANK_UPDATE_TABS" then
        S.Data.UpdateGuildBankTabs()
    end
end)

-- Check for when the GuildBankFrame is loaded and estimate when the items will be available
local guildBankFrameLoadTime, guildBankLoaded = nil
eventHandlerFrame:SetScript("OnUpdate", function(self)
    if GuildBankFrame then
        if not guildBankFrameLoadTime then
            guildBankFrameLoadTime = GetTime()
        else
            -- Give it 2 seconds after the GuildBankFrame is loaded
            if GetTime() > guildBankFrameLoadTime + 2 then
                guildBankLoaded = true
                S.Utils.TriggerEvent("GuildBankAvailable")
                eventHandlerFrame:SetScript("OnUpdate", nil)
            end
        end
    end
end)
function S.IsGuildBankAvailable()
    return guildBankLoaded
end