local _, S = ...

local lastToggledTime = 0
local lastShownTime = 0
local lastHiddenTime = 0
local TOGGLE_TIMEOUT = 0.01

local lastItemSplit = nil
local lastItemSplitContainerType = nil
local lastItemSplitTime = 0

local opened, openedThisFrame = false, false
local openStateTracker = CreateFrame("Frame", nil, UIParent)
openStateTracker:Show()
openStateTracker:SetScript("OnUpdate", function(self, elapsed)
    opened = openedThisFrame
    openedThisFrame = SortedFrame:IsShown()
end)
local autoCloseFrame = CreateFrame("Frame", nil, UIParent)
autoCloseFrame:Hide()
local autoOpenFrame = CreateFrame("Frame", nil, UIParent)
autoOpenFrame:Hide()


Sorted_itemLists = {}


function SortedFrame_UpdateMinSize()
    local width = 24 + SortedSortButtons_GetTotalWidth()
    if not Sorted_GetData(playerGUID).minimized then
        width = width + Sorted_GetSetting("categoriesWidth")
    end
    if width < 384 then
        width = 384
    end
    if SortedFrame:GetWidth() < width then
        SortedFrame:SetWidth(width)
    end

    local height
    if not Sorted_GetData(playerGUID).minimized and Sorted_GetSetting("categoriesUseIcons") == 1 then
        height = SortedFrameFilterButtons:GetHeight() + 96
    else
        height = SortedFrameMiniFilterButtons:GetHeight()
    end
    if height < 380 then
        height = 380
    end
    if SortedFrame:GetHeight() < height then
        SortedFrame:SetHeight(height)
    end
    SortedFrame:SetMinResize(width, height)
    Sorted_UpdateFrameSizes()
end

local playerGUID = UnitGUID("player")
Sorted_SelectedPlayerGUID = playerGUID
local currentPlayerIsSelected = true
function S.IsCurrentPlayerSelected()
    return currentPlayerIsSelected
end
function Sorted_SelectPlayer(guid)
    if guid ~= Sorted_SelectedPlayerGUID then
        Sorted_SelectedPlayerGUID = guid
        currentPlayerIsSelected = (guid == playerGUID)
        _G["SortedFrameFootSlots"]:UpdateText()
        _G["SortedBankSidePanelFootSlots"]:UpdateText()
        if not Sorted_IsClassic() then
            Sorted_DeselectEquipmentSet()
            SortedEquipmentSetsDropdownButton_Update()
            _G["SortedReagentSidePanelFootSlots"]:UpdateText()
            if Sorted_bankIsOpened and currentPlayerIsSelected then
                _G["SortedReagentSidePanelFootCenterDepositButton"]:Enable()
            else
                _G["SortedReagentSidePanelFootCenterDepositButton"]:Disable()
            end
        end
        SortedAltsDropdownButton:ValueFunc()

        Sorted_SelectCategoryButton(nil)
        Sorted_ReloadAllSettings()

        C_Timer.After(0.1, function() 
            Sorted_UpdateTimeItemsAdded()
            Sorted_UpdateItemButtons()
            Sorted_FilterItems()
        end)

        C_Timer.After(1, function() 
            Sorted_UpdateItemButtons()
            Sorted_FilterItems()
        end)
    end
end

Sorted_ContainerSlots = {}
Sorted_BankContainerSlots = {}

S.bagFrames = {}
local Sorted_shownBagFrames = {}
local function Sorted_GetBagFrame(containerID)
    for k,v in pairs(S.bagFrames) do
        if v.containerID == containerID then return v end
    end
end
function Sorted_GetBagFrameShown(containerID)
    return Sorted_shownBagFrames[containerID]
end

function Sorted_SetScale(scale)
    SortedFrame:SetScale(scale)
    SortedBankSidePanel:SetScale(scale)
    SortedReagentSidePanel:SetScale(scale)
    for k,v in pairs(S.bagFrames) do
        v:SetScale(scale)
    end
    SortedIconSelectionMenu:SetScale(scale)
end

function Sorted_PutItemInSlot(containerID, slotID)
    _, itemCount, locked = GetContainerItemInfo(containerID, slotID)
    if not locked and not itemCount then
        PickupContainerItem(containerID, slotID)
        return true
    end
end

function Sorted_PutItemInBags(containerType)
    if CursorHasItem() then
        local type, itemID = GetCursorInfo()
        if type == "item" then
            local canStack = (lastItemSplitTime < time() - 60) or (lastItemSplit ~= itemID) or (lastItemSplitContainerType ~= containerType)
            lastItemSplitTime = 0

            local containers = {}
            if containerType == "BAGS" or containerType == "REAGENT" or containerType == "BANK" or containerType == "KEYRING" then
                containers = Sorted_ContainersOfType(containerType)
            elseif string.sub(containerType, 1, 9) == "CONTAINER" then
                containers[1] = tonumber(string.sub(containerType, 10))
                if GetContainerNumFreeSlots(containers[1]) == 0 then
                    UIErrorsFrame:AddMessage("That bag is full.", 1.0, 0.0, 0.0, 53, 8)
                    ClearCursor()
                    return
                end
            end
            for k, containerID in pairs(containers) do
                if Sorted_ItemGoesInBag(itemID, containerID) then
                    if not Sorted_shownBagFrames[containerID] or string.sub(containerType, 1, 9) == "CONTAINER" then
                        if canStack then
                            if GetContainerNumFreeSlots(containerID) > 0 then
                                if containerID == BACKPACK_CONTAINER then
                                    PutItemInBackpack()
                                elseif containerID == BANK_CONTAINER then
                                    for i = 40, 67 do
                                        if not GetInventoryItemID("player", i) then
                                            PutItemInBag(i)
                                        end
                                    end
                                elseif containerID == REAGENTBANK_CONTAINER then
                                    for i = 1, GetContainerNumSlots(REAGENTBANK_CONTAINER) do
                                        if not GetInventoryItemID("player", ReagentBankButtonIDToInvSlotID(i)) then
                                            PutItemInBag(ReagentBankButtonIDToInvSlotID(i))
                                        end
                                    end
                                elseif containerID == KEYRING_CONTAINER then
                                    for i = 1, 32 do
                                        if not GetInventoryItemID("player", KeyRingButtonIDToInvSlotID(i)) then
                                            PutItemInBag(KeyRingButtonIDToInvSlotID(i))
                                        end
                                    end
                                else
                                    PutItemInBag(ContainerIDToInventoryID(containerID))
                                end
                            end
                        else

                            for slotID = 1, GetContainerNumSlots(containerID) do
                                if Sorted_PutItemInSlot(containerID, slotID) then return end
                            end

                        end
                    end
                end
            end
        end
    end
