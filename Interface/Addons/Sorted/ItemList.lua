local _, S = ...

S.MAX_GROUPS = 25

function SortedItemList_UpdateScrollBar(self)
    local n = self.scrollChild:GetHeight() - self:GetHeight()
    if n < 1 then n = 1 end
    n = math.ceil(n)
    self.scrollBar:SetMinMaxValues(1, n)
    self:StopScrolling()
end

local function SortedItemList_OnUpdate(self, elapsed)
    if ((MouseIsOver(self) or MouseIsOver(self.itemDropButton)) and GetCursorInfo() == "item")
    and not ((self.itemDropButton.type == "BANK" or self.itemDropButton.type == "REAGENT") and not Sorted_bankIsOpened) then
        self.itemDropButton:Show()
    else
        self.itemDropButton:Hide()
    end
    if self.animating then
        self.animElapsed = self.animElapsed + elapsed * 6
        if self.animElapsed > 1 or Sorted_GetSetting("animations") == 1 then
            self.animElapsed = 1
            self.animating = false
        end
        local mult = math.sin(self.animElapsed * math.pi * 0.5)
        for _, groupHeader in pairs(self.groupHeaders) do
            if groupHeader:IsShown() then
                if groupHeader.animate and groupHeader.previousY then
                    groupHeader.currentY = groupHeader.previousY + (groupHeader.targetY - groupHeader.previousY) * mult
                else
                    groupHeader.currentY = groupHeader.targetY
                end
                groupHeader:SetPoint("TOP", 0, groupHeader.currentY)
            end
        end
        for _, itemButton in pairs(self.itemButtons) do
            if SortedItemList_ItemButtonShown(self, itemButton) then
                if itemButton.animate and itemButton.previousY then
                    itemButton.currentY = itemButton.previousY + (itemButton.targetY - itemButton.previousY) * mult
                else
                    itemButton.currentY = itemButton.targetY
                end
                itemButton:SetPoint("TOP", 0, itemButton.currentY)
            end
        end
    end
end

function SortedItemList_UpdateItemButtons(self, itemID)
    for _, itemButton in ipairs(self.itemButtons) do
        if (not itemID or itemID == itemButton.itemID) then
            SortedItemButton_Update(itemButton)
        end
    end
    
    -- Combine stacks
    if Sorted_GetSetting("combineStacks") == 2 then
        local items = {}
        for _, itemButton in ipairs(self.itemButtons) do
            local itemData = itemButton:GetData()
            if SortedItemList_ItemButtonShown(self, itemButton) and (not itemID or itemID == itemData.itemID) then
                if items[itemData.link] then
                    if items[itemData.link].count < itemData.count then
                        items[itemData.link].count = itemData.count
                        items[itemData.link].bag = itemData.bag
                        items[itemData.link].slot = itemData.slot
                    end
                    items[itemData.link].totalCount = items[itemData.link].totalCount + itemData.count
                else
                    items[itemData.link] = {
                        ["count"] = itemData.count,
                        ["bag"] = itemData.bag,
                        ["slot"] = itemData.slot,
                        ["totalCount"] = itemData.count
                    }
                end
            end
        end
        for _, itemButton in ipairs(self.itemButtons) do
            local itemData = itemButton:GetData()
            if SortedItemList_ItemButtonShown(self, itemButton) and (not itemID or itemID == itemData.itemID) then
                SortedItemButton_Update(itemButton)
                if not (itemButton.bag == items[itemData.link].bag and itemButton.slot == items[itemData.link].slot) then
                    itemButton.empty = true
                else
                    itemButton.count = items[itemData.link].totalCount
                    if itemButton.count > 1 then
                        itemButton.quantityString:SetText(itemButton.count)
                        if itemData.value > 0 and not itemData.hasNoValue then
                            itemButton.valueString:SetText(Sorted_FormatValueString(itemData.value * itemButton.count))
                            local color = Sorted_GetValueColor(itemData.value * itemButton.count)
                            itemButton.valueString:SetTextColor(color.r, color.g, color.b)
                        end
                    end
                end
            end
        end
    end

