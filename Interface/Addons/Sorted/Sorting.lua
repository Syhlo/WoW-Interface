local _, S = ...

-- GROUPING
S.collapsedGroups = {}

S.GROUP_BY_CATEGORY = 1
S.GROUP_BY_MARKER_ICON = 2
S.GROUP_BY_TYPE = 3
S.GROUP_BY_BINDING = 4
S.GROUP_BY_EXPAC = 5

S.GROUP_BY_TYPE_ORDER = {
    [LE_ITEM_CLASS_WEAPON] = 1,
    [LE_ITEM_CLASS_ARMOR] = 2,
    [LE_ITEM_CLASS_CONTAINER] = 3,
    [LE_ITEM_CLASS_GEM] = 4,
    [LE_ITEM_CLASS_KEY] = 5,
    [LE_ITEM_CLASS_ITEM_ENHANCEMENT] = 6,
    [LE_ITEM_CLASS_CONSUMABLE] = 7,
    [LE_ITEM_CLASS_GLYPH] = 8,
    [LE_ITEM_CLASS_TRADEGOODS] = 9,
    [LE_ITEM_CLASS_PROJECTILE] = 10,
    [LE_ITEM_CLASS_QUIVER] = 11,
    [LE_ITEM_CLASS_RECIPE] = 12,
    [LE_ITEM_CLASS_BATTLEPET] = 13,
    [LE_ITEM_CLASS_QUESTITEM] = 14,
    [LE_ITEM_CLASS_REAGENT] = 15,
    [LE_ITEM_CLASS_MISCELLANEOUS] = 16,
    [LE_ITEM_CLASS_WOW_TOKEN] = 17,
}

S.BINDING_GROUPS = {
    [0] = {
        ["name"] = Sorted.Localize("SUBFILTER_BINDING_NONE"),
        ["order"] = 6,
    },
    [1] = {
        ["name"] = Sorted.Localize("SUBFILTER_BINDING_ON_PICKUP"),
        ["order"] = 5,
    },
    [2] = {
        ["name"] = Sorted.Localize("SUBFILTER_BINDING_ON_EQUIP").." ("..Sorted.Localize("SUBFILTER_BINDING_SOULBOUND")..")",
        ["order"] = 2,
    },
    [3] = {
        ["name"] = Sorted.Localize("SUBFILTER_BINDING_ON_USE").." ("..Sorted.Localize("SUBFILTER_BINDING_SOULBOUND")..")",
        ["order"] = 4,
    },
    [4] = {
        ["name"] = Sorted.Localize("SUBFILTER_BINDING_NONE"),
        ["order"] = 6,
    },
    [5] = {
        ["name"] = Sorted.Localize("SUBFILTER_BINDING_ON_PICKUP"),
        ["order"] = 5,
    },
    [6] = {
        ["name"] = Sorted.Localize("SUBFILTER_BINDING_ON_EQUIP"),
        ["order"] = 1,
    },
    [7] = {
        ["name"] = Sorted.Localize("SUBFILTER_BINDING_ON_USE"),
        ["order"] = 3,
    }
}

S.groupingMethods = {
    [S.GROUP_BY_CATEGORY] = {
        ["name"] = "GROUPING_CATEGORY",
        ["func"] = function(itemData)
            if itemData.categories then
                local data = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)
                for categoryID, category in ipairs(data) do
                    if itemData.categories[categoryID] == 1 then
                        return categoryID, category.name
                    end
                end
            end
            return S.MAX_GROUPS, "None"
        end
    },
    [S.GROUP_BY_MARKER_ICON] = {
        ["name"] = "FILTER_MARKER_ICON",
        ["func"] = function(itemData)
            local favorited = Sorted_GetFavorited(itemData)
            if not favorited then
                return S.MAX_GROUPS, S.FormatMarkerIcon(nil)
            end
            return favorited, S.FormatMarkerIcon(favorited)
        end
    },
    [S.GROUP_BY_TYPE] = {
        ["name"] = "COLUMN_TYPE",
        ["func"] = function(itemData)
            if not itemData.classID then return nil end
            return S.GROUP_BY_TYPE_ORDER[itemData.classID], GetItemClassInfo(itemData.classID)
        end
    },
    [S.GROUP_BY_BINDING] = {
        ["name"] = "COLUMN_BINDING",
        ["func"] = function(itemData)
            if not itemData.bindType then return S.BINDING_GROUPS[0].order, S.BINDING_GROUPS[0].name end
            local binding = itemData.bindType
            if not itemData.bound then binding = binding + 4 end
            return S.BINDING_GROUPS[binding].order, S.BINDING_GROUPS[binding].name
        end
    },
    [S.GROUP_BY_EXPAC] = {
        ["name"] = "COLUMN_EXPANSION",
        ["func"] = function(itemData)
            if not itemData.expacID then return 0 end
            return 18 - itemData.expacID, Sorted_FormatExpac(itemData.expacID, 58, 29)
        end
    },
}