end

function Sorted_UpdateNewItemsPerCategory()
    if Sorted_GetSetting("newItemIndicators") == 2 then
        local data = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)
        local newItems = Sorted_GetData().newItems
        for categoryID, category in pairs(data) do
            category.newItems = 0
        end
        local itemStringsThatHaveAlreadyBeenCounted = {}
        for _, itemButton in pairs(SortedFrameItemList.itemButtons) do
            if itemButton:IsNew() then
                local itemData = itemButton:GetData()
                local itemKey = Sorted_ItemKey(itemData.link)
                if not itemStringsThatHaveAlreadyBeenCounted[itemKey] then
                    itemStringsThatHaveAlreadyBeenCounted[itemKey] = {}
                end
                for categoryID, category in pairs(data) do
                    if Sorted_CategoryFilter(categoryID, itemData, true) then
                        if not itemStringsThatHaveAlreadyBeenCounted[itemKey][categoryID] then
                            category.newItems = category.newItems + newItems[itemKey]
                            itemStringsThatHaveAlreadyBeenCounted[itemKey][categoryID] = true
                        end
                    end
                end
            end
        end
        for i, v in ipairs(Sorted_CategoryButtons) do
            if data[i] then
                if data[i].newItems > 0 then
                    v.newItemsIndicator:Show()
                    v.newItemsIndicator.text:SetText(data[i].newItems)
                    v.miniButton.newItemsIndicator:Show()
                    v.miniButton.newItemsIndicator.text:SetText(data[i].newItems)
                else
                    v.newItemsIndicator:Hide()
                    v.miniButton.newItemsIndicator:Hide()
                end
            end
        end
    else
        for i, v in ipairs(Sorted_CategoryButtons) do
            v.newItemsIndicator:Hide()
            v.miniButton.newItemsIndicator:Hide()
        end
    end
end

function Sorted_ClearNewItems()
    for _, itemList in pairs(Sorted_itemLists) do
        for _, itemButton in pairs(itemList.itemButtons) do
            if itemButton:IsNew() == -1 then
                Sorted_GetData().newItems[Sorted_ItemKey(itemButton:GetData().link)] = nil
            end
        end
    end
end

function SortedFrameRightPanel_Update()
    if Sorted_GetSetting("categoriesUseIcons") == 1 then
        SortedFrameFilterButtons:Show()
        if S.DoSkinning() then
            SortedSubcategoryFrameParent:SetPoint("TOPLEFT", SortedFrameFilterButtons, "BOTTOMLEFT", 0, 1)
        else
            SortedSubcategoryFrameParent:SetPoint("TOPLEFT", SortedFrameFilterButtons, "BOTTOMLEFT")
        end
        if Sorted_GetData(playerGUID).minimized then
            SortedFrameMiniFilterButtons:Show()
        else
            SortedFrameMiniFilterButtons:Hide()
        end
    else
        SortedFrameFilterButtons:Hide()
        SortedSubcategoryFrameParent:SetPoint("TOPLEFT")
        SortedFrameMiniFilterButtons:Show()
    end
end

function SortedFrame_MinimizeRightPanel(temporary, dontResize)
    SortedFrameRight:Hide()
    SortedFrameMiniFilterButtons:Show()
    SortedFrameLeft:SetPoint("BOTTOMRIGHT", SortedFrameMain, -1, 2)
    if not temporary then
        SortedFrameMinimizeButton:Hide()
        SortedFrameMaximizeButton:Show()
        Sorted_GetData(playerGUID).minimized = true
    end
    if Sorted_GetSetting("categoriesUseIcons") == 2 and Sorted_SelectedCategory == 0 then
        return
    end
    --[[if not temporary and not dontResize then
        SortedFrame:SetWidth(SortedFrame:GetWidth() - 138)
    end]]
    SortedFrame_UpdateMinSize()

    --Sorted_SelectCategoryButton(nil)
    SortedSubcategoryFrame_Update()
    --Sorted_FilterItems()
    --Sorted_ScrollToTop()
end

function SortedFrame_MaximizeRightPanel(temporary, dontResize)
    if Sorted_GetSetting("categoriesUseIcons") == 1 then
        SortedFrameMiniFilterButtons:Hide()
    end
    if not temporary then
        SortedFrameMaximizeButton:Hide()
        SortedFrameMinimizeButton:Show()
        Sorted_GetData(playerGUID).minimized = false
    end
    if Sorted_GetSetting("categoriesUseIcons") == 2 and Sorted_SelectedCategory == 0 then
        return
    end
    SortedFrameRight:Show()
    SortedFrameLeft:SetPoint("BOTTOMRIGHT", SortedFrameRight, "BOTTOMLEFT")
    --[[if not temporary and not dontResize then
        SortedFrame:SetWidth(SortedFrame:GetWidth() + 138)
    end]]
    SortedFrame_UpdateMinSize()
end

function SortedEquipmentSetsDropdownButton_Update()
    data = Sorted_GetData(Sorted_SelectedPlayerGUID)
    -- If there's an equipment set known for this character, enable the dropdown menu
    -- There's an extra check here, for compatibility with versions before this feature was added
    if data.equipSets then
        for k,v in pairs(data.equipSets) do
            if v then
                SortedEquipmentSetsDropdownButton:Show()
                return
            end
        end
    end
    SortedEquipmentSetsDropdownButton:Hide()