end

function SortedItemList_SetBackdropAlpha(self, alpha)
    for _, itemButton in pairs(self.itemButtons) do
        itemButton.bgTex:SetGradientAlpha(
            "VERTICAL", 
            0,   0,    0,   0, 
            0,   0,    0,   0.1 * alpha
        )
    end
end

function SortedItemList_ItemButtonShown(self, itemButton)
    return not itemButton.empty
    and not ((itemButton.bag > 0 and itemButton.bag <= NUM_BAG_SLOTS) and self.type == "BAGS" and Sorted_GetBagFrameShown(itemButton.bag)) 
    and not ((itemButton.bag > NUM_BAG_SLOTS and itemButton.bag <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) and self.type == "BANK" and Sorted_GetBagFrameShown(itemButton.bag))
end

function SortedItemList_ToggleRoundIcons(self, isRound)
    for _, itemButton in ipairs(self.itemButtons) do
        if isRound then
            itemButton.itemIcon:AddMaskTexture(itemButton.itemIconMask)
            itemButton.iconGlow:SetTexture("Interface\\Addons\\Sorted\\Textures\\Item_Glow_Circle")
            itemButton.iconShadow:SetTexture("Interface\\Addons\\Sorted\\Textures\\Item_Shadow_Circle")
        else
            itemButton.itemIcon:RemoveMaskTexture(itemButton.itemIconMask)
            itemButton.iconGlow:SetTexture("Interface\\Addons\\Sorted\\Textures\\Item_Glow")
            itemButton.iconShadow:SetTexture("Interface\\Addons\\Sorted\\Textures\\Item_Shadow")
        end
    end
end

