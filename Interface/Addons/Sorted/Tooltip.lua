local _, S = ...
local pairs, ipairs, string, type, time = pairs, ipairs, string, type, time

S.Tooltip = {}
local extraTooltip = CreateFrame("GameTooltip", "SortedExtendedTooltip", GameTooltip, "GameTooltipTemplate")



local i = 0

function S.Tooltip.Schedule(func)
    local tooltipDelay = S.Settings.Get("tooltipDelay")
    if tooltipDelay == 0 then
        func()
        return
    end
    i = i + 1
    local id = i
    C_Timer.After(tooltipDelay, function()
        if i == id then
            func()
        end
    end)
end

function S.Tooltip.Cancel()
    GameTooltip:Hide()
    extraTooltip:Hide()
    if S.WoWVersion() >= 5 then
        BattlePetTooltip:Hide()
    end
    i = i + 1
end


local function Create()
    GameTooltip:SetOwner(S.Tooltip.parent, S.Tooltip.anchor)
    GameTooltip:ClearLines()
    GameTooltip:AddLine(S.Tooltip.text)
    GameTooltip:Show()
end
function S.Tooltip.CreateText(parent, anchor, text)
    S.Tooltip.parent = parent
    S.Tooltip.anchor = anchor
    S.Tooltip.text = text
    S.Tooltip.Schedule(Create)
end
function S.Tooltip.CreateLocalized(parent, anchor, key, arg1, arg2, arg3)
    S.Tooltip.CreateText(parent, anchor, S.Localize(key, arg1, arg2, arg3))
end



local extraTooltipLines = {}
extraTooltip.logo = extraTooltip:CreateTexture("")
extraTooltip.logo:SetTexture("Interface\\Addons\\Sorted\\Textures\\Portrait-Text")
extraTooltip.logo:SetTexCoord(0, 1, 0.25, 0.75)
extraTooltip.logo:SetPoint("TOPLEFT", 10, -6)
extraTooltip.logo:SetSize(64, 32)
extraTooltip.bagIcon = extraTooltip:CreateTexture("")
extraTooltip.bagIcon:SetTexture("Interface\\Addons\\Sorted\\Textures\\Tooltip-Icons")
extraTooltip.bagIcon:SetTexCoord(0, 0.25, 0, 1)
extraTooltip.bagIcon:SetPoint("TOPRIGHT", -116, -12)
extraTooltip.bagIcon:SetSize(20, 20)
extraTooltip.bankIcon = extraTooltip:CreateTexture("")
extraTooltip.bankIcon:SetTexture("Interface\\Addons\\Sorted\\Textures\\Tooltip-Icons")
extraTooltip.bankIcon:SetTexCoord(0.25, 0.5, 0, 1)
extraTooltip.bankIcon:SetPoint("TOPRIGHT", -68, -12)
extraTooltip.bankIcon:SetSize(20, 20)
extraTooltip.reagentIcon = extraTooltip:CreateTexture("")
extraTooltip.reagentIcon:SetTexture("Interface\\Addons\\Sorted\\Textures\\Tooltip-Icons")
extraTooltip.reagentIcon:SetTexCoord(0.5, 0.75, 0, 1)
extraTooltip.reagentIcon:SetPoint("TOPRIGHT", -20, -12)
extraTooltip.reagentIcon:SetSize(20, 20)
local function GetLine(index)
    if extraTooltipLines[index] then return extraTooltipLines[index] end
    local line = {}
    line.nameString = extraTooltip:CreateFontString(nil)
    line.nameString:SetFontObject("SortedFont")
    line.nameString:SetPoint("LEFT", extraTooltip, "TOPLEFT", 8, -index * 24 - 22)
    line.bagString = extraTooltip:CreateFontString(nil)
    line.bagString:SetFontObject("SortedFont")
    line.bagString:SetPoint("CENTER", extraTooltip.bagIcon, "CENTER", 0, -index * 24)
    line.bankString = extraTooltip:CreateFontString(nil)
    line.bankString:SetFontObject("SortedFont")
    line.bankString:SetPoint("CENTER", extraTooltip.bankIcon, "CENTER", 0, -index * 24)
    line.reagentString = extraTooltip:CreateFontString(nil)
    line.reagentString:SetFontObject("SortedFont")
    line.reagentString:SetPoint("CENTER", extraTooltip.reagentIcon, "CENTER", 0, -index * 24)
    extraTooltipLines[index] = line
    return extraTooltipLines[index]
end

