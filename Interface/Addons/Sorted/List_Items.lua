local _, S = ...
local pairs, ipairs, string, type, time, GetTime = pairs, ipairs, string, type, time, GetTime

-- Use new APIs
local ContainerIDToInventoryID, GetContainerItemInfo, PickupContainerItem, GetContainerNumSlots, GetContainerNumFreeSlots = ContainerIDToInventoryID, GetContainerItemInfo, PickupContainerItem, GetContainerNumSlots, GetContainerNumFreeSlots
local SortBags = SortBags
if C_Container then
    if C_Container.ContainerIDToInventoryID then ContainerIDToInventoryID = C_Container.ContainerIDToInventoryID end
    if C_Container.GetContainerItemInfo then GetContainerItemInfo = C_Container.GetContainerItemInfo end
    if C_Container.PickupContainerItem then PickupContainerItem = C_Container.PickupContainerItem end
    if C_Container.GetContainerNumSlots then GetContainerNumSlots = C_Container.GetContainerNumSlots end
    if C_Container.GetContainerNumFreeSlots then GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots end
    if C_Container.SortBags then SortBags = C_Container.SortBags end
end


S.ListItemsMixin = {}


-- Default item sort
local function DefaultSort(entry1, entry2)
    if entry1.quality == entry2.quality then
        if entry1.effectiveILvl == entry2.effectiveILvl then
            if entry1.name == entry2.name then
                if entry1.combinedCount == entry2.combinedCount then
                    return entry1.bag * 36 + entry1.slot > entry2.bag * 36 + entry2.slot
                end
                return entry1.combinedCount > entry2.combinedCount
            end
            return entry1.name < entry2.name
        end
        return entry1.effectiveILvl > entry2.effectiveILvl
    end
    return entry1.quality > entry2.quality
end



-- ITEM GROUPS
-- All item lists should share this table for getting and setting the selected grouping method
S.itemGroupingSettings = {
    ["selectedGrouping"] = nil,
    ["collapsedGroups"] = {}
}
S.BINDING_GROUPS = {
    [0] = {
        ["name"] = S.Localize("SUBFILTER_BINDING_NONE"),
        ["order"] = 6,
    },
    [1] = {
        ["name"] = S.Localize("SUBFILTER_BINDING_ON_PICKUP"),
        ["order"] = 5,
    },
    [2] = {
        ["name"] = S.Localize("SUBFILTER_BINDING_ON_EQUIP").." ("..S.Localize("SUBFILTER_BINDING_SOULBOUND")..")",
        ["order"] = 2,
    },
    [3] = {
        ["name"] = S.Localize("SUBFILTER_BINDING_ON_USE").." ("..S.Localize("SUBFILTER_BINDING_SOULBOUND")..")",
        ["order"] = 4,
    },
    [4] = {
        ["name"] = S.Localize("SUBFILTER_BINDING_NONE"),
        ["order"] = 6,
    },
    [5] = {
        ["name"] = S.Localize("SUBFILTER_BINDING_ON_PICKUP"),
        ["order"] = 5,
    },
    [6] = {
        ["name"] = S.Localize("SUBFILTER_BINDING_ON_EQUIP"),
        ["order"] = 1,
    },
    [7] = {
        ["name"] = S.Localize("SUBFILTER_BINDING_ON_USE"),
        ["order"] = 3,
    }
}
-- Function 'func' takes an item and returns:
-- The name of the group
-- A number which is the order of the group when sorting
S.ItemGroups = {
    ["CATEGORY"] = {
        ["name"] = S.Localize("GROUPING_CATEGORY"),
        ["func"] = function(item)
            local categories = S.Settings.Get("categories2")
            for key, cat in pairs(categories) do
                if not S.Category.Filter(key, item) then
                    return "|TInterface\\Icons\\"..cat.icon..":16:16:0:0:64:64:6:58:6:58|t "..cat.name, key
                end
            end
            return "None", 100
        end
    },
    ["FAVORITES"] = {
        ["name"] = S.Localize("FILTER_MARKER_ICON"),
        ["func"] = function(item)
            local markerIcon = S.Data.GetFavorited(item)
            if not markerIcon then
                markerIcon = 100
            end
            return S.Utils.FormatMarkerIcon(markerIcon), markerIcon
        end
    },
    ["TYPE"] = {
        ["name"] = S.Localize("COLUMN_TYPE"),
        ["func"] = function(item)
            if item.classID then
                return GetItemClassInfo(item.classID), item.classID
            else
                return "None", 100
            end
        end
    },
    ["QUALITY"] = {
        ["name"] = S.Localize("FILTER_QUALITY"),
        ["func"] = function(item)
            if item.quality then
                return S.Utils.GetItemQualityName(item.quality), -item.quality
            else
                return "None", 100
            end
        end
    },
    ["BINDING"] = {
        ["name"] = S.Localize("COLUMN_BINDING"),
        ["func"] = function(item)
            if not item.bindType then return S.BINDING_GROUPS[0].name, S.BINDING_GROUPS[0].order end
            local binding = item.bindType
            if not item.bound then binding = binding + 4 end
            return S.BINDING_GROUPS[binding].name, S.BINDING_GROUPS[binding].order
        end
    },
    ["EXPANSION"] = {
        ["name"] = S.Localize("COLUMN_EXPANSION"),
        ["func"] = function(item)
            if not item.expacID then return 0 end
            return S.Utils.FormatExpac(item.expacID, 40, 20)..S.Utils.FormatExpacLong(item.expacID), 18 - item.expacID
        end
    }
}



-- Item Columns
local function GetIconSize(self)
    return S.Settings.Get("iconSize") + 4