-- SORTING
local draggingIndex = nil

local function GetSortArrow(ascending)
    local s = "|TInterface\\Addons\\Sorted\\Textures\\Sort-Arrow"
    if Sorted_GetSetting("fontOutline") > 0 then
        s = s.."-Outline"
        if Sorted_GetSetting("fontOutline") > 1 then
            s = s..":0:0:-5"
        else
            s = s..":0:0:-2"
        end
    else
        s = s..":0:0:-1"
    end
    if ascending then
        s = s..":-1:16:16:0:16:0:16|t"
    else
        s = s..":0:16:16:0:16:16:0|t"
    end
    return s
end

-- Sort functions
local function SortByName(data1, data2) return data1.name < data2.name end
local function SortByQuantity(data1, data2) return data1.count < data2.count end
local function SortByLevel(data1, data2) if not data1.effectiveILvl then return false elseif not data2.effectiveILvl then return true end return data1.effectiveILvl > data2.effectiveILvl end
local function SortByValue(data1, data2) return data1.value * data1.count < data2.value * data2.count end
local function SortByRarity(data1, data2) return data1.quality > data2.quality end
local function SortByNameThenQuantity(data1, data2)
    if data1.name == data2.name then
        if data1.count == data2.count then
            return data1.bag * 36 + data1.slot < data2.bag * 36 + data2.slot
        end
        return SortByQuantity(data2, data1)
    end
    return SortByName(data1, data2)
end
local function SortByRarityThenLevel(data1, data2)
    if data1.quality == data2.quality then
        if data1.effectiveILvl == data2.effectiveILvl then
            return SortByNameThenQuantity(data1, data2)
        end
        return SortByLevel(data1, data2)
    else
        return SortByRarity(data1, data2)
    end
end
local function SortByLevelThenRarity(data1, data2)
    if data1.effectiveILvl == data2.effectiveILvl then
        if data1.quality == data2.quality then
            return SortByNameThenQuantity(data1, data2)
        end
        return SortByRarity(data1, data2)
    else
        return SortByLevel(data1, data2)
    end
end

local function Sorted_ItemButtonSort(itemButton1, itemButton2)
    local data1, data2 = itemButton1:GetData(), itemButton2:GetData()

    -- Get rid of those pesky non-existent item buttons
    if not itemButton1 then return false
    elseif not itemButton2 then return true end
    if itemButton1.empty then return false
    elseif itemButton2.empty then return true end
    if itemButton1.filtered and not itemButton2.filtered then return false
    elseif itemButton2.filtered and not itemButton1.filtered then return true end
    if not data1.itemID then return false
    elseif not data2.itemID then return true end

    -- Getting into the real meat of the sorting
    if Sorted_GetSetting("newOnTop") == 2 then
        local data1New, data2New = itemButton1:IsNew(), itemButton2:IsNew()
        if data1New ~= data2New then
            if data1New and not data2New then return true
            elseif not data1New and data2New then return false end
            return data1New < data2New
        end
    end

    -- Grouping
    if Sorted_GetSetting("grouping") > 0 then
        local group1 = S.groupingMethods[Sorted_GetSetting("grouping")].func(data1)
        if not group1 then return false end
        local group2 = S.groupingMethods[Sorted_GetSetting("grouping")].func(data2)
        if not group2 then return true end
        if group1 ~= group2 then
            return group1 < group2
        end
    end

    if Sorted_GetSetting("favoritesOnTop") == 2 then
        local data1Fav, data2Fav = Sorted_GetFavorited(data1), Sorted_GetFavorited(data2)
        if data1Fav ~= data2Fav then
            if data1Fav == nil then return false
            elseif data2Fav == nil then return true
            else return data1Fav < data2Fav end
        end
    end

    local sortButton = Sorted_GetSortButton(Sorted_selectedSort)

    if Sorted_sortVariant < 3 or #sortButton.sortMethods == 1 then
        if Sorted_sortVariant % 2 == 1 then
            return sortButton.sortMethods[1].func(data1, data2)
        else
            return sortButton.sortMethods[1].func(data2, data1)
        end
    else
        if Sorted_sortVariant % 2 == 1 then
            return sortButton.sortMethods[2].func(data1, data2)
        else
            return sortButton.sortMethods[2].func(data2, data1)
        end
    end
end

function SortedItemList_SortItems(self)
    table.sort(self.itemButtons, Sorted_ItemButtonSort)
end


-- SORT BUTTONS

-- These refer to the uniqueID of the sort buttons in Sorted_sortButtons
SORTED_SORTBUTTON_FAVORITES = 1
SORTED_SORTBUTTON_QUANTITY = 2
SORTED_SORTBUTTON_NAME = 3
SORTED_SORTBUTTON_REQUIRED_LEVEL = 8
SORTED_SORTBUTTON_LEVEL = 4
SORTED_SORTBUTTON_UPGRADE = 15
SORTED_SORTBUTTON_ADDED = 6
SORTED_SORTBUTTON_TYPE = 9
SORTED_SORTBUTTON_SUBTYPE = 14
SORTED_SORTBUTTON_TYPE_ICON = 13
SORTED_SORTBUTTON_EXPANSION = 10
SORTED_SORTBUTTON_BIND = 7
SORTED_SORTBUTTON_VALUE = 5
SORTED_SORTBUTTON_TRANSMOG = 11
SORTED_SORTBUTTON_ICON = 12
SORTED_SORTBUTTON_TRASH = 16

