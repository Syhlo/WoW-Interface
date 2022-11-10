local Sorted = LibStub("Sorted.")

-- Adds a new column that displays Scrap's icon
local CreateElement = function(f)
    f.button = CreateFrame("BUTTON", nil, f)
    f.button:SetPoint("CENTER")
    f.button:SetHighlightTexture("Interface\\Buttons\\UI-GroupLoot-Coin-Up")
    f.button:SetPushedTexture("Interface\\Buttons\\UI-GroupLoot-Coin-Down")
    f.button.parent = f.parent
    function f.button:Update()
        if self.hasNoValue or self.isGuild then
            f.button:Hide()
        elseif self.isJunk then
            f.button:Show()
            f.button:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Coin-Up")
        else
            f.button:Show()
            f.button:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Coin-Highlight")
        end
        f.button:SetEnabled(Sorted.IsPlayingCharacterSelected())
    end
    f.button:SetScript("OnClick", function(self)
        if self.itemID then
            Scrap:ToggleJunk(self.itemID)
        end
        self:Update()
    end)
end
local UpdateElement = function(f, data)
    f.button.hasNoValue = data.hasNoValue
    f.button.isJunk = data.scrap
    f.button.itemID = data.itemID
    f.button.isGuild = data.isGuild
    f.button:Update()
end
local UpdateIcon = function(f, iconSize, borderThickness, iconShape, iconBorders)
    f.button:SetSize(iconSize * 0.9, iconSize * 0.9)
end
Sorted:AddItemColumn("SCRAP", "Scrap", 20, CreateElement, UpdateElement, UpdateIcon)

-- Hook Scrap's ToggleJunk to update the icons in Sorted
local temp = Scrap.ToggleJunk
Scrap.ToggleJunk = function(self, id)
    temp(self, id)
    Sorted.UpdateColumn("SCRAP")
end

-- Add sorting
local Sort = function(asc, data1, data2)
    if data1.scrap == data2.scrap then
        return Sorted.DefaultItemSort(data1, data2)
    end
    if asc then
        return not data1.scrap
    else
        return data1.scrap
    end
end
Sorted:AddSortMethod("SCRAP", "|TInterface\\Buttons\\UI-GroupLoot-Coin-Up:16:16:0:-2:32:32:0:32:0:32|t", Sort, false)

-- Add value of IsJunk to itemData
local PreSort = function(itemData)
    if Sorted.IsPlayingCharacterSelected() and not itemData.isGuild then
        if itemData.itemID then
            itemData.scrap = Scrap:IsJunk(itemData.itemID)
        else
            itemData.scrap = nil
        end
    end
end
Sorted:AddDataToItem("SCRAP", PreSort)