end

function Sorted_UpdateFrameSizes()
    SortedFrameRight:SetWidth(Sorted_GetSetting("categoriesWidth"))
    if SortedFrame:GetWidth() > 600 then
        SortedAltsDropdownButton:SetWidth(140)
    else
        SortedAltsDropdownButton:SetWidth(140 - (600 - SortedFrame:GetWidth()) / 4)
    end
    if SortedFrame:GetWidth() > 900 then
        SortedEquipmentSetsDropdownButton:SetWidth(200)
    else
        SortedEquipmentSetsDropdownButton:SetWidth(200 - (900 - SortedFrame:GetWidth()) / 6)
    end
    SortedReagentSidePanel:SetWidth(SortedFrameLeft:GetWidth())
    SortedBankSidePanel:SetWidth(SortedFrameLeft:GetWidth())

    local bagFrameHeight = SortedFrameLeft:GetWidth()
    if SortedFrame:GetHeight() < bagFrameHeight then
        bagFrameHeight = SortedFrame:GetHeight()
    elseif bagFrameHeight < 240 then
        bagFrameHeight = 240
    end
    for k,v in pairs(S.bagFrames) do
        v:SetWidth(SortedFrameLeft:GetWidth())
        v:SetHeight(bagFrameHeight)
    end
end

local function SplitStack(button, split)
    lastItemSplit = button:GetParent():GetData().itemID
    lastItemSplitContainerType = Sorted_GetContainerType(button:GetParent():GetID())
    lastItemSplitTime = time()
	SplitContainerItem(button:GetParent():GetID(), button:GetID(), split)
end

-- Hook ContainerFrameItemButton_OnModifiedClick function to handle splitting of item stacks
local ContainerFrameItemButton_OnModifiedClickOriginal = ContainerFrameItemButton_OnModifiedClick
ContainerFrameItemButton_OnModifiedClick = function(self, button)
    ContainerFrameItemButton_OnModifiedClickOriginal(self, button)
    self.SplitStack = SplitStack
end

function Sorted_UpdateItemButtons(container, itemID)
    for _, itemList in pairs(Sorted_itemLists) do
        if (not container or Sorted_ContainerIsType(container, itemList.type)) and itemList:ShouldUpdate() then
            SortedItemList_UpdateItemButtons(itemList, itemID)
        end
    end


    -- Bag containers
    for k, v in pairs(Sorted_ContainerSlots) do
        local slotData = Sorted_GetContainerItemInfo(0, v:GetID(), Sorted_SelectedPlayerGUID)
        _G[v:GetName().."IconTexture"]:SetTexture(slotData.texture)
        if currentPlayerIsSelected then
            v:Enable()
            v:SetAlpha(1)
        else
            v:Disable()
            v:SetAlpha(0.9)
        end
    end
    -- Bank containers
    for k, v in pairs(Sorted_BankContainerSlots) do
        local slotData = Sorted_GetContainerItemInfo(-4, v:GetID(), Sorted_SelectedPlayerGUID)
        _G[v:GetName().."IconTexture"]:SetTexture(slotData.texture)
        if (v:GetID() > GetNumBankSlots() and currentPlayerIsSelected)
             or (not slotData.texture and not currentPlayerIsSelected) then
            v:Hide()
        else
            v:Show()
            if Sorted_bankIsOpened and currentPlayerIsSelected then
                v:Enable()
                v:SetAlpha(1)
            else
                v:Disable()
                v:SetAlpha(0.9)
            end
        end
    end
    if not currentPlayerIsSelected then
        _G["SortedBankSidePanelFootBagsPurchaseSlotButton"]:Hide()
    end
end

function Sorted_UpdateScrollBars()
    for _, itemList in pairs(Sorted_itemLists) do
        SortedItemList_UpdateScrollBar(itemList)
    end

    if Sorted_SelectedCategory > 0 then
        n = SortedSubcategoryFrame:GetScrollChild():GetHeight() - SortedSubcategoryFrame:GetHeight()
        if n < 1 then 
            n = 1
            SortedSubcategoryFrame.scrollBar:Hide()
            SortedSubcategoryFrameScrollChild:SetWidth(Sorted_GetSetting("categoriesWidth") - 6)
        else
            SortedSubcategoryFrame.scrollBar:Show()
            SortedSubcategoryFrameScrollChild:SetWidth(Sorted_GetSetting("categoriesWidth") - 24)
        end
        n = math.ceil(n)
        SortedSubcategoryFrame.scrollBar:SetMinMaxValues(1, n)
    else
        SortedSubcategoryFrame.scrollBar:Hide()
    end
end

function Sorted_ScrollToTop()
    for _, itemList in ipairs(Sorted_itemLists) do
        itemList.scrollBar:SetValue(1)
        itemList:StopScrolling()
    end
end

function Sorted_ToggleRoundIcons()
    local isRound = (Sorted_GetSetting("iconShape") == 2)
    for _, itemList in pairs(Sorted_itemLists) do
        SortedItemList_ToggleRoundIcons(itemList, isRound)
    end
end

function Sorted_PositionItemButtons(animate, onlyAnimateFiltered)
    for _, itemList in pairs(Sorted_itemLists) do
        if itemList:ShouldUpdate() then
            SortedItemList_PositionItemButtons(itemList, animate, onlyAnimateFiltered)
        end
    end
end

-- itemID: Only update items with the specified ID
local function FilterItems(itemID, animate, onlyAnimateFiltered)
    for _, itemList in pairs(Sorted_itemLists) do
        if itemList:ShouldUpdate() then
            SortedItemList_FilterItems(itemList, itemID)
        end
    end
    Sorted_UpdateIconBorders()
    Sorted_SortItems(animate, onlyAnimateFiltered)