function SortedItemList_PositionItemButtons(self, animate, onlyAnimateFiltered)
    self.animating = true
    if animate then
        self.animElapsed = 0
    else
        self.animElapsed = 1
    end

    for _, v in pairs(self.groupHeaders) do
        v:Hide()
    end

    local count, currentGrouping, y = 0, -1, -2
    for _, itemButton in ipairs(self.itemButtons) do
        if (SortedItemList_ItemButtonShown(self, itemButton)) then
            if Sorted_GetSetting("grouping") > 0 and (not itemButton.filtered) then
                local group, text
                if Sorted_GetSetting("newOnTop") == 2 and itemButton:IsNew() then
                    group, text = nil, nil--0, "New"
                else
                    group, text = S.groupingMethods[Sorted_GetSetting("grouping")].func(itemButton:GetData())
                end
                if group and text and group ~= currentGrouping then
                    currentGrouping = group
                    self.groupHeaders[currentGrouping]:Show()
                    self.groupHeaders[currentGrouping]:SetPoint("LEFT")
                    self.groupHeaders[currentGrouping].previousY = self.groupHeaders[currentGrouping].currentY
                    --self.groupHeaders[currentGrouping]:SetPoint("TOP", 0, y - 6)
                    self.groupHeaders[currentGrouping].targetY = y - 6
                    self.groupHeaders[currentGrouping].animate = not onlyAnimateFiltered
                    self.groupHeaders[currentGrouping].text:SetText(text)
                    if S.collapsedGroups[currentGrouping] then
                        self.groupHeaders[currentGrouping].collapseButton:Hide()
                        self.groupHeaders[currentGrouping].expandButton:Show()
                    else
                        self.groupHeaders[currentGrouping].collapseButton:Show()
                        self.groupHeaders[currentGrouping].expandButton:Hide()
                    end
                    count = count + 1
                    y = y - 28
                end
            end
            if Sorted_GetSetting("grouping") == 0 or not S.collapsedGroups[currentGrouping] or itemButton.filtered then
                if itemButton.filtered and currentGrouping >= 0 then
                    -- Add a space between the last group and the greyed-out, filtered items
                    currentGrouping = -1
                    y = y - 12
                end
                itemButton:Show()
                itemButton:SetPoint("LEFT")
                itemButton:SetPoint("RIGHT", self.scrollBar, "LEFT", -2, 0)
                itemButton.previousY = itemButton.currentY
                --itemButton:SetPoint("TOP", 0, y)
                itemButton.targetY = y
                itemButton:SetHeight(Sorted_GetSetting("iconSize") + Sorted_GetSetting("padding"))
                itemButton.iconFrame:SetSize(Sorted_GetSetting("iconSize"), Sorted_GetSetting("iconSize"))
                local glowSize = Sorted_GetSetting("iconSize") * (1 + Sorted_GetSetting("iconBorderThickness") / 10)
                itemButton.iconShadow:SetSize(glowSize * 1.25, glowSize * 1.25)
                itemButton.iconGlow:SetSize(glowSize, glowSize)
                count = count + 1
                y = y - (Sorted_GetSetting("iconSize") + Sorted_GetSetting("padding"))
                if itemButton.filtered then
                    itemButton:SetAlpha(0.2)
                    itemButton.iconGlow:SetAlpha(0)
                    itemButton.animate = true
                else
                    if S.IsCurrentPlayerSelected() then
                        itemButton:SetAlpha(1)
                    else
                        itemButton:SetAlpha(0.9)
                    end
                    itemButton.iconGlow:SetAlpha(1)
                    itemButton.animate = not onlyAnimateFiltered
                end
            else
                itemButton:ClearAllPoints()
                itemButton:Hide()
                itemButton.animate = false
            end
        else
            itemButton:ClearAllPoints()
            itemButton:Hide()
        end
    end
    self.scrollChild:SetHeight(-y)
    --[[if not (type=="BANK" or type=="REAGENT") or Sorted_bankIsOpened then
        self.itemDropButton:SetPoint("TOPLEFT", self.scrollChild, "BOTTOMLEFT", 0, 64)
        self.scrollChild:SetHeight(self.scrollChild:GetHeight() + 64)
    else
        self.itemDropButton:SetPoint("TOPLEFT", self.scrollChild, "BOTTOMLEFT", 0, 0)
    end]]
    if self.scrollChild:GetHeight() < self:GetHeight() then
        self.scrollChild:SetHeight(self:GetHeight())
    end
    Sorted_UpdateScrollBars()
    -- Set warning string
    local type = self.type
    if type == "BAGS" or type == "BANK" or type == "REAGENT" then
        --[[if count == 0 then
            if Sorted_SelectedFilter == 13 then
                self.warningString:SetText("No miscellaneous items found")
            elseif Sorted_SelectedFilter > 0 then
                self.warningString:SetText("No "..Sorted_FilterButtons[Sorted_SelectedFilter].text:GetText():lower().." found")
            else
                self.warningString:SetText("No items found")
            end
            if #SortedFrameSearchBox:GetText() > 0 then
                self.warningString:SetText(self.warningString:GetText().." containing\n\"".._G["SortedFrameSearchBox"]:GetText().."\"")
            end
        else
            self.warningString:SetText("")
        end]]
        if type=="BANK" and not Sorted_GetBankCached() then
            if S.IsCurrentPlayerSelected() then
                self.warningString:SetText(Sorted.Localize("WARNING_BANK_NOT_CACHED"))
            else
                self.warningString:SetText(Sorted.Localize("WARNING_BANK_NOT_CACHED_OTHER", Sorted_Data[Sorted_SelectedPlayerGUID].name))
            end
        elseif type=="REAGENT" and not Sorted_GetReagentUnlocked() then
            if not S.IsCurrentPlayerSelected() then
                self.warningString:SetText(Sorted.Localize("WARNING_REAGENTBANK_NOT_PURCHASED_OTHER", Sorted_Data[Sorted_SelectedPlayerGUID].name))
                self.PurchaseButton:Hide()
                self.CostMoneyFrame:Hide()
            else
                if not Sorted_bankIsOpened then
                    self.warningString:SetText(Sorted.Localize("WARNING_REAGENTBANK_NOT_PURCHASED"))
                    self.PurchaseButton:Hide()
                    self.CostMoneyFrame:Hide()
                else
                    self.warningString:SetText(Sorted.Localize("WARNING_REAGENTBANK_PURCHASE"))
                    self.PurchaseButton:Show()
                    self.CostMoneyFrame:Show()
                end
            end
        elseif count == 0 then
            self.warningString:SetText(Sorted.Localize("WARNING_NO_ITEMS_FOUND"))
        else
            self.warningString:SetText("")
        end
    end
