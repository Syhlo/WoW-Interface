local _, S = ...
local pairs, ipairs, string, type, time = pairs, ipairs, string, type, time

-- Default currency sort
local function DefaultSort(entry1, entry2)
    return entry1.name < entry2.name
end


-- CURRENCY GROUPS
S.currencyGroupingSettings = {
    ["selectedGrouping"] = "CATEGORY",
    ["collapsedGroups"] = {}
}
S.CurrencyGroups = {
    ["CATEGORY"] = {
        ["name"] = S.Localize("GROUPING_CATEGORY"),
        ["func"] = function(currency)
            return currency.heading, currency.heading
        end
    },
    ["QUALITY"] = {
        ["name"] = S.Localize("FILTER_QUALITY"),
        ["func"] = function(currency)
            if currency.quality then
                return _G["ITEM_QUALITY"..currency.quality.."_DESC"], -currency.quality
            else
                return "None", 100
            end
        end
    },
    ["FAVORITES"] = {
        ["name"] = S.Localize("FILTER_MARKER_ICON"),
        ["func"] = function(currency)
            local markerIcon = S.Data.GetCurrencyFavorited(currency)
            if not markerIcon then
                markerIcon = 100
            end
            return S.Utils.FormatMarkerIcon(markerIcon), markerIcon
        end
    }
}


-- Currency Columns
local function GetColumnWidth(self, key)
    local settings = S.Settings.Get("currencyColumnSettings")
    if settings.widths and settings.widths[key] then
        return settings.widths[key]
    end
    return self.width
end
local function GetIconSize(self)
    return S.Settings.Get("iconSize") + 4
