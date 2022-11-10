local Sorted = LibStub("Sorted.")

-- Adds a new column that displays CanIMogIt's icon
local CreateElement = function(f)
    f.text = f:CreateFontString(nil, "OVERLAY", "SortedFont")
    f.text:SetAllPoints()
    f.text:SetJustifyH("CENTER")
end
local UpdateElement = function(f, data)
    if data.pawn then
        f.text:SetText("|TInterface\\Addons\\Pawn\\Textures\\UpgradeArrow:12:12:0:0:32:32:0:32:0:32|t")
    elseif data.isEquippable then
        f.text:SetText("|TInterface\\Addons\\Pawn\\Textures\\DowngradeArrow:12:12:0:0:32:32:0:32:0:32|t")
    else
        f.text:SetText("")
    end
end
Sorted:AddItemColumn("PAWN", "Pawn", 20, CreateElement, UpdateElement)

-- Add sorting
local Sort = function(asc, data1, data2)
    if data1.pawn == data2.pawn then
        if data1.isEquippable and not data2.isEquippable then
            return true
        elseif data2.isEquippable and not data1.isEquippable then
            return false
        end
        return Sorted.DefaultItemSort(data1, data2)
    end
    if asc then
        return not data1.pawn
    else
        return data1.pawn
    end
end
Sorted:AddSortMethod("PAWN", "|TInterface\\Addons\\Pawn\\Textures\\PawnLogo:20:20:0:0:256:128:0:128:0:128|t", Sort, false)

local PreSort = function(itemData)
    if Sorted.IsPlayingCharacterSelected() and not itemData.isGuild then
        itemData.pawn = PawnIsContainerItemAnUpgrade(itemData.bag, itemData.slot)
    end
end
Sorted:AddDataToItem("PAWN", PreSort)