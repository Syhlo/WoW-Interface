local _, S = ...

local Sorted_maxILvl = 0 -- ilvl opacity is set against this

function SortedItemButton_Update(self)
    local data = self:GetData()
    self.empty = true
    if data.itemID then
        if not data.level then
            SortedContainerItemInfo_Update(self.bag, self.slot, Sorted_SelectedPlayerGUID)
        end
        self.empty = false

        if data.name then
            --self.statTable = GetItemStats(data.link)

            self.itemString = string.match(data.link, "item[%-?%d:]+")

            if not Sorted_IsClassic() and CanIMogIt then
                self.transmogValue = CanIMogIt:GetIconText(data.link)
                self.transmogString:SetText(self.transmogValue)

                --[[self.transmogValue = Sorted_TransmogCollected(data.itemID, data.link)
                
                if self.transmogValue >= 3 then
                    self.transmogString:SetText("Learnt")
                elseif self.transmogValue >= 1 then
                    self.transmogString:SetText("Unlearnt")
                else
                    self.transmogString:SetText("")
                end

                if self.transmogValue == 4 then
                    local r,g,b = Sorted_GetItemQualityColor(2)
                    self.transmogString:SetTextColor(r,g,b)
                elseif self.transmogValue == 3 then
                    local r,g,b = Sorted_GetItemQualityColor(6)
                    self.transmogString:SetTextColor(r,g,b)
                elseif self.transmogValue == 2 then
                    local r,g,b = Sorted_GetItemQualityColor(6)
                    self.transmogString:SetTextColor(r,g,b)
                elseif self.transmogValue == 1 then
                    local r,g,b = Sorted_GetItemQualityColor(6)
                    self.transmogString:SetTextColor(r,g,b)
                else
                    local r,g,b = Sorted_GetItemQualityColor(5)
                    self.transmogString:SetTextColor(r,g,b)
                end
    
                --self.transmogString:SetText(self.transmogValue)]]
            end

            if S.IsCurrentPlayerSelected() and data.effectiveILvl and data.effectiveILvl > Sorted_maxILvl then 
                Sorted_maxILvl = data.effectiveILvl 
            end
            
            if self:IsNew() and S.IsCurrentPlayerSelected() then
                if self:IsNew() > 0 then
                    self.newItemHighlight:SetAlpha(1)
                    self.newItemHighlight.pulse:Play()
                    self.newItemHighlight.pulse:SetLooping("REPEAT")
                else
                    self.newItemHighlight.pulse:Stop()
                    self.newItemHighlight:SetAlpha(0.4)
                end
                self.newItemHighlight:SetPoint("TOPLEFT", -100, -1)
                self.newItemHighlight:SetPoint("BOTTOMRIGHT", 100, 1)
                self.newItemHighlight:Show()
            else
                self.newItemHighlight:Hide()
                self.newItemHighlight:ClearAllPoints()
                self.newItemHighlight.pulse:Stop()
            end

            if data.count > 1 then
                self.quantityString:SetText(data.count)
            else
                self.quantityString:SetText("")
            end

            self.itemIcon:SetTexture(data.texture)
            -- Battle pets
            if self.cageName then
                data.name = "Caged ".. self.cageName
                self.nameString:SetText(data.name)
                self.levelString:SetTextColor(1, 0.92, 0.8, (self.petLevel / 25.0 * 0.65) + 0.35)
                self.levelString:SetText(self.petLevel)
                data.effectiveILvl = tonumber(self.petLevel)

            -- Everything else
            else
                self.nameString:SetText(data.name)
                if (data.effectiveILvl and data.effectiveILvl > 1) then
                    self.levelString:SetText(data.effectiveILvl)
                    local alpha = data.effectiveILvl / Sorted_maxILvl
                    alpha = alpha * alpha * 0.65 + 0.35
                    if alpha > 1 then alpha = 1 end
                    self.levelString:SetTextColor(1, 0.92, 0.8, alpha)
                else
                    self.levelString:SetText("")
                    data.effectiveILvl = 0
                end
            end
            local r,g,b = Sorted_GetItemQualityColor(data.quality)
            self.nameString:SetTextColor(r,g,b,1)


            if data.minLevel > UnitLevel("player") then
                self.minLevelString:SetTextColor(1, 0.3, 0.2, 0.8)
                self.minLevelString:SetText(data.minLevel)
            elseif (data.minLevel > 1) then
                self.minLevelString:SetText(data.minLevel)
                local alpha = data.minLevel / UnitLevel("player")
                alpha = alpha * alpha * 0.65 + 0.35
                if alpha > 1 then alpha = 1 end
                self.minLevelString:SetTextColor(1, 0.92, 0.8, alpha)
            else
                self.minLevelString:SetText("")
            end

            if (data.value > 0 and not data.hasNoValue) then
                self.valueString:SetText(Sorted_FormatValueString(data.value * data.count))
                local color = Sorted_GetValueColor(data.value * data.count)
                self.valueString:SetTextColor(color.r, color.g, color.b)
            else
                self.valueString:SetText("")
            end

            local size = Sorted_GetSetting("iconSize")
            if data.bindType > 0 then
                if data.bindType == 4 then data.bindType = 1 end -- Treat quest items as BoP
                local x = (data.bindType - 1) / 4
                local y
                if data.bound then y = 0 else y = 0.5 end
                self.bindIcon:SetTexCoord(x, x + 0.25, y, y + 0.5)
                self.bindIcon:SetSize(size * 0.9, size * 0.9)
            else
                self.bindIcon:SetTexCoord(1.1,1.1,1.1,1.1)
            end

            self.trashButton:SetSize(size * 0.9, size * 0.9)
            if data.hasNoValue then
                self.trashButton:GetNormalTexture():SetTexCoord(0, 0, 0, 0)
                self.trashButton:GetHighlightTexture():SetTexCoord(0, 0, 0, 0)
            elseif Sorted_GetTrash(data) <= 1 then
                self.trashButton:GetNormalTexture():SetTexCoord(0.25, 0.5, 0, 0.5)
                self.trashButton:GetHighlightTexture():SetTexCoord(0.25, 0.5, 0.5, 1)
            else
                self.trashButton:GetNormalTexture():SetTexCoord(0, 0.25, 0, 0.5)
                self.trashButton:GetHighlightTexture():SetTexCoord(0, 0.25, 0.5, 1)
            end

            if data.classID then
                self.typeString:SetText(GetItemClassInfo(data.classID))
                self.subtypeString:SetText(S.GetItemSubClassInfo(data.classID, data.subClassID))
                local x = (data.classID % 8) / 8
                local y = math.floor(data.classID / 8) / 8
                --self.typeIcon:SetText(string.format("|TInterface\\Addons\\Sorted\\Textures\\Type-Icons:%d:%d:0:0:256:256:%d:%d:%d:%d|t", size * 1.1, size * 1.1, x, x+32, y, y+32))
                self.typeIcon:SetTexCoord(x, x + 0.125, y, y + 0.125)
                self.typeIcon:SetSize(size * 0.9, size * 0.9)
            else
                self.typeString:SetText("")
                self.typeIcon:SetTexCoord(0.7,0.7,0.7,0.7)
            end

            --self.expacString:SetText(Sorted_FormatExpac(data.expacID))
            if data.expacID >= 0 then
                local x = ((data.expacID) % 4) / 4
                local y = math.floor((data.expacID) / 4) / 8
                self.expacIcon:SetTexCoord(x, x + 0.25, y, y + 0.125)
                self.expacIcon:SetSize(size * 2.2, size * 1.1)
            else
                self.expacIcon:SetTexCoord(1.1,1.1,1.1,1.1)
            end

            self.favoriteButton:SetWidth(size)
            self.favoriteButton:SetHeight(size + Sorted_GetSetting("padding"))
            size = 8 + size * 0.4
            self.favoriteButton:GetNormalTexture():SetSize(size * 0.9, size * 0.9)
            self.favoriteButton:GetHighlightTexture():SetSize(size * 0.9, size * 0.9)
            self.favoriteButton:GetPushedTexture():SetSize(size * 0.9, size * 0.9)
            if Sorted_GetFavorited(data) then
                -- Only animate if icon has changed
                if not self.previousFavorited or self.previousFavorited ~= Sorted_GetFavorited(data) then 
                    self.favoriteButton:GetNormalTexture():SetTexCoord(
                        (math.fmod(Sorted_GetFavorited(data) - 1, 4)) * 0.21875, 
                        (math.fmod(Sorted_GetFavorited(data) - 1, 4) + 1) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(data) - 1) / 4)) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(data) - 1) / 4) + 1) * 0.21875
                    )
                    self.favoriteButton:GetHighlightTexture():SetTexCoord(
                        (math.fmod(Sorted_GetFavorited(data) - 1, 4)) * 0.21875, 
                        (math.fmod(Sorted_GetFavorited(data) - 1, 4) + 1) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(data) - 1) / 4)) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(data) - 1) / 4) + 1) * 0.21875
                    )
                    self.favoriteButton:GetPushedTexture():SetTexCoord(
                        (math.fmod(Sorted_GetFavorited(data) - 1, 4)) * 0.21875, 
                        (math.fmod(Sorted_GetFavorited(data) - 1, 4) + 1) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(data) - 1) / 4)) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(data) - 1) / 4) + 1) * 0.21875
                    )
                    self.favoriteButtonEnabled = true
                    self.favoriteButton.fade:Stop()
                    self.favoriteButton.pulse:Play()
                    self.previousFavorited = Sorted_GetFavorited(data)
                end
            -- Restore to default grey star
            elseif self.previousFavorited then
                self.favoriteButton:GetHighlightTexture():SetTexCoord(
                    0, 
                    0.21875, 
                    0, 
                    0.21875
                )
                self.favoriteButton.pulse:Stop()
                --self.favoriteButton.fade:Play()
                self.favoriteButton:GetNormalTexture():SetTexCoord(1,1,1,1)
                self.favoriteButton:GetPushedTexture():SetTexCoord(1,1,1,1)
                self.previousFavorited = 0
            end

            local r,g,b = Sorted_GetItemQualityHighlightColor(data.quality)
            self.button.iconGlow:SetVertexColor(r, g, b, 1)
            self.button.highlight:SetVertexColor(r, g, b, 1)
            r,g,b = Sorted_GetItemQualityHighlightTextColor(data.quality)
            self.button.pushed:SetVertexColor(r, g, b, 0.6)
            if not S.IsCurrentPlayerSelected() or (self.isBankSlot and not Sorted_bankIsOpened) then
                if not self.button.unclickable then
                    self.button.unclickable = true
                    self.button:RegisterForClicks()
                    self.button:RegisterForDrag()
                end
            elseif self.button.unclickable then
                self.button.unclickable = nil
                self.button:RegisterForClicks("AnyUp")
                self.button:RegisterForDrag("LeftButton")
            end
            
            if not Sorted_IsClassic() and S.IsCurrentPlayerSelected() and self:IsUpgrade() and Sorted_enabledColumns[SORTED_SORTBUTTON_UPGRADE] then
                self.upgradeIcon:SetTexCoord(0.3125,0.390625,0.6484375,0.734375)
                self.upgradeIcon:SetSize(size * 0.9, size * 0.9)
            else
                self.upgradeIcon:SetTexCoord(1,1,1,1)
            end
        else
            self.empty = true
        end
    end
    if self.empty then 
        self:Hide()
    else
        self:Show()
    end