end
S.CurrencyColumns = {
    ["FAVORITES"] = {
        ["name"] = S.Localize("COLUMN_FAVORITES"),
        ["width"] = 24,
        ["GetWidth"] = GetColumnWidth,
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
        ["GetWidth"] = GetColumnWidth,
        ["align"] = "RIGHT",
        ["sortMethods"] = {
            {
                ["title"] = "#",
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByKey(not asc, slot1, slot2, "count", DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(f)
            f.quantityString = f:CreateFontString(nil, "OVERLAY", "SortedFont")
            f.quantityString:SetPoint("RIGHT", -2, 0)
            f.quantityString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
        end,
        ["UpdateElement"] = function(self, data)
            self.quantityString:SetText(S.Utils.FormatBigNumber(data.count))

            if data.filtered then
                self.quantityString:SetTextColor(S.Color.GREY:GetRGB())
            else
                if data.count == data.maxQuantity then
                    self.quantityString:SetTextColor(S.Color.RED:GetRGB())
                else
                    self.quantityString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
                end
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
            -- If is honor
            if ( S.WoWVersion() <= 3 and data.id == Constants.CurrencyConsts.CLASSIC_HONOR_CURRENCY_ID ) then
                self.icon:SetTexCoord( 0.03125, 0.59375, 0.03125, 0.59375 );
            else
                self.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
            end

            if self.mouseEntered then
                self.iconBorder:SetVertexColor(data.color2:GetRGB())
            else
                self.iconBorder:SetVertexColor(data.color1:GetRGB())
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
        ["GetWidth"] = function(self) return nil end,
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
            self.nameString:SetText(data.name)

            if self.mouseEntered then
                self.nameString:SetTextColor(data.color2:GetRGB())
            else
                self.nameString:SetTextColor(data.color1:GetRGB())
            end
        end
    },
    ["CATEGORY"] = {
        ["name"] = S.Localize("GROUPING_CATEGORY"),
        ["width"] = 120,
        ["GetWidth"] = GetColumnWidth,
        ["align"] = "LEFT",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("GROUPING_CATEGORY"),
                ["func"] = function(asc, slot1, slot2) 
                    return S.Sort.ByKey(asc, slot1, slot2, "heading", DefaultSort)
                end,
                ["inverse"] = true
            }
        },
        ["CreateElement"] = function(self)
            self.categoryString = self:CreateFontString(nil, "OVERLAY", "SortedFont")
            self.categoryString:SetPoint("TOPLEFT", 2, -4)
            self.categoryString:SetPoint("BOTTOMRIGHT", -2, 4)
            self.categoryString:SetJustifyH("LEFT")
            self.categoryString:SetJustifyV("MIDDLE")
            self.categoryString:SetTextColor(0.96, 0.9, 0.82, 1)
        end,
        ["UpdateElement"] = function(self, data)
            self.categoryString:SetText(data.heading)
        end
    },
    ["MAX-QUANTITY"] = {
        ["name"] = S.Localize("COLUMN_MAX_QUANTITY"),
        ["width"] = 42,
        ["GetWidth"] = GetColumnWidth,
        ["align"] = "LEFT",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_MAX_QUANTITY"),
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByKey(not asc, slot1, slot2, "maxQuantity", DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(self)
            self.maxQuantityString = self:CreateFontString(nil, "OVERLAY", "SortedFont")
            self.maxQuantityString:SetPoint("TOPLEFT", 2, -4)
            self.maxQuantityString:SetPoint("BOTTOMRIGHT", -2, 4)
            self.maxQuantityString:SetJustifyH("LEFT")
            self.maxQuantityString:SetJustifyV("MIDDLE")
            self.maxQuantityString:SetTextScale(0.9)
        end,
        ["UpdateElement"] = function(self, data)
            if data.maxQuantity > 0 then
                self.maxQuantityString:Show()
                self.maxQuantityString:SetText(S.Utils.FormatBigNumber(data.maxQuantity))
                if data.count == data.maxQuantity then
                    self.maxQuantityString:SetTextColor(S.Color.RED:GetRGB())
                    self.maxQuantityString:SetAlpha(0.7)
                else
                    self.maxQuantityString:SetTextColor(S.Color.YELLOWISH_TEXT:GetRGB())
                    self.maxQuantityString:SetAlpha(0.6)
                end
            else
                self.maxQuantityString:Hide()
            end
        end
    },
    ["WEEKLY-QUANTITY"] = {
        ["name"] = S.Localize("COLUMN_WEEKLY_QUANTITY"),
        ["width"] = 60,
        ["GetWidth"] = GetColumnWidth,
        ["align"] = "RIGHT",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_WEEKLY_QUANTITY_SHORT"),
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByKey(not asc, slot1, slot2, "quantityEarnedThisWeek", DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(self)
            self.weeklyQuantityString = self:CreateFontString(nil, "OVERLAY", "SortedFont")
            self.weeklyQuantityString:SetPoint("TOPLEFT", 2, -4)
            self.weeklyQuantityString:SetPoint("BOTTOMRIGHT", -2, 4)
            self.weeklyQuantityString:SetJustifyH("RIGHT")
            self.weeklyQuantityString:SetJustifyV("MIDDLE")
            self.weeklyQuantityString:SetTextColor(0.96, 0.9, 0.82, 1)
        end,
        ["UpdateElement"] = function(self, data)
            if data.canEarnPerWeek then
                if data.quantityEarnedThisWeek == data.maxWeeklyQuantity then
                    self.weeklyQuantityString:SetTextColor(1, 0.15, 0.17, 1)
                else
                    self.weeklyQuantityString:SetTextColor(0.96, 0.9, 0.82, 1)
                end
    
                self.weeklyQuantityString:Show()
                self.weeklyQuantityString:SetText(S.Utils.FormatBigNumber(data.quantityEarnedThisWeek))
            else
                self.weeklyQuantityString:Hide()
            end
        end
    },
    ["MAX-WEEKLY-QUANTITY"] = {
        ["name"] = S.Localize("COLUMN_MAX_WEEKLY_QUANTITY"),
        ["width"] = 60,
        ["GetWidth"] = GetColumnWidth,
        ["align"] = "LEFT",
        ["sortMethods"] = {
            {
                ["title"] = S.Localize("COLUMN_MAX_WEEKLY_QUANTITY_SHORT"),
                ["func"] = function(asc, slot1, slot2)
                    return S.Sort.ByKey(not asc, slot1, slot2, "maxWeeklyQuantity", DefaultSort)
                end
            }
        },
        ["CreateElement"] = function(self)
            self.maxWeeklyQuantityString = self:CreateFontString(nil, "OVERLAY", "SortedFont")
            self.maxWeeklyQuantityString:SetPoint("TOPLEFT", 2, -4)
            self.maxWeeklyQuantityString:SetPoint("BOTTOMRIGHT", -2, 4)
            self.maxWeeklyQuantityString:SetJustifyH("LEFT")
            self.maxWeeklyQuantityString:SetJustifyV("MIDDLE")
            self.maxWeeklyQuantityString:SetTextColor(0.96, 0.9, 0.82, 1)
            self.maxWeeklyQuantityString:SetTextScale(0.9)
        end,
        ["UpdateElement"] = function(self, data)
            if data.canEarnPerWeek then
                if data.quantityEarnedThisWeek == data.maxWeeklyQuantity then
                    self.maxWeeklyQuantityString:SetTextColor(1, 0.15, 0.17, 0.7)
                else
                    self.maxWeeklyQuantityString:SetTextColor(0.96, 0.9, 0.82, 0.6)
                end
    
                self.maxWeeklyQuantityString:Show()
                self.maxWeeklyQuantityString:SetText(S.Utils.FormatBigNumber(data.maxWeeklyQuantity))
            else
                self.maxWeeklyQuantityString:Hide()
            end
        end
    }
}


local function UpdateEntryDataTable(self)
    self.entryData = {}
    local data = S.GetData()
    if data.currencies then
        for k,v in pairs(data.currencies) do
            table.insert(self.entryData, {
                ["currencyID"] = k
            })
        end
    end
end

local function EntryHasData(self, entry)
    local data = self:GetDataForEntry(entry)
    return data and data.count > 0
end
local function GetDataForEntry(self, entry)
    local data = S.GetData()
    if data.currencies and entry then
        return data.currencies[entry.currencyID]
    end
end



local function GetEntryFavorited(self, entryData)
    return S.Data.GetCurrencyFavorited(entryData)
end



function S.CreateCurrencyList(parent)
    local self =  S.CreateList(parent, S.CreateCurrencyEntry, S.CurrencyColumns, "currencyColumnSettings", true, S.CurrencyGroups, S.currencyGroupingSettings)
    self.AddCurrencies = AddCurrencies
    self.EntryHasData = EntryHasData
    self.GetDataForEntry = GetDataForEntry
    self.UpdateEntryDataTable = UpdateEntryDataTable
    self.GetEntryFavorited = GetEntryFavorited
    
    S.Utils.RunOnEvent(self, "EnteredWorld", UpdateEntryDataTable)
    S.Utils.RunOnEvent(self, "CurrenciesUpdated", function(self)
        if self:IsShown() then
            self:UpdateEntryDataTable()
            self:ScheduleUpdate(false, true)
        end
    end)
    S.Utils.RunOnEvent(self, "CharacterSelected", function(self)
        self.columnSettings = S.Settings.Get(self.columnSettingsKey)
        if self:IsShown() then
            self:UpdateEntryDataTable()
            self:ScheduleUpdate(false, true)
        end
    end)

    -- Update everything on show, since updates are disabled when the frame is hidden for performance
    self:SetScript("OnShow", function(self)
        self:UpdateEntryDataTable()
        self:OnShow()
    end)

    return self
end