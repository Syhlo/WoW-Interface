local _, S = ...
local pairs, ipairs, string, type, time, GetTime = pairs, ipairs, string, type, time, GetTime

local GetContainerItemCooldown, ShowContainerSellCursor = GetContainerItemCooldown, ShowContainerSellCursor
if C_Container then
    if C_Container.GetContainerItemCooldown then GetContainerItemCooldown = C_Container.GetContainerItemCooldown end
    if C_Container.ShowContainerSellCursor then ShowContainerSellCursor = C_Container.ShowContainerSellCursor end
end

local WHITE = CreateColor(1, 1, 1)
local GREY = CreateColor(0.2, 0.2, 0.2)
local LIGHT_GREY = CreateColor(0.4, 0.4, 0.4)

S.maxILvl = 0 -- ilvl opacity is set against this

local function UpdateEntry(self)
    self:UpdateSuper()

    if self.bag and self.slot then
        self:UpdateIsCoolingDown()
        self:SetID(self.bag)
        self.button:SetID(self.slot)
        self.button.bag = self.bag
        self.button.slot = self.slot

        -- Combined stack expand/collapse button
        if self.list.gridView then
            self.expandCombinedStackButton:Hide()
        else
            if self.isCombined then
                self.expandCombinedStackButton:SetShown(self.isCombined)
                self.expandCombinedStackButton:SetCombinedStackButtonCollapsed(not self.list.expandedCombinedItems[self.data.key])
                self.expandCombinedStackButton:GetNormalTexture():SetDesaturated(self.filtered)
                if self.filtered then
                    self.expandCombinedStackButton:GetNormalTexture():SetVertexColor(S.Color.GRAY:GetRGB())
                else
                    self.expandCombinedStackButton:GetNormalTexture():SetVertexColor(S.Color.WHITE:GetRGB())
                end
            else
                self.expandCombinedStackButton:Hide()
            end
        end
        
        -- New item highlight
        if S.IsPlayingCharacterSelected() then
            if C_NewItems.IsNewItem(self.bag, self.slot) and not S.IsItemScheduledToBeNotNew(self.bag, self.slot) then
                self.newItem:Show()
                self.newItem:SetAlpha(1)
            else
                self.newItem:Hide()
            end
        else
            self.newItem:Hide()
        end
    
        -- Mouseover highlight
        if self.list.gridView then
            self.highlight:SetTexture("")
        else
            self.highlight:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
            if self.filtered then
                self.highlight:SetVertexColor(GREY:GetRGB())
            else
                self.highlight:SetVertexColor(self.data.color1:GetRGB())
            end
        end

    else
        self:Hide()
    end
end

--[[local function OnIconChanged(self)
    self:OnIconChangedSuper()
    local iconSize = S.Settings.Get("iconSize")
    self.typeIcon:SetSize(iconSize, iconSize)
    self.bindIcon:SetSize(iconSize * 1.1, iconSize * 1.1)
    self.expacIcon:SetSize(iconSize * 2.4, iconSize * 1.2)
    self.valueIcon:SetSize(iconSize * 0.6, iconSize * 0.6)
    self.trashButton:SetSize(iconSize * 1.25, iconSize * 1.25)
end]]