end


-- TOOLTIPS
function SortedItemButton_CalculateItemTooltipAnchors(self, mainTooltip)
	local x = self:GetRight();
	local anchorFromLeft = x < GetScreenWidth() / 2;
	--[[if ( anchorFromLeft ) then
		mainTooltip:SetAnchorType("ANCHOR_CURSOR", 0, 0);
		mainTooltip:SetPoint("LEFT", self, "RIGHT");
	else
		mainTooltip:SetAnchorType("ANCHOR_CURSOR", 0, 0);
		mainTooltip:SetPoint("RIGHT", self, "LEFT");
	end]]
	if ( anchorFromLeft ) then
		mainTooltip:SetAnchorType("ANCHOR_RIGHT", 0, 0);
		mainTooltip:SetPoint("BOTTOMLEFT", self, "TOPRIGHT");
	else
		mainTooltip:SetAnchorType("ANCHOR_LEFT", 0, 0);
		mainTooltip:SetPoint("BOTTOMRIGHT", self, "TOPLEFT");
	end
end

function SortedItemButton_OnEnter(self)
    local parent = self:GetParent()
    local button = self
    local itemData = parent:GetData()
    if S.IsCurrentPlayerSelected() then
        if parent:IsNew() and parent:IsNew() >= 0 then
            Sorted_GetData().newItems[Sorted_ItemKey(itemData.link)] = -1
        end
        parent.newItemHighlight.pulse:Stop()
        parent.newItemHighlight:SetAlpha(0.4)
        C_NewItems.RemoveNewItem(parent:GetID(), button:GetID());

        local showSell = nil;
        if ( MerchantFrame:IsShown() and MerchantFrame.selectedTab == 1 ) then
            showSell = 1;
        end

        if ( IsModifiedClick("DRESSUP") and self.hasItem ) then
            ShowInspectCursor();
        elseif ( showSell ) then
            ShowContainerSellCursor(self:GetParent():GetID(),self:GetID());
        elseif ( self.readable ) then
            ShowInspectCursor();
        else
            ResetCursor();
        end

        if ArtifactFrame and self.hasItem then
            ArtifactFrame:OnInventoryItemMouseEnter(self:GetParent():GetID(), self:GetID());
        end
    end
    SortedTooltip.Schedule(function()
        SortedItemButton_DelayedOnEnter(self)
    end)
