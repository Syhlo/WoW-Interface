local Sorted = LibStub("Sorted.")

-- Adds a new column that displays CanIMogIt's icon
local CreateElement = function(f)
    f.text = f:CreateFontString(nil, "OVERLAY", "SortedFont")
    f.text:SetAllPoints()
    f.text:SetJustifyH("CENTER")
end
local UpdateElement = function(f, data)
    f.text:SetText(data.canI)
end
Sorted:AddItemColumn("CANIMOGIT", "Can I Mog It?", 48, CreateElement, UpdateElement)

-- Add sorting
local Sort = function(asc, data1, data2)
    if data1.canI == data2.canI then
        return Sorted.DefaultItemSort(data1, data2)
    end
    if asc then
        return data1.canI < data2.canI
    else
        return data1.canI > data2.canI
    end
end
Sorted:AddSortMethod("CANIMOGIT", "|TInterface\\MINIMAP\\TRACKING\\Transmogrifier:18:18:0:0:32:32:0:32:0:32|t", Sort, false)

local PreSort = function(itemData)
    if Sorted.IsPlayingCharacterSelected() then
        itemData.canI = CanIMogIt:GetIconText(itemData.link, itemData.bag, itemData.slot)
    end
end
Sorted:AddDataToItem("CANIMOGIT", PreSort)