--[[local function UpdateEntryTextAndIcons(self)
    if S.IsPlayingCharacterSelected() then
        if C_NewItems.IsNewItem(self.bag, self.slot) and not S.IsItemScheduledToBeNotNew(self.bag, self.slot) then
            self.newItem:Show()
            self.newItem:SetAlpha(1)
        else
            self.newItem:Hide()
        end
    else
        self.newItem:Hide()
    end

    local data = self:GetData()

    -- Quantity string. Doesn't use the value in 'data'
    -- Instead uses 'self.count' provided after combining stacks
    if self.count <= 1 then
        self.quantityString:SetText("")
    else
        self.quantityString:SetText(self.count)
    end


    self.icon:SetTexture(data.texture)
    self.nameString:SetText(data.name)

    if not self.list.gridView then

        if self.isCombined then
            self.expandCombinedStackButton:SetShown(self.isCombined)
            self.expandCombinedStackButton:SetCombinedStackButtonCollapsed(not self.list.expandedCombinedItems[self.data.key])
        else
            self.expandCombinedStackButton:Hide()
        end

        self.typeString:SetText(GetItemClassInfo(data.classID))
        self.subtypeString:SetText(GetItemSubClassInfo(data.classID, data.subClassID))
        local x = (data.classID % 8) / 8
        local y = math.floor(data.classID / 8) / 8
        self.typeIcon:SetTexCoord(x, x + 0.125, y, y + 0.125)
        if data.bindType > 0 then
            if data.bindType == 4 then data.bindType = 1 end -- Treat quest items as BoP
            local x = (data.bindType - 1) / 4
            local y
            if data.bound then y = 0 else y = 0.5 end
            self.bindIcon:SetTexCoord(x, x + 0.25, y, y + 0.5)
        else
            self.bindIcon:SetTexCoord(1, 1, 1, 1)
        end

        local expacID = data.expacID
        if not expacID then
            expacID = 0
        end
        x = (expacID % 4) / 4
        y = math.floor(expacID / 4) / 8
        self.expacIcon:SetTexCoord(x, x + 0.25, y, y + 0.125)

        -- Battle pets
        if self.cageName then
            data.name = "Caged ".. self.cageName
            self.nameString:SetText(data.name)
            self.lvlString:SetText(self.petLevel)
            data.effectiveILvl = tonumber(self.petLevel)

        -- Everything else
        else
            self.nameString:SetText(data.name)
            if S.IsPlayingCharacterSelected() and data.effectiveILvl and data.effectiveILvl > S.maxILvl then 
                S.maxILvl = data.effectiveILvl 
            end
            if (data.effectiveILvl and data.effectiveILvl > 1) then
                self.lvlString:SetText(data.effectiveILvl)
            else
                self.lvlString:SetText("")
                data.effectiveILvl = 0
            end
        end

        if data.minLevel > 1 then
            self.reqLvlString:SetText(data.minLevel)
        else
            self.reqLvlString:SetText("")
        end

        if (data.value > 0 and not data.hasNoValue) then
            self.valueIcon:SetTexture(S.Utils.GetValueIcon(data.value * self.count))
            self.valueString:SetText(S.Utils.FormatValueStringNoIcon(data.value * self.count))
        else
            self.valueString:SetText("")
            self.valueIcon:SetTexture("")
        end

        if data.hasNoValue then
            self.trashButton:Hide()
        elseif S.Data.GetTrash(data) <= 1 then
            self.trashButton:Show()
            self.trashButton:GetNormalTexture():SetTexCoord(0.25, 0.5, 0, 0.5)
            self.trashButton:GetHighlightTexture():SetTexCoord(0.25, 0.5, 0.5, 1)
        else
            self.trashButton:Show()
            self.trashButton:GetNormalTexture():SetTexCoord(0, 0.25, 0, 0.5)
            self.trashButton:GetHighlightTexture():SetTexCoord(0, 0.25, 0.5, 1)
        end

    else
        -- Grid view. All elements attached to a column heading are hidden anyway
        self.expandCombinedStackButton:Hide()
    end
end



local function UpdateEntryColors(self)
    local data = self:GetData()
    self.color1 = S.Utils.GetItemQualityColor(data.quality)
    self.color2 = S.Utils.GetItemQualityHighlightColor(data.quality)

    if not self.filtered then
        if self.mouseEntered then
            self.nameString:SetTextColor(self.color2:GetRGB())
            self.iconBorder:SetVertexColor(self.color2:GetRGB())
        else
            self.nameString:SetTextColor(self.color1:GetRGB())
            self.iconBorder:SetVertexColor(self.color1:GetRGB())
        end
        self.icon:SetDesaturated(false)
        self.icon:SetVertexColor(WHITE:GetRGB())
        self.quantityString:SetTextColor(1, 0.95, 0.85)

        if not self.list.gridView then
            self.expandCombinedStackButton:GetNormalTexture():SetDesaturated(false)
            self.expandCombinedStackButton:GetNormalTexture():SetVertexColor(WHITE:GetRGB())
            self.favoriteButton:GetNormalTexture():SetDesaturated(false)
            self.favoriteButton:GetNormalTexture():SetVertexColor(WHITE:GetRGB())
            self.expacIcon:SetDesaturated(false)
            self.expacIcon:SetVertexColor(WHITE:GetRGB())
            self.bindIcon:SetDesaturated(false)
            self.bindIcon:SetVertexColor(WHITE:GetRGB())
            self.typeIcon:SetDesaturated(false)
            self.typeIcon:SetVertexColor(WHITE:GetRGB())
            self.valueIcon:SetDesaturated(false)
            self.valueIcon:SetVertexColor(WHITE:GetRGB())
            self.highlight:SetVertexColor(self.color1:GetRGB())
            self.button:GetPushedTexture():SetVertexColor(self.color1:GetRGB())

            -- Battle pets
            if self.cageName then
                self.lvlString:SetTextColor(1, 0.92, 0.8, (self.petLevel / 25.0 * 0.65) + 0.35)

            -- Everything else
            else
                if (data.effectiveILvl and data.effectiveILvl > 0) then
                    local alpha = data.effectiveILvl / S.maxILvl
                    alpha = alpha * alpha * 0.65 + 0.35
                    if alpha > 1 then alpha = 1 end
                    self.lvlString:SetTextColor(1, 0.92, 0.8, alpha)
                end
            end

            if data.minLevel > UnitLevel("player") then
                self.reqLvlString:SetTextColor(1, 0.2, 0.3, 0.8)
            elseif (data.minLevel > 1) then
                local alpha = data.minLevel / UnitLevel("player")
                alpha = alpha * alpha * 0.65 + 0.35
                if alpha > 1 then alpha = 1 end
                self.reqLvlString:SetTextColor(1, 0.92, 0.8, alpha)
            end

            if (data.value > 0 and not data.hasNoValue) then
                local color = S.Utils.GetValueColor(data.value * data.count)
                self.valueString:SetTextColor(color:GetRGB())
            end
            
            self.typeString:SetTextColor(1, 0.95, 0.85)
            self.subtypeString:SetTextColor(1, 0.95, 0.85)
        end
    else
        local tinted = S.Utils.GetItemQualityGreyedColor(data.quality)

        self.nameString:SetTextColor(tinted:GetRGB())
        self.icon:SetDesaturated(true)
        self.icon:SetVertexColor(LIGHT_GREY:GetRGB())
        self.iconBorder:SetVertexColor(tinted:GetRGB())
        self.quantityString:SetTextColor(GREY:GetRGB())

        if not self.list.gridView then
            self.expandCombinedStackButton:GetNormalTexture():SetDesaturated(true)
            self.expandCombinedStackButton:GetNormalTexture():SetVertexColor(LIGHT_GREY:GetRGB())
            self.favoriteButton:GetNormalTexture():SetDesaturated(true)
            self.favoriteButton:GetNormalTexture():SetVertexColor(LIGHT_GREY:GetRGB())
            self.expacIcon:SetDesaturated(true)
            self.expacIcon:SetVertexColor(LIGHT_GREY:GetRGB())
            self.bindIcon:SetDesaturated(true)
            self.bindIcon:SetVertexColor(LIGHT_GREY:GetRGB())
            self.typeIcon:SetDesaturated(true)
            self.typeIcon:SetVertexColor(LIGHT_GREY:GetRGB())
            self.valueIcon:SetDesaturated(true)
            self.valueIcon:SetVertexColor(LIGHT_GREY:GetRGB())
            self.highlight:SetVertexColor(GREY:GetRGB())
            self.button:GetPushedTexture():SetVertexColor(GREY:GetRGB())
            self.lvlString:SetTextColor(GREY:GetRGB())
            self.reqLvlString:SetTextColor(GREY:GetRGB())
            self.valueString:SetTextColor(GREY:GetRGB())
            self.typeString:SetTextColor(GREY:GetRGB())
            self.subtypeString:SetTextColor(GREY:GetRGB())
        end
    end
end



local function UpdateEntry(self)
    self:UpdateSuper()
    if self.bag and self.slot then
        self:UpdateIsCoolingDown()
        self:SetID(self.bag)
        self.button:SetID(self.slot)
        self.button.bag = self.bag
        self.button.slot = self.slot
        local data = self:GetData()
        if not data.link then
            self:Hide()
        else
            UpdateEntryTextAndIcons(self)
            UpdateEntryColors(self)
        end
    else
        self:Hide()
    end
end]]