end

function SortedItemButton_DelayedOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE");

    if S.IsCurrentPlayerSelected() and not (self:GetParent().isBankSlot and not Sorted_bankIsOpened) then
        -- Keyring specific code
        if ( self:GetParent():GetID() == KEYRING_CONTAINER ) then
            SortedItemButton_CalculateItemTooltipAnchors(self, GameTooltip);
            GameTooltip:SetInventoryItem("player", KeyRingButtonIDToInvSlotID(self:GetID()));
            CursorUpdate(self);
            return;
        end

        C_NewItems.RemoveNewItem(self:GetParent():GetID(), self:GetID());

        local newItemTexture = self.NewItemTexture;
        local battlepayItemTexture = self.BattlepayItemTexture;
        local flash = self.flashAnim;
        local newItemGlowAnim = self.newitemglowAnim;
        
        if battlepayItemTexture then battlepayItemTexture:Hide() end
        if flash and newItemGlowAnim and (flash:IsPlaying() or newItemGlowAnim:IsPlaying()) then
            flash:Stop();
            newItemGlowAnim:Stop();
        end
	
        local hasItem, hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name
        if self:GetParent():GetID() == BANK_CONTAINER or (not Sorted_IsClassic() and self:GetParent():GetID() == REAGENTBANK_CONTAINER) then
            hasItem, hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = GameTooltip:SetInventoryItem("player", self:GetInventorySlot())
        else
            hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = GameTooltip:SetBagItem(self:GetParent():GetID(), self:GetID());
        end
        if(speciesID and speciesID > 0) then
            SortedItemButton_CalculateItemTooltipAnchors(self, GameTooltip); -- Battle pet tooltip uses the GameTooltip's anchor
            BattlePetToolTip_Show(speciesID, level, breedQuality, maxHealth, power, speed, name);
            return;
        else
            if (BattlePetTooltip) then
                BattlePetTooltip:Hide();
            end
        end
    else
        if self:GetParent():GetData().classID ~= LE_ITEM_CLASS_BATTLEPET then
            GameTooltip:SetHyperlink(Sorted_GetContainerItemInfo(self:GetParent():GetID(), self:GetID(), Sorted_SelectedPlayerGUID).link)
        else
            return
        end
    end

	SortedItemButton_CalculateItemTooltipAnchors(self, GameTooltip);

	if ( IsModifiedClick("COMPAREITEMS") or GetCVarBool("alwaysCompareItems") ) then
		GameTooltip_ShowCompareItem(GameTooltip);
	end

	if ( InRepairMode() and (repairCost and repairCost > 0) ) then
		GameTooltip:AddLine(REPAIR_COST, nil, nil, nil, true);
		SetTooltipMoney(GameTooltip, repairCost);
		GameTooltip:Show();
	end

    if not Sorted_IsClassic() then
        if not GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_MOUNT_EQUIPMENT_SLOT_FRAME) then
            local itemLocation = ItemLocation:CreateFromBagAndSlot(self:GetParent():GetID(), self:GetID());
            if itemLocation and itemLocation:IsValid() then
                if C_MountJournal.IsMountEquipmentUnlocked and C_MountJournal.IsMountEquipmentUnlocked() and (not CollectionsJournal or not CollectionsJournal:IsShown()) then
                    local tabIndex = 1;
                    CollectionsMicroButton_SetAlertShown(tabIndex);
                end
            end
        end
    end

    if Sorted_GetSetting("tooltipInfo") == 2 then
        Sorted_AddToTooltip(GameTooltip, self:GetParent():GetID(), self:GetID())
    end
end