end
--[[local function GetColumnMinWidthOrIconSize(self)
    local width = S.Settings.Get("iconSize") + 4
    if width > self.minWidth then
        return width
    else
        return self.minWidth
    end
end]]
S.ItemColumns = {
    ["FAVORITES"] = {
        ["name"] = S.Localize("COLUMN_FAVORITES"),
        ["width"] = 24,
        ["align"] = "CENTER",
        ["CreateElement"] = function(self)
            self.favoriteButton = CreateFrame("BUTTON", nil, self)
            self.favoriteButton:SetPoint("CENTER")
            self.favoriteButton:SetSize(18, 18)
            self.favoriteButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
            self.favoriteButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
            self.favoriteButton:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
            self.favoriteButton.backdrop = self.favoriteButton:CreateTexture(nil, "BACKGROUND")
            self.favoriteButton.backdrop:SetTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
            self.favoriteButton.backdrop:SetAllPoints()
            self.favoriteButton.parent = self.parent
            self.favoriteButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
            self.favoriteButton:SetScript("OnClick", function(self, button, down)
                if button == "LeftButton" then
                    self.parent:ToggleFavorited()
                elseif button == "RightButton" then
                    S.MarkerIconMenu.Show(self, self.parent:GetData().quality, self.parent:GetData().texture, self.parent.SetFavorited, self.parent, self.parent.ClearFavorited)
                end
            end)
        end,
        ["UpdateElement"] = function(self, data)
            local favorited = self.parent:GetFavorited()
            local favoriteButtonTexSize = 0.21875
            local x,y
            if not favorited or favorited == 0 then
                self.favoriteButton:GetNormalTexture():SetTexCoord(1,1,1,1)
                x = 0
                y = 0
                self.favoriteButton:GetHighlightTexture():SetTexCoord(
                    x * favoriteButtonTexSize, 
                    (x+1) * favoriteButtonTexSize,
                    y * favoriteButtonTexSize, 
                    (y+1) * favoriteButtonTexSize
                )
                self.favoriteButton:GetPushedTexture():SetTexCoord(
                    x * favoriteButtonTexSize, 
                    (x+1) * favoriteButtonTexSize,
                    y * favoriteButtonTexSize, 
                    (y+1) * favoriteButtonTexSize
                )
                if self.mouseEntered then
                    self.favoriteButton.backdrop:SetTexCoord(0,favoriteButtonTexSize,favoriteButtonTexSize*2,favoriteButtonTexSize*3)
                else
                    self.favoriteButton.backdrop:SetTexCoord(1,1,1,1)
                end
            else
                x,y = (favorited - 1) % 4, floor((favorited - 1) / 4)
                self.favoriteButton:GetNormalTexture():SetTexCoord(
                    x * favoriteButtonTexSize, 
                    (x+1) * favoriteButtonTexSize,
                    y * favoriteButtonTexSize, 
                    (y+1) * favoriteButtonTexSize
                )
                self.favoriteButton:GetHighlightTexture():SetTexCoord(
                    x * favoriteButtonTexSize, 
                    (x+1) * favoriteButtonTexSize,
                    y * favoriteButtonTexSize, 
                    (y+1) * favoriteButtonTexSize
                )
                self.favoriteButton:GetPushedTexture():SetTexCoord(
                    x * favoriteButtonTexSize, 
                    (x+1) * favoriteButtonTexSize,
                    y * favoriteButtonTexSize, 
                    (y+1) * favoriteButtonTexSize
                )
                self.favoriteButton.backdrop:SetTexCoord(1,1,1,1)
            end

            if data.filtered then
                self.favoriteButton:GetNormalTexture():SetDesaturated(true)
                self.favoriteButton:GetNormalTexture():SetVertexColor(S.Color.LIGHT_GREY:GetRGB())
            else
                self.favoriteButton:GetNormalTexture():SetDesaturated(false)
                self.favoriteButton:GetNormalTexture():SetVertexColor(S.Color.WHITE:GetRGB())
            end
        end
    },
    ["QUANTITY"] = {
        ["name"] = S.Localize("COLUMN_QUANTITY"),
        ["width"] = 42,
        ["align"] = "RIGHT",
        ["sortMethods"] = {
            {
                ["title"] = "#",
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByKey(not asc, slot1, slot2, "combinedCount", DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.quantityString = f:CreateFontString(nil, "OVERLAY", "SortedFont")
            f.quantityString:SetPoint("RIGHT", -2, 0)
            f.quantityString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
        end,
        ["UpdateElement"] = function(self, data)
            if data.combinedCount <= 1 then
                self.quantityString:SetText("")
            else
                self.quantityString:SetText(data.combinedCount)
                if data.filtered then
                    self.quantityString:SetTextColor(S.Color.GREY:GetRGB())
                else
                    self.quantityString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
                end
            end
        end
    },
    ["MAX_STACK"] = {
        ["name"] = S.Localize("COLUMN_MAX_STACK"),
        ["width"] = 42,
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_MAX_STACK_SHORT"),
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByKey(not asc, slot1, slot2, "combinedCount", DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.text = f:CreateFontString(nil, "OVERLAY", "SortedFont")
            f.text:SetPoint("LEFT", 2, 0)
            f.text:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
            f.text:SetAlpha(0.5)
        end,
        ["UpdateElement"] = function(self, data)
            self.text:SetText(data.stackCount)
            if data.filtered then
                self.text:SetTextColor(S.Color.GREY:GetRGB())
            else
                self.text:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
            end
        end
    },
    ["ICON"] = {
        ["name"] = S.Localize("COLUMN_ICON"),
        ["GetWidth"] = GetIconSize,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = "",
                ["func"] = function(asc, slot1, slot2) 
                    return S.Sort.ByKey(not asc, slot1, slot2, "quality", DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(self)
            self.icon = self:CreateTexture(nil, "ARTWORK")
            self.icon:SetPoint("CENTER")
            self.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
            self.iconMask = self:CreateMaskTexture()
            self.iconMask:SetTexture("Interface\\Addons\\Sorted\\Textures\\Circle_Mask")
            self.iconMask:SetPoint("CENTER")
            self.iconBorder = self:CreateTexture(nil, "BORDER")
            self.iconBorder:SetTexture("Interface\\Addons\\Sorted\\Textures\\Circle_Mask")
            self.iconBorder:SetPoint("CENTER")
        end,
        ["UpdateElement"] = function(self, data)
            self.icon:SetTexture(data.texture)
            if data.filtered then
                self.icon:SetDesaturated(true)
                self.icon:SetVertexColor(S.Color.LIGHT_GREY:GetRGB())
                self.iconBorder:SetVertexColor(data.tinted:GetRGB())
            else
                self.icon:SetDesaturated(false)
                self.icon:SetVertexColor(S.Color.WHITE:GetRGB())
                if self.mouseEntered then
                    self.iconBorder:SetVertexColor(data.color2:GetRGB())
                else
                    self.iconBorder:SetVertexColor(data.color1:GetRGB())
                end
            end
        end,
        ["UpdateIcon"] = function(self, iconSize, borderThickness, iconShape, iconBorders)
            self.icon:SetSize(iconSize, iconSize)
            self.iconMask:SetSize(iconSize, iconSize)
            if iconShape == 0 then
                self.icon:RemoveMaskTexture(self.iconMask)
                self.iconBorder:SetTexture("Interface\\Addons\\Sorted\\Textures\\Item_Glow")
            elseif iconShape == 1 then
                self.icon:AddMaskTexture(self.iconMask)
                self.iconBorder:SetTexture("Interface\\Addons\\Sorted\\Textures\\Circle_Mask")
            end
            self.iconBorder:SetSize(iconSize + borderThickness, iconSize + borderThickness)
            self.iconBorder:SetShown(iconBorders == 1)
        end
    },
    ["NAME"] = {
        ["name"] = S.Localize("COLUMN_NAME"),
        ["GetWidth"] = function() return nil end,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_RARITY_SHORT"),
                ["func"] = function(asc, slot1, slot2) 
                    return S.Sort.ByKey(not asc, slot1, slot2, "quality", DefaultSort)
                end
            },
            {
                ["title"] = S.Localize("COLUMN_NAME_SHORT"),
                ["func"] = function(asc, slot1, slot2) 
                    return S.Sort.ByKey(asc, slot1, slot2, "name", DefaultSort)
                end,
                ["inverse"] = true
            }
        },
        ["CreateElement"] = function(self)
            self.nameString = self:CreateFontString(nil, "OVERLAY", "SortedFont")
            self.nameString:SetPoint("TOP", 0, -2)
            self.nameString:SetPoint("BOTTOM", 0, 2)
            self.nameString:SetPoint("LEFT", 2, 0)
            self.nameString:SetPoint("RIGHT", -2, 0)
            self.nameString:SetJustifyH("LEFT")
            self.nameString:SetJustifyV("MIDDLE")
        end,
        ["UpdateElement"] = function(self, data)
            -- Battle pets
            if self.cageName then
                data.name = "Caged ".. self.cageName
                self.nameString:SetText(data.name)

            -- Everything else
            else
                self.nameString:SetText(data.name)
            end
            -- Color
            if data.filtered then
                self.nameString:SetTextColor(data.tinted:GetRGB())
            else
                if self.mouseEntered then
                    self.nameString:SetTextColor(data.color2:GetRGB())
                else
                    self.nameString:SetTextColor(data.color1:GetRGB())
                end
            end
        end
    },
    ["REQUIRED_LEVEL"] = {
        ["name"] = S.Localize("COLUMN_REQUIRED_LEVEL"),
        ["width"] = 38,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_REQUIRED_LEVEL_SHORT"),
                ["func"] = function(asc, slot1, slot2)
                    -- Items without a level requirement can be either 1 or 0, however they are functionally the same
                    -- This sorting treats them as identical
                    local value1 = slot1.minLevel
                    local value2 = slot2.minLevel
                    if value1 < 1 then
                        value1 = 1
                    end
                    if value2 < 1 then
                        value2 = 1
                    end
                    return S.Sort.ByValue(not asc, value1, value2, slot1, slot2, DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.reqLvlString = f:CreateFontString(nil, "OVERLAY", "SortedFont")
            f.reqLvlString:SetAllPoints()
        end,
        ["UpdateElement"] = function(self, data)
            if data.minLevel > 1 then
                self.reqLvlString:SetText(data.minLevel)

                if data.minLevel > UnitLevel("player") then
                    if data.filtered then
                        self.reqLvlString:SetTextColor(S.Color.GREY:GetRGB())
                    else
                        self.reqLvlString:SetTextColor(S.Color.RED:GetRGB())
                    end
                    self.reqLvlString:SetAlpha(0.8)

                elseif (data.minLevel > 1) then
                    local alpha = data.minLevel / UnitLevel("player")
                    alpha = alpha * alpha * 0.65 + 0.35
                    if alpha > 1 then alpha = 1 end
                    if data.filtered then
                        self.reqLvlString:SetTextColor(S.Color.GREY:GetRGB())
                    else
                        self.reqLvlString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
                    end
                    self.reqLvlString:SetAlpha(alpha)
                end
            else
                self.reqLvlString:SetText("")
            end
        end
    },
    ["ITEM_LEVEL"] = {
        ["name"] = S.Localize("COLUMN_ITEM_LEVEL"),
        ["width"] = 38,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_ITEM_LEVEL_SHORT"),
                ["func"] = function(asc, slot1, slot2) 
                    return S.Sort.ByKey(not asc, slot1, slot2, "effectiveILvl", DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.lvlString = f:CreateFontString(nil, "OVERLAY", "SortedFont")
            f.lvlString:SetAllPoints()
        end,
        ["UpdateElement"] = function(self, data)
                -- Battle pets
            if self.cageName then
                self.lvlString:SetText(self.petLevel)
                data.effectiveILvl = tonumber(self.petLevel)
                if data.filtered then
                    self.lvlString:SetTextColor(S.Color.GREY:GetRGB())
                else
                    self.lvlString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
                end
                self.lvlString:SetAlpha((self.petLevel / 25.0 * 0.65) + 0.35)

            -- Everything else
            else
                if S.IsPlayingCharacterSelected() and data.effectiveILvl and data.effectiveILvl > S.maxILvl then 
                    S.maxILvl = data.effectiveILvl 
                end
                if (data.effectiveILvl and data.effectiveILvl > 1) then
                    self.lvlString:SetText(data.effectiveILvl)

                    local alpha = data.effectiveILvl / S.maxILvl
                    alpha = alpha * alpha * 0.65 + 0.35
                    if alpha > 1 then alpha = 1 end
                    if data.filtered then
                        self.lvlString:SetTextColor(S.Color.GREY:GetRGB())
                    else
                        self.lvlString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
                    end
                    self.lvlString:SetAlpha(alpha)

                else
                    self.lvlString:SetText("")
                    data.effectiveILvl = 0
                end
            end
        end
    },
    ["AGE"] = {
        ["name"] = S.Localize("COLUMN_TIME_ADDED"),
        ["width"] = 58,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_TIME_ADDED_SHORT"),
                ["func"] = function(asc, slot1, slot2)
                    local age1, age2 = S.Data.GetItemAge(slot1), S.Data.GetItemAge(slot2)
                    return S.Sort.ByValue(asc, age1, age2, slot1, slot2, DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.ageString = f:CreateFontString(nil, "OVERLAY", "SortedFont")
            f.ageString:SetPoint("TOPLEFT", 2, -4)
            f.ageString:SetPoint("BOTTOMRIGHT", -2, 4)
            f.ageString:SetJustifyH("CENTER")
            f.ageString:SetJustifyV("MIDDLE")
            f.ageString:SetTextColor(1, 0.92, 0.8)
            f:SetScript("OnUpdate", function(self)
                local itemData = self.parent:GetData()
                if itemData then
                    local age = S.Data.GetItemAge(itemData)
                    if age then
                        self.ageString:SetText(S.Utils.FormatTime(age))
                        local alpha = 1 / (1 + age / 10000)
                        alpha = 0.4 + alpha * 0.6
                        self.ageString:SetAlpha(alpha)
                        return
                    end
                end
                self.ageString:SetText("")
            end)
        end,
        ["UpdateElement"] = function(self, data)
            if data.filtered then
                self.ageString:SetTextColor(S.Color.GREY:GetRGB())
            else
                self.ageString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
            end
        end
    },
    ["TYPE"] = {
        ["name"] = S.Localize("COLUMN_TYPE_SHORT"),
        ["width"] = 80,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_TYPE_SHORT"),
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByValue(asc, GetItemClassInfo(slot1.classID), GetItemClassInfo(slot2.classID), slot1, slot2, DefaultSort)
                end,
                ["inverse"] = true
            }
        },
        ["CreateElement"] = function(f)
            f.typeString = f:CreateFontString(nil, "OVERLAY", "SortedFont")
            f.typeString:SetPoint("TOPLEFT", 2, -4)
            f.typeString:SetPoint("BOTTOMRIGHT", -2, 4)
            f.typeString:SetJustifyH("LEFT")
            f.typeString:SetJustifyV("MIDDLE")
        end,
        ["UpdateElement"] = function(self, data)
            self.typeString:SetText(GetItemClassInfo(data.classID))

            if data.filtered then
                self.typeString:SetTextColor(S.Color.GREY:GetRGB())
            else
                self.typeString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
            end
        end
    },
    ["SUBTYPE"] = {
        ["name"] = S.Localize("FILTER_SUBTYPE"),
        ["width"] = 80,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("FILTER_SUBTYPE"),
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByValue(asc, GetItemSubClassInfo(slot1.classID, slot1.subClassID), GetItemSubClassInfo(slot2.classID, slot2.subClassID), slot1, slot2, DefaultSort)
                end,
                ["inverse"] = true
            }
        },
        ["CreateElement"] = function(f)
            f.subtypeString = f:CreateFontString(nil, "OVERLAY", "SortedFont")
            f.subtypeString:SetPoint("TOPLEFT", 2, -4)
            f.subtypeString:SetPoint("BOTTOMRIGHT", -2, 4)
            f.subtypeString:SetJustifyH("LEFT")
            f.subtypeString:SetJustifyV("MIDDLE")
        end,
        ["UpdateElement"] = function(self, data)
            self.subtypeString:SetText(GetItemSubClassInfo(data.classID, data.subClassID))
            
            if data.filtered then
                self.subtypeString:SetTextColor(S.Color.GREY:GetRGB())
            else
                self.subtypeString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
            end
        end
    },
    ["TYPE_ICON"] = {
        ["name"] = S.Localize("COLUMN_TYPE").." ("..S.Localize("COLUMN_ICON")..")",
        ["width"] = 24,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = "|TInterface\\Addons\\Sorted\\Textures\\Type-Icon-Heading:18:18:0:0:64:64:0:48:0:48|t",
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByValue(asc, GetItemClassInfo(slot1.classID), GetItemClassInfo(slot2.classID), slot1, slot2, DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.typeIcon = f:CreateTexture()
            f.typeIcon:SetTexture("Interface\\Addons\\Sorted\\Textures\\Type-Icons")
            f.typeIcon:SetPoint("CENTER")
        end,
        ["UpdateElement"] = function(self, data)
            local x = (data.classID % 8) / 8
            local y = math.floor(data.classID / 8) / 8
            self.typeIcon:SetTexCoord(x, x + 0.125, y, y + 0.125)

            if data.filtered then
                self.typeIcon:SetDesaturated(true)
                self.typeIcon:SetVertexColor(S.Color.LIGHT_GREY:GetRGB())
            else
                self.typeIcon:SetDesaturated(false)
                self.typeIcon:SetVertexColor(S.Color.WHITE:GetRGB())
            end
        end,
        ["UpdateIcon"] = function(self, iconSize)
            self.typeIcon:SetSize(iconSize, iconSize)
        end
    },
    ["EXPANSION"] = {
        ["name"] = S.Localize("COLUMN_EXPANSION"),
        ["width"] = 48,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_EXPANSION_SHORT"),
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByKey(not asc, slot1, slot2, "expacID", DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.expacIcon = f:CreateTexture()
            f.expacIcon:SetTexture("Interface\\Addons\\Sorted\\Textures\\Expac-Icons")
            f.expacIcon:SetPoint("CENTER")
        end,
        ["UpdateElement"] = function(self, data)
            local expacID = data.expacID
            if not expacID then
                expacID = 0
            end
            x = (expacID % 4) / 4
            y = math.floor(expacID / 4) / 8
            self.expacIcon:SetTexCoord(x, x + 0.25, y, y + 0.125)

            if data.filtered then
                self.expacIcon:SetDesaturated(true)
                self.expacIcon:SetVertexColor(S.Color.LIGHT_GREY:GetRGB())
            else
                self.expacIcon:SetDesaturated(false)
                self.expacIcon:SetVertexColor(S.Color.WHITE:GetRGB())
            end
        end,
        ["UpdateIcon"] = function(self, iconSize)
            self.expacIcon:SetSize(iconSize * 2.4, iconSize * 1.2)
        end
    },
    ["BINDING"] = {
        ["name"] = S.Localize("COLUMN_BINDING"),
        ["width"] = 24,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = "|TInterface\\Addons\\Sorted\\Textures\\Bind-Icons:0:0:0:0:128:64:38:56:7:28|t", --S.Localize("COLUMN_BINDING_SHORT"),
                ["func"] = function(asc, slot1, slot2)
                    -- Sorts by bindType, with unbound items first
                    local value1 = slot1.bindType * 2
                    local value2 = slot2.bindType * 2
                    if value1 == 0 then
                        value1 = 100
                    end
                    if value2 == 0 then
                        value2 = 100
                    end
                    if slot1.bound then 
                        value1 = value1 - 1
                    end
                    if slot2.bound then 
                        value2 = value2 - 1
                    end
                    return S.Sort.ByValue(not asc, value1, value2, slot1, slot2, DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.bindIcon = f:CreateTexture()
            f.bindIcon:SetTexture("Interface\\Addons\\Sorted\\Textures\\Bind-Icons")
            f.bindIcon:SetPoint("CENTER")
        end,
        ["UpdateElement"] = function(self, data)
            if data.bindType > 0 then
                if data.bindType == 4 then data.bindType = 1 end -- Treat quest items as BoP
                local x = (data.bindType - 1) / 4
                local y
                if data.bound then y = 0 else y = 0.5 end
                self.bindIcon:SetTexCoord(x, x + 0.25, y, y + 0.5)

                if data.filtered then
                    self.bindIcon:SetDesaturated(true)
                    self.bindIcon:SetVertexColor(S.Color.LIGHT_GREY:GetRGB())
                else
                    self.bindIcon:SetDesaturated(false)
                    self.bindIcon:SetVertexColor(S.Color.WHITE:GetRGB())
                end
            else
                self.bindIcon:SetTexCoord(1, 1, 1, 1)
            end
        end,
        ["UpdateIcon"] = function(self, iconSize, borderThickness, iconShape)
            self.bindIcon:SetSize(iconSize * 1.1, iconSize * 1.1)
        end
    },
    ["VALUE"] = {
        ["name"] = S.Localize("COLUMN_SELL_PRICE"),
        ["width"] = 48,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_SELL_PRICE_SHORT"),
                ["func"] = function(asc, slot1, slot2) 
                    local value1 = slot1.value * slot1.count
                    local value2 = slot2.value * slot2.count
                    if slot1.hasNoValue then value1 = 0 end
                    if slot2.hasNoValue then value2 = 0 end
                    return S.Sort.ByValue(not asc, value1, value2, slot1, slot2, DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.valueIcon = f:CreateTexture()
            f.valueIcon:SetPoint("RIGHT", -2, 0)
            f.valueString = f:CreateFontString(nil, "OVERLAY", "SortedFont")
            f.valueString:SetPoint("RIGHT",  f.valueIcon, "LEFT", -2, 0)
            f.valueString:SetPoint("LEFT", 2, 0)
            f.valueString:SetHeight(1)
            f.valueString:SetJustifyH("RIGHT")
        end,
        ["UpdateElement"] = function(self, data)
            if (data.value > 0 and not data.hasNoValue) then
                self.valueIcon:SetTexture(S.Utils.GetValueIcon(data.value * data.combinedCount))
                self.valueString:SetText(S.Utils.FormatValueStringNoIcon(data.value * data.combinedCount))

                if data.filtered then
                    self.valueString:SetTextColor(S.Color.GREY:GetRGB())
                    self.valueIcon:SetDesaturated(true)
                    self.valueIcon:SetVertexColor(S.Color.LIGHT_GREY:GetRGB())
                else
                    local color = S.Utils.GetValueColor(data.value * data.combinedCount)
                    self.valueString:SetTextColor(color:GetRGB())
                    self.valueIcon:SetDesaturated(false)
                    self.valueIcon:SetVertexColor(S.Color.WHITE:GetRGB())
                end
            else
                self.valueString:SetText("")
                self.valueIcon:SetTexture("")
            end
        end
    },
    ["TRASH"] = {
        ["name"] = S.Localize("COLUMN_TRASH"),
        ["width"] = 28,
        ["align"] = "CENTER",
        ["sortMethods"] = {
            {
                ["title"] = "|TInterface\\Addons\\Sorted\\Textures\\Trash-Icons:0:0:0:0:128:64:38:58:5:25|t", --S.Localize("COLUMN_BINDING_SHORT"),
                ["func"] = function(asc, slot1, slot2)
                    local trash1, trash2 = S.Data.GetTrash(slot1), S.Data.GetTrash(slot2)
                    if slot1.hasNoValue then
                        trash1 = 3
                    elseif trash1 == 0 then
                        trash1 = 1
                    end
                    if slot2.hasNoValue then
                        trash2 = 3
                    elseif trash2 == 0 then
                        trash2 = 1
                    end
                    return S.Sort.ByValue(asc, trash1, trash2, slot1, slot2, DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.trashButton = CreateFrame("BUTTON", nil, f)
            f.trashButton:SetPoint("CENTER")
            f.trashButton:SetSize(24, 24)
            f.trashButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Trash-Icons")
            f.trashButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Trash-Icons")
            f.trashButton.parent = f.parent
            f.trashButton:SetScript("OnClick", function(self)
                S.Data.ToggleTrash(self.parent:GetData())
                S.Utils.TriggerEvent("FavoriteChanged")
            end)
        end,
        ["UpdateElement"] = function(self, data)
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

            if data.filtered then
                self.trashButton:GetNormalTexture():SetDesaturated(true)
                self.trashButton:GetNormalTexture():SetVertexColor(S.Color.LIGHT_GREY:GetRGB())
            else
                self.trashButton:GetNormalTexture():SetDesaturated(false)
                self.trashButton:GetNormalTexture():SetVertexColor(S.Color.WHITE:GetRGB())
            end
        end,
        ["UpdateIcon"] = function(self, iconSize, borderThickness, iconShape)
            self.trashButton:SetSize(iconSize * 1.25, iconSize * 1.25)
        end
    }
}



local LIS = LibStub("LibItemSearch-1.2")
-- Item search is slow, only perform it occasionally while player is typing
local lastTimeSearched = GetTime()
local searchScheduled = false
local i = 1
local function DelayedFilter(self)
    lastTimeSearched = GetTime()
    local searchText = S.primaryFrame.searchBox:GetText()
    searchScheduled = false
    for _, entry in ipairs(self.entryData) do
        entry.filtered = false
        if #searchText > 0 then
            if not LIS:Matches(entry.data.link, searchText) then
                entry.filtered = true
            end
        end
        if not entry.filtered then
            entry.filtered = S.FilterItem(entry.data)
        end
    end
end
function S.ListItemsMixin:FilterEntries()
    local searchText = S.primaryFrame.searchBox:GetText()
    if #searchText > 0 and lastTimeSearched > GetTime() - 0.3 then
        if not searchScheduled then
            searchScheduled = true
            C_Timer.After(0.5, function() DelayedFilter(self) end)
        end
    else
        DelayedFilter(self)
        self:ScheduleUpdate(false, true)
    end
end


local function HasData(entry)
    local data = S.Data.GetItem(entry.bag, entry.slot, S.GetSelectedCharacter())
    if data.link then return true end
    return false
end
function S.ListItemsMixin:EntryHasData(entry)
    return HasData(entry)
end
function S.ListItemsMixin:GetDataForEntry(entry)
    return S.Data.GetItem(entry.bag, entry.slot, S.GetSelectedCharacter())
end

function S.ListItemsMixin:EntryExists(entryDataIndex)
    if self.entryData[entryDataIndex] then
        local entryData = self.entryData[entryDataIndex]
        local itemData = S.Data.GetItem(entryData.bag, entryData.slot, S.GetSelectedCharacter())
        if itemData.link then
            return true
        end
    end
    return false
end

function S.ListItemsMixin:GetEntryFavorited(entryData)
    return S.Data.GetFavorited(entryData)
end

function S.ListItemsMixin:GetEntryNew(entryData)
    return C_NewItems.IsNewItem(entryData.bag, entryData.slot)
end


local freeSpaceColor, freeSpaceColorHighlight = S.Color.YELLOWISH_TEXT, S.Color.WHITE
local freeSpaceLowColor, freeSpaceLowColorHighlight = S.Color.YELLOW, S.Color.YELLOW_HIGHLIGHT
local freeSpaceZeroColor, freeSpaceZeroColorHighlight = S.Color.RED, S.Color.RED_HIGHLIGHT
local freeSpaceMaxColor, freeSpaceMaxColorHighlight = CreateColor(0.96, 0.9, 0.82, 0.6), CreateColor(0.96, 0.9, 0.82, 0.9)

local function FreeSpaceTooltip(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:ClearLines()

    local containers
    if self.type == "BAGS" then
        GameTooltip:AddLine(S.Localize("TOOLTIP_TITLE_BAGS"), 1, 1, 1, 1)
        containers = S.Utils.ContainersOfType("BAGS")
    elseif self.type == "BANK" then
        GameTooltip:AddLine(S.Localize("TOOLTIP_TITLE_BANK"), 1, 1, 1, 1)
        containers = S.Utils.ContainersOfType("BANK")
    elseif self.type == "REAGENT" then
        GameTooltip:AddLine(S.Localize("TOOLTIP_TITLE_REAGENTS"), 1, 1, 1, 1)
        containers = S.Utils.ContainersOfType("REAGENT")
    elseif self.type == "KEYRING" then
        GameTooltip:AddLine(KEYRING, 1, 1, 1, 1)
        containers = S.Utils.ContainersOfType("KEYRING")
    end
    GameTooltip:AddLine(" ")

    for i,container in pairs(containers) do
        local itemName, _, itemRarity

        if container ~= BANK_CONTAINER and container ~= BACKPACK_CONTAINER and container ~= REAGENTBANK_CONTAINER and container ~= KEYRING_CONTAINER then
            local invID = ContainerIDToInventoryID(container)
            local itemLink = GetInventoryItemLink("player", invID)
            if itemLink then
                itemName, _, itemRarity = GetItemInfo(itemLink)
            end
        else
            if self.type == "BAGS" then
                itemName, itemRarity = BACKPACK_TOOLTIP, 1
            elseif self.type == "BANK" then
                itemName, itemRarity = BANK, 1
            elseif self.type == "REAGENT" then
                itemName, itemRarity = REAGENT_BANK, 1
            elseif self.type == "KEYRING" then
                itemName, itemRarity = KEYRING, 1
            end
        end

        if itemName then
            local r,g,b = S.Utils.GetItemQualityColor(itemRarity)
            local r2, g2, b2 = 1, 1, 1
            if GetContainerNumFreeSlots(container) == 0 then
                r2, g2, b2 = 1, 0.2, 0.2
            elseif GetContainerNumSlots(container) * 0.1 >= GetContainerNumFreeSlots(container) then
                r2, g2, b2 = 1, 0.82, 0
            end
            GameTooltip:AddDoubleLine(itemName, (GetContainerNumSlots(container) - GetContainerNumFreeSlots(container)).."|cFFD1C9BF/"..GetContainerNumSlots(container), r, g, b, r2, g2, b2)
        end
    end

    if S.WoWVersion() >= 7 then
        GameTooltip:AddLine(" ")
        if self.type == "BAGS" then
            GameTooltip:AddLine(S.Localize("TOOLTIP_CLEANUP_BAGS"))
        elseif self.type == "BANK" then
            GameTooltip:AddLine(S.Localize("TOOLTIP_CLEANUP_BANK"))
        elseif self.type == "REAGENT" then
            GameTooltip:AddLine(S.Localize("TOOLTIP_CLEANUP_REAGENTS"))
        end
    end

    GameTooltip:Show()
end
local function FreeSpaceOnEnter(self)
    if self.numFreeSlots == 0 then
        self.text:SetTextColor(freeSpaceZeroColorHighlight:GetRGBA())
    elseif self.numFreeSlots <= self.numSlots * 0.05 then
        self.text:SetTextColor(freeSpaceLowColorHighlight:GetRGBA())
    else
        self.text:SetTextColor(freeSpaceColorHighlight:GetRGBA())
    end
    self.maxText:SetTextColor(freeSpaceMaxColorHighlight:GetRGBA())

    S.Tooltip.Schedule(function() FreeSpaceTooltip(self) end)
end
local function FreeSpaceOnLeave(self)
    if self.numFreeSlots == 0 then
        self.text:SetTextColor(freeSpaceZeroColor:GetRGBA())
    elseif self.numFreeSlots <= self.numSlots * 0.05 then
        self.text:SetTextColor(freeSpaceLowColor:GetRGBA())
    else
        self.text:SetTextColor(freeSpaceColor:GetRGBA())
    end
    self.maxText:SetTextColor(freeSpaceMaxColor:GetRGBA())

    S.Tooltip.Cancel()
end
local function FreeSpaceOnClick(self)
    if self.type == "BAGS" then
        SortBags()
    elseif self.type == "BANK" then
        SortBankBags()
    elseif self.type == "REAGENT" then
        SortReagentBankBags()
    end
end

function S.ListItemsMixin:SetMinimised(minimised)
    self.freeSpace:SetShown(not minimised)
    for k,v in pairs(self.containerButtons) do
        v:SetShown(not minimised)
    end
    if minimised then
        self:SetPoint("BOTTOMRIGHT")
    else
        self:SetPoint("BOTTOMRIGHT", 0, 32)
    end
end

function S.ListItemsMixin:IsAvailable()
    if not S.IsPlayingCharacterSelected() then
        return false
    end
    if self.type == "BAGS" or self.type == "KEYRING" then
        return true
    elseif self.type == "BANK" or self.type == "REAGENT" then
        return S.IsBankOpened()
    end
end

-- Replaces the OnUpdate of List. Adds filtering, and updating of the bag slot buttons
-- Only update when some time has passed since the last update
-- This variable is shared by all item lists, so they can't update on the same frame which distributes the lag
local lastUpdateTime = 0
local function OnUpdate3(self)
    if self.updateScheduled and GetTime() > lastUpdateTime + 0.05 then
        if self.resizeScheduled then
            self:OnResize()
            self:UpdateEntryButtonIcons()
        end
        self:UpdateColumnsSortArrows()
        self:UpdateColumns()
        if self.sortingScheduled then
            self:UpdateDisplayedEntryData()
        end
        self:UpdateEntryButtons()
        self:UpdateScrollBarMax()
        self:UpdateContainerButtons()

        self.updateScheduled = false
        self.resizeScheduled = false
        self.sortingScheduled = false
        
        lastUpdateTime = GetTime()
    end
end
-- The OnUpdate function when the "Place item in here" overlay is showing
local function OnUpdate2(self)
    OnUpdate3(self)
    local infoType = GetCursorInfo()
    if not self:IsMouseOver() or not (infoType == "item") then
        self.placeItem:Hide()
        self:SetScript("OnUpdate", self.OnUpdate)
    end
end
local typeToStringTable = {
    ["BAGS"] = S.Localize("BAGS"),
    ["BANK"] = S.Localize("BANK"),
    ["REAGENT"] = S.Localize("REAGENTS"),
    ["KEYRING"] = KEYRING
}
local function TypeToString(type)
    return typeToStringTable[type]
end
-- The OnUpdate function when the "Place item in here" overlay isn't showing
-- Checks if the mouse is over and whether the overlay should be shown
local function OnUpdate(self)
    OnUpdate3(self)
    if self:IsAvailable() and self:IsMouseOver() then
        local infoType, itemID, itemLink = GetCursorInfo()
        if infoType == "item" then
            self.placeItem:Show()
            self.placeItem.text:SetText(string.format(S.Localize("BUTTON_PLACE_ITEM"), itemLink, TypeToString(self.type)))
            self:SetScript("OnUpdate", self.OnUpdate2)
        end
    end
end

function S.ListItemsMixin:UpdateEntryButtonContainerHighlights()
    for i = 1,self:GetNumVisibleEntries() do
        local v = self.entryButtons[i]
        if v:IsShown() then
            if v.bag == self.mouseIsOverContainer then
                v.containerHighlight:Show()
            else
                v.containerHighlight:Hide()
            end
        end
    end
end

function S.ListItemsMixin:AddContainerButton(containerID, gray)
    local parent = CreateFrame("FRAME", nil, self)
    local b = S.FrameTools.CreateCircleButton("Button", parent, not gray, nil, false)
    b.containerID = containerID
    b.inventoryID = ContainerIDToInventoryID(containerID)
    b:SetID(b.inventoryID)

    b:SetFrameLevel(parent:GetFrameLevel() + 1)
    b:SetPoint("LEFT", self.freeSpace, "RIGHT", 32 * #self.containerButtons, 0)

    b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    b:RegisterForDrag("LeftButton")
    b:SetScript("OnClick", function(self, button, down)
        if button == "LeftButton" then
            PickupInventoryItem(self.inventoryID)
        else
            S.Utils.EmptyBag(containerID)
        end
    end)
    b:SetScript("OnDragStart", function(self)
        PickupInventoryItem(self.inventoryID)
    end)
    b.UpdateTooltip = function(self)
        if S.IsPlayingCharacterSelected() and GetInventoryItemID("PLAYER", self.inventoryID) then
            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            ContainerFrameItemButton_CalculateItemTooltipAnchors(self, GameTooltip)
            GameTooltip:SetInventoryItem("player", self.inventoryID)
            GameTooltip:AddLine(S.Localize("TOOLTIP_EMPTY_BAG"))
            GameTooltip:Show()
        end
    end
    
    b:SetScript("OnEnter", function(self)
        if self.list:IsAvailable() then
            self:UpdateTooltip()
        end
        self.list.mouseIsOverContainer = self.containerID
        self.list:UpdateEntryButtonContainerHighlights()
    end)
    b:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        self.list.mouseIsOverContainer = nil
        self.list:UpdateEntryButtonContainerHighlights()
    end)
    b:Show()
    b.list = self
    self.containerButtons[#self.containerButtons + 1] = b
end
local function UpdateContainerButtons(self)
    for k,v in pairs(self.containerButtons) do
        local itemData = S.Data.GetInventoryItem(v.inventoryID)
        if itemData then
            v.icon:SetTexture(itemData.texture)
        end
    end
end
local function UpdateContainerButtonsBank(self)
    local numSlots, full = GetNumBankSlots()
    if not S.IsPlayingCharacterSelected() then
        full = true
        numSlots = 10
    end
    if not full and S.IsBankOpened() then
        self.BuyBankSlotButton:Show()
        self.BuyBankSlotButton:SetPoint("LEFT", self.freeSpace, "RIGHT", numSlots * 32, 0)
        self.BuyBankSlotButton.text:SetText(S.Utils.FormatValueString(GetBankSlotCost(numSlots)))
    else
        self.BuyBankSlotButton:Hide()
    end
    for i,v in ipairs(self.containerButtons) do
        if i > numSlots then
            v:Hide()
        else
            local itemData = S.Data.GetInventoryItem(v.inventoryID)
            if itemData then
                v.icon:SetTexture(itemData.texture)
            end
            v:SetShown(not S.primaryFrame:GetMinimised())
        end
    end
end

local function UpdateReagentWarningMessage(self)
    local data = S.GetData()
    if data.reagentNotUnlocked then
        if S.IsPlayingCharacterSelected() then
            if S.IsBankOpened() then
                self.reagentWarningMessage:Hide()
                self.reagentPurchaseButton:Show()
            else
                self.reagentWarningMessage:SetText(S.Localize("WARNING_REAGENTBANK_NOT_PURCHASED"))
                self.reagentWarningMessage:Show()
                self.reagentPurchaseButton:Hide()
            end
        else
            self.reagentWarningMessage:SetText(string.format(S.Localize("WARNING_REAGENTBANK_NOT_PURCHASED_OTHER"), data.name))
            self.reagentWarningMessage:Show()
            self.reagentPurchaseButton:Hide()
        end
    else
        self.reagentWarningMessage:Hide()
        self.reagentPurchaseButton:Hide()
    end
end

local function UpdateBankWarningMessage(self)
    local data = S.GetData()
    if data.bankNotCached then
        if S.IsPlayingCharacterSelected() then
            self.bankWarningMessage:SetText(S.Localize("WARNING_BANK_NOT_CACHED"))
        else
            self.bankWarningMessage:SetText(string.format(S.Localize("WARNING_BANK_NOT_CACHED_OTHER"), data.name))
        end
        self.bankWarningMessage:Show()
    else
        self.bankWarningMessage:Hide()
    end
end

function S.ListItemsMixin:UpdateEntryButtons()
    self:UpdateEntryButtonsSuper()
    self:UpdateEntryButtonContainerHighlights()
end

function S.CreateItemList(parent, type, itemButtonTemplate)
    local list =  S.CreateList(parent, S.CreateItemEntry, S.ItemColumns, "itemColumnSettings", true, S.ItemGroups, S.itemGroupingSettings)
    list:ClearAllPoints()
    list:SetPoint("TOPLEFT")
    list:SetPoint("BOTTOMRIGHT", 0, 32)

    list.canCombineStacks = true
    list.expandedCombinedItems = {}

    list.UpdateEntryButtonsSuper = list.UpdateEntryButtons
    Mixin(list, S.ListItemsMixin)
    
    list.itemButtonTemplate = itemButtonTemplate
    list.OnUpdate = OnUpdate
    list.OnUpdate2 = OnUpdate2
    list:SetScript("OnUpdate", OnUpdate)

    if type == "BANK" then
        list.UpdateContainerButtons = UpdateContainerButtonsBank
    else
        list.UpdateContainerButtons = UpdateContainerButtons
    end
    list.containerButtons = {}

    list.type = type
    list.containers = {}
    for k, bag in pairs(S.Utils.ContainersOfType(type)) do
        table.insert(list.containers, bag)
        for slot = 1, S.Utils.GetContainerMaxSlots(bag) do
            list:AddEntry({
                ["bag"] = bag, 
                ["slot"] = slot
            })
        end
    end

    if list.type == "BANK" then
        list.UpdateBankWarningMessage = UpdateBankWarningMessage
        list.bankWarningMessage = list:CreateFontString(nil, "OVERLAY", "SortedFont")
        list.bankWarningMessage:SetAllPoints()
        list.bankWarningMessage:SetTextScale(1.2)
        S.Utils.RunOnEvent(list, "CharacterSelected", list.UpdateBankWarningMessage)
        S.Utils.RunOnEvent(list, "BagsUpdated", list.UpdateBankWarningMessage)
    elseif list.type == "REAGENT" then
        list.UpdateReagentWarningMessage = UpdateReagentWarningMessage
        list.reagentWarningMessage = list:CreateFontString(nil, "OVERLAY", "SortedFont")
        list.reagentWarningMessage:SetAllPoints()
        list.reagentWarningMessage:SetTextScale(1.2)
        S.Utils.RunOnEvent(list, "CharacterSelected", list.UpdateReagentWarningMessage)
        S.Utils.RunOnEvent(list, "BagsUpdated", list.UpdateReagentWarningMessage)
        list.reagentPurchaseButton = CreateFrame("BUTTON", nil, list, "UIPanelButtonTemplate")
        local rpb = list.reagentPurchaseButton
        rpb:SetPoint("CENTER", -32, 0)
        rpb:SetSize(96, 32)
        rpb.text = rpb:CreateFontString(nil, "OVERLAY", "SortedFont")
        rpb:SetFontString(rpb.text)
        rpb:SetText(S.Localize("BUTTON_BUY_REAGENTS"))
        rpb.text1 = rpb:CreateFontString(nil, "OVERLAY", "SortedFont")
        rpb.text1:SetPoint("BOTTOM", rpb, "TOP", 0, 8)
        rpb.text1:SetTextScale(1.2)
        rpb.text1:SetPoint("LEFT", list)
        rpb.text1:SetPoint("RIGHT", list)
        rpb.text1:SetText(S.Localize("WARNING_BUY_REAGENTS"), 0, 10)
        rpb.text2 = rpb:CreateFontString(nil, "OVERLAY", "SortedFont")
        rpb.text2:SetPoint("LEFT", rpb, "RIGHT", 4, 0)
        rpb.text2:SetText(S.Utils.FormatValueString(GetReagentBankCost()))
        rpb.text2:SetTextScale(1.2)
        rpb:SetScript("OnClick", function(self) StaticPopup_Show("CONFIRM_BUY_REAGENTBANK_TAB") end)
        S.Utils.RunOnEvent(list, "ReagentsPurchased", list.UpdateReagentWarningMessage)

        list.depositReagentsButton = CreateFrame("BUTTON", nil, list)
        local drb = list.depositReagentsButton
        drb:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Deposit-Reagents-Button")
        drb:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Deposit-Reagents-Button")
        drb:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\Deposit-Reagents-Button")
        drb:GetNormalTexture():SetTexCoord(0, 0.25, 0.25, 0.75)
        drb:GetHighlightTexture():SetTexCoord(0, 0.25, 0.25, 0.75)
        drb:GetPushedTexture():SetTexCoord(0.25, 0.5, 0.25, 0.75)
        drb:SetPoint("BOTTOM", parent, 0, -2)
        drb:SetSize(64, 32)
        drb:SetScript("OnEnter", function(self)
            S.Tooltip.CreateLocalized(self, "LEFT", "BUTTON_DEPOSIT_REAGENTS")
        end)
        drb:SetScript("OnLeave", function(self)
            S.Tooltip.Cancel()
        end)
        drb:SetScript("OnClick", function(self)
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
            DepositReagentBank()
        end)
        drb:SetScript("OnMouseDown", function(self)
            drb:GetHighlightTexture():SetTexCoord(0.25, 0.5, 0.25, 0.75)
        end)
        drb:SetScript("OnMouseUp", function(self)
            drb:GetHighlightTexture():SetTexCoord(0, 0.25, 0.25, 0.75)
        end)
        function drb:Update()
            self:SetShown(S.IsBankOpened())
        end
        S.Utils.RunOnEvent(drb, "BankOpened", drb.Update)
        S.Utils.RunOnEvent(drb, "BankClosed", drb.Update)
        drb:Hide()
    end

    S.Utils.RunOnEvent(list, "BagsUpdated", function(self)
        if self:IsShown() then
            self:ScheduleUpdate(false, true)
        end
    end)
    S.Utils.RunOnEvent(list, "LayoutChanged", function(self)
        self:UpdateEntryButtonContainerHighlights()
    end)
    S.Utils.RunOnEvent(list, "SearchChanged", function(self)
        if self:IsShown() then
            self:ScheduleUpdate(false, true)
            --self.scrollBar:SetValue(0)
        end
    end)
    S.Utils.RunOnEvent(list, "CategorySelected", function(self)
        if self:IsShown() then
            self:ScheduleUpdate(false, true)
            self:ScrollToTop()
        end
    end)
    S.Utils.RunOnEvent(list, "CharacterSelected", function(self)
        self.columnSettings = S.Settings.Get(self.columnSettingsKey)
        if self:IsShown() then
            self:ScheduleUpdate(false, true)
            self:ScrollToTop()
        end
    end)
    S.Utils.RunOnEvent(list, "EquipmentSetSelected", function(self)
        if self:IsShown() then
            self:ScheduleUpdate(false, true)
            self:ScrollToTop()
        end
    end)
    S.Utils.RunOnEvent(list, "FavoriteChanged", function(self)
        if self:IsShown() then
            self:ScheduleUpdate(false, true)
        end
    end)

    -- Update everything on show, since updates are disabled when the frame is hidden for performance.
    -- Also update BankFrame.selectedTab so items will go into either the bank or reagent bank correctly
    list:SetScript("OnShow", function(self)
        self:OnShow()
        if self.type == "BANK" then
            BankFrame.selectedTab = 1
            self:UpdateBankWarningMessage()
        elseif self.type == "REAGENT" then
            BankFrame.selectedTab = 2
            self:UpdateReagentWarningMessage()
        end
    end)


    list.placeItem = CreateFrame("BUTTON", nil, list)
    list.placeItem:SetPoint("TOPLEFT", list.head, "BOTTOMLEFT")
    list.placeItem:SetPoint("BOTTOMRIGHT")
    list.placeItem:SetFrameLevel(list:GetFrameLevel() + 100)
    list.placeItem:Hide()
    list.placeItem.bg = list.placeItem:CreateTexture(nil, "BACKGROUND")
    list.placeItem.bg:SetAllPoints()
    list.placeItem.bg:SetColorTexture(0, 0, 0, 0.5)
    S.FrameTools.AddBorder(list.placeItem, "highlight", "Interface\\Addons\\Sorted\\Textures\\Place-Item-Highlight", 8, 2, true)
    for k,v in pairs(list.placeItem.highlight.parts) do
        v:SetBlendMode("ADD")
    end
    list.placeItem.text = list.placeItem:CreateFontString(nil, "OVERLAY", "SortedFont")
    list.placeItem.text:SetTextColor(S.Utils.GetButtonTextColor():GetRGB())
    list.placeItem.text:SetPoint("TOPLEFT", 16, -16)
    list.placeItem.text:SetPoint("BOTTOMRIGHT", -16, 16)
    list.placeItem.text:SetTextScale(1.5)
    list.placeItem.list = list
    list.placeItem:SetScript("OnMouseDown", function(self)
        S.Utils.PlaceCursorItemInContainerType(self.list.type)
    end)

    
    list.freeSpace = CreateFrame("BUTTON", nil, list)
    list.freeSpace:SetPoint("TOPLEFT", list, "BOTTOMLEFT")
    list.freeSpace:SetSize(70, 32)
    list.freeSpace.text = list.freeSpace:CreateFontString(nil, "OVERLAY", "SortedFont")
    list.freeSpace.text:SetPoint("RIGHT", list.freeSpace, "CENTER", 0, 0)
    list.freeSpace.text:SetTextColor(freeSpaceColor:GetRGBA())
    list.freeSpace.text:SetTextScale(1.2)
    list.freeSpace.maxText = list.freeSpace:CreateFontString(nil, "OVERLAY", "SortedFont")
    list.freeSpace.maxText:SetPoint("BOTTOMLEFT", list.freeSpace.text, "BOTTOMRIGHT", 2, 0)
    list.freeSpace.maxText:SetTextColor(freeSpaceMaxColor:GetRGBA())
    list.freeSpace.parent = list
    list.freeSpace.type = type
    function list.freeSpace:Update()
        local data = S.GetData()
        if data.containerNumSlots then
            self.numSlots, self.numFreeSlots = 0, 0
            for k, bag in pairs(self.parent.containers) do
                if data.containerNumSlots[bag] then
                    self.numSlots = self.numSlots + data.containerNumSlots[bag].numSlots
                    self.numFreeSlots = self.numFreeSlots + data.containerNumSlots[bag].numFreeSlots
                end
            end
            if self.numSlots == 0 or self.type == "REAGENT" and data.reagentNotUnlocked then
                self.text:Hide()
                self.maxText:Hide()
            else
                self.text:Show()
                self.maxText:Show()
                self.text:SetText(self.numSlots - self.numFreeSlots)
                if self.numFreeSlots == 0 then
                    self.text:SetTextColor(freeSpaceZeroColor:GetRGBA())
                elseif self.numFreeSlots <= self.numSlots * 0.05 then
                    self.text:SetTextColor(freeSpaceLowColor:GetRGBA())
                else
                    self.text:SetTextColor(freeSpaceColor:GetRGBA())
                end
                self.maxText:SetText(self.numSlots)
            end
        else
            self.text:Hide()
            self.maxText:Hide()
        end
    end
    S.Utils.RunOnEvent(list.freeSpace, "BagsUpdated", list.freeSpace.Update)
    S.Utils.RunOnEvent(list.freeSpace, "CharacterSelected", list.freeSpace.Update)
    list.freeSpace:SetScript("OnEnter", FreeSpaceOnEnter)
    list.freeSpace:SetScript("OnLeave", FreeSpaceOnLeave)
    list.freeSpace:SetScript("OnClick", FreeSpaceOnClick)


    if type == "BANK" then
        list.BuyBankSlotButton = CreateFrame("BUTTON", nil, list)
        local b = list.BuyBankSlotButton
        b:SetSize(28, 28)
        b:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\CommonButtonsDropdown")
        b:GetNormalTexture():SetTexCoord(0, 0.375, 0, 0.375)
        b:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Close-Button-Highlight")
        b:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\CommonButtonsDropdown")
        b:GetPushedTexture():SetTexCoord(0.375, 0.75, 0, 0.375)
        b.text = b:CreateFontString(nil, "OVERLAY", "SortedFont")
        b.text:SetPoint("LEFT", b, "RIGHT")
        b.text:SetTextColor(1, 0.92, 0.8)
        b:SetScript("OnClick", PurchaseSlot)
        list:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
        list:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
        list:HookScript("OnEvent", function(self, event)
            if event == "PLAYERBANKBAGSLOTS_CHANGED" or event == "PLAYERBANKSLOTS_CHANGED" then
                self:UpdateContainerButtons()
            end
        end)
        S.Utils.RunOnEvent(list, "BankOpened", list.UpdateContainerButtons)
        S.Utils.RunOnEvent(list, "BankClosed", list.UpdateContainerButtons)
        b:SetScript("OnEnter", function(self)
            S.Tooltip.CreateLocalized(self, "LEFT", "TOOLTIP_BUY_BANK_SLOT")
        end)
        b:SetScript("OnLeave", S.Tooltip.Cancel)
    end



    return list
end