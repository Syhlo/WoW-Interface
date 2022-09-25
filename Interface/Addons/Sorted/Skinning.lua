local _, S = ...
local doSkinning = false

function S.InitialiseSkinning()
    if IsAddOnLoaded("AddOnSkins") and Sorted_GetSetting("skinning") == 2 then
        S.AS = unpack(AddOnSkins)
        Sorted.AddOnSkins = S.AS
        doSkinning = true
    end
end

function S.DoSkinning()
    return doSkinning
end

local function SkinDropdown(frame)
    S.AS:SkinArrowButton(frame, "down")
    local normalMask, disabledMask, pushedMask = frame:GetNormalTexture():GetMaskTexture(1), frame:GetDisabledTexture():GetMaskTexture(1), frame:GetPushedTexture():GetMaskTexture(1)
    normalMask:ClearAllPoints()
    normalMask:SetPoint("TOPLEFT", frame, "TOPRIGHT", -frame:GetHeight(), -1)
    normalMask:SetPoint("BOTTOMRIGHT", -4, 3)
    disabledMask:ClearAllPoints()
    disabledMask:SetPoint("TOPLEFT", frame, "TOPRIGHT", -frame:GetHeight(), -1)
    disabledMask:SetPoint("BOTTOMRIGHT", -4, 3)
    pushedMask:ClearAllPoints()
    pushedMask:SetPoint("TOPLEFT", frame, "TOPRIGHT", -frame:GetHeight(), -1)
    pushedMask:SetPoint("BOTTOMRIGHT", -4, 3)
end

function S:SkinCheckBox(cb)
    S.AS:SkinCheckBox(cb)
    cb.hilight:SetColorTexture(unpack(S.AS.Color))
    cb.hilight:SetAlpha(0.3)
end