function Sorted_CreateItemButton(self, bag, slot)
    local frameName = "SortedSlot_Bag"..bag.."Item"..slot

    local parent = CreateFrame("Frame", frameName, self)
    parent:SetHeight(20)
    parent:SetID(bag)

    -- Returns a table with a whole bunch of item data. Check Sorted_GetContainerItemInfo in Data.lua for all the table attributes
    function parent:GetData()
        return Sorted_GetContainerItemInfo(self.bag, self.slot, Sorted_SelectedPlayerGUID)
    end

    function parent:IsUpgrade()
        return S.IsContainerItemAnUpgrade(self.bag, self.slot)
    end

    parent.itemList = self:GetParent()

    parent.favoriteButton = CreateFrame("Button", parent:GetName().."FavoriteButton", parent)
    parent.favoriteButton:SetSize(19,19)
    parent.favoriteButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
    parent.favoriteButton:GetNormalTexture():SetTexCoord(1, 1, 1, 1)
    parent.favoriteButton:GetNormalTexture():ClearAllPoints()
    parent.favoriteButton:GetNormalTexture():SetPoint("CENTER")
    parent.favoriteButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
    parent.favoriteButton:GetHighlightTexture():SetTexCoord(0, 0.21875, 0, 0.21875)
    parent.favoriteButton:GetHighlightTexture():ClearAllPoints()
    parent.favoriteButton:GetHighlightTexture():SetPoint("CENTER")
    parent.favoriteButton:GetHighlightTexture():SetAlpha(0.5)
    parent.favoriteButton:GetHighlightTexture():SetBlendMode("ADD")
    parent.favoriteButton:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
    parent.favoriteButton:GetPushedTexture():SetTexCoord(1, 1, 1, 1)
    parent.favoriteButton:GetPushedTexture():ClearAllPoints()
    parent.favoriteButton:GetPushedTexture():SetPoint("CENTER")
    parent.favoriteButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    parent.favoriteButton.pulse = parent.favoriteButton:CreateAnimationGroup()
    local anim = parent.favoriteButton.pulse:CreateAnimation("Scale")
    anim:SetOrder(1)
    anim:SetFromScale(1, 1)
    anim:SetToScale(1.2, 1.2)
    anim:SetDuration(0.2)
    anim:SetSmoothing("OUT")
    anim = parent.favoriteButton.pulse:CreateAnimation("Scale")
    anim:SetOrder(2)
    anim:SetFromScale(1, 1)
    anim:SetToScale(0.833333, 0.833333)
    anim:SetDuration(0.2)
    anim:SetSmoothing("IN")
    parent.favoriteButton.fade = parent.favoriteButton:CreateAnimationGroup()
    anim = parent.favoriteButton.fade:CreateAnimation("Alpha")
    anim:SetFromAlpha(1)
    anim:SetToAlpha(0.2)
    anim:SetDuration(0.2)
    parent.favoriteButton.fade:HookScript("OnFinished", function(self)
        self:GetParent():GetNormalTexture():SetTexCoord(1, 1, 1, 1)
    end)

    parent.quantityString = parent:CreateFontString(parent:GetName().."QuantityString", "OVERLAY", "Sorted11Font")
    --parent.quantityString:SetPoint("RIGHT", parent, "LEFT", 50, 0)
    parent.quantityString:SetPoint("TOP")
    parent.quantityString:SetPoint("BOTTOM")
    parent.quantityString:SetJustifyH("RIGHT")
    parent.quantityString:SetJustifyV("MIDDLE")
    parent.quantityString:SetTextColor(0.96, 0.9, 0.82, 1)
    --parent.quantityString:SetWidth(Sorted_GetSortButton(SORTED_SORTBUTTON_QUANTITY).width)

    parent.nameFrame = CreateFrame("Frame", parent:GetName().."NameFrame", parent)
    parent.nameFrame:SetPoint("TOP", 0, -2)
    parent.nameFrame:SetPoint("BOTTOM", 0, 2)
    parent.nameFrame.leftX = 0
    parent.nameFrame.rightX = 0
    parent.nameString = parent.nameFrame:CreateFontString(parent:GetName().."NameString", "OVERLAY", "Sorted11Font")
    --parent.nameString:SetPoint("LEFT", 78, 0)
    --parent.nameString:SetPoint("RIGHT", -92, 0)
    parent.nameString:SetAllPoints()
    parent.nameString:SetJustifyH("LEFT")
    parent.nameString:SetJustifyV("MIDDLE")

    parent.levelString = parent:CreateFontString(parent:GetName().."LevelString", "OVERLAY", "Sorted11Font")
    --parent.levelString:SetPoint("LEFT", parent, "RIGHT", -88, 0)
    parent.levelString:SetTextColor(1, 0.92, 0.8)
    --parent.levelString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_LEVEL].width)

    parent.upgradeIcon = parent:CreateTexture(parent:GetName().."UpgradeIcon")
    parent.upgradeIcon:SetTexture("Interface/ContainerFrame/Bags")

    parent.minLevelString = parent:CreateFontString(parent:GetName().."MinLevelString", "OVERLAY", "Sorted11Font")
    parent.minLevelString:SetTextColor(1, 0.92, 0.8)
    --parent.minLevelString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_REQUIRED_LEVEL].width)

    parent.valueString = parent:CreateFontString(parent:GetName().."ValueString", "OVERLAY", "Sorted11Font")
    --parent.valueString:SetPoint("RIGHT", -4, 0)
    parent.valueString:SetPoint("TOP")
    parent.valueString:SetPoint("BOTTOM")
    parent.valueString:SetJustifyH("RIGHT")
    parent.valueString:SetJustifyV("MIDDLE")
    --parent.valueString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_VALUE].width)

    --parent.bindString = parent:CreateFontString(parent:GetName().."BindString", "OVERLAY", "Sorted11Font")
    --parent.bindString:SetJustifyH("CENTER")
    --parent.bindString:SetJustifyV("MIDDLE")
    --parent.bindString:SetTextColor(1, 0.92, 0.8)
    --parent.bindString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_BIND].width)
    parent.bindIcon = parent:CreateTexture(parent:GetName().."BindIcon")
    parent.bindIcon:SetTexture("Interface\\Addons\\Sorted\\Textures\\Bind-Icons")
    
    parent.trashButton = CreateFrame("Button", parent:GetName().."TrashButton", parent) --parent:CreateTexture(parent:GetName().."TrashIcon")
    parent.trashButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Trash-Icons")
    parent.trashButton:GetNormalTexture():SetTexCoord(0,0.25,0,0.5)
    parent.trashButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Trash-Icons")
    parent.trashButton:GetHighlightTexture():SetTexCoord(0,0.25,0.5,1)
    parent.trashButton:SetScript("OnMouseDown", function(self)
        local itemData = self:GetParent():GetData()
        if not itemData.hasNoValue then
            Sorted_ToggleTrash(itemData)
            Sorted_UpdateItemButtons()
            Sorted_FilterItems()
        end
    end)

    parent.transmogString = parent:CreateFontString(parent:GetName().."TransmogString", "OVERLAY", "Sorted11Font")
    parent.transmogString:SetJustifyH("CENTER")
    parent.transmogString:SetJustifyV("MIDDLE")
    parent.transmogString:SetTextColor(1, 0.92, 0.8)
    --parent.transmogString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_TRANSMOG].width)

    parent.typeString = parent:CreateFontString(parent:GetName().."TypeString", "OVERLAY", "Sorted11Font")
    parent.typeString:SetPoint("TOP")
    parent.typeString:SetPoint("BOTTOM")
    parent.typeString:SetJustifyH("LEFT")
    parent.typeString:SetJustifyV("MIDDLE")
    parent.typeString:SetTextColor(1, 0.92, 0.8)
    --parent.typeString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_TYPE].width - 8)

    --parent.typeIcon = parent:CreateFontString(parent:GetName().."TypeString", "OVERLAY", "Sorted11Font")
    --parent.typeIcon:SetJustifyH("CENTER")
    --parent.typeIcon:SetJustifyV("MIDDLE")
    parent.typeIcon = parent:CreateTexture(parent:GetName().."TypeIcon")
    parent.typeIcon:SetTexture("Interface\\Addons\\Sorted\\Textures\\Type-Icons")

    parent.subtypeString = parent:CreateFontString(parent:GetName().."TypeString", "OVERLAY", "Sorted11Font")
    parent.subtypeString:SetPoint("TOP")
    parent.subtypeString:SetPoint("BOTTOM")
    parent.subtypeString:SetJustifyH("LEFT")
    parent.subtypeString:SetJustifyV("MIDDLE")
    parent.subtypeString:SetTextColor(1, 0.92, 0.8)

    --parent.expacString = parent:CreateFontString(parent:GetName().."ExpacString", "OVERLAY", "Sorted13Font")
    --parent.expacString:SetJustifyH("CENTER")
    --parent.expacString:SetJustifyV("MIDDLE")
    --parent.expacString:SetTextColor(1, 0.92, 0.8)
    --parent.expacString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_EXPANSION].width - 8)

    parent.expacIcon = parent:CreateTexture(parent:GetName().."ExpacIcon")
    parent.expacIcon:SetTexture("Interface\\Addons\\Sorted\\Textures\\Expac-Icons")

    parent.timeAddedString = parent:CreateFontString(parent:GetName().."TimeAddedString", "OVERLAY", "Sorted11Font")
    parent.timeAddedString:SetPoint("TOP")
    parent.timeAddedString:SetPoint("BOTTOM")
    parent.timeAddedString:SetJustifyH("RIGHT")
    parent.timeAddedString:SetJustifyV("MIDDLE")
    parent.timeAddedString:SetTextColor(1, 0.92, 0.8)
    --parent.timeAddedString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_ADDED].width)

    parent.bgTex = parent:CreateTexture("", "BACKGROUND")
    parent.bgTex:SetAllPoints()
    parent.bgTex:SetColorTexture(1, 1, 1, 1)
    parent.bgTex:SetGradientAlpha("VERTICAL", 0.3, 0.26, 0.2, 0.02, 0, 0, 0, 0.15)

    parent.newItemHighlight = parent:CreateTexture(parent:GetName().."HighlightTexture", "ARTWORK")
    parent.newItemHighlight:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
    parent.newItemHighlight:SetTexCoord(0.3, 0.7, 0.05, 0.95)
    parent.newItemHighlight:SetVertexColor(1, 0.9, 0.6, 0.6)
    parent.newItemHighlight:SetBlendMode("ADD")
    parent.newItemHighlight:Hide()
    parent.newItemHighlight.pulse = parent.newItemHighlight:CreateAnimationGroup()
    anim = parent.newItemHighlight.pulse:CreateAnimation("Alpha", nil)
    anim:SetDuration(1)
    anim:SetFromAlpha(0.6)
    anim:SetToAlpha(0.8)
    anim:SetSmoothing("IN_OUT")
    anim:SetOrder(1)
    anim = parent.newItemHighlight.pulse:CreateAnimation("Alpha", nil)
    anim:SetDuration(1)
    anim:SetFromAlpha(0.8)
    anim:SetToAlpha(0.6)
    anim:SetSmoothing("IN_OUT")
    anim:SetOrder(2)
    anim = parent.newItemHighlight.pulse:CreateAnimation("Alpha", nil)
    anim:SetDuration(1)
    anim:SetFromAlpha(0.6)
    anim:SetToAlpha(0.8)
    anim:SetSmoothing("IN_OUT")
    anim:SetOrder(3)
    anim = parent.newItemHighlight.pulse:CreateAnimation("Alpha", nil)
    anim:SetDuration(1)
    anim:SetFromAlpha(0.8)
    anim:SetToAlpha(0.6)
    anim:SetSmoothing("IN_OUT")
    anim:SetOrder(4)
    anim = parent.newItemHighlight.pulse:CreateAnimation("Translation", nil)
    anim:SetDuration(1)
    anim:SetOffset(-100, 0)
    anim:SetSmoothing("OUT")
    anim:SetOrder(1)
    anim = parent.newItemHighlight.pulse:CreateAnimation("Translation", nil)
    anim:SetDuration(1)
    anim:SetOffset(100, 0)
    anim:SetSmoothing("IN")
    anim:SetOrder(2)
    anim = parent.newItemHighlight.pulse:CreateAnimation("Translation", nil)
    anim:SetDuration(1)
    anim:SetOffset(100, 0)
    anim:SetSmoothing("OUT")
    anim:SetOrder(3)
    anim = parent.newItemHighlight.pulse:CreateAnimation("Translation", nil)
    anim:SetDuration(1)
    anim:SetOffset(-100, 0)
    anim:SetSmoothing("IN")
    anim:SetOrder(4)
    parent.newItemHighlight.pulse:SetScript("OnFinished", function(self) self:GetParent():SetAlpha(0.4) end)
    

    parent.cooldownBar = CreateFrame("StatusBar", parent:GetName().."CooldownBar", parent)
    parent.cooldownBar:SetAllPoints()
    parent.cooldownBar:SetStatusBarTexture("Interface\\Addons\\Sorted\\Textures\\StatusBar")
    parent.cooldownBar:SetStatusBarColor(1, 0.92, 0.75, 0.2)
    parent.cooldownBar:SetOrientation("HORIZONTAL")
    parent.cooldownBar:SetFrameLevel(parent:GetFrameLevel() + 100)
    parent.cooldownBg = parent.cooldownBar:CreateTexture(parent:GetName().."CooldownBg", "ARTWORK")
    parent.cooldownBg:SetColorTexture(0, 0, 0, 0.3)
    parent.cooldownBg:SetAllPoints()
    parent.cooldownBg.fadeIn = parent.cooldownBg:CreateAnimationGroup()
    anim = parent.cooldownBg.fadeIn:CreateAnimation("Alpha", nil)
    anim:SetDuration(0.4)
    anim:SetFromAlpha(0)
    anim:SetToAlpha(1)
    parent.cooldownFlash = parent:CreateTexture(parent:GetName().."CooldownFlash", "OVERLAY")
    parent.cooldownFlash:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Higherlight")
    parent.cooldownFlash:SetVertexColor(1,0.9,0.66)
    parent.cooldownFlash:SetAllPoints()
    parent.cooldownFlash:SetBlendMode("ADD")
    parent.cooldownFlash:Hide()
    parent.cooldownFlash.anim = parent.cooldownFlash:CreateAnimationGroup()
    anim = parent.cooldownFlash.anim:CreateAnimation("Alpha", nil)
    anim:SetDuration(0.25)
    anim:SetFromAlpha(0)
    anim:SetToAlpha(1)
    anim:SetOrder(1)
    anim:SetSmoothing("IN")
    anim = parent.cooldownFlash.anim:CreateAnimation("Alpha", nil)
    anim:SetDuration(1)
    anim:SetFromAlpha(1)
    anim:SetToAlpha(0)
    anim:SetOrder(2)
    anim:SetSmoothing("OUT")
    parent.cooldownFlash.anim:HookScript("OnFinished", function(self)
        self:GetParent():Hide()
    end)

    parent.timeSinceLastUpdate = 0
    parent.timeBetweenUpdates = math.random() * 0.05 + 0.05
    parent.isCooldown = false
    parent.cooldownBg:Hide()
    parent.cooldownBar:Hide()

    parent.IsNew = function(self)
        if not S.IsCurrentPlayerSelected() then
            return false
        end
        local data = self:GetData()
        if data.link then
            if Sorted_GetData().newItems then
                return Sorted_GetData().newItems[Sorted_ItemKey(data.link)]
            end
        end
    end
    
    parent:HookScript("OnUpdate", function(self, elapsed)
        if self.mouseOver then
            self.button.highlight:ClearAllPoints()
            local x,y = GetCursorPosition()
            x = x / self.button:GetEffectiveScale()
            y = y / self.button:GetEffectiveScale()
            local x2,y2 = self:GetCenter()
            self.button.highlight:SetWidth(self.button:GetWidth() * 3)
            self.button.highlight:SetPoint("LEFT", UIParent, "BOTTOMLEFT", x - self.button.highlight:GetWidth() / 2, y)
            self.button.highlight:SetPoint("TOP", UIParent, "BOTTOMLEFT", 0, y2 + self:GetHeight() / 2)
            self.button.highlight:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", 0, y2 - self:GetHeight() / 2)
            self.button.highlight:Show()
        end


        if not self.isCooldown then
            self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed
            if self.timeSinceLastUpdate < self.timeBetweenUpdates then
                return
            else
                self.timeSinceLastUpdate = 0
            end
        end
        
        local data = self:GetData()
        if data.itemID then
            local startTime, duration, enable = GetItemCooldown(data.itemID)
            if startTime == 0 then
                if self.isCooldown then
                    self.isCooldown = false
                    self.cooldownBg:Hide()
                    self.cooldownBg.fadeIn:Stop()
                    self.cooldownBar:Hide()
                end
                return
            end
            if (not self.isCooldown) or (self.startTime ~= startTime) then
                self.isCooldown = true
                self.startTime = startTime
                self.endTime = startTime + duration
                self.duration = duration
                self.cooldownBg:Show()
                self.cooldownBg.fadeIn:Play()
                self.cooldownBar:SetMinMaxValues(startTime, self.endTime)
                self.cooldownBar:SetValue(startTime)
                self.cooldownBar:SetAlpha(0) -- Give it one frame before showing the bar, else the previous value flashes briefly
                self.cooldownBar:Show()
            else
                self.cooldownBar:SetAlpha(1)
                self.cooldownBar:SetValue(GetTime())
                -- Flash
                if GetTime() > self.endTime - 0.25 and not self.cooldownFlash.anim:IsPlaying() then
                    if self.duration <= 1 then
                        return
                    elseif self.duration < 5 then
                        parent.cooldownFlash:SetVertexColor(1*0.2,0.9*0.2,0.66*0.2)
                    else
                        parent.cooldownFlash:SetVertexColor(1,0.9,0.66)
                    end
                    self.cooldownFlash:Show()
                    self.cooldownFlash.anim:Play()
                end
            end
        end
    end)

    --[[elseif bag == REAGENTBANK_CONTAINER then
        parent.button = _G["ReagentBankFrameItem"..slot]]

    local buttonType
    if Sorted_IsClassic() then
        buttonType = "Button"
    else
        buttonType = "ItemButton"
    end

    if bag == BANK_CONTAINER then
        parent.button = CreateFrame(buttonType, frameName.."Button", parent, "BankItemButtonGenericTemplate")
    elseif bag == REAGENTBANK_CONTAINER then
        parent.button = CreateFrame(buttonType, frameName.."Button", parent, "ReagentBankItemButtonGenericTemplate")
    else
        parent.button = CreateFrame(buttonType, frameName.."Button", parent, "ContainerFrameItemButtonTemplate")
    end
    parent.button:SetScript("OnEnter", SortedItemButton_OnEnter)
    parent.button:HookScript("OnLeave", SortedTooltip.Cancel)
    parent.button.UpdateTooltip = SortedItemButton_DelayedOnEnter --SortedItemButton_OnEnter
    
    local button = parent.button
    button:SetAllPoints()
    button:SetID(slot)
    button:SetNormalTexture("")
    button:GetNormalTexture():ClearAllPoints()
    if button.NewItemTexture then
        button.BattlepayItemTexture:Hide()
        button.BattlepayItemTexture:ClearAllPoints()
        button.NewItemTexture:Hide()
        button.NewItemTexture:ClearAllPoints()
        _G[button:GetName().."IconQuestTexture"]:ClearAllPoints()
        _G[button:GetName().."IconQuestTexture"]:Hide()
    end
    if button.flash then
        button.flash:ClearAllPoints()
    end
    if button.UpgradeIcon then
        button.UpgradeIcon:ClearAllPoints()
        button.UpgradeIcon = nil
    end

    button:SetHighlightTexture("")
    button:GetHighlightTexture():ClearAllPoints()
    button:SetPushedTexture("")
    button:GetPushedTexture():ClearAllPoints()
    button:Show()
    
    if not Sorted_IsClassic() then
        button.LevelLinkLockTexture:ClearAllPoints()
        button.LevelLinkLockTexture:Hide()
    end
    _G[button:GetName().."IconTexture"]:ClearAllPoints()
    _G[button:GetName().."IconTexture"]:Hide()

    button.pushed = button:CreateTexture("")
    button.pushed:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
    button.pushed:SetTexCoord(0.4, 0.7, 0, 1)
    button.pushed:SetBlendMode("ADD")
    button.pushed:SetAlpha(0)
    button.pushed:SetAllPoints()
    button.pushed:Hide()

    -- Mouseover highlight animations
    button.highlight = button:CreateTexture("")
    button.highlight:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
    --button.highlight:SetTexCoord(0.4, 1, 0, 1)
    button.highlight:SetBlendMode("ADD")
    button.highlight:SetAlpha(0)
    button.highlight:ClearAllPoints()
    button.highlight:SetWidth(2000)
    button.highlight:Hide()

    button.fadeIn = button:CreateAnimationGroup()
    anim = button.fadeIn:CreateAnimation("Alpha", nil)
    anim:SetDuration(0.1)
    anim:SetFromAlpha(0.5)
    anim:SetToAlpha(1)
    anim:SetOrder(1)
    anim:SetChildKey("highlight")
    anim = button.fadeIn:CreateAnimation("Alpha", nil)
    anim:SetDuration(0.2)
    anim:SetFromAlpha(1)
    anim:SetToAlpha(0.7)
    anim:SetOrder(2)
    anim:SetChildKey("highlight")
    button.fadeIn:HookScript("OnFinished", function(self) self:GetParent().highlight:SetAlpha(0.7) end)

    button.fadeOut = button:CreateAnimationGroup()
    anim = button.fadeOut:CreateAnimation("Alpha", nil)
    anim:SetDuration(0)
    anim:SetFromAlpha(0)
    anim:SetToAlpha(0)
    anim:SetChildKey("highlight")
    button.fadeOut:HookScript("OnFinished", function(self) 
        self:GetParent().highlight:Hide() 
        --self:GetParent().wobble:Pause() 
        self:GetParent().highlight:ClearAllPoints()
    end)
    button.fadeOutAnim = anim

    --[[button.wobble = button:CreateAnimationGroup()
    button.wobble:SetLooping("REPEAT")
    anim = button.wobble:CreateAnimation("Translation", nil)
    anim:SetDuration(2)
    anim:SetOffset(-50, 0)
    anim:SetOrder(1)
    anim:SetSmoothing("OUT")
    anim:SetChildKey("highlight")
    anim = button.wobble:CreateAnimation("Translation", nil)
    anim:SetDuration(4)
    anim:SetOffset(100, 0)
    anim:SetOrder(2)
    anim:SetSmoothing("IN_OUT")
    anim:SetChildKey("highlight")
    anim = button.wobble:CreateAnimation("Translation", nil)
    anim:SetDuration(2)
    anim:SetOffset(-50, 0)
    anim:SetOrder(3)
    anim:SetSmoothing("IN")
    anim:SetChildKey("highlight")]]

    function button:ShowHighlight()
        if Sorted_GetSetting("animations") == 2 then
            --self.fadeOut:Stop()
            --self.wobble:Play() 
            self.fadeIn:Play() 
        end
        --self.highlight:Show()
    end
    function button:HideHighlight()
        self.fadeIn:Stop() 
        if Sorted_GetSetting("animations") == 2 then
            self.fadeOut:Play()
        else
            self.highlight:ClearAllPoints()
            self.highlight:Hide()
        end
    end

    parent.iconFrame = CreateFrame("Frame", parent:GetName().."IconFrame", parent)
    parent.itemIcon = parent.iconFrame:CreateTexture(parent:GetName().."IconTexture", "OVERLAY")
    parent.itemIcon:SetAllPoints()
    parent.itemIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    --parent.itemIcon:SetMask("Interface\\ChatFrame\\UI-ChatIcon-HotS")

    parent.itemIconMask = parent.iconFrame:CreateMaskTexture()
    parent.itemIconMask:SetTexture("Interface\\Addons\\Sorted\\Textures\\Circle_Mask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    parent.itemIconMask:SetAllPoints()
    --parent.itemIcon:SetBlendMode("ADD")
    button.iconFrame = parent.iconFrame
    button.itemIcon = parent.itemIcon

    parent.iconGlow = parent.iconFrame:CreateTexture(parent:GetName().."IconGlowTexture", "ARTWORK")
    parent.iconGlow:SetTexture("Interface\\Addons\\Sorted\\Textures\\Item_Glow")
    parent.iconGlow:SetPoint("CENTER")
    --parent.iconGlow:SetBlendMode("ADD")
    parent.iconGlow:Hide()
    button.iconGlow = parent.iconGlow

    parent.iconShadow = parent.iconFrame:CreateTexture(parent:GetName().."IconShadowTexture", "BORDER")
    parent.iconShadow:SetTexture("Interface\\Addons\\Sorted\\Textures\\Item_Shadow")
    parent.iconShadow:SetPoint("CENTER")
    parent.iconShadow:Show()
    button.iconShadow = parent.iconShadow

    button.text = parent.nameString

    parent.iconFrame.zoomIn = parent.iconFrame:CreateAnimationGroup()
    anim = parent.iconFrame.zoomIn:CreateAnimation("Scale", nil)
    anim:SetDuration(0.1)
    anim:SetFromScale(1,1)
    anim:SetToScale(1.4, 1.4)
    anim:SetOrder(1)
    anim:SetSmoothing("IN_OUT")
    parent.iconFrame.zoomIn:HookScript("OnFinished", function(self) 
        self:GetParent().zoomLoop:Play()
    end)

    parent.iconFrame.zoomLoop = parent.iconFrame:CreateAnimationGroup()
    parent.iconFrame.zoomLoop:SetLooping("REPEAT")
    anim = parent.iconFrame.zoomLoop:CreateAnimation("Scale", nil)
    anim:SetDuration(0)
    anim:SetFromScale(1.4, 1.4)
    anim:SetToScale(1.4, 1.4)
    anim:SetOrder(1)

    parent.iconFrame.zoomOut = parent.iconFrame:CreateAnimationGroup()
    anim = parent.iconFrame.zoomOut:CreateAnimation("Scale", nil)
    anim:SetDuration(0)
    anim:SetFromScale(1.4, 1.4)
    anim:SetToScale(1, 1)
    anim:SetOrder(1)
    anim:SetSmoothing("IN_OUT")

    button.zoomIn = parent.iconFrame.zoomIn
    button.zoomLoop = parent.iconFrame.zoomLoop
    button.zoomOut = parent.iconFrame.zoomOut

    local nameFrame = parent.nameFrame
    button.nameFrame = nameFrame
    button.indentText = nameFrame:CreateAnimationGroup()
    anim = button.indentText:CreateAnimation("Translation", nil)
    anim:SetDuration(0.1)
    anim:SetOffset(5, 0)
    anim:SetSmoothing("IN_OUT")
    button.indentText:HookScript("OnFinished", function(self)
        self:GetParent():SetPoint("LEFT", self:GetParent().leftX + 5, 0)
        self:GetParent():SetPoint("RIGHT", self:GetParent().rightX + 5, 0)
    end)

    button:HookScript("OnEnter", function(self)
        self:GetParent().mouseOver = true
        self:ShowHighlight()
        self.zoomOut:Stop()
        if not self:GetParent().filtered then
            if Sorted_GetSetting("animations") == 2 then
                self.zoomIn:Play()
                if self:GetParent().itemList.isScrolling then
                    self.nameFrame:SetPoint("LEFT", self.nameFrame.leftX + 5, 0)
                    self.nameFrame:SetPoint("RIGHT", self.nameFrame.rightX + 5, 0)
                else
                    self.indentText:Play()
                end
            else
                self.zoomLoop:Play()
                self.nameFrame:SetPoint("LEFT", self.nameFrame.leftX + 5, 0)
                self.nameFrame:SetPoint("RIGHT", self.nameFrame.rightX + 5, 0)
            end
            self.iconFrame:SetParent(self:GetParent():GetParent():GetParent())
            --self:GetParent().nameString:SetFontObject("Sorted12Font")
            self.iconGlow:Show()
            --self.iconShadow:Show()
        end
        --self.itemIcon:SetBlendMode("BLEND")
        self.nameFrame:SetFrameLevel(self:GetParent():GetFrameLevel() + 11)
        self.iconFrame:SetFrameLevel(self:GetParent():GetFrameLevel() + 10)
        local r,g,b = Sorted_GetItemQualityHighlightTextColor(self:GetParent():GetData().quality)
        self:GetParent().nameString:SetTextColor(r,g,b)
    end)
    button:HookScript("OnLeave", function(self)
        self:GetParent().mouseOver = false
        self:HideHighlight()
        self.zoomIn:Stop()
        self.zoomLoop:Stop()
        if Sorted_GetSetting("animations") == 2 then
            self.zoomOut:Play()
        end
        self.indentText:Stop()
        self.nameFrame:SetPoint("LEFT", self.nameFrame.leftX, 0)
        self.nameFrame:SetPoint("RIGHT", self.nameFrame.rightX, 0)
        --self.itemIcon:SetBlendMode("ADD")
        if Sorted_GetSetting("iconBorders") == 1 or self:GetParent().filtered then
            self.iconGlow:Hide()
        end
        --self.iconShadow:Hide()
        self.nameFrame:SetFrameLevel(self:GetParent():GetFrameLevel() + 1)
        self.iconFrame:SetParent(self)
        self.iconFrame:SetFrameLevel(self:GetParent():GetFrameLevel() + 1)
        local r,g,b = Sorted_GetItemQualityColor(self:GetParent():GetData().quality)
        self:GetParent().nameString:SetTextColor(r,g,b)
        --self:GetParent().nameString:SetFontObject("Sorted11Font")
        r,g,b = Sorted_GetItemQualityHighlightColor(self:GetParent():GetData().quality)
        self.iconGlow:SetVertexColor(r, g, b, 1)
    end)

    button:HookScript("OnMouseDown", function(self)
        if self:IsEnabled() then
            self.pushed:Show()
            local r,g,b = Sorted_GetItemQualityHighlightTextColor(self:GetParent():GetData().quality)
            self.iconGlow:SetVertexColor(r, g, b, 1)
            r,g,b = r^0.3,g^0.3,b^0.3
            self:GetParent().nameString:SetTextColor(r,g,b)
        end
    end)
    button:HookScript("OnMouseUp", function(self)
        if self:IsEnabled() then
            self.pushed:Hide()
            local r,g,b = Sorted_GetItemQualityHighlightTextColor(self:GetParent():GetData().quality)
            self:GetParent().nameString:SetTextColor(r,g,b)
            r,g,b = Sorted_GetItemQualityHighlightColor(self:GetParent():GetData().quality)
            self.iconGlow:SetVertexColor(r, g, b, 1)
        end
    end)
    button:HookScript("OnDragStop", function(self)
        self.pushed:Hide()
    end)

    return parent
end