end
function Sorted_FilterItems(itemID, animate, onlyAnimateFiltered)
    local co = coroutine.create(FilterItems)
    coroutine.resume(co, itemID, animate, onlyAnimateFiltered)
end

function Sorted_SortItems(animate, onlyAnimateFiltered)
    for _, itemList in pairs(Sorted_itemLists) do
        if itemList:ShouldUpdate() then
            SortedItemList_SortItems(itemList)
        end
    end
    Sorted_PositionItemButtons(animate, onlyAnimateFiltered)
end

--[[local function Sorted_CalculateItemTooltipAnchors(self, mainTooltip)
    local x = self:GetRight()
	local anchorFromLeft = x < GetScreenWidth() / 2
	if ( anchorFromLeft ) then
		mainTooltip:SetAnchorType("ANCHOR_CURSOR")
		mainTooltip:SetPoint("LEFT", self, "RIGHT", 0, 0)
	else
		mainTooltip:SetAnchorType("ANCHOR_CURSOR")
		mainTooltip:SetPoint("RIGHT", self, "LEFT", 2, 0)
	end
end]]

local function SortedBagFrame_Update(self)
    if self.containerID ~= KEYRING_CONTAINER then
        SetBagPortraitTexture(self.portrait, self.containerID)
        if Sorted.IsSkinned() then
            self.skinnedPortrait:SetTexture(_G[self:GetName().."Portrait"]:GetTexture())
        end
        local itemName, itemRarity
        local itemLink = GetInventoryItemLink("player", self.invID)
        if itemLink then
            itemName, _, itemRarity = GetItemInfo(itemLink)
            self.bagName:SetText(itemName)
            self.bagType:SetText(Sorted_GetBagTypeName(GetItemFamily(itemLink)))
            local r,g,b = Sorted_GetItemQualityColor(itemRarity)
            self.bagName:SetTextColor(r,g,b)
        end
    else
        SetPortraitToTexture(self.portrait, "Interface\\ContainerFrame\\KeyRing-Bag-Icon")
        self.bagName:SetText("Keyring")
    end
end

local function SortedBagFrame_BringToFront(self)
    local tableIndex
    for i,v in ipairs(S.bagFrames) do
        if v == self then
            tableIndex = i
        end
    end
    table.remove(S.bagFrames, tableIndex)
    table.insert(S.bagFrames, self)
    for i,v in ipairs(S.bagFrames) do
        local level = 2000 + i * 5
        v:SetFrameLevel(level)
        v.shadow:SetFrameLevel(level - 1)
    end
end