function S.Skin()
    if S.DoSkinning() then
        -- ITEM LISTS
        for _, itemList in pairs(Sorted_itemLists) do
            --S.AS:StripTextures(itemList)
            S.AS:SkinScrollBar(itemList.scrollBar)
            for _, groupHeader in pairs(itemList.groupHeaders) do
                S.AS:SkinArrowButton(groupHeader.expandButton, "right")
                S.AS:SkinArrowButton(groupHeader.collapseButton, "down")
                groupHeader.bg:Hide()
            end
        end
        --S.AS:SkinFrame(SortedIconSelectionMenu, "Default")

        -- DROPDOWN MENUS
        S.AS:SkinFrame(SortedDropdownMenuParent, "Default")

        -- MAIN FRAME
        S.AS:SkinFrame(SortedFrame)
        if Sorted_WoWMajorVersionNumber() < 8 then
            SortedFramePortraitFrame:Hide()
        end

        -- Title bar
        SortedFrameCloseButton:SetPoint("TOPRIGHT", 3, 5)
        S.AS:SkinMaxMinFrame(SortedMinMaxFrame)
        SortedFrameTitleBarMinimizeButtonDiv:Hide()
        SortedFrameTitleBarBlizzardButtonDiv:Hide()
        SortedBlizzardButton:ClearAllPoints()
        SortedBlizzardButton:SetSize(36, 16)
        SortedBlizzardButton:SetPoint("RIGHT", SortedMinMaxFrame, "LEFT", -2, 0)
        SortedBlizzardButton:SetText("ElvUI")
        SortedBlizzardButton:SetNormalFontObject(Sorted12Font)
        S.AS:SkinButton(SortedBlizzardButton, true)
        SkinDropdown(SortedAltsDropdownButton)
        SortedAltsDropdownButton:SetAlpha(1)
        SortedAltsDropdownButton:SetPoint("TOPLEFT", -1, -4)
        SkinDropdown(SortedEquipmentSetsDropdownButton)
        SortedEquipmentSetsDropdownButton:SetAlpha(1)
        SortedEquipmentSetsDropdownButton:SetPoint("TOPLEFT", SortedAltsDropdownButton, "TOPRIGHT", 4, 0)
        SortedFrameTitleBarAltsButtonDiv:Hide()
        S.AS:StripTextures(SortedEquipmentSetsDropdownButtonDiv)
        S.AS:SkinButton(SortedFramePortraitButton)
        S.AS:SkinEditBox(SortedFrameSearchBox)
        S.AS:StripTextures(SortedFrameSearchBoxFrame)
        SortedFrameSearchBoxFrame:SetPoint("TOPLEFT", 4, -2)
        SortedFrameSearchBoxFrame:SetHeight(24)
        SortedFrameSearchBox:SetPoint("TOPLEFT", 56, 0)
        SortedFrameSearchBox:SetPoint("BOTTOM", 0, 2)
        S.AS:SkinButton(SortedFrameSellGreysButton)

        SortedFramePortraitButton.dontAnimate = true
        SortedFramePortraitButton.textTexture:SetAlpha(1)
        SortedFramePortraitButton.textTexture:SetTexture("Interface\\Addons\\Sorted\\Textures\\Title-Flat")
        SortedFramePortraitButton.textTexture:SetTexCoord(0, 0.625, 0, 1)
        SortedFramePortraitButton.textTexture:SetSize(50, 20)
        SortedFramePortraitButton:ClearAllPoints()
        SortedFramePortraitButton:SetPoint("TOPLEFT", 4, -4)
        SortedFramePortraitButton:SetPoint("RIGHT", SortedAltsDropdownButton, "LEFT", -4, 0)
        SortedFramePortraitButton:SetPoint("BOTTOM", SortedFrameSearchBoxFrame, "BOTTOM", 0, 1)

        S.AS:StripTextures(SortedFrameMain)

        -- Sort buttons
        S.AS:StripTextures(SortedFrameSortButtons)
        SortedFrameSortButtons:SetPoint("RIGHT", -20, 0)
        for k, v in pairs(Sorted_sortButtons) do
            if v.uniqueID == SORTED_SORTBUTTON_FAVORITES then
                S.AS:SkinFrame(v.button, "Default", true)
                v.button.l:Hide()
                v.button.c:Hide()
                v.button.r:Hide()
            else
                S.AS:SkinButton(v.button, true)
            end
            if v.columnSeparators then
                for _, colSep in pairs(v.columnSeparators) do
                    colSep:SetAlpha(0)
                end
            end
        end

        -- Categories
        S.AS:SkinFrame(SortedFrameFilterButtons)
        for i = 1, 22 do
            local button, miniButton = _G["SortedFilterButton"..i], _G["SortedFilterButton"..i.."Mini"]
            S.AS:SkinButton(button)
            button.selectedTexture:SetColorTexture(unpack(S.AS.Color))
            button.selectedTexture:SetBlendMode("ADD")
            button.selectedTexture:SetAlpha(0.3)
            button:SetHeight(button:GetHeight() - 1)
            S.AS:StripTextures(button.newItemsIndicator)

            _G["SortedFilterButton"..i.."MiniBackdrop"]:Hide()
            S.AS:SkinIconButton(miniButton)
            miniButton:GetHighlightTexture():SetColorTexture(unpack(S.AS.Color))
            miniButton:GetHighlightTexture():SetBlendMode("ADD")
            miniButton:GetHighlightTexture():SetAlpha(0.3)
            miniButton.selectedTexture:SetColorTexture(unpack(S.AS.Color))
            miniButton.selectedTexture:SetBlendMode("ADD")
            miniButton.selectedTexture:SetAlpha(0.4)
            S.AS:SkinFrame(miniButton.newItemsIndicator)
            miniButton.newItemsIndicator:SetWidth(36)
            miniButton.newItemsIndicator:SetPoint("LEFT", miniButton, "RIGHT", 4, 0)
        end
        S.AS:SkinFrame(SortedSubcategoryFrameParent)
        --SortedSubcategoryFrameParent:SetPoint("TOPLEFT", SortedFrameFilterButtons, "BOTTOMLEFT", 0, -4)
        S.AS:SkinScrollBar(SortedSubcategoryFrameScrollBar)

        -- Item list
        SortedFrameItemList:SetPoint("TOPLEFT", SortedFrameSortButtons, "BOTTOMLEFT", 0, 1)
        SortedFrameItemList:SetPoint("RIGHT", -24, 0)
        SortedFrameItemListScrollBar:SetPoint("TOPRIGHT", 22, 7)
        SortedFrameItemListScrollBar:SetPoint("BOTTOM", 0, 14)

        -- Footer
        S.AS:SkinFrame(SortedFrameFootSlots)
        SortedFrameFootSlots:SetPoint("BOTTOMLEFT", 4, 3)
        S.AS:StripTextures(SortedFrameFootBags)
        for i = 0,3 do
            S.AS:SkinIconButton(_G["Sorted___Bag"..i.."Slot"])
        end
        SortedFrameFootBags:SetPoint("BOTTOMLEFT", SortedFrameFootSlots, "BOTTOMRIGHT", 3, 0)
        S.AS:StripTextures(SortedFrameFootCenter)
        SortedFrameResizeHandle:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\UI-Resize-Button-Highlight")
        SortedFrameResizeHandle:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\UI-Resize-Button-Highlight")
        S.AS:StripTextures(SortedFrameMoneyFrame)
        S.AS:SkinFrame(SortedFrameMoneyInnerFrame)
        S.AS:StripTextures(SortedFrameFootRight)
        S.AS:SkinFrame(SortedCurrencyFrame)
        SortedCurrencyFrame:SetPoint("TOPRIGHT", SortedFrame, "BOTTOMRIGHT", -24, 1)
        SortedCurrencyFrameText:SetPoint("BOTTOM", 0, 2)

        -- Item buttons
        for _, itemList in pairs(Sorted_itemLists) do
            for _, itemButton in pairs(itemList.itemButtons) do
                itemButton.bgTex:Hide()
            end
        end

        -- Side tabs
        SortedTabsFrame.UpdateWidths = function(self)
            for _, tab in pairs(self.tabs) do
                tab:SetHeight(tab.buttonText:GetWidth() + 16)
            end
        end
        S.AS:SkinButton(SortedTabBank, true)
        S.AS:SkinButton(SortedTabReagents, true)
        SortedTabReagents:SetPoint("BOTTOMRIGHT", SortedTabBank, "TOPRIGHT", 0, 8)


        -- BANK SIDE PANEL
        S.AS:SkinFrame(SortedBankSidePanel)
        SortedBankSidePanel:SetPoint("TOPRIGHT", SortedFrameSortButtons, "BOTTOMLEFT", -3, 4)
        S.AS:StripTextures(SortedBankSidePanelLeftFrame)
        -- Footer
        S.AS:StripTextures(SortedBankSidePanelFootCenter)
        S.AS:SkinFrame(SortedBankSidePanelFootBags)
        SortedBankSidePanelShadowFrame:Hide()
        for _, button in pairs(Sorted_BankContainerSlots) do
            S.AS:SkinIconButton(button)
        end
        S.AS:SkinFrame(SortedBankSidePanelFootSlots)
        SortedBankSidePanelFootSlots:SetPoint("BOTTOMLEFT", 1, 1)
        SortedBankSidePanelFootBags:SetPoint("BOTTOMLEFT", SortedBankSidePanelFootSlots, "BOTTOMRIGHT", 3, 0)
        SortedBankSidePanelFoot:SetHeight(30)
        -- Item list
        SortedBankItemList:SetPoint("BOTTOMRIGHT", -21, 2)
        SortedBankItemListScrollBar:SetPoint("TOPRIGHT", 22, -14)
        SortedBankItemListScrollBar:SetPoint("BOTTOM", 0, 14)


        -- REAGENTS SIDE PANEL
        S.AS:SkinFrame(SortedReagentSidePanel)
        SortedReagentSidePanel:SetPoint("TOPRIGHT", SortedFrameSortButtons, "BOTTOMLEFT", -3, 4)
        S.AS:StripTextures(SortedReagentSidePanelLeftFrame)
        -- Footer
        S.AS:StripTextures(SortedReagentSidePanelFootCenter)
        SortedReagentSidePanelShadowFrame:Hide()
        S.AS:SkinFrame(SortedReagentSidePanelFootSlots)
        SortedReagentSidePanelFootSlots:SetPoint("BOTTOMLEFT", 1, 1)
        S.AS:SkinButton(SortedReagentSidePanelFootCenterDepositButton)
        SortedReagentSidePanelFoot:SetHeight(30)
        -- Item list
        if Sorted_IsShadowlands() then
            SortedReagentItemList:SetPoint("BOTTOMRIGHT", -21, 2)
            SortedReagentItemListScrollBar:SetPoint("TOPRIGHT", 22, -14)
            SortedReagentItemListScrollBar:SetPoint("BOTTOM", 0, 14)
            S.AS:SkinButton(SortedReagentItemListPurchaseButton)
        end


        -- INDIVIDUAL BAG FRAMES
        for _, bagFrame in pairs(S.bagFrames) do
            S.AS:SkinFrame(bagFrame)
            --_G[bagFrame:GetName().."Portrait"]:Hide()
            bagFrame.skinnedPortrait = bagFrame:CreateTexture()
            --bagFrame.skinnedPortrait:SetPoint("TOPLEFT", 2, -2)
            --bagFrame.skinnedPortrait:SetSize(48, 48)
            S.AS:StripTextures(_G[bagFrame:GetName().."Head"])
            S.AS:SkinFrame(_G[bagFrame:GetName().."Slots"])
        end


        -- Backdrops
        SortedFrame.Center:Hide()
        SortedFrameBg:SetAllPoints()
        _G[SortedFrame:GetName().."DropShadow"]:SetAllPoints()

        SortedBankSidePanel.Center:Hide()
        SortedBankSidePanel.bg:SetAllPoints()
        _G[SortedBankSidePanel:GetName().."DropShadow"]:SetAllPoints()

        SortedReagentSidePanel.Center:Hide()
        SortedReagentSidePanel.bg:SetAllPoints()
        _G[SortedReagentSidePanel:GetName().."DropShadow"]:SetAllPoints()

        for _, bagFrame in pairs(S.bagFrames) do
            bagFrame.Center:Hide()
            bagFrame.bg:SetAllPoints()
            _G[bagFrame:GetName().."DropShadow"]:SetAllPoints()
        end

        Sorted_UpdateBackdropTexture()
    end
end