-- Saved between sessions. Uses unique IDs
Sorted_enabledColumns = {
    [SORTED_SORTBUTTON_FAVORITES] = true,
    [SORTED_SORTBUTTON_QUANTITY] = true,
    [SORTED_SORTBUTTON_ICON] = true,
    [SORTED_SORTBUTTON_NAME] = true,
    [SORTED_SORTBUTTON_REQUIRED_LEVEL] = false,
    [SORTED_SORTBUTTON_LEVEL] = true,
    [SORTED_SORTBUTTON_UPGRADE] = true,
    [SORTED_SORTBUTTON_ADDED] = false,
    [SORTED_SORTBUTTON_TYPE] = false,
    [SORTED_SORTBUTTON_SUBTYPE] = false,
    [SORTED_SORTBUTTON_TYPE_ICON] = false,
    [SORTED_SORTBUTTON_EXPANSION] = false,
    [SORTED_SORTBUTTON_BIND] = false,
    [SORTED_SORTBUTTON_VALUE] = true,
    [SORTED_SORTBUTTON_TRANSMOG] = false,
    [SORTED_SORTBUTTON_TRASH] = false
}

Sorted_sortButtonOrder = {
    [SORTED_SORTBUTTON_FAVORITES] = 1,
    [SORTED_SORTBUTTON_QUANTITY] = 2,
    [SORTED_SORTBUTTON_ICON] = 3,
    [SORTED_SORTBUTTON_NAME] = 4,
    [SORTED_SORTBUTTON_REQUIRED_LEVEL] = 5,
    [SORTED_SORTBUTTON_LEVEL] = 6,
    [SORTED_SORTBUTTON_UPGRADE] = 7,
    [SORTED_SORTBUTTON_ADDED] = 8,
    [SORTED_SORTBUTTON_TYPE] = 9,
    [SORTED_SORTBUTTON_SUBTYPE] = 10,
    [SORTED_SORTBUTTON_TYPE_ICON] = 11,
    [SORTED_SORTBUTTON_EXPANSION] = 12,
    [SORTED_SORTBUTTON_BIND] = 13,
    [SORTED_SORTBUTTON_VALUE] = 14,
    [SORTED_SORTBUTTON_TRANSMOG] = 15,
    [SORTED_SORTBUTTON_TRASH] = 16
}