local function GetFavorited(self)
    if self.bag and self.slot then
        return S.Data.GetFavorited(self:GetData())
    else
        return false
    end
end
local function ToggleFavorited(self)
    S.Data.ToggleFavorited(self:GetData())
    S.Utils.TriggerEvent("FavoriteChanged")
end
local function SetFavorited(self, value)
    S.Data.ToggleFavorited(self:GetData(), value)
    S.Utils.TriggerEvent("FavoriteChanged")
end
local function ClearFavorited(self)
    S.Data.Unfavorite(self:GetData())
    S.Utils.TriggerEvent("FavoriteChanged")
end

local function SetFiltered(self, filtered)
    self.filtered = filtered
    UpdateEntry(self)
end

local function GetData(self)
    -- Originally obtained data from S.GetData()
    -- The List now adds data as an attribute when sorting, so may as well use that instead
    return self.data --S.Data.GetItem(self.bag, self.slot, S.GetSelectedCharacter())
end

-- Based on Blizzard's Update function for ContainerFrameItemButtons
-- Works for items in the bank container too
local function Button_OnUpdate(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE");

    if not S.IsPlayingCharacterSelected() then
        local link = self.parent.data.link
        if link then
            GameTooltip:SetHyperlink(link)
        end
        ContainerFrameItemButton_CalculateItemTooltipAnchors(self, GameTooltip)

    else
        S.ScheduleNewItemToRemove(self.bag, self.slot)

        --C_NewItems.RemoveNewItem(self:GetBagID(), self:GetID());

        --[[self.NewItemTexture:Hide();
        self.BattlepayItemTexture:Hide();

        if ( self.flashAnim:IsPlaying() or self.newitemglowAnim:IsPlaying() ) then
            self.flashAnim:Stop();
            self.newitemglowAnim:Stop();
        end]]

        local showSell = nil;

        if self.bag == BANK_CONTAINER then
            local hasItem, hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(self:GetID(),self.isBag));
            if(speciesID and speciesID > 0) then
                BattlePetToolTip_Show(speciesID, level, breedQuality, maxHealth, power, speed, name);
                CursorUpdate(self);
                return;
            end
        elseif self.bag == KEYRING_CONTAINER then
            local hasItem, hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = GameTooltip:SetInventoryItem("player", KeyRingButtonIDToInvSlotID(self:GetID()))
        else
            local hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = GameTooltip:SetBagItem(self:GetBagID(), self:GetID());
            if ( speciesID and speciesID > 0 ) then
                ContainerFrameItemButton_CalculateItemTooltipAnchors(self, GameTooltip); -- Battle pet tooltip uses the GameTooltip's anchor
                BattlePetToolTip_Show(speciesID, level, breedQuality, maxHealth, power, speed, name);
                return;
            else
                if ( BattlePetTooltip ) then
                    BattlePetTooltip:Hide();
                end
            end
        end

        ContainerFrameItemButton_CalculateItemTooltipAnchors(self, GameTooltip);

        if ( IsModifiedClick("COMPAREITEMS") or GetCVarBool("alwaysCompareItems") ) then
            GameTooltip_ShowCompareItem(GameTooltip);
        end

        if ( InRepairMode() and (repairCost and repairCost > 0) ) then
            GameTooltip:AddLine(REPAIR_COST, nil, nil, nil, true);
            SetTooltipMoney(GameTooltip, repairCost);
            GameTooltip:Show();
        elseif ( MerchantFrame:IsShown() and MerchantFrame.selectedTab == 1 ) then
            showSell = 1;
        end

        if ( not SpellIsTargeting() ) then
            if ( IsModifiedClick("DRESSUP") --[[and self:HasItem()]] ) then
                ShowInspectCursor();
            elseif ( showSell ) then
                ShowContainerSellCursor(self:GetBagID(), self:GetID());
            elseif ( self:IsReadable() ) then
                ShowInspectCursor();
            else
                ResetCursor();
            end
        end

        if S.WoWVersion() >= 5 then
            if ( not GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_MOUNT_EQUIPMENT_SLOT_FRAME) ) then
                local itemLocation = ItemLocation:CreateFromBagAndSlot(self:GetBagID(), self:GetID());
                if ( itemLocation and itemLocation:IsValid() and C_PlayerInfo.CanPlayerUseMountEquipment() and (not CollectionsJournal or not CollectionsJournal:IsShown()) ) then
                    local tabIndex = 1;
                    CollectionsMicroButton_SetAlertShown(tabIndex);
                end
            end

            if ArtifactFrame --[[and self:HasItem()]] then
                ArtifactFrame:OnInventoryItemMouseEnter(self:GetBagID(), self:GetID());
            end
        end

        if S.Settings.Get("tooltipInfo") == 1 then
            S.Tooltip.Extended(self.bag, self.slot)
        end
    end