local textColor = {["r"] = 1, ["g"] = 1, ["b"] = 1}
local grayedTextColor = {["r"] = 0.6, ["g"] = 0.61, ["b"] = 0.65}
function S.Tooltip.Extended(bag, slot)
    local self = S.Data.GetItem(bag, slot)
    local i = 0
    if self.classID == LE_ITEM_CLASS_BATTLEPET then return end
    -- Add Sorted's tooltip info
    extraTooltip:SetOwner(GameTooltip, "ANCHOR_BOTTOM")
    extraTooltip:ClearLines()
    --extraTooltip:AddLine("|TInterface\\Addons\\Sorted\\Textures\\Title:24:96:-6:4|t")
    extraTooltip:AddLine(" ")
    for _, line in pairs(extraTooltipLines) do
        line.nameString:Hide()
        line.bagString:Hide()
        line.bankString:Hide()
        line.reagentString:Hide()
    end
    for GUID, data in pairs(Sorted_Data) do
        if data.realm == GetRealmName() then
            local bagCount = 0
            for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
                for slot = 1, 36 do
                    local itemData = S.Data.GetItem(bag, slot, GUID)
                    if itemData.itemID == self.itemID and itemData.count then
                        bagCount = bagCount + itemData.count
                    end
                end
            end

            local bankCount = 0
            for _, bag in pairs(S.Utils.ContainersOfType("BANK")) do
                for slot = 1, 36 do
                    local itemData = S.Data.GetItem(bag, slot, GUID)
                    if itemData.itemID == self.itemID and itemData.count then
                        bankCount = bankCount + itemData.count
                    end
                end
            end

            local reagentCount = 0
            if S.WoWVersion() >= 6 then
                for slot = 1, 98 do
                    local itemData = S.Data.GetItem(REAGENTBANK_CONTAINER, slot, GUID)
                    if itemData.itemID == self.itemID and itemData.count then
                        reagentCount = reagentCount + itemData.count
                    end
                end
            end

            if bagCount > 0 or bankCount > 0 or reagentCount > 0 then
                i = i + 1
                local line = GetLine(i)
                line.nameString:SetText(S.Utils.FormatFaction(data.faction)..S.Utils.GetClassHexColor(data.class)..data.name)
                line.bagString:SetText(bagCount)
                if bagCount > 0 then line.bagString:SetTextColor(textColor.r, textColor.g, textColor.b) else line.bagString:SetTextColor(grayedTextColor.r, grayedTextColor.g, grayedTextColor.b) end
                line.bankString:SetText(bankCount)
                if bankCount > 0 then line.bankString:SetTextColor(textColor.r, textColor.g, textColor.b) else line.bankString:SetTextColor(grayedTextColor.r, grayedTextColor.g, grayedTextColor.b) end
                line.nameString:Show()
                line.bagString:Show()
                line.bankString:Show()
                if S.WoWVersion() >= 6 then
                    line.reagentString:SetText(reagentCount)
                    if reagentCount > 0 then line.reagentString:SetTextColor(textColor.r, textColor.g, textColor.b) else line.reagentString:SetTextColor(grayedTextColor.r, grayedTextColor.g, grayedTextColor.b) end
                    line.reagentString:Show()
                end
                --[[local left = Sorted_FormatFaction(data.faction)..Sorted_GetClassColor(data.class):GenerateHexColorMarkup()..data.name
                local right
                local bagColor, bankColor, reagentColor
                if bagCount > 0 then bagColor = textColor else bagColor = grayedTextColor end
                if bankCount > 0 then bankColor = textColor else bankColor = grayedTextColor end
                if not Sorted_IsClassic() then
                    if reagentCount > 0 then reagentColor = textColor else reagentColor = grayedTextColor end
                    right = string.format("%s%6d |TInterface\\Addons\\Sorted\\Textures\\Tooltip-Icons:20:20:0:0:128:32:0:32:0:32|t %s%6d |TInterface\\Addons\\Sorted\\Textures\\Tooltip-Icons:20:20:0:0:128:32:32:64:0:32|t %s%6d |TInterface\\Addons\\Sorted\\Textures\\Tooltip-Icons:20:20:0:0:128:32:64:96:0:32|t", bagColor, bagCount, bankColor, bankCount, reagentColor, reagentCount)
                else
                    right = string.format("%s%6d |TInterface\\Addons\\Sorted\\Textures\\Tooltip-Icons:20:20:0:0:128:32:0:32:0:32|t %s%6d |TInterface\\Addons\\Sorted\\Textures\\Tooltip-Icons:20:20:0:0:128:32:32:64:0:32|t", bagColor, bagCount, bankColor, bankCount)
                end
                extraTooltip:AddDoubleLine(left, right)]]
            end
        end
    end
    extraTooltip:Show()
    local width = GameTooltip:GetWidth()
    if width < 256 then
        GameTooltip:SetWidth(256)
        width = 256
    end
    extraTooltip:SetPoint("LEFT", GameTooltip, "RIGHT", -288, 0)
    extraTooltip:SetPoint("RIGHT", GameTooltip)
    extraTooltip:SetHeight(i * 24 + 40)
end