local function Sorted_CreateBagFrame(containerID)
    local frame = CreateFrame("Frame", "SortedBag"..tostring(containerID).."Frame", UIParent, "PortraitFrameTemplate")
    frame:SetMovable(true)
    frame:SetResizable(true)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetFrameStrata("HIGH")
    frame:Hide()

    frame.bg = _G[frame:GetName().."Bg"]
    frame.bg:SetPoint("TOPLEFT", 2, -2)
    frame.bg:SetPoint("BOTTOMRIGHT", -2, 2)
    Sorted.RegisterBackdrop(frame.bg)

    frame.shadow = CreateFrame("Frame", frame:GetName().."DropShadow", frame, "SortedDropShadowTemplate")

    local draggable = CreateFrame("Frame", frame:GetName().."Draggable", frame)
    draggable:SetPoint("TOPLEFT", 58, 0)
    draggable:SetPoint("RIGHT")
    draggable:SetHeight(22)
    draggable:SetScript("OnMouseDown", function(self, button) 
        SortedBagFrame_BringToFront(self:GetParent())
        if button == "LeftButton" and not self:GetParent().isMoving then
            self:GetParent():StartMoving()
            self:GetParent().isMoving = true
        end
    end)
    draggable:SetScript("OnMouseUp", function(self, button) 
        if button == "LeftButton" and self:GetParent().isMoving then
            self:GetParent():StopMovingOrSizing();
            self:GetParent().isMoving = false;
        end
    end)
    draggable:SetScript("OnHide", function(self, button) 
        if (self:GetParent().isMoving) then
            self:GetParent():StopMovingOrSizing()
            self:GetParent().isMoving = false
        end
    end)

    local slots = CreateFrame("Button", frame:GetName().."Slots", frame, "SortedBagSlotsTemplate")
    if containerID == KEYRING_CONTAINER then
        slots:SetID(253)
    else
        slots:SetID(containerID)
    end
    slots:SetPoint("TOP", 0, -24)
    slots:SetPoint("BOTTOMLEFT", frame, "TOPRIGHT", -72, -64)
    slots:SetWidth(68)

    local head = CreateFrame("Frame", frame:GetName().."Head", frame, "SortedColumnHeaderTemplate")
    head:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -22)
    head:SetPoint("BOTTOM", slots, "BOTTOM", 0, -1)
    head:SetPoint("RIGHT", slots, "LEFT", 0, 0)
    head:SetFrameLevel(1)

    local bagName = head:CreateFontString(frame:GetName().."NameFont", "OVERLAY", "Sorted13Font")
    bagName:SetPoint("TOPLEFT", 64, -4)
    bagName:SetPoint("RIGHT", slots, "LEFT")
    bagName:SetPoint("BOTTOM", slots, "TOP", 0, -17)
    bagName:SetMaxLines(1)
    bagName:SetJustifyH("LEFT")
    bagName:SetJustifyV("MIDDLE")

    local bagType = head:CreateFontString(frame:GetName().."TypeFont", "OVERLAY", "Sorted12Font")
    bagType:SetPoint("BOTTOMLEFT", 64, 7)

    if containerID > 0 and containerID <= NUM_BAG_SLOTS then
        frame.TitleText:SetText("Bag "..containerID)
    elseif containerID > NUM_BAG_SLOTS and containerID <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS then
        frame.TitleText:SetText("Bank Bag "..(containerID - NUM_BAG_SLOTS))
    elseif containerID == KEYRING_CONTAINER then
        frame.TitleText:SetText("Keyring")
    end

    frame.containerID = containerID
    if containerID == KEYRING_CONTAINER then
        frame.invID = -2
    else
        frame.invID = ContainerIDToInventoryID(containerID)
    end
    frame.bagName = bagName
    frame.bagType = bagType

    frame:SetFrameLevel(2000 + containerID * 5)
    if not Sorted_IsClassic() then
        frame.NineSlice:SetFrameLevel(2000 + containerID * 5)
    end
    frame.CloseButton:SetFrameLevel(2000 + containerID * 5 + 1)

    frame:SetScript("OnShow", function(self)
        self:ClearAllPoints()
        Sorted_UpdateFrameSizes()
        if self.containerID > 0 and self.containerID <= NUM_BAG_SLOTS then
            self:SetPoint("CENTER", SortedFrame, "TOPLEFT", -384 + self.containerID * 40, -64 - self.containerID * 64)
        elseif self.containerID > NUM_BAG_SLOTS then
            self:SetPoint("CENTER", SortedBankSidePanel, "TOPLEFT", -640 + self.containerID * 40, 256 - self.containerID * 64)
        else
            self:SetPoint("CENTER", SortedFrame, "TOPLEFT", -288, -128)
        end
        Sorted_shownBagFrames[self.containerID] = true
        SortedBagFrame_Update(self)
        Sorted_UpdateItemButtons(self.containerID)
        Sorted_UpdateTimeItemsAdded()
        Sorted_FilterItems()
    end)
    frame:SetScript("OnHide", function(self)
        Sorted_shownBagFrames[self.containerID] = false
        if self.containerID > 0 and self.containerID <= NUM_BAG_SLOTS then
            Sorted_ContainerSlots[self.containerID].openedTexture:Hide()
        elseif self.containerID > NUM_BAG_SLOTS then
            Sorted_BankContainerSlots[self.containerID - NUM_BAG_SLOTS].openedTexture:Hide()
        end
        Sorted_UpdateItemButtons()
        Sorted_FilterItems()
    end)
    frame:SetScript("OnMouseDown", SortedBagFrame_BringToFront)

    -- Create item list
    if containerID == KEYRING_CONTAINER then
        frame.type = "KEYRING"
    else
        frame.type = "CONTAINER"..containerID
    end
    local scrollFrame = CreateFrame("ScrollFrame", frame:GetName().."ItemList", frame, "SortedItemListTemplate")
    scrollFrame:SetPoint("TOPLEFT", head, "BOTTOMLEFT", 2, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", -3, 3)
    frame.ItemList = scrollFrame

    

    frame:RegisterEvent("BAG_UPDATE")
    frame:SetScript("OnEvent", function(self)
        SortedBagFrame_Update(self)
    end)
    SortedBagFrame_Update(frame)

    return frame
end



--[[ INITIALISE ]]
-- Bag Frames
for i = 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
    local bagFrame = Sorted_CreateBagFrame(i)
    table.insert(S.bagFrames, bagFrame)
    table.insert(Sorted_shownBagFrames, false)
end

--Keyring frame
if Sorted_IsClassic() then
    local bagFrame = Sorted_CreateBagFrame(KEYRING_CONTAINER)
    table.insert(S.bagFrames, bagFrame)
end


-- Functions that specifically need to be run after other PLAYER_ENTERING_WORLD updates
-- (generally, because they require data that can't be loaded until after PLAYER_ENTERING_WORLD fires)
local function PostEnteringWorldUpdates()
    _G["SortedFrameFootSlots"]:UpdateText()
    _G["SortedBankSidePanelFootSlots"]:UpdateText()
    if not Sorted_IsClassic() then
        _G["SortedReagentSidePanelFootSlots"]:UpdateText()
    end
    _G["SortedMoneyText"]:UpdateMoneyText()
    if not Sorted_GetData(playerGUID).minimized then
        --[[SortedFrame_MinimizeRightPanel(false, true)
        SortedFrame_MaximizeRightPanel(false, true)]]
    else
        SortedFrame_MinimizeRightPanel(false, true)
    end
    SortedFrameRightPanel_Update()
    Sorted_UpdateFrameSizes()
    S.Skin()
end


function SortedFrame_OnBagUpdate(arg1)
    Sorted_UpdateBagContents(arg1)
    Sorted_UpdateItemButtons(arg1)
    Sorted_FilterItems()
end

function SortedFrame_OnLoad(self)  
    Sorted.RegisterBackdrop(SortedFrameBg)
    self.TopTileStreaks:Hide()
    _G["SortedFrameCloseButton"]:SetScript("OnClick", Sorted_CloseBags)
    -- Container buttons. Offset for classic keyring
    local offsetX = 0
    if Sorted_IsClassic() then
        offsetX = 14
        SortedFrameFootBags:SetWidth(SortedFrameFootBags:GetWidth() + offsetX)
    end
    for i = 1, NUM_BAG_SLOTS do
        local button
        if not Sorted_IsClassic() then
            button = CreateFrame("ItemButton", "Sorted___Bag"..(i-1).."Slot", SortedFrameFootBags, "ContainerFrameItemButtonTemplate")
        else
            button = CreateFrame("Button", "Sorted___Bag"..(i-1).."Slot", SortedFrameFootBags, "ContainerFrameItemButtonTemplate")
        end
        button:SetID(-NUM_BAG_SLOTS + i)
        local buttonSize = SortedFrameFoot:GetHeight() - 2
        button:SetPoint("TOPLEFT", offsetX + (i - 1) * buttonSize, 0)
        button:SetPoint("BOTTOMRIGHT", SortedFrameFootBags, "TOPLEFT", offsetX + i * buttonSize, 1 - buttonSize)
        button:GetNormalTexture():ClearAllPoints()
        button.IconBorder:SetAllPoints()
        button:Show()
        button:GetNormalTexture():SetPoint("TOPLEFT", button, -11, 10)
        button:GetNormalTexture():SetPoint("BOTTOMRIGHT", button, 11, -10)
        button.BattlepayItemTexture:Hide();
        button.NewItemTexture:Hide()
        button.BackgroundTexture = button:CreateTexture("SortedFrameFootBagsButton"..i.."BackgroundTexture", "BACKGROUND")
        button.BackgroundTexture:SetTexture("Interface\\PaperDoll\\UI-PaperDoll-Slot-Bag")
        button.BackgroundTexture:SetAllPoints()

        button.openedTexture = button:CreateTexture(button:GetName().."OpenedTexture", "OVERLAY")
        button.openedTexture:SetTexture("Interface\\Buttons\\CheckButtonHilight")
        button.openedTexture:SetAllPoints()
        button.openedTexture:SetBlendMode("ADD")
        button.openedTexture:Hide()
        button.containerID = i
        button:SetScript("OnClick", function(self, button)
            if CursorHasItem() then
                local type, itemID = GetCursorInfo()
                if type == "item" and select(6, GetItemInfo(itemID)) == "Container" then
                    ContainerFrameItemButton_OnClick(self, button)
                    return
                end
            end
            
            if GetInventoryItemID("player", ContainerIDToInventoryID(self.containerID)) then
                local bagFrame = Sorted_GetBagFrame(self.containerID)
                if Sorted_shownBagFrames[self.containerID] then
                    bagFrame:Hide()
                    self.openedTexture:Hide()
                    PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
                else
                    bagFrame:Show()
                    SortedBagFrame_BringToFront(bagFrame)
                    self.openedTexture:Show()
                    PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
                end
            end
        end)

        Sorted_ContainerSlots[i] = button
    end
    SortedFrameFootBags:SetID(0)

    -- Keyring button
    if Sorted_IsClassic() then
        local button = CreateFrame("Button", "SortedKeyringButton", SortedFrameFootBags)
        button:SetNormalTexture("Interface\\Buttons\\UI-Button-KeyRing")
        button:SetHighlightTexture("Interface\\Buttons\\UI-Button-KeyRing-Highlight")
        button:SetPushedTexture("Interface\\Buttons\\UI-Button-KeyRing-Down")
        button:GetNormalTexture():SetTexCoord(0,0.5625,0,0.625)
        button:GetHighlightTexture():SetTexCoord(0,0.5625,0,0.625)
        button:GetPushedTexture():SetTexCoord(0,0.5625,0,0.625)
        local buttonSize = SortedFrameFoot:GetHeight() - 2
        button:SetPoint("TOPLEFT")
        button:SetPoint("BOTTOMRIGHT", SortedFrameFootBags, "TOPLEFT", buttonSize * 0.45, -buttonSize)

        button:HookScript("OnEnter", function(self) 
            SortedTooltip.Schedule(function()
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
                GameTooltip:ClearLines()
                GameTooltip:AddLine(Sorted.Localize("TOOLTIP_KEYRING"), 1, 1, 1, 1)
                GameTooltip:Show()
            end)
        end)
        button:HookScript("OnLeave", SortedTooltip.Cancel)
        button:HookScript("OnClick", function(self)
            if _G["SortedBag-2Frame"]:IsShown() then
                _G["SortedBag-2Frame"]:Hide()
            else
                _G["SortedBag-2Frame"]:Show()
            end
        end)
    end

    self:SetScript("OnUpdate", self.OnUpdateFunc)

    local function PerformOnOpenSettings()
        if Sorted_GetSetting("onOpenPinFavorites") == 1 then
            Sorted_SetSetting("favoritesOnTop", 1)
            SortedFrameFavoritesSortButton:Set(0)
        else
            Sorted_SetSetting("favoritesOnTop", 2)
            SortedFrameFavoritesSortButton:Set(1)
        end
        if Sorted_GetSetting("onOpenSortKeepPrev") == 1 then
            Sorted_selectedSort = math.floor(Sorted_GetSetting("onOpenSortMethod") / 10)
            local sortButton = Sorted_GetSortButton(Sorted_selectedSort)
            if not sortButton or not sortButton:Enabled() then
                Sorted_selectedSort = SORTED_DEFAULT_SORT
                Sorted_sortVariant = 1
                Sorted_SetSetting("onOpenSortMethod", SORTED_DEFAULT_SORT * 10 + 1)
            else
                Sorted_sortVariant = (Sorted_GetSetting("onOpenSortMethod") % 10 - 1) * 2 + Sorted_GetSetting("onOpenSortAscending")
            end
        elseif Sorted_GetSetting("onOpenSortKeepPrev") == 2 then
            Sorted_selectedSort = math.floor(Sorted_GetSetting("lastSort") / 10)
            Sorted_sortVariant = (Sorted_GetSetting("lastSort") % 10)
        end
        SortedSortButtons_Update()
        if Sorted_GetSetting("onOpenFilterKeepPrev") == 1 then
            Sorted_SelectCategoryButton(Sorted_GetSetting("onOpenFilterCategory"), true)
            if Sorted_SelectedCategory == 0 then
                Sorted_SetSetting("onOpenFilterKeepPrev", 0)
                Sorted_SetSetting("onOpenFilterCategory", 0)
            end
        elseif Sorted_GetSetting("onOpenFilterKeepPrev") == 2 then
            Sorted_SelectCategoryButton(Sorted_GetSetting("lastCategory"), true)
        else
            Sorted_SelectCategoryButton(nil, true)
        end
        if Sorted_GetSetting("onOpenKeepSearch") == 1 then
            SortedFrameSearchBox:SetText("")
        else
            SortedFrameSearchBox:SetText(Sorted_GetSetting("lastSearch"))
        end
        SortedSubcategoryFrame_Update()
    end

    self:HookScript("OnShow", function(self)
        Sorted_SelectPlayer(playerGUID)

        Sorted_ScrollToTop()
        if Sorted_bankIsOpened then
            SortedTabsFrame:SelectTab(1)
        else
            SortedTabsFrame:SelectTab(0)
        end

        -- Spread lag over several frames. What can I say, it seems to work?
        local onShowProgress = 0
        SortedFrame:HookScript("OnUpdate", function(self, elapsed)
            if onShowProgress < 9 then
                onShowProgress = onShowProgress + 1
                if onShowProgress == 1 then
                    Sorted_UpdateBagContents()
                elseif onShowProgress == 3 then
                    Sorted_UpdateEquipmentSets()
                elseif onShowProgress == 5 then
                    PerformOnOpenSettings()
                elseif onShowProgress == 7 then
                    Sorted_UpdateItemButtons()
                elseif onShowProgress == 9 then
                    Sorted_FilterItems()
                end
            else
                SortedFrame:SetScript("OnUpdate", nil)
            end
        end)
    end)
    self:HookScript("OnHide", function(self)
        Sorted_ClearNewItems()
        if Sorted_bankIsOpened then CloseBankFrame() end
        SortedIconSelectionMenu:Hide()
        SortedDropdownMenuParent:Hide()
        self.toggled = false
    end)

    table.insert(UISpecialFrames, "SortedFrame")

    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_LEVEL_UP")
    self:RegisterEvent("BAG_UPDATE")
    self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
    self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
    if Sorted_WoWMajorVersionNumber() >= 3 then
        self:RegisterEvent("EQUIPMENT_SETS_CHANGED")
        if Sorted_WoWMajorVersionNumber() >= 6 then
            self:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
        end
    end
    self:SetScript("OnEvent", function(self, event, ...)
        if event == "BAG_UPDATE" and self:IsShown() then
            SortedFrame_OnBagUpdate(...)
        elseif event == "PLAYERBANKSLOTS_CHANGED" and self:IsShown() then
            Sorted_UpdateBagContents(BANK_CONTAINER)
            Sorted_UpdateItemButtons(BANK_CONTAINER)
            Sorted_FilterItems()
        elseif event == "PLAYERREAGENTBANKSLOTS_CHANGED" and self:IsShown() then
            Sorted_UpdateBagContents(REAGENTBANK_CONTAINER)
            Sorted_UpdateItemButtons(REAGENTBANK_CONTAINER)
            Sorted_FilterItems()
        elseif event == "PLAYER_LOGIN" then
            S.InitialiseSkinning()
            Sorted_InitialiseBlizzToggleButton()
            Sorted_KillBlizzBags()
            --Sorted_HideElvUIFrames()
            --Sorted_HideGW2UIFrames()

        elseif event == "PLAYER_ENTERING_WORLD" then
            Sorted_InitialiseData()
            Sorted_LoadData()
            Sorted_UpdateBagContents()
            SortedFilterButtons_Update(SortedFrameFilterButtons)
            PostEnteringWorldUpdates()

        elseif event == "GET_ITEM_INFO_RECEIVED" then
            --Sorted_UpdateBagContents()
            --Sorted_UpdateItemButtons(nil, arg1)
            --Sorted_UpdateItemButtons()
            --Sorted_FilterItems(arg1)
        elseif event == "PLAYER_LEVEL_UP" then
            Sorted_GetData(playerGUID).level = ...
            Sorted_UpdateItemButtons()
        elseif event == "EQUIPMENT_SETS_CHANGED" then
            Sorted_UpdateEquipmentSets()
        elseif event == "ADDON_LOADED" then
            local addonName = ...
            if addonName == "Blizzard_AuctionHouseUI" then
                AuctionHouseFrame.ItemSellFrame:HookScript("OnShow", function(self)
                    autoOpenFrame:Show()
                    autoOpenFrame.reason = 0
                end)
                AuctionHouseFrame.ItemSellFrame:HookScript("OnHide", function(self)
                    autoCloseFrame:Show()
                    autoCloseFrame.reason = 0
                end)
            end
        end
    end)

    autoOpenFrame.reason = nil
    autoOpenFrame:SetScript("OnEvent", function(self, event)
        self:Show()
        if event == "MERCHANT_SHOW" then
            self.reason = 1
        elseif event == "AUCTION_HOUSE_SHOW" then
            self.reason = 2
        elseif event == "BANKFRAME_OPENED" then
            self.reason = 4
        elseif event == "MAIL_SHOW" then
            self.reason = 8
        end
    end)
    autoOpenFrame:SetScript("OnUpdate", function(self, elapsed)
        if self.delayedAFrame then
            self.delayedAFrame = false
            self:Hide()
            if bit.band(Sorted_GetSetting("autoOpenClose"), self.reason) ~= 0 or opened then
                Sorted_OpenBags(nil, true)
            else
                Sorted_CloseBags(nil, true)
            end
        else
            self.delayedAFrame = true
        end
    end)
    autoOpenFrame:RegisterEvent("MAIL_SHOW")
    autoOpenFrame:RegisterEvent("MERCHANT_SHOW")
    autoOpenFrame:RegisterEvent("BANKFRAME_OPENED")
    autoOpenFrame:RegisterEvent("AUCTION_HOUSE_SHOW")

    autoCloseFrame:SetScript("OnEvent", function(self, event)
        self:Show()
        if event == "MERCHANT_CLOSED" then
            self.reason = 16
        elseif event == "AUCTION_HOUSE_CLOSED" then
            self.reason = 32
        elseif event == "BANKFRAME_CLOSED" then
            self.reason = 64
        elseif event == "MAIL_CLOSED" then
            self.reason = 128
        end
    end)
    autoCloseFrame:SetScript("OnUpdate", function(self, elapsed)
        self:Hide()
        if bit.band(Sorted_GetSetting("autoOpenClose"), self.reason) ~= 0 or not opened then
            Sorted_CloseBags(nil, true)
        else
            Sorted_OpenBags(nil, true)
        end
    end)
    autoCloseFrame:RegisterEvent("MERCHANT_CLOSED")
    autoCloseFrame:RegisterEvent("MAIL_CLOSED")
    autoCloseFrame:RegisterEvent("BANKFRAME_CLOSED")
    autoCloseFrame:RegisterEvent("AUCTION_HOUSE_CLOSED")
    

    if Sorted_IsDemo() then
        self:SetFrameStrata("FULLSCREEN_DIALOG")
    end
end

function SortedBankPanel_OnLoad(self)
    -- Bank container buttons
    for i = 1, NUM_BANKBAGSLOTS do
        local button
        if not Sorted_IsClassic() then
            button = CreateFrame("ItemButton","SortedBankSidePanelFootBagsButton"..i, SortedBankSidePanelFootBags, "BankItemButtonBagTemplate")
        else
            button = CreateFrame("Button","SortedBankSidePanelFootBagsButton"..i, SortedBankSidePanelFootBags, "BankItemButtonBagTemplate")
        end
        local buttonSize = SortedBankSidePanelFoot:GetHeight() - 2
        button:SetPoint("TOPLEFT", (i - 1) * buttonSize, 0)
        button:SetSize(buttonSize, buttonSize)
        button:SetID(i)
        button:Show()
        button:Disable()
        button.tooltipText = ""
        button:GetNormalTexture():SetPoint("TOPLEFT", button, -11, 10)
        button:GetNormalTexture():SetPoint("BOTTOMRIGHT", button, 11, -10)
        button.BackgroundTexture = button:CreateTexture("SortedBankSidePanelFootBagsButton"..i.."BackgroundTexture", "BACKGROUND")
        button.BackgroundTexture:SetTexture("Interface\\PaperDoll\\UI-PaperDoll-Slot-Bag")
        button.BackgroundTexture:SetAllPoints()
        Sorted_BankContainerSlots[i] = button

        button.openedTexture = button:CreateTexture(button:GetName().."OpenedTexture", "OVERLAY")
        button.openedTexture:SetTexture("Interface\\Buttons\\CheckButtonHilight")
        button.openedTexture:SetAllPoints()
        button.openedTexture:SetBlendMode("ADD")
        button.openedTexture:Hide()
        button.containerID = NUM_BAG_SLOTS + i
        button:SetScript("OnClick", function(self, button)
            if CursorHasItem() then
                local type, itemID = GetCursorInfo()
                if type == "item" and select(6, GetItemInfo(itemID)) == "Container" then
                    BankFrameItemButtonBag_OnClick(self, self)
                    return
                end
            end
            
            if GetInventoryItemID("player", ContainerIDToInventoryID(self.containerID)) then
                local bagFrame = Sorted_GetBagFrame(self.containerID)
                if Sorted_shownBagFrames[self.containerID] then
                    bagFrame:Hide()
                    self.openedTexture:Hide()
                    PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
                else
                    bagFrame:Show()
                    SortedBagFrame_BringToFront(bagFrame)
                    self.openedTexture:Show()
                    PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
                end
            end
        end)
    end
    SortedBankSidePanelFootBags:SetID(-4)

    self:RegisterEvent('BANKFRAME_OPENED')
    self:RegisterEvent('BANKFRAME_CLOSED')
    self:SetScript('OnEvent', function(self, event)
        if not SortedFrame.killed then
            if event == "BANKFRAME_OPENED" then
                if not Sorted_GetBankCached() then
                    Sorted_SetBankCached()
                end
                Sorted_bankIsOpened = true
                Sorted_SelectPlayer(playerGUID)
                Sorted_UpdateBagContents()
                if SortedFrame:IsShown() then
                    SortedTabsFrame:SelectTab(1)
                end
                if currentPlayerIsSelected then
                    _G["SortedReagentSidePanelFootCenterDepositButton"]:Enable()
                end
            elseif event == "BANKFRAME_CLOSED" then
                SortedTabsFrame:DeselectTab()
                Sorted_bankIsOpened = false
                _G["SortedReagentSidePanelFootCenterDepositButton"]:Disable()
                for k,v in pairs(S.bagFrames) do
                    if v.containerID > NUM_BAG_SLOTS then
                        v:Hide()
                    end
                end
            end
        end
    end)
    
    if Sorted_IsDemo() then
        self:SetFrameStrata("FULLSCREEN")
    end
end
    

function Sorted_OpenBags(bag, force)
    if not SortedFrame.killed then
        if (force or lastToggledTime < GetTime() - TOGGLE_TIMEOUT) and not SortedFrame.toggled then
            PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
            SortedFrame.toggled = true
            SortedFrame:Show()
            lastToggledTime = GetTime()
            lastShownTime = GetTime()
        end
        if bag == KEYRING_CONTAINER then
            _G["SortedBag-2Frame"]:Show()
        end
    end
end
function Sorted_CloseBags(bag, force)
    if (force or lastToggledTime < GetTime() - TOGGLE_TIMEOUT) and SortedFrame.toggled then
        PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
        SortedFrame.toggled = false
        SortedFrame:Hide()
        lastToggledTime = GetTime()
        lastHiddenTime = GetTime()
        for k,v in pairs(S.bagFrames) do
            v:Hide()
        end
    end
end
function Sorted_ToggleBags(bag)
    if bag ~= KEYRING_CONTAINER then
        if SortedFrame.toggled then
            Sorted_CloseBags(bag)
        else
            Sorted_OpenBags(bag)
        end
    else
        if _G["SortedBag-2Frame"]:IsShown() then
            _G["SortedBag-2Frame"]:Hide()
        else
            _G["SortedBag-2Frame"]:Show()
        end
    end
end
hooksecurefunc('OpenBackpack', Sorted_ToggleBags)
hooksecurefunc('CloseBackpack', Sorted_CloseBags)
hooksecurefunc('ToggleBackpack', Sorted_ToggleBags)
hooksecurefunc('OpenBag', Sorted_ToggleBags)
hooksecurefunc('ToggleBag', Sorted_ToggleBags)