end

-- Blizz item button functions
local function Button_GetBagID(self)
    return self.parent:GetID()
end
local function Button_IsReadable(self)
    return self.readable
end
local function Button_HasItem(self)
    -- Sorted only shows buttons with items, so this can always return true
	return true --self.hasItem
end



local function UpdateIsCoolingDown(self)
    if self.list:IsAvailable() and self.bag and self.slot then
        self.cooldownStart, self.cooldownDuration = GetContainerItemCooldown(self.bag, self.slot)
        self.coolingDown = self.cooldownDuration > 2
        if self.coolingDown then
            self:SetScript("OnUpdate", self.UpdateCooldown)
        else
            self:SetScript("OnUpdate", nil)
        end
        self.cooldownBar:SetShown(self.coolingDown)
    else
        self:SetScript("OnUpdate", nil)
        self.cooldownBar:Hide()
    end
end
local function UpdateCooldown(self)
    local time = GetTime()
    if time > self.cooldownStart + self.cooldownDuration then
        self.cooldownBar:Hide()
        self:SetScript("OnUpdate", nil)
    else
        local x = 0.5 - (GetTime() - self.cooldownStart) / self.cooldownDuration * 0.5
        self.cooldownBar.tex:SetTexCoord(x, x + 0.5, 0, 1)
    end