end

function SortedItemList_OnLoad(self)
    self:OnLoad()
    local type = self:GetParent().type
    if type == "REAGENT" and Sorted_IsClassic() then
        return
    end
    self.type = type
    self.scrollBar = CreateFrame("Slider", self:GetName().."ScrollBar", self, "UIPanelScrollBarTrimTemplate")
    if type == "BANK" or type == "REAGENT" then
        self.scrollBar:SetPoint("TOPRIGHT", -3, -17)
        self.scrollBar:SetPoint("BOTTOM", 0, 13)
    elseif string.sub(type, 1, 9) == "CONTAINER" or type == "KEYRING" then
        self.scrollBar:SetPoint("TOPRIGHT", -1, -17)
        self.scrollBar:SetPoint("BOTTOM", 0, 15)
    else
        self.scrollBar:SetPoint("TOPRIGHT", 0, 8)
        self.scrollBar:SetPoint("BOTTOM", 0, 13)
    end
    self.scrollBar:SetMinMaxValues(1, 1000)
	self.scrollBar:SetValueStep(1)
	self.scrollBar.scrollStep = 32
    self.scrollBar:SetValue(0)
    local bg = self.scrollBar:CreateTexture(self:GetName().."ScrollBarBG", "BACKGROUND")
    bg:SetVertTile(true) bg:SetHorizTile(true)
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Background")

    self.scrollChild = CreateFrame("Frame", self:GetName().."ScrollChild", self)
    self.scrollChild:SetPoint("RIGHT", self.scrollBar, "LEFT", 0, 0)
    self.scrollChild:SetWidth(800)
    self:SetScrollChild(self.scrollChild)

    self.groupHeaders = {}
    for i = 0, S.MAX_GROUPS do
        local groupHeader = CreateFrame("Button", self.scrollChild:GetName().."GroupHeader"..i, self.scrollChild)
        groupHeader:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
        groupHeader:GetHighlightTexture():SetTexCoord(0.5, 1, 0.3, 0.7)
        groupHeader:GetHighlightTexture():SetVertexColor(1, 0.93, 0.9)
        groupHeader:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
        groupHeader:GetPushedTexture():SetTexCoord(0.5, 1, 0.3, 0.7)
        groupHeader:GetPushedTexture():SetVertexColor(1, 0.93, 0.9)
        groupHeader:GetPushedTexture():SetBlendMode("ADD")
        groupHeader:SetID(i)
        groupHeader.collapseButton = CreateFrame("Button", groupHeader:GetName().."CollapseButton", groupHeader)
        groupHeader.collapseButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
        groupHeader.collapseButton:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
        groupHeader.collapseButton:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
        groupHeader.collapseButton:SetPoint("LEFT", 4, 0)
        groupHeader.collapseButton:SetSize(20,20)
        groupHeader.collapseButton:SetFrameLevel(groupHeader:GetFrameLevel() + 1)
        groupHeader.expandButton = CreateFrame("Button", groupHeader:GetName().."ExpandButton", groupHeader)
        groupHeader.expandButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
        groupHeader.expandButton:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
        groupHeader.expandButton:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
        groupHeader.expandButton:SetPoint("LEFT", 4, 0)
        groupHeader.expandButton:SetSize(20,20)
        groupHeader.expandButton:Hide()
        groupHeader.expandButton:SetFrameLevel(groupHeader:GetFrameLevel() + 1)

        groupHeader.collapseButton:SetScript("OnEnter", function(self) groupHeader:LockHighlight() end)
        groupHeader.collapseButton:SetScript("OnLeave", function(self) groupHeader:UnlockHighlight() end)
        groupHeader.collapseButton:SetScript("OnMouseDown", function(self) if button == "LeftButton" then groupHeader:SetButtonState("PUSHED") end end)
        groupHeader.collapseButton:SetScript("OnMouseUp", function(self) groupHeader:SetButtonState("NORMAL") end)
        groupHeader.collapseButton:SetScript("OnClick", function(self) groupHeader:Click() end)
        groupHeader.expandButton:SetScript("OnEnter", function(self) groupHeader:LockHighlight() end)
        groupHeader.expandButton:SetScript("OnLeave", function(self) groupHeader:UnlockHighlight() end)
        groupHeader.expandButton:SetScript("OnMouseDown", function(self) if button == "LeftButton" then groupHeader:SetButtonState("PUSHED") end end)
        groupHeader.expandButton:SetScript("OnMouseUp", function(self) groupHeader:SetButtonState("NORMAL") end)
        groupHeader.expandButton:SetScript("OnClick", function(self) groupHeader:Click() end)

        groupHeader:SetScript("OnEnter", function(self)
            groupHeader.collapseButton:LockHighlight()
            groupHeader.expandButton:LockHighlight()
        end)
        groupHeader:SetScript("OnLeave", function(self)
            groupHeader.collapseButton:UnlockHighlight()
            groupHeader.expandButton:UnlockHighlight()
        end)
        groupHeader:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" then
                groupHeader.collapseButton:SetButtonState("PUSHED")
                groupHeader.expandButton:SetButtonState("PUSHED")
            end
        end)
        groupHeader:SetScript("OnMouseUp", function(self)
            groupHeader.collapseButton:SetButtonState("NORMAL")
            groupHeader.expandButton:SetButtonState("NORMAL")
        end)
        groupHeader:SetScript("OnClick", function(self, button)
            if S.collapsedGroups[self:GetID()] then
                S.collapsedGroups[self:GetID()] = nil
            else
                S.collapsedGroups[self:GetID()] = true
            end
            Sorted_SortItems(true)
        end)

        groupHeader:SetHeight(20)
        groupHeader:SetPoint("RIGHT")
        groupHeader.text = groupHeader:CreateFontString()
        groupHeader.text:SetFontObject(Sorted11Font)
        groupHeader.text:SetPoint("LEFT", 26, 0)
        groupHeader.text:SetDrawLayer("OVERLAY", 2)
        groupHeader.bg = groupHeader:CreateTexture()
        groupHeader.bg:SetTexture("Interface\\Addons\\Sorted\\Textures\\Shadow")
        groupHeader.bg:SetPoint("TOPLEFT", 0, 12)
        groupHeader.bg:SetPoint("BOTTOMRIGHT", groupHeader.text, "BOTTOMRIGHT", 16, -16)
        groupHeader.bg:SetDrawLayer("OVERLAY", 1)

        self.groupHeaders[i] = groupHeader
    end

    self.itemButtons = {}
    local index = 1
    local containers
    local maxSlots = 36
    if type == "REAGENT" then
        maxSlots = 98
    end
    if type == "BAGS" or type == "BANK" or type == "REAGENT" or type == "KEYRING" then
        containers = Sorted_ContainersOfType(type)
        if type == "KEYRING" then
            self.container = KEYRING_CONTAINER
        end
    elseif string.sub(type, 1, 9) == "CONTAINER" then
        self.container = tonumber(string.sub(type, 10))
        containers = { self.container }
    end
    for _, bag in pairs(containers) do
        for slot = 1, maxSlots do
            self.itemButtons[index] = Sorted_CreateItemButton(self.scrollChild, bag, slot)
            self.itemButtons[index].bag = bag
            self.itemButtons[index].slot = slot
            if type=="BANK" or type=="REAGENT" then
                self.itemButtons[index].isBankSlot = true
            end

            self.itemButtons[index].button:HookScript("OnEnter", function(self)
                if not Sorted_GetFavorited(self:GetParent():GetData()) then
                    self:GetParent().favoriteButton:GetNormalTexture():SetTexCoord(0, 0.21875, 0.21875 * 2, 0.21875 * 3)
                end
            end)

            self.itemButtons[index].button:HookScript("OnLeave", function(self)
                if not Sorted_GetFavorited(self:GetParent():GetData()) then
                    self:GetParent().favoriteButton:GetNormalTexture():SetTexCoord(1, 1, 1, 1)
                end
            end)

            --[[self.itemButtons[index].button:SetScript("OnClick", function(self, button)
                if IsModifiedClick() then
                    SortedItemButton_OnModifiedClick(self, button)
                else
                    ContainerFrameItemButton_OnClick(self, button)
                end
            end)]]
            --Sorted_Slots[index].button:SetScript("OnReceiveDrag", function(self) SortedItemButton_OnClick(self, "LeftButton") end)

            self.itemButtons[index].favoriteButton:HookScript("OnEnter", function(self)
                self:GetParent().mouseOver = true
            end)
            self.itemButtons[index].favoriteButton:HookScript("OnLeave", function(self)
                self:GetParent().button.highlight:Hide()
                self:GetParent().mouseOver = false
            end)

            self.itemButtons[index].favoriteButton:HookScript("OnClick", function(self, mouseButton)
                if SortedIconSelectionMenu:IsShown() then
                    SortedIconSelectionMenu:Hide()
                    return
                end
                if mouseButton == "LeftButton" then
                    Sorted_ToggleFavorite(self:GetParent():GetData())
                    Sorted_UpdateItemButtons()
                    Sorted_FilterItems()
                elseif mouseButton == "RightButton" then
                    SortedIconSelectionMenu.itemButton = self:GetParent()
                    local x,y = GetCursorPosition()
                    x,y = x/UIParent:GetEffectiveScale(), y/UIParent:GetEffectiveScale()
                    SortedIconSelectionMenu:SetPoint("LEFT", UIParent, "BOTTOMLEFT", x * (1 / SortedIconSelectionMenu:GetScale()) + 8, y * (1 / SortedIconSelectionMenu:GetScale()))
                    SortedIconSelectionMenu:Show()
                end
            end)

            index = index + 1
        end
    end

    self.scrollChild:EnableMouse("LeftButton")
    self.scrollChild:SetScript("OnReceiveDrag", SortedItemList_OnClick)

    self.itemDropButton = CreateFrame("Button", self:GetName().."ItemDropButton", self)
    self.itemDropButton:SetFrameLevel(self:GetFrameLevel() + 2)
    self.itemDropButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Slot")
    self.itemDropButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Slot-Highlight")
    self.itemDropButton.type = type
    if string.sub(type, 1, 9) == "CONTAINER" then
        self.itemDropButton:SetPoint("BOTTOMRIGHT", -21, 0)
        self.itemDropButton:SetSize(112, 54)
        self.itemDropButton:GetNormalTexture():SetTexCoord(0, 1, 0, 0.96875)
        self.itemDropButton:GetHighlightTexture():SetTexCoord(0, 1, 0, 0.96875)
    else
        self.itemDropButton:SetPoint("BOTTOMRIGHT", -21, -3)
        self.itemDropButton:SetSize(112, 56)
    end
    self.itemDropButton:GetHighlightTexture():SetAlpha(0.7)
    self.itemDropButton:SetScript("OnMouseDown", function(self) Sorted_PutItemInBags(self.type) end)
    self.itemDropButton:SetScript("OnReceiveDrag", function(self) Sorted_PutItemInBags(self.type) end)
    self.itemDropButton:SetScript("OnEnter", function(self)
        if GetCursorInfo() == "item" then
            SortedTooltip.Schedule(function()
                GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
                GameTooltip:ClearLines()
                if self.type == "REAGENT" then
                    GameTooltip:AddLine("Place item in your reagent bank")
                elseif string.sub(self.type, 1, 9) == "CONTAINER" then
                    GameTooltip:AddLine("Place item in this bag")
                else
                    GameTooltip:AddLine("Place item in your "..self.type:lower())
                end
                GameTooltip:Show()
            end)
        end
    end)
    self.itemDropButton:SetScript("OnLeave", SortedTooltip.Cancel)

    --[[local texL = self.itemDropButton:CreateTexture(self.itemDropButton:GetName().."TexL", "BACKGROUND")
    texL:SetPoint("TOPLEFT")
    texL:SetPoint("BOTTOMRIGHT", self.itemDropButton, "BOTTOMLEFT", 64, 0)
    texL:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Button-Mult")
    texL:SetTexCoord(0, 0.25, 0, 1)
    texL:SetBlendMode("MOD")
    local texR = self.itemDropButton:CreateTexture(self.itemDropButton:GetName().."TexR", "BACKGROUND")
    texR:SetPoint("TOPRIGHT")
    texR:SetPoint("BOTTOMLEFT", self.itemDropButton, "BOTTOMRIGHT", -160, 0)
    texR:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Button-Mult")
    texR:SetTexCoord(0.375, 1, 0, 1)
    texR:SetBlendMode("MOD")
    local texC = self.itemDropButton:CreateTexture(self.itemDropButton:GetName().."TexC", "BACKGROUND")
    texC:SetPoint("TOPRIGHT", texR, "TOPLEFT")
    texC:SetPoint("BOTTOMLEFT", texL, "BOTTOMRIGHT")
    texC:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Button-Mult", "BACKGROUND")
    texC:SetTexCoord(0.25, 0.375, 0, 1)
    texC:SetBlendMode("MOD")]]


    self.foregroundFrame = CreateFrame("Frame", self:GetName().."ForegroundFrame", self.scrollChild)
    self.foregroundFrame:SetAllPoints()
    if type=="REAGENT" then
        self.PurchaseButton:SetParent(self.foregroundFrame)
        self.CostMoneyFrame:SetParent(self.foregroundFrame)
    end
    self.warningString:SetParent(self.foregroundFrame)


    -- Create column separator lines, starting from the left
    local posX = 0
    local indexReached = 0
    for i, v in ipairs(Sorted_sortButtons) do
        if not v.dontDrawColumnSeparators then
            local columnSeparator = self.foregroundFrame:CreateTexture(self:GetName().."TexColSep"..i, "OVERLAY")
            columnSeparator:SetPoint("TOP")
            columnSeparator:SetPoint("BOTTOM")
            columnSeparator:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Column-Seperator")
            columnSeparator:SetTexCoord(0, 0.9375, 0.1, 0.1)
            columnSeparator:SetWidth(3.5)
            columnSeparator.relScrollBar = self.scrollBar
            if not v.columnSeparators then v.columnSeparators = {} end
            table.insert(v.columnSeparators, columnSeparator)
        end
    end

     if type == "BAGS" then
        self.ShouldUpdate = function(self) 
            return true 
        end
    elseif type == "BANK" then
        self.ShouldUpdate = function(self)
            return SortedBankSidePanel:IsShown()
        end
    elseif type == "REAGENT" then
        self.ShouldUpdate = function(self)
            return SortedReagentSidePanel:IsShown()
        end
    else
        self.ShouldUpdate = function(self)
            return _G["SortedBag"..self.container.."Frame"]:IsShown()
        end
    end

     self:HookScript("OnUpdate", SortedItemList_OnUpdate)
     
     table.insert(Sorted_itemLists, self)
end