-- Ordered left to right
Sorted_sortButtons = {
    {
        ["name"] = Sorted.Localize("COLUMN_FAVORITES"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameFavoritesSortButton,
        ["width"] = 20,
        ["itemButtonKeys"] = {"favoriteButton"},
        ["align"] = "CENTER",
        ["uniqueID"] = SORTED_SORTBUTTON_FAVORITES -- This will never change in the future, even if other sortButtons are added.
    },
    {
        ["name"] = Sorted.Localize("COLUMN_QUANTITY"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 42,
        ["sortMethods"] = {
            {
                ["title"] = "#",
                ["func"] = function(slot1, slot2)
                    if slot1.count == slot2.count then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    return SortByQuantity(slot2, slot1)
                end
            }
        },
        ["align"] = "RIGHT",
        ["itemButtonKeys"] = {"quantityString"},
        ["uniqueID"] = SORTED_SORTBUTTON_QUANTITY
    },
    {
        ["name"] = Sorted.Localize("COLUMN_ICON"),
        ["dontDrawColumnSeparators"] = true,
        ["Enabled"] = function(self) return true end,
        ["width"] = 24,
        ["sortMethods"] = {
            {
                ["title"] = "",
                ["func"] = function(slot1, slot2) 
                    return SortByRarityThenLevel(slot1, slot2)
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"iconFrame"},
        ["uniqueID"] = SORTED_SORTBUTTON_ICON
    },
    {
        ["name"] = Sorted.Localize("COLUMN_NAME"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 128,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_RARITY_SHORT"),
                ["func"] = function(slot1, slot2) 
                    return SortByRarityThenLevel(slot1, slot2)
                end
            },
            {
                ["title"] = Sorted.Localize("COLUMN_NAME_SHORT"),
                ["func"] = function(slot1, slot2) 
                    return SortByNameThenQuantity(slot1, slot2)
                end,
                ["inverse"] = true
            }
        },
        ["align"] = "LEFT",
        ["itemButtonKeys"] = {"nameString"},
        ["uniqueID"] = SORTED_SORTBUTTON_NAME
    },
    {
        ["name"] = Sorted.Localize("COLUMN_REQUIRED_LEVEL"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 38,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_REQUIRED_LEVEL_SHORT"),
                ["func"] = function(slot1, slot2)
                    if slot1.minLevel == slot2.minLevel or (slot1.minLevel < 2 and slot2.minLevel < 2) then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    return slot1.minLevel > slot2.minLevel
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"minLevelString"},
        ["uniqueID"] = SORTED_SORTBUTTON_REQUIRED_LEVEL
    },
    {
        ["name"] = Sorted.Localize("COLUMN_ITEM_LEVEL"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 38,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_ITEM_LEVEL_SHORT"),
                ["func"] = function(slot1, slot2) 
                    return SortByLevelThenRarity(slot1, slot2)
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"levelString"},
        ["uniqueID"] = SORTED_SORTBUTTON_LEVEL
    },
    {
        ["name"] = "Pawn",
        ["Enabled"] = function(self) return IsAddOnLoaded("Pawn") end,
        ["width"] = 24,
        ["sortMethods"] = {
            {
                ["title"] = "|TInterface\\ContainerFrame\\Bags:0:0:0:0:256:256:83:98:169:186|t",
                ["func"] = function(slot1, slot2) 
                    local upgrade1, upgrade2 = S.IsContainerItemAnUpgrade(slot1.bag, slot1.slot), S.IsContainerItemAnUpgrade(slot2.bag, slot2.slot)
                    if upgrade1 == upgrade2 then
                        return SortByLevelThenRarity(slot1, slot2)
                    end
                    return upgrade1
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"upgradeIcon"},
        ["uniqueID"] = SORTED_SORTBUTTON_UPGRADE
    },
    {
        ["name"] = Sorted.Localize("COLUMN_TIME_ADDED"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 64,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_TIME_ADDED_SHORT"),
                ["func"] = function(slot1, slot2)
                    if not slot1.timeAdded then return false end
                    if not slot2.timeAdded then return true end
                    if slot1.timeAdded == slot2.timeAdded then
                        return SortByNameThenQuantity(slot1, slot2)
                    end
                    return slot1.timeAdded > slot2.timeAdded
                end
            }
        },
        ["align"] = "RIGHT",
        ["itemButtonKeys"] = {"timeAddedString"},
        ["uniqueID"] = SORTED_SORTBUTTON_ADDED
    },
    {
        ["name"] = Sorted.Localize("COLUMN_TYPE"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 80,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_TYPE_SHORT"),
                ["func"] = function(slot1, slot2)
                    if slot1.classID == slot2.classID then
                        if slot1.subClassID == slot2.subClassID then
                            return SortByRarityThenLevel(slot1, slot2)
                        end
                        if not slot1.subClassID then return false end
                        if not slot2.subClassID then return true end
                        return S.GetItemSubClassInfo(slot1.classID, slot1.subClassID) < S.GetItemSubClassInfo(slot2.subClassID, slot2.subClassID)
                    end
                    if not slot1.classID then return false end
                    if not slot2.classID then return true end
                    return GetItemClassInfo(slot1.classID) < GetItemClassInfo(slot2.classID)
                end
            }
        },
        ["align"] = "LEFT",
        ["itemButtonKeys"] = {"typeString"},
        ["uniqueID"] = SORTED_SORTBUTTON_TYPE
    },
    {
        ["name"] = Sorted.Localize("FILTER_SUBTYPE"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 80,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("FILTER_SUBTYPE"),
                ["func"] = function(slot1, slot2)
                    if slot1.classID == slot2.classID and slot1.subClassID == slot2.subClassID then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if not slot1.classID or not slot1.subClassID then return false end
                    if not slot2.classID or not slot2.subClassID then return true end
                    return S.GetItemSubClassInfo(slot1.classID, slot1.subClassID) < S.GetItemSubClassInfo(slot2.classID, slot2.subClassID)
                end
            }
        },
        ["align"] = "LEFT",
        ["itemButtonKeys"] = {"subtypeString"},
        ["uniqueID"] = SORTED_SORTBUTTON_SUBTYPE
    },
    {
        ["name"] = Sorted.Localize("COLUMN_TYPE").." ("..Sorted.Localize("COLUMN_ICON")..")",
        ["Enabled"] = function(self) return true end,
        ["width"] = 32,
        ["sortMethods"] = {
            {
                ["title"] = "",
                ["func"] = function(slot1, slot2)
                    if slot1.classID == slot2.classID then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if not slot1.classID then return false end
                    if not slot2.classID then return true end
                    return slot1.classID < slot2.classID
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"typeIcon"},
        ["uniqueID"] = SORTED_SORTBUTTON_TYPE_ICON
    },
    {
        ["name"] = Sorted.Localize("COLUMN_EXPANSION"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 56,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_EXPANSION_SHORT"),
                ["func"] = function(slot1, slot2)
                    if slot1.expacID == slot2.expacID then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if not slot1.expacID then return false end
                    if not slot2.expacID then return true end
                    return slot1.expacID > slot2.expacID
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"expacIcon"},
        ["uniqueID"] = SORTED_SORTBUTTON_EXPANSION
    },
    {
        ["name"] = Sorted.Localize("COLUMN_BINDING"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 28,
        ["sortMethods"] = {
            {
                ["title"] = "|TInterface\\Addons\\Sorted\\Textures\\Bind-Icons:0:0:0:0:128:64:38:56:7:28|t", --Sorted.Localize("COLUMN_BINDING_SHORT"),
                ["func"] = function(slot1, slot2)
                    if slot1.bindType == slot2.bindType and slot1.bound == slot2.bound then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if slot1.bindType == 0 then return false end
                    if slot2.bindType == 0 then return true end
                    if slot2.bound and not slot1.bound then return true end
                    if slot1.bound and not slot2.bound then return false end
                    return slot1.bindType > slot2.bindType
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"bindIcon"},
        ["uniqueID"] = SORTED_SORTBUTTON_BIND
    },
    {
        ["name"] = Sorted.Localize("COLUMN_SELL_PRICE"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 56,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_SELL_PRICE_SHORT"),
                ["func"] = function(slot1, slot2) 
                    if slot1.hasNoValue and slot2.hasNoValue then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if slot1.hasNoValue then return false end
                    if slot2.hasNoValue then return true end
                    if slot1.value * slot1.count == slot2.value * slot2.count then
                        return SortByNameThenQuantity(slot1, slot2)
                    end
                    return slot1.value * slot1.count > slot2.value * slot2.count
                end
            }
        },
        ["align"] = "RIGHT",
        ["itemButtonKeys"] = {"valueString"},
        ["uniqueID"] = SORTED_SORTBUTTON_VALUE
    },
    {
        ["name"] = "Can I Mog It?",
        ["Enabled"] = function(self) return IsAddOnLoaded("CanIMogIt") end,
        ["width"] = 28,
        ["sortMethods"] = {
            {
                ["title"] = "|TInterface\\MINIMAP\\TRACKING\\Transmogrifier:0:0|t",
                ["func"] = function(slot1, slot2)
                    local s1, s2 = CanIMogIt:GetIconText(slot1.link), CanIMogIt:GetIconText(slot2.link)
                    if s1 == s2 then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if not s1 or s1 == "" then 
                        return false
                    elseif not s2 or s2 == "" then 
                        return true
                    else
                        return s1 < s2
                    end
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"transmogString"},
        ["uniqueID"] = SORTED_SORTBUTTON_TRANSMOG
    },
    {
        ["name"] = Sorted.Localize("COLUMN_TRASH"),
        ["Enabled"] = function(self) return true end,
        ["width"] = 28,
        ["sortMethods"] = {
            {
                ["title"] = "|TInterface\\Addons\\Sorted\\Textures\\Trash-Icons:0:0:0:0:128:64:38:58:5:25|t", --Sorted.Localize("COLUMN_BINDING_SHORT"),
                ["func"] = function(slot1, slot2)
                    local trash1, trash2 = Sorted_GetTrash(slot1), Sorted_GetTrash(slot2)
                    if trash1 == 0 then trash1 = 1 end
                    if trash2 == 0 then trash2 = 1 end
                    if trash1 == trash2 then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    return trash1 < trash2
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"trashButton"},
        ["uniqueID"] = SORTED_SORTBUTTON_TRASH
    }
}
SORTED_DEFAULT_SORT = 3

function Sorted_GetSortButton(uniqueID)
    for k,v in pairs(Sorted_sortButtons) do
        if v.uniqueID == uniqueID then
            return v
        end
    end
end

function SortedSortButtons_GetTotalWidth()
    local width = 0
    for k,v in pairs(Sorted_sortButtons) do
        if v:Enabled() and Sorted_enabledColumns[v.uniqueID] then
            width = width + v.width
        end
    end
    return width
end

function Sorted_UpdateSortButtons()
    -- Left sortButtons
    local leftPosX, rightPosX = 0, 0
    local nameColumnIndex = 0
    local lastButtonIndex = 0
    for i, v in ipairs(Sorted_sortButtons) do
        nameColumnIndex = i
        if v:Enabled() then
            if Sorted_enabledColumns[v.uniqueID] then
                if v.uniqueID == SORTED_SORTBUTTON_NAME then
                    break -- Stop at item name column
                end
                if v.uniqueID == SORTED_SORTBUTTON_ICON and lastButtonIndex == 0 then
                    leftPosX = 6 -- Provide space to the left if the first column is icon
                end
                if v.dontDrawColumnSeparators then
                    if lastButtonIndex > 0 and Sorted_sortButtons[lastButtonIndex].columnSeparators then
                        for k,colSep in pairs(Sorted_sortButtons[lastButtonIndex].columnSeparators) do   
                            colSep:SetPoint("LEFT", -100, 0)
                        end
                    end
                end
                if i > lastButtonIndex then lastButtonIndex = i end
                v.button:SetPoint("LEFT", leftPosX, 0)
                v.button:SetPoint("RIGHT", v.button:GetParent(), "LEFT", leftPosX + v.width, 0)
                if v.itemButtonKeys then
                    for _,itemList in pairs(Sorted_itemLists) do
                        for _,slot in pairs(itemList.itemButtons) do
                            for _,itemButtonKey in pairs(v.itemButtonKeys) do
                                if v.align == "LEFT" then
                                    slot[itemButtonKey]:SetPoint("LEFT", slot, "LEFT", 4 + leftPosX, 0)
                                    slot[itemButtonKey]:SetWidth(v.width - 4)
                                elseif v.align == "RIGHT" then
                                    slot[itemButtonKey]:SetPoint("RIGHT", slot, "LEFT", -6 + leftPosX + v.width, 0)
                                    slot[itemButtonKey]:SetWidth(v.width - 4)
                                elseif v.align == "CENTER" then
                                    slot[itemButtonKey]:SetPoint("CENTER", slot, "LEFT", leftPosX + v.width / 2, 0)
                                end
                                if slot[itemButtonKey].SetFrameLevel then
                                    slot[itemButtonKey]:SetFrameLevel(580)
                                end
                            end
                        end
                    end
                end
                leftPosX = leftPosX + v.width
                if v.columnSeparators then
                    for k,colSep in pairs(v.columnSeparators) do   
                        colSep:SetPoint("LEFT", leftPosX - 2, 0)
                    end
                end
            end
        end
    end
    -- Right sortButtons
    local dontDrawColumnSeparators = false
    for i = #Sorted_sortButtons, nameColumnIndex + 1, -1 do
        local v = Sorted_sortButtons[i]
        if v:Enabled() then
            if Sorted_enabledColumns[v.uniqueID] then
                if i > lastButtonIndex then lastButtonIndex = i end
                v.button:SetPoint("LEFT", v.button:GetParent(), "RIGHT", rightPosX - 4 - v.width, 0)
                v.button:SetPoint("RIGHT", rightPosX - 4, 0)
                if v.itemButtonKeys then
                    for _,itemList in pairs(Sorted_itemLists) do
                        for _,slot in pairs(itemList.itemButtons) do
                            for _,itemButtonKey in pairs(v.itemButtonKeys) do
                                if v.align == "LEFT" then
                                    slot[itemButtonKey]:SetPoint("LEFT", slot, "RIGHT", 4 + rightPosX - v.width, 0)
                                    slot[itemButtonKey]:SetWidth(v.width - 4)
                                elseif v.align == "RIGHT" then
                                    slot[itemButtonKey]:SetPoint("RIGHT", slot, "RIGHT", -6 + rightPosX, 0)
                                    slot[itemButtonKey]:SetWidth(v.width - 4)
                                elseif v.align == "CENTER" then
                                    slot[itemButtonKey]:SetPoint("CENTER", slot, "RIGHT", rightPosX - v.width / 2, 0)
                                end
                                if slot[itemButtonKey].SetFrameLevel then
                                    slot[itemButtonKey]:SetFrameLevel(580)
                                end
                            end
                        end
                    end
                end
                if v.columnSeparators then
                    if dontDrawColumnSeparators then
                        for k,colSep in pairs(v.columnSeparators) do
                            colSep:SetPoint("LEFT", -100, 0)
                        end
                    else
                        for k,colSep in pairs(v.columnSeparators) do
                            if rightPosX == 0 then
                                colSep:SetPoint("LEFT", colSep.relScrollBar, "LEFT", rightPosX - 5, 0)
                            else
                                colSep:SetPoint("LEFT", colSep.relScrollBar, "LEFT", rightPosX - 4, 0)
                            end
                        end
                    end
                end
                if v.dontDrawColumnSeparators then
                    dontDrawColumnSeparators = true
                else
                    dontDrawColumnSeparators = false
                end
                rightPosX = rightPosX - v.width
            end
        end
    end
    -- Fill remaining space with the last button
    if Sorted_enabledColumns[SORTED_SORTBUTTON_NAME] then
        local sortButton = Sorted_GetSortButton(SORTED_SORTBUTTON_NAME)
        sortButton.button:SetPoint("LEFT", leftPosX, 0)
        sortButton.button:SetPoint("RIGHT", rightPosX - 4, 0)
        for k,itemList in pairs(Sorted_itemLists) do
            for l,slot in pairs(itemList.itemButtons) do
                --[[if leftPosX == 0 then
                    slot.iconFrame:SetPoint("LEFT", slot, "LEFT", 6, 0)
                else
                    slot.iconFrame:SetPoint("LEFT", slot, "LEFT", 2 + leftPosX, 0)
                end]]
                slot.nameFrame:SetPoint("LEFT", leftPosX + 4, 0)
                slot.nameFrame.leftX = leftPosX + 4
                slot.nameFrame:SetPoint("RIGHT", rightPosX - 9, 0)
                slot.nameFrame.rightX = rightPosX - 9
            end
        end
        if sortButton.columnSeparators then
            if dontDrawColumnSeparators then
                for k,colSep in pairs(sortButton.columnSeparators) do
                    colSep:SetPoint("LEFT", -100, 0)
                end
            else
                for k,colSep in pairs(sortButton.columnSeparators) do
                    colSep:SetPoint("LEFT", colSep.relScrollBar, "LEFT", rightPosX - 4, 0)
                end
            end
        end
    else
        local v = Sorted_sortButtons[lastButtonIndex]
        v.button:SetPoint("RIGHT")
        if v.itemButtonKeys then
            for _,itemList in pairs(Sorted_itemLists) do
                for _,slot in pairs(itemList.itemButtons) do
                    for _,itemButtonKey in pairs(v.itemButtonKeys) do
                        if v.align == "LEFT" then
                            slot[itemButtonKey]:SetWidth(200)
                        elseif v.align == "RIGHT" then
                            slot[itemButtonKey]:SetPoint("RIGHT", -4, 0)
                        end
                    end
                end
            end
        end
        if v.columnSeparators then
            for k,colSep in pairs(v.columnSeparators) do   
                colSep:SetPoint("LEFT", colSep:GetParent(), "RIGHT", - 2, 0)
            end
        end
    end

    SortedFrame_UpdateMinSize()
end

function Sorted_EnableSortButton(id)
    local button = Sorted_GetSortButton(id)
    button.button:Show()
    if button.columnSeparators then
        for k,v in pairs(button.columnSeparators) do   
            v:Show()
        end
    end
    if button.itemButtonKeys then
        for _,itemList in pairs(Sorted_itemLists) do
            for _,slot in pairs(itemList.itemButtons) do
                for _,itemButtonKey in pairs(button.itemButtonKeys) do
                    slot[itemButtonKey]:Show()
                    if slot[itemButtonKey].SetFrameLevel then
                        slot[itemButtonKey]:SetFrameLevel(580)
                    end
                end
            end
        end
    end
    Sorted_enabledColumns[id] = true
    Sorted_UpdateSortButtons()
    Sorted_UpdateTimeItemsAdded()
    Sorted_UpdateItemButtons()
    Sorted_FilterItems()
end
function Sorted_DisableSortButton(id)
    if Sorted_selectedSort == id then
        Sorted_selectedSort = SORTED_DEFAULT_SORT
        Sorted_sortVariant = 1
        Sorted_GetSortButton(SORTED_DEFAULT_SORT).button.text:SetText("Rarity")
        Sorted_SortItems()
    end
    local button = Sorted_GetSortButton(id)
    if button.columnSeparators then
        for k,v in pairs(button.columnSeparators) do
            v:Hide()
        end
    end
    if button.itemButtonKeys then
        for _,itemList in pairs(Sorted_itemLists) do
            for _,slot in pairs(itemList.itemButtons) do
                for _,itemButtonKey in pairs(button.itemButtonKeys) do
                    slot[itemButtonKey]:Hide()
                end
            end
        end
    end
    button.button:Hide()
    Sorted_enabledColumns[id] = false
    Sorted_UpdateSortButtons()
    Sorted_UpdateItemButtons()
    Sorted_FilterItems()
end
function Sorted_ToggleSortButton(id)
    if Sorted_enabledColumns[id] then
        Sorted_DisableSortButton(id)
    else
        Sorted_EnableSortButton(id)
    end
end

local function DropdownGroupingButtonClick(self)
    if Sorted_GetSetting("grouping") == self.data then
        Sorted_SetSetting("grouping", 0)
    else
        Sorted_SetSetting("grouping", self.data)
    end
    SortedDropdownMenu:Clear()
    SortedDropdownMenuParent:GetParent():InitFunc()
    SortedDropdownMenuParent:Show()
    S.collapsedGroups = {}
    Sorted_SortItems()
end
local function DropdownButtonClick(self)
    if Sorted_enabledColumns[self.data] then
        local foundOther = false
        for k,v in pairs(Sorted_enabledColumns) do
            if k ~= self.data and k ~="version" and v then
                foundOther = true
            end
        end
        if not foundOther then 
            self:SetChecked(true)
            return false 
        end           
    end     
    Sorted_ToggleSortButton(self.data)
    self:SetChecked(Sorted_enabledColumns[self.data])
end
local function DropdownInitFunc(self)
    SortedDropdownMenu:AddText(Sorted.Localize("CONFIG_GROUPING"))
    for id, grouping in ipairs(S.groupingMethods) do
        local b = SortedDropdownMenu:AddCheckButton(DropdownGroupingButtonClick, Sorted.Localize(grouping.name))
        b.data = id
        b:SetChecked(Sorted_GetSetting("grouping") == id)
    end
    SortedDropdownMenu:AddText(Sorted.Localize("CONFIG_COLUMNS"))
    for i,v in ipairs(Sorted_sortButtons) do
        if v:Enabled() then
            local b = SortedDropdownMenu:AddCheckButton(DropdownButtonClick, v.name)
            b.data = v.uniqueID
            b:SetChecked(Sorted_enabledColumns[v.uniqueID])
        end
    end
end
local function DropdownValueFunc(self) end

function SortedSortButton_OnClick(self, button)
    PlaySound(SOUNDKIT.IG_CHAT_SCROLL_UP)
    if SortedDropdownMenuParent.toggled then
        SortedDropdownMenuParent:ToggleOff(self:GetParent())
    else
        if button == "LeftButton" then
            local sortButton = Sorted_GetSortButton(self:GetID())
            if sortButton.sortMethods then
                if Sorted_selectedSort == self:GetID() then
                    Sorted_sortVariant = Sorted_sortVariant + 1
                    if Sorted_sortVariant > #sortButton.sortMethods * 2 then 
                        Sorted_sortVariant = 1 
                    end
                else
                    Sorted_selectedSort = self:GetID()
                    Sorted_sortVariant = 1
                end
                Sorted_GetSortButton(SORTED_SORTBUTTON_NAME).button.text:SetText("Name") 
                SortedSortButtons_Update()
                Sorted_SortItems()
                Sorted_ScrollToTop()
                Sorted_SetSetting("lastSort", Sorted_selectedSort * 10 + Sorted_sortVariant)
            end
        else
            local x,y = GetCursorPosition()
            x,y = x/UIParent:GetEffectiveScale(), y/UIParent:GetEffectiveScale()
            SortedDropdownMenuParent:ToggleOn(self:GetParent())
            SortedDropdownMenuParent:ClearAllPoints()
            SortedDropdownMenuParent:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x * (1 / SortedFrame:GetScale()), y * (1 / SortedFrame:GetScale()))
        end
    end
end

function SortedSortButton_OnMouseDown(self)
    for i, button in ipairs(Sorted_sortButtons) do
        if button.uniqueID == self:GetID() then
            draggingIndex = i
        end
    end
end

function SortedSortButton_OnMouseUp(self)
    draggingIndex = nil
end

function SortedSortButton_OnEnter(self)
    if draggingIndex then
        for i, button in ipairs(Sorted_sortButtons) do
            if i ~= draggingIndex and button.uniqueID == self:GetID() then
                local temp = Sorted_sortButtons[draggingIndex]
                table.remove(Sorted_sortButtons, draggingIndex)
                table.insert(Sorted_sortButtons, i, temp)
                for i2, v in ipairs(Sorted_sortButtons) do
                    Sorted_sortButtonOrder[v.uniqueID] = i2
                end
                Sorted_UpdateSortButtons()
                draggingIndex = i
                return
            end
        end
    end
end

function SortedSortButtons_Update()
    for i, button in ipairs(Sorted_sortButtons) do
        if button.uniqueID ~= SORTED_SORTBUTTON_FAVORITES then
            local s
            if button.sortMethods then
                if button.uniqueID == Sorted_selectedSort then
                    s = button.sortMethods[math.ceil(Sorted_sortVariant / 2)].title
                else
                    s = button.sortMethods[#button.sortMethods].title
                end
            end
            if button.uniqueID == Sorted_selectedSort then
                local ascending
                if button.sortMethods[math.ceil(Sorted_sortVariant / 2)].inverse then
                    ascending = ((Sorted_sortVariant % 2) == 0)
                else
                    ascending = ((Sorted_sortVariant % 2) == 1)
                end
                s = s..GetSortArrow(ascending)
            end
            button.button.text:SetText(s)
        end
    end
end

function SortedSortButtons_OnLoad(self)
    self.InitFunc = DropdownInitFunc
    self.ValueFunc = DropdownValueFunc

    Sorted_selectedSort = SORTED_DEFAULT_SORT
    Sorted_sortVariant = 1
    for i,v in ipairs(Sorted_sortButtons) do
        local b
        if v.uniqueID ~= SORTED_SORTBUTTON_FAVORITES then -- Ignore favorites tab
            b = CreateFrame("Button", self:GetName()..v.name, self, "SortedColumnHeaderTemplate")
            b:SetScript("OnClick", SortedSortButton_OnClick)
        else
            b = SortedFrameFavoritesSortButton
        end
        b:SetScript("OnMouseDown", SortedSortButton_OnMouseDown)
        b:SetScript("OnMouseUp", SortedSortButton_OnMouseUp)
        b:SetScript("OnDragStop", SortedSortButton_OnMouseUp)
        b:SetScript("OnEnter", SortedSortButton_OnEnter)
        b:SetID(v.uniqueID)
        b:RegisterForClicks("LeftButtonUp", "RightButtonDown")
        b:RegisterForDrag("LeftButton")

        v.button = b

        if v.sortMethods then
            b.text:SetText(v.sortMethods[1].title) 
        end
    end
    SortedSortButtons_Update()
end