end

local containerHighlightColor = CreateColor(0.2, 0.7, 1)
local cooldownColor = CreateColor(0.15, 0.14, 0.12)

function SetCombinedStackButtonCollapsed(self, collapsed)
    self.collapsed = collapsed
    if collapsed then
        self:GetNormalTexture():SetTexCoord(0, 0.5, 0, 0.5)
        self:GetHighlightTexture():SetTexCoord(0.5, 1, 0, 0.5)
        self:GetPushedTexture():SetTexCoord(0, 0.5, 0, 0.5)
    else
        self:GetNormalTexture():SetTexCoord(0, 0.5, 0.5, 1)
        self:GetHighlightTexture():SetTexCoord(0.5, 1, 0.5, 1)
        self:GetPushedTexture():SetTexCoord(0, 0.5, 0.5, 1)
    end
end
function ExpandCombinedStackButtonOnClick(self)
    local expandedCombinedItems = self.entryButton.list.expandedCombinedItems
    local key = self.entryButton.data.key
    if expandedCombinedItems[key] then
        expandedCombinedItems[key] = nil
    else
        expandedCombinedItems[key] = true
    end
    self.entryButton.list:ScheduleUpdate(false, true)
end

function S.CreateItemEntry(list, template)
    local self = S.CreateListEntry(list, list.itemButtonTemplate)
    self.UpdateSuper = self.Update
    self.Update = UpdateEntry
    self.SetFiltered = SetFiltered
    self.GetFavorited = GetFavorited
    self.ToggleFavorited = ToggleFavorited
    self.ClearFavorited = ClearFavorited
    self.SetFavorited = SetFavorited
    self.GetData = GetData
    self.UpdateCooldown = UpdateCooldown
    self.UpdateIsCoolingDown = UpdateIsCoolingDown
    --self.OnIconChangedSuper = self.OnIconChanged
    --self.OnIconChanged = OnIconChanged

    -- Replace Blizz methods
    self.OnUpdate = Button_OnUpdate
    self.button.UpdateTooltip = Button_OnUpdate
    if S.WoWVersion() <= 3 then 
        self.button.GetBagID = Button_GetBagID -- Replacing this in Retail seems to cause the "Sorted was blocked from an action only available to the Blizzard UI" error
    end
    self.button.IsReadable = Button_IsReadable
    self.button.HasItem = Button_HasItem
    self.button:HookScript("OnEnter", function(self)
        self:UpdateTooltip()
    end)

    self.newItem = CreateFrame("Frame", nil, self)
    self.newItem:SetAllPoints()
    self.newItem:SetFrameLevel(self:GetFrameLevel() + 4)
    self.newItemHighlight = self.newItem:CreateTexture(nil, "OVERLAY")
    self.newItemHighlight:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Higherlight")
    self.newItemHighlight:SetAllPoints()
    self.newItemHighlight:SetBlendMode("ADD")
    self.newItemHighlight:SetVertexColor(0.5, 0.45, 0.3)
    self.newItem.anim = self.newItem:CreateAnimationGroup()
    self.newItem.anim:SetLooping("REPEAT")
    local anim = self.newItem.anim:CreateAnimation("Alpha")
    anim:SetDuration(1)
    anim:SetFromAlpha(0.3)
    anim:SetToAlpha(0.6)
    anim:SetSmoothing("IN_OUT")
    anim:SetOrder(1)
    anim = self.newItem.anim:CreateAnimation("Alpha")
    anim:SetDuration(1)
    anim:SetFromAlpha(0.6)
    anim:SetToAlpha(0.3)
    anim:SetSmoothing("IN_OUT")
    anim:SetOrder(2)
    self.newItem:HookScript("OnShow", function(self)
        self.anim:Play()
    end)
    self.newItem:HookScript("OnEnter", function(self)
        self:Hide()
        self.anim:Stop()
    end)
    self.newItem:HookScript("OnHide", function(self)
        self.anim:Stop()
    end)

    self.cooldownBar = CreateFrame("Frame", nil, self)
    self.cooldownBar:SetAllPoints()
    --[[self.cooldownBar:SetStatusBarTexture("Interface\\Addons\\Sorted\\Textures\\UI-Higherlight")
    self.cooldownBar:SetStatusBarColor(1, 0.92, 0.75, 0.3)
    self.cooldownBar:SetOrientation("HORIZONTAL")]]
    self.cooldownBar:SetFrameLevel(self:GetFrameLevel() + 6)
    self.cooldownBar.tex = self.cooldownBar:CreateTexture(nil, "OVERLAY")
    self.cooldownBar.tex:SetTexture("Interface\\Addons\\Sorted\\Textures\\Status-Bar")
    self.cooldownBar.tex:SetAllPoints()
    self.cooldownBar.tex:SetBlendMode("ADD")
    self.cooldownBar.tex:SetVertexColor(cooldownColor:GetRGB())
    self.cooldownBar.bg = self.cooldownBar:CreateTexture(nil, "BACKGROUND")
    self.cooldownBar.bg:SetColorTexture(0.02, 0.02, 0.02, 0.7)
    self.cooldownBar.bg:SetAllPoints()
    self.cooldownBar:Hide()
    self:RegisterEvent("BAG_UPDATE_COOLDOWN")
    self:SetScript("OnEvent", self.UpdateIsCoolingDown)

    self.containerHighlightParent = CreateFrame("FRAME", nil, self)
    self.containerHighlightParent:SetAllPoints()
    self.containerHighlightParent:SetFrameLevel(self:GetFrameLevel() + 5)
    self.containerHighlight = self.containerHighlightParent:CreateTexture(nil, "OVERLAY")
    self.containerHighlight:SetAllPoints()
    self.containerHighlight:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
    self.containerHighlight:SetVertexColor(containerHighlightColor:GetRGB())
    self.containerHighlight:SetTexCoord(0.3, 0.8, 0.4, 0.6)
    self.containerHighlight:SetBlendMode("ADD")
    self.containerHighlight:Hide()

    local f = CreateFrame("BUTTON", nil, self)
    f:SetFrameLevel(self.button:GetFrameLevel() + 1)
    f:SetPoint("LEFT", 2, 0)
    f:SetSize(16, 16)
    f:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Expand-Button-Clean")
    f:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Expand-Button-Clean")
    f:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\Expand-Button-Clean")
    f.SetCombinedStackButtonCollapsed = SetCombinedStackButtonCollapsed
    f:SetScript("OnClick", ExpandCombinedStackButtonOnClick)
    f:RegisterForClicks("LeftButtonDown")
    f.entryButton = self
    self.expandCombinedStackButton = f

    -- Create all elements from columns table
    for k, _ in pairs(self.list.columns) do
        self:AddColumn(k)
    end

    return self
end