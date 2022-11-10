local _, S = ...
local pairs, ipairs, string, type, time = pairs, ipairs, string, type, time

S.CONTAINER_TYPES = {}
S.CONTAINER_TYPES.ALL = "ALL"
S.CONTAINER_TYPES.BAGS = "BAGS"
S.CONTAINER_TYPES.BANK = "BANK"
S.CONTAINER_TYPES.KEYRING = "KEYRING"
S.CONTAINER_TYPES.REAGENT = "REAGENT"


-- Use new APIs
local ContainerIDToInventoryID, GetContainerItemInfo, PickupContainerItem, GetContainerNumSlots, GetContainerNumFreeSlots = ContainerIDToInventoryID, GetContainerItemInfo, PickupContainerItem, GetContainerNumSlots, GetContainerNumFreeSlots
local UseContainerItem = UseContainerItem
if C_Container then
    if C_Container.ContainerIDToInventoryID then ContainerIDToInventoryID = C_Container.ContainerIDToInventoryID end
    if C_Container.GetContainerItemInfo then GetContainerItemInfo = C_Container.GetContainerItemInfo end
    if C_Container.PickupContainerItem then PickupContainerItem = C_Container.PickupContainerItem end
    if C_Container.GetContainerNumSlots then GetContainerNumSlots = C_Container.GetContainerNumSlots end
    if C_Container.GetContainerNumFreeSlots then GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots end
    if C_Container.UseContainerItem then UseContainerItem = C_Container.UseContainerItem end
end

S.Utils = {}

-- S.WoWVersion() returns the major WoW version number, Classic: 1, TBC: 2, WotlK: 3, etc...
local WoWMajorVersionNumber = tonumber(string.sub(GetBuildInfo(), 1, 2))
function S.WoWVersion()
    return WoWMajorVersionNumber
end

-- Returns the number of bags that can be equipped
function S.Utils.GetMaxNumBags()
    return NUM_BAG_SLOTS
    --[[if S.WoWVersion() < 10 then
        return 4
    else
        return 5
    end]]
end

-- Constant. Maximum number of categories the player can create
local NUM_MAX_CATEGORIES = 36
function S.Utils.GetMaxNumCategories()
    return NUM_MAX_CATEGORIES
end

-- Constant. Size of the largest bag in WoW
local MAX_BAG_SLOTS = 36
function S.Utils.MaxBagSlots()
    return MAX_BAG_SLOTS
end


-- Dealing with other bag frames
--[[local killableFramesParent = CreateFrame("FRAME")
killableFramesParent:Hide()
local function ClearPoints(frame)
    local children = { frame:GetChildren() }
    for k,v in pairs(children) do
        ClearPoints(v)
    end
    frame:SetParent(killableFramesParent)
    frame:ClearAllPoints()
end
local function KillFrame(frame)
    frame:SetScript("OnShow", nil)
    frame:SetScript("OnHide", nil)
    frame:SetScript("OnEnter", nil)
    frame:SetScript("OnLeave", nil)
    --frame:UnregisterAllEvents()
    ClearPoints(frame)
end

local framesToKill = {}
for i = 1, NUM_CONTAINER_FRAMES do
    framesToKill[#framesToKill + 1] = _G["ContainerFrame"..i]
end
framesToKill[#framesToKill + 1] = _G["BankFrame"]
if ContainerFrameCombinedBags then
    framesToKill[#framesToKill + 1] = ContainerFrameCombinedBags
end
function S.Utils.KillBlizzBags()
    for _, frame in pairs(framesToKill) do
        KillFrame(frame)
    end
end

-- Add bag frames from other addons and kill them all after PLAYER_LOGIN
local eventHandlerFrame2 = CreateFrame("FRAME")
eventHandlerFrame2:RegisterEvent("PLAYER_LOGIN")
eventHandlerFrame2:SetScript("OnEvent", function(self)
    if _G["ElvUI_ContainerFrame"] then
        framesToKill[#framesToKill + 1] = _G["ElvUI_ContainerFrame"]
        framesToKill[#framesToKill + 1] = _G["ElvUI_BankContainerFrame"]
    end
    if _G["GwBagFrame"] then
        framesToKill[#framesToKill + 1] = _G["GwBagFrame"]
        framesToKill[#framesToKill + 1] = _G["GwBankFrame"]
    end
    S.Utils.KillBlizzBags()
end)]]



-- Basic event handling for custom events

--[[ Events 
--------------
EnteredWorld: fired after PLAYER_ENTERING_WORLD
Resizing: fired every time the window changes size
Resized: fired when window is finished resizing
SettingChanged-<setting>: Parameters: (Value)
FontChanged: fired after any changes are applied to the font object
CategorySelected: fired when the selected category changes
SortingChanged: fired when the sorting method changes, like when a column heading is clicked
BagsUpdated: fired when the contents of a bag has changed
CurrenciesUpdated: fired when the quantity of a currency changes
PrimaryFrameOpened
PrimaryFrameClosed
BankOpened: fired after the bank is opened and the data of its bag contents have been updated
BankClosed: fired after the bank is closed
SearchChanged
CharacterSelected
ColumnsChanged: fired when a column is enabled or disabled
FavoriteChanged: fired when an item or currency has its marker icon changed
ReagentsPurchased
LayoutChanged: fired when a list changes to grid view, or vice versa
EquipmentSetsUpdated
GuildBankUpdated: fired each time a guild bank tab is updated
GuildBankUpdatedFull: fired after all 8 tabs have been updated
ProfileChanged: fired when the character switches settings profile
]]
local registeredEvents = {}
function S.Utils.RunOnEvent(self, event, func)
    if not registeredEvents[event] then
        registeredEvents[event] = {}
    end
    table.insert(registeredEvents[event], {
        ["func"] = func,
        ["self"] = self
    })
end
-- Run all functions registered with an event. Extra parameters a,b,c can be passed to the function
function S.Utils.TriggerEvent(event, a, b, c)
    if registeredEvents[event] then
        for k,v in pairs(registeredEvents[event]) do
            v.func(v.self, event, a, b, c)
        end
    end
end




-- Dealing with other bag frames
-- Make them all children of 'killableFramesParent', which can be hidden or shown to enable or disable the killable frames
local killableFramesParent = CreateFrame("FRAME", nil, UIParent)
killableFramesParent:SetAllPoints()
killableFramesParent:Hide()
local function MakeFrameKillable(frame)
    frame:SetParent(killableFramesParent)
end


local function MakeBlizzBagsKillable()
    if _G["ContainerFrameCombinedBags"] then
        MakeFrameKillable(_G["ContainerFrameCombinedBags"])
    end
    for i = 1, NUM_CONTAINER_FRAMES do
        MakeFrameKillable(_G["ContainerFrame"..i])
    end
    MakeFrameKillable(_G["BankFrame"])
    if _G["ElvUI_ContainerFrame"] then
        MakeFrameKillable(_G["ElvUI_ContainerFrame"])
        MakeFrameKillable(_G["ElvUI_BankContainerFrame"])
    end
    if _G["GwBagFrame"] then
        MakeFrameKillable(_G["GwBagFrame"])
        MakeFrameKillable(_G["GwBankFrame"])
    end
end

function S.Utils.KillBlizzBags()
    S.Enable()
    killableFramesParent:Hide()
end
function S.Utils.ResurrectBlizzBags()
    S.Disable()
    killableFramesParent:Show()
end
function S.Utils.ToggleBlizzBags()
    if killableFramesParent:IsShown() then
        S.Utils.KillBlizzBags()
    else
        S.Utils.ResurrectBlizzBags()
    end
end

local function CreateToggleButton(parent)
    if parent.ClickableTitleFrame then
        parent.ClickableTitleFrame:Hide()
    end
    if parent.TitleContainer then
        parent.TitleContainer:Hide()
    end
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetFrameLevel(parent:GetFrameLevel() + 520)
    button.text = button:CreateTexture()
    button.text:SetPoint("CENTER", 4, -1)
    button.text:SetSize(60, 20)
    button.text:SetTexCoord(0, 0.75, 0, 1)
    button.text:SetTexture("Interface\\Addons\\Sorted\\Textures\\title-no-bg")
    button:SetSize(64, 24)
    button:HookScript("OnMouseDown", function(self)
        self.text:SetPoint("CENTER", 3, -2)
        self.text:SetAlpha(0.75)
    end)
    button:HookScript("OnMouseUp", function(self)
        self.text:SetPoint("CENTER", 4, -1)
        self.text:SetAlpha(1)
    end)
    button:HookScript("OnEnter", function(self)
        S.Tooltip.CreateLocalized(self, "ANCHOR_RIGHT", "TOOLTIP_TOGGLE_SORTED")
    end)
    button:HookScript("OnLeave", function(self)
        S.Tooltip.Cancel()
    end)
    button:HookScript("OnClick", function(self)
        S.Utils.ToggleBlizzBags()
        CloseAllBags()
        OpenAllBags()
    end)
    return button
end
local function CreateBlizzToggleButtons()
    local f = _G["ContainerFrame1"]
    f.SortedButton = CreateToggleButton(f)
    if S.WoWVersion() <= 3 then
        _G["ContainerFrame1Name"]:Hide()
        f.SortedButton:SetPoint("TOPRIGHT", -26, -6)
    else
        f.SortedButton:SetPoint("TOPRIGHT", -22, -1)
    end
    f.SortedButton:SetHeight(20)

    if _G["ContainerFrameCombinedBags"] then
        f = _G["ContainerFrameCombinedBags"]
        f.SortedButton = CreateToggleButton(f)
        f.SortedButton:SetPoint("TOPRIGHT", -22, -1)
        f.SortedButton:SetHeight(20)
    end

    if _G["ElvUI_ContainerFrame"] then
        f = _G["ElvUI_ContainerFrame"]
        f.SortedButton = CreateToggleButton(f)
        f.SortedButton:SetPoint("TOPLEFT", 2, -2)
        f.SortedButton:SetSize(64, 22)
        if S.Skinning.GetSkin() == S.Skinning.ADDONSKINS then
            S.AS:SkinButton(f.SortedButton)
            f.SortedButton.text:SetTexture("Interface\\Addons\\Sorted\\Textures\\Title-Flat")
        end
    end
end

S.Utils.RunOnEvent(nil, "EnteredWorld", function()
    CreateBlizzToggleButtons()
    MakeBlizzBagsKillable()
    S.Utils.KillBlizzBags()
end)



-- Shared media
local LSM = LibStub("LibSharedMedia-3.0")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Original", "Interface\\Addons\\Sorted\\Textures\\UI-Background")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Abstract", "Interface\\Addons\\Sorted\\Textures\\Abstract")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Abstract Light", "Interface\\Addons\\Sorted\\Textures\\Abstract-Light")
LSM:Register(LSM.MediaType.BACKGROUND, "Solid", "Interface\\Addons\\Sorted\\Textures\\Solid")
LSM:Register(LSM.MediaType.BACKGROUND, "Necrolord", "Interface\\FrameGeneral\\UIFrameNecrolordBackground")
LSM:Register(LSM.MediaType.BACKGROUND, "Night Fae", "Interface\\FrameGeneral\\UIFrameNightFaeBackground")
LSM:Register(LSM.MediaType.BACKGROUND, "Oribos", "Interface\\FrameGeneral\\UIFrameOribosBackground")
LSM:Register(LSM.MediaType.BACKGROUND, "Venthyr", "Interface\\FrameGeneral\\UIFrameVenthyrBackground")
LSM:Register(LSM.MediaType.BACKGROUND, "Kyrian", "Interface\\FrameGeneral\\UIFrameKyrianBackground")
LSM:Register(LSM.MediaType.BACKGROUND, "Dragonflight", "Interface\\FrameGeneral\\UIFrameDragonflightBackground")
LSM:Register(LSM.MediaType.BACKGROUND, "Rock", "Interface\\FrameGeneral\\UI-Background-Rock")
LSM:Register(LSM.MediaType.BACKGROUND, "Bank", "Interface\\BankFrame\\Bank-Background")

LSM:Register(LSM.MediaType.STATUSBAR, "Sorted", "Interface\\Addons\\Sorted\\Textures\\UI-Highlight")

LSM:Register(LSM.MediaType.FONT, "Metamorphous", "Interface\\Addons\\Sorted\\Textures\\Metamorphous-Regular.ttf")
LSM:Register(LSM.MediaType.FONT, "Open Sans", "Interface\\Addons\\Sorted\\Textures\\OpenSans-Regular.ttf")
LSM:Register(LSM.MediaType.FONT, "Open Sans Condensed", "Interface\\Addons\\Sorted\\Textures\\OpenSans-CondBold.ttf")
LSM:Register(LSM.MediaType.FONT, "Open Sans Light", "Interface\\Addons\\Sorted\\Textures\\OpenSans-Light.ttf")
LSM:Register(LSM.MediaType.FONT, "Open Sans Semibold", "Interface\\Addons\\Sorted\\Textures\\OpenSans-Semibold.ttf")
LSM:Register(LSM.MediaType.FONT, "Open Sans Bold", "Interface\\Addons\\Sorted\\Textures\\OpenSans-Bold.ttf")
LSM:Register(LSM.MediaType.FONT, "Semplicita", "Interface\\Addons\\Sorted\\Textures\\SemplicitaPro-Medium.ttf")
LSM:Register(LSM.MediaType.FONT, "Semplicita Light", "Interface\\Addons\\Sorted\\Textures\\SemplicitaPro-Regular.ttf")
LSM:Register(LSM.MediaType.FONT, "Semplicita Semibold", "Interface\\Addons\\Sorted\\Textures\\SemplicitaPro-Semibold.ttf")
LSM:Register(LSM.MediaType.FONT, "Semplicita Bold", "Interface\\Addons\\Sorted\\Textures\\SemplicitaPro-Bold.ttf")
LSM:Register(LSM.MediaType.FONT, "Bliz Quadrata", "Interface\\Addons\\Sorted\\Textures\\Bliz-Quadrata.ttf")
LSM:Register(LSM.MediaType.FONT, "Segoe UI", "Interface\\Addons\\Sorted\\Textures\\segoeui.ttf")
LSM:Register(LSM.MediaType.FONT, "Segoe UI Light", "Interface\\Addons\\Sorted\\Textures\\segoeuisl.ttf")
LSM:Register(LSM.MediaType.FONT, "Segoe UI Semibold", "Interface\\Addons\\Sorted\\Textures\\seguisb.ttf")
LSM:Register(LSM.MediaType.FONT, "Segoe UI Bold", "Interface\\Addons\\Sorted\\Textures\\segoeuib.ttf")

function S.Utils.GetFonts()
    return LSM:List("font")
end
function S.Utils.GetFontPath(font)
    return LSM:Fetch("font", font)
end

function S.Utils.GetBackgrounds()
    return LSM:List(LSM.MediaType.BACKGROUND)
end
function S.Utils.GetBackgroundPath(bg)
    return LSM:Fetch(LSM.MediaType.BACKGROUND, bg)
end



function S.Utils.GetItemQualityName(quality)
    return _G["ITEM_QUALITY"..quality.."_DESC"]
end

-- COLORS AND TEXT FORMATTING
local SORTED_ITEM_QUALITY_COLORS = {
    [0] = CreateColor(0.6, 0.6, 0.6), --Poor
    [1] = CreateColor(0.95, 0.95, 0.95), --Common
    [2] = CreateColor(0.3, 1, 0.1), --Uncommon
    [3] = CreateColor(0, 0.7, 1), --Rare
    [4] = CreateColor(0.9, 0.3, 1), --Epic
    [5] = CreateColor(1, 0.5, 0.1), --Legendary
    [6] = CreateColor(1, 0.85, 0.55), --Artifact
    [7] = CreateColor(0.15, 1, 1), --Heirloom
    [8] = CreateColor(1, 0.8, 0)--WoWToken
}
function S.Utils.GetItemQualityColor(quality)
    return SORTED_ITEM_QUALITY_COLORS[quality]
    --return GetItemQualityColor(quality)
end

local SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS = {
    [0] = CreateColor(0.8,0.8,0.8), -- Poor
    [1] = CreateColor(1,1,1), -- Common
    [2] = CreateColor(0.8,1,0.5), -- Uncommon
    [3] = CreateColor(0.4,0.9,1), -- Rare
    [4] = CreateColor(1,0.6,1), -- Epic
    [5] = CreateColor(1,0.8,0.4), -- Legendary
    [6] = CreateColor(1,0.97,0.8), -- Artifact
    [7] = CreateColor(0.6,1,1), -- Heirloom
    [8] = CreateColor(1,0.8,0)  -- WoW Token
}
function S.Utils.GetItemQualityHighlightColor(quality)
    return SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS[quality]
end

local SORTED_ITEM_QUALITY_GREYED_COLORS = {}
for k,v in pairs(SORTED_ITEM_QUALITY_COLORS) do
    SORTED_ITEM_QUALITY_GREYED_COLORS[k] = CreateColor(
        v.r * 0.07 + 0.16, 
        v.g * 0.07 + 0.16, 
        v.b * 0.07 + 0.16
    )
end
function S.Utils.GetItemQualityGreyedColor(quality)
    return SORTED_ITEM_QUALITY_GREYED_COLORS[quality]
end

local buttonTextColor = CreateColor(1, 0.8, 0)
function S.Utils.GetButtonTextColor()
    return buttonTextColor
end

function S.Utils.BasicTextSearch(search, text)
    for s in search:lower():gmatch("([^%s]+)") do
        if string.find(text:lower():gsub("%s", ""), s) then
            return true
        end
    end
    return false
end

function S.Utils.FormatValueString(value)
    if value < 100 then
        return GetMoneyString(value)
    elseif value < 10000 then
        return GetMoneyString(math.floor(value / 100) * 100)
    elseif value < 10000000 then
        return GetMoneyString(math.floor(value / 10000) * 10000)
    else
        local n = math.floor(value / 10000000) * 10000
        local s = ""..n
        n = GetMoneyString(n)
        return n:sub(1, #s-4).."K"..n:sub(#s-3)
    end
end
function S.Utils.FormatValueStringNoIcon(value)
    if value < 100 then
        return value
    elseif value < 10000 then
        return math.floor(value / 100)
    else
        return S.Utils.FormatBigNumber(math.floor(value / 10000))
    end
end
function S.Utils.GetValueIcon(value)
    if value < 100 then
        return "Interface\\MONEYFRAME\\UI-CopperIcon"
    elseif value < 10000 then
        return "Interface\\MONEYFRAME\\UI-SilverIcon"
    else
        return "Interface\\MONEYFRAME\\UI-GoldIcon"
    end
end

-- In case some crazy person gets a billion of some currency
function S.Utils.FormatBigNumber(n)
    if n < 1000 then
        return n
    elseif n < 10000 then
        local s = tostring(n)
        return s:sub(1,1).."."..s:sub(2,2).."K"
    elseif n < 1000000 then
        local s = tostring(floor(n / 1000))
        return s.."K"
    elseif n < 10000000 then
        local s = tostring(floor(n / 1000))
        return s:sub(1,1).."."..s:sub(2,2).."M"
    elseif n < 1000000000 then
        local s = tostring(floor(n / 1000000))
        return s.."M"
    elseif n < 10000000000 then
        local s = tostring(floor(n / 1000000))
        return s:sub(1,1).."."..s:sub(2,2).."B"
    elseif n < 1000000000000 then
        local s = tostring(floor(n / 1000000000))
        return s.."B"
    end
end

local valueColors = {
    [1] = CreateColor(0.8,  0.45, 0.2),
    [2] = CreateColor(0.7,  0.7,  0.7),
    [3] = CreateColor(0.9,  0.75, 0.2),
    [4] = CreateColor(1,    0.7,  0.2),
    [5] = CreateColor(1,    0.6,  0.1)
}
function S.Utils.GetValueColor(value)
    if value < 100 then return valueColors[1]
    elseif value < 10000 then return valueColors[2]
    elseif value < 10000000 then return valueColors[3]
    elseif value < 10000000000 then return valueColors[4]
    else return valueColors[5]
    end
end

function S.Utils.GetClassColor(class)
    return (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
end
function S.Utils.GetClassHexColor(class)
    return (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]:GenerateHexColorMarkup()
end

function S.Utils.GetRaceName(raceID) 
    if type(raceID) == "number" then
        return C_CreatureInfo.GetRaceInfo(raceID).raceName
    else
        return raceID
    end
end

function S.Utils.FormatFaction(faction, size)
    if not size then
        size = 20
    end
    if faction == "Alliance" then
        return "|TInterface\\FriendsFrame\\PlusManz-Alliance:"..size..":"..size.."|t"
    elseif faction == "Horde" then
        return "|TInterface\\FriendsFrame\\PlusManz-Horde:"..size..":"..size.."|t"
    else
        return "|TInterface\\Addons\\Sorted\\Textures\\Pandaren-Logo:"..size..":"..size.."|t"
    end
end

local expansionColors = {
    [0] = "|cffFFBB3D", -- wow
    [1] = "|cff95C96A", -- tbc
    [2] = "|cff45D8FF", -- wrath
    [3] = "|cffFF7727", -- cata
    [4] = "|cff35FFA3", -- mop
    [5] = "|cffE24E21", -- wod
    [6] = "|cffB4FF55", -- legion
    [7] = "|cff9EBBEE", -- bfa
    [8] = "|cffFDFFFB", -- sl
    [9] = "|cffFFCC88", -- df
}
function S.Utils.ExpacColor(expacID)
    return expansionColors[expacID]
end
function S.Utils.FormatExpac(expacID, width, height)
    if not expacID then
        expacID = 0
    end
    local x = (expacID % 4) * 64
    local y = math.floor(expacID / 4) * 32
    if width and height then
        return string.format("|TInterface\\Addons\\Sorted\\Textures\\Expac-Icons:%d:%d:0:0:256:256:%d:%d:%d:%d|t", height, width, x, x+64, y, y+32)
    else
        return string.format("|TInterface\\Addons\\Sorted\\Textures\\Expac-Icons:%d:%d:0:0:256:256:%d:%d:%d:%d|t", 32, 64, x, x+64, y, y+32)
    end
end
local expansionStrings = {
    [0] = "World of Warcraft",
    [1] = "The Burning Crusade",
    [2] = "Wrath of the Lich King",
    [3] = "Cataclysm",
    [4] = "Mists of Pandaria",
    [5] = "Warlords of Draenor",
    [6] = "Legion",
    [7] = "Battle for Azeroth",
    [8] = "Shadowlands",
    [9] = "Dragonflight"
}
function S.Utils.FormatExpacLong(expacID)
    if not expansionStrings[expacID] then
        return expansionStrings[0]
    end
    return --[[expansionColors[expacID]..]]expansionStrings[expacID]
end

function S.Utils.FormatTime(time)
    if not time then return "" end
    if time > 31536000 then
        if time > 63072000 then
            return math.floor(time / 31536000).." "..S.Localize("SUBFILTER_TIME_YEARS_SHORT")
        else
            return "1 "..S.Localize("SUBFILTER_TIME_YEAR_SHORT")
        end

    elseif time >= 2419200 then
        if time >= 4838400 then
            return math.floor(time / 2419200).." "..S.Localize("SUBFILTER_TIME_MONTHS_SHORT")
        else
            return "1 "..S.Localize("SUBFILTER_TIME_MONTH_SHORT")
        end

    elseif time >= 604800 then
        if time >= 1209600 then
            return math.floor(time / 604800).." "..S.Localize("SUBFILTER_TIME_WEEKS_SHORT")
        else
            return "1 "..S.Localize("SUBFILTER_TIME_WEEK_SHORT")
        end

    elseif time >= 86400 then
        if time >= 172800 then
            return math.floor(time / 86400).." "..S.Localize("SUBFILTER_TIME_DAYS_SHORT")
        else
            return "1 "..S.Localize("SUBFILTER_TIME_DAY_SHORT")
        end

    elseif time >= 3600 then
        if time >= 7200 then
            return math.floor(time / 3600).." "..S.Localize("SUBFILTER_TIME_HOURS_SHORT")
        else
            return "1 "..S.Localize("SUBFILTER_TIME_HOUR_SHORT")
        end

    elseif time >= 60 then
        if time >= 120 then
            return math.floor(time / 60).." "..S.Localize("SUBFILTER_TIME_MINUTES_SHORT")
        else
            return "1 "..S.Localize("SUBFILTER_TIME_MINUTE_SHORT")
        end

    elseif time >= 0 then
        if time == 1 then
            return "1 "..S.Localize("SUBFILTER_TIME_SECOND_SHORT")
        else
            return time.." "..S.Localize("SUBFILTER_TIME_SECONDS_SHORT")
        end
    else
        return ""
    end
end

local MARKER_ICON_COLORS = {
    [0] = "None",
    [1] = "|cFFFFD827",
    [2] = "|cFFFF8C0A",
    [3] = "|cFFEC40FF",
    [4] = "|cFF26FF22",
    [5] = "|cFFADD3EB",
    [6] = "|cFF13C7FF",
    [7] = "|cFFFA543F",
    [8] = "|cFFF3EEE8"
}
local FORMATTED_MARKER_ICONS = {
    [0] = "None",
    [1] = "Star",
    [2] = "Circle",
    [3] = "Diamond",
    [4] = "Triangle",
    [5] = "Moon",
    [6] = "Square",
    [7] = "Cross",
    [8] = "Skull"
}
function S.Utils.FormatMarkerIcon(id, width, height)
    if not id or not FORMATTED_MARKER_ICONS[id] then
        return FORMATTED_MARKER_ICONS[0]
    end
    return FORMATTED_MARKER_ICONS[id]
    -- Return the image of the icon
    --[[if not width or not height then
        width = 16 + S.Settings.Get("fontSize")
        height = width
    end
    local x,y = ((id - 1) % 4) * 28, floor((id - 1) / 4) * 28
    return string.format("|TInterface\\Addons\\Sorted\\Textures\\Favorite-Icons:%d:%d:0:0:128:128:%d:%d:%d:%d|t", height, width, x, x+28, y, y+28)]]
end


-- TOOLTIPS
function S.Utils.GetItemTooltip(bag, slot)
    S.DataTooltip:ClearLines()
    local link = GetContainerItemLink(bag, slot)
    if link then
        S.DataTooltip:SetHyperlink(link)
        local i = 1
        local tooltip = {}
        local lineCount = 0
        while true do
            local foundLine = false
            local left, right = _G["SortedDataTooltipTextLeft"..i], _G["SortedDataTooltipTextRight"..i]
            if left then
                local s = left:GetText()
                if s and #s > 1 then
                    local r,g,b = left:GetTextColor()
                    tooltip[i] = {}
                    tooltip[i].l = s
                    tooltip[i].lr = r
                    tooltip[i].lg = g
                    tooltip[i].lb = b
                    lineCount = i
                end
                foundLine = true
            end
            if right then
                local s = right:GetText()
                if s and #s > 1 then
                    local r,g,b = right:GetTextColor()
                    if not tooltip[i] then
                        tooltip[i] = {}
                    end
                    tooltip[i].r = s
                    tooltip[i].rr = r
                    tooltip[i].rg = g
                    tooltip[i].rb = b
                    lineCount = i
                end
                foundLine = true
            end
            if not foundLine then
                break
            end
            i = i + 1
        end
        return tooltip, lineCount
    end
end

function S.Utils.GetItemTooltipString(bag, slot, omitFirstLine)
    S.DataTooltip:ClearLines()
    local link = GetContainerItemLink(bag, slot)
    if link then
        S.DataTooltip:SetHyperlink(link)
        local tooltip = ""
        local line = 1
        if omitFirstLine then
            line = 2
        end
        while true do
            local foundLine = false
            local left, right = _G["SortedDataTooltipTextLeft"..line], _G["SortedDataTooltipTextRight"..line]
            if left then
                local s = left:GetText()
                if s and #s > 1 then
                    if line > 1 then
                        tooltip = tooltip.."\n"
                    end
                    tooltip = tooltip..s.."   "
                    foundLine = true
                end
            end
            if right then
                local s = right:GetText()
                if s and #s > 1 then
                    if not foundLine and line > 1 then
                        tooltip = tooltip.."\n"
                    end
                    tooltip = tooltip..s
                    foundLine = true
                end
            end
            if not foundLine then
                break
            end
            line = line + 1
        end
        return tooltip
    end
end

function S.Utils.GetItemTooltipLine(bag, slot, line)
    S.DataTooltip:ClearLines()
    local link = GetContainerItemLink(bag, slot)
    if link then
        S.DataTooltip:SetHyperlink(link)
        local tooltip = ""
        local left, right = _G["SortedDataTooltipTextLeft"..line], _G["SortedDataTooltipTextRight"..line]
        if left then
            left = left:GetText()
        end
        if right then
            right = right:GetText()
        end
        return left, right
    end
end



-- CONTAINERS UTILITIES
local containersOfType = {
    [S.CONTAINER_TYPES.BANK] = { BANK_CONTAINER },
    [S.CONTAINER_TYPES.BAGS] = { BACKPACK_CONTAINER },
    [S.CONTAINER_TYPES.ALL] = { BACKPACK_CONTAINER, BANK_CONTAINER }
}

if S.WoWVersion() >= 10 then
    for i = 1, NUM_BAG_SLOTS + NUM_REAGENTBAG_SLOTS do 
        table.insert(containersOfType[S.CONTAINER_TYPES.BAGS], i) 
        table.insert(containersOfType[S.CONTAINER_TYPES.ALL], i) 
        containersOfType["CONTAINER"..i] = { i }
    end
    for i = NUM_BAG_SLOTS + NUM_REAGENTBAG_SLOTS  + 1, NUM_BAG_SLOTS + NUM_REAGENTBAG_SLOTS + NUM_BANKBAGSLOTS do 
        table.insert(containersOfType[S.CONTAINER_TYPES.BANK], i) 
        table.insert(containersOfType[S.CONTAINER_TYPES.ALL], i) 
        containersOfType["CONTAINER"..i] = { i }
    end

else
    for i = 1, NUM_BAG_SLOTS do 
        table.insert(containersOfType[S.CONTAINER_TYPES.BAGS], i) 
        table.insert(containersOfType[S.CONTAINER_TYPES.ALL], i) 
        containersOfType["CONTAINER"..i] = { i }
    end
    for i = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do 
        table.insert(containersOfType[S.CONTAINER_TYPES.BANK], i) 
        table.insert(containersOfType[S.CONTAINER_TYPES.ALL], i) 
        containersOfType["CONTAINER"..i] = { i }
    end
end

if S.WoWVersion() <= 3 then
    containersOfType[S.CONTAINER_TYPES.KEYRING] = { KEYRING_CONTAINER }
    table.insert(containersOfType[S.CONTAINER_TYPES.ALL], KEYRING_CONTAINER)
elseif S.WoWVersion() >= 6 then
    containersOfType[S.CONTAINER_TYPES.REAGENT] = { REAGENTBANK_CONTAINER }
    table.insert(containersOfType[S.CONTAINER_TYPES.ALL], REAGENTBANK_CONTAINER)
end

function S.Utils.ContainersOfType(containerType)
    return containersOfType[containerType]
end



local containerTypes = {
    [BANK_CONTAINER] = "BANK",
    [BACKPACK_CONTAINER] = "BAGS"
}
for i = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do 
    containerTypes[i] = "BANK"
end
for i = 1, NUM_BAG_SLOTS do 
    containerTypes[i] = "BAGS"
end
if S.WoWVersion() < 4 then
    containerTypes[KEYRING_CONTAINER] = "KEYRING"
elseif S.WoWVersion() >= 6 then
    containerTypes[REAGENTBANK_CONTAINER] = "REAGENT"
end
function S.Utils.GetContainerType(container)
    return containerTypes[container]
end
function S.Utils.ContainerIsType(container, type)
    return containerTypes[container] == type
end

function S.Utils.GetContainerMaxSlots(container)
    if container == REAGENTBANK_CONTAINER then
        return 98
    elseif container == BANK_CONTAINER then
        return 28
    else
        return S.Utils.MaxBagSlots()
    end
end

local containerInventoryIDs = {}
for _, containerID in pairs(S.Utils.ContainersOfType("ALL")) do
    if containerID ~= BACKPACK_CONTAINER and containerID ~= BANK_CONTAINER and containerID ~= REAGENTBANK_CONTAINER and containerID ~= KEYRING_CONTAINER then
        containerInventoryIDs[ContainerIDToInventoryID(containerID)] = containerID
    end
end
function S.Utils.InventoryIDToContainerID(inventoryID)
    return containerInventoryIDs[inventoryID]
end



function S.Utils.VendorTrash()
    if MerchantFrame:IsVisible() then
        for k,bagID in pairs(S.Utils.ContainersOfType("BAGS")) do
            for slotID = 1,36 do
                local itemData = S.Data.GetItem(bagID, slotID)
                if (S.Data.GetTrash(itemData) <= 1) and (not itemData.noValue) then
                    UseContainerItem(bagID, slotID)
                end
            end
        end
    end
end


-- Methods to attempt to empty the contents of one bag into the other bags
-- Usage: S.Utils.EmptyBag(bagID)
local lockedSlots
local function DropItemInFirstAvailableBag(containers, excludedBag)
    local _, cursorItemID, cursorItemLink = GetCursorInfo()
    local itemFamily = GetItemFamily(cursorItemLink)
    for _, bag in pairs(containers) do
        if bag ~= excludedBag then
            if not lockedSlots[bag] then lockedSlots[bag] = {} end
            if GetContainerNumFreeSlots(bag) > 0 then
                local bagFamily
                if bag == BACKPACK_CONTAINER then
                    bagFamily = 0
                else
                    bagFamily = GetItemFamily(GetInventoryItemLink("player", ContainerIDToInventoryID(bag)))
                end
                if bagFamily == 0 or bagFamily == itemFamily then
                    for slot = 1, GetContainerNumSlots(bag) do
                        if not lockedSlots[bag][slot] then
                            local _, _, _, _, _, _, _, _, _, itemID = GetContainerItemInfo(bag, slot)
                            if not itemID or itemID == cursorItemID then
                                PickupContainerItem(bag, slot)
                                lockedSlots[bag][slot] = true
                                if not CursorHasItem() then
                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end
function S.Utils.EmptyBag(bag)
    lockedSlots = {}
    local containers = S.Utils.ContainersOfType(S.Utils.GetContainerType(bag))
    for slot = 1, GetContainerNumSlots(bag) do
        PickupContainerItem(bag, slot)
        if CursorHasItem() then
            if not DropItemInFirstAvailableBag(containers, bag) then
                UIErrorsFrame:AddExternalErrorMessage(S.Localize("WARNING_BAG_COULDNT_EMPTY"))
                ClearCursor()
                return
            end
        end
    end
    ClearCursor()
end



local cursorHasSplitStack = false
local pickupLocationBag, pickupLocationSlot = nil, nil
local pickupLocationInventoryID = nil
local pickupLocationGuildTab, pickupLocationGuildSlot = nil, nil
-- Check cursor has an item first with:  infoType, ... = GetCursorInfo()
function S.Utils.PlaceCursorItemInContainerType(containerType, guildTab)
    local _, cursorItemID, cursorItemLink = GetCursorInfo()
    
    -- Guild bank function
    if containerType == "GUILD_BANK" then
        local tabs = {}
        if guildTab then
            tabs[1] = guildTab
        else
            for i = 1, GetNumGuildBankTabs() do
                tabs[i] = i
            end
        end
        -- First combine stacks if item isn't from a split stack
        if not cursorHasSplitStack then
            for _, tab in pairs(tabs) do
                for slot = 1, 98 do
                    if not (tab == pickupLocationGuildTab and slot == pickupLocationGuildSlot) then
                        local itemLink = GetGuildBankItemLink(tab, slot)
                        if itemLink == cursorItemLink then
                            PickupGuildBankItem(tab, slot)
                            if not GetCursorInfo() then
                                return
                            end
                        end
                    end
                end
            end
        end
        -- Then put item in an empty slot
        for _, tab in pairs(tabs) do
            for slot = 1, 98 do
                local itemLink = GetGuildBankItemLink(tab, slot)
                if not itemLink then
                    PickupGuildBankItem(tab, slot)
                    if not GetCursorInfo() then
                        cursorHasSplitStack = false
                        return
                    end
                end
            end
        end


    -- Container function
    else
        -- First combine stacks if item isn't from a split stack
        if not cursorHasSplitStack then
            for _, bag in pairs(S.Utils.ContainersOfType(containerType)) do
                -- Prevent putting a bag into itself
                if not pickupLocationInventoryID or S.Utils.InventoryIDToContainerID(pickupLocationInventoryID) ~= bag then
                    for slot = 1, GetContainerNumSlots(bag) do
                        if not (bag == pickupLocationBag and slot == pickupLocationSlot) then
                            local _, count, _, _, _, _, _, _, _, itemID = GetContainerItemInfo(bag, slot)
                            if itemID then
                                local _, _, _, _, _, _, _, stackCount = GetItemInfo(itemID)
                                if itemID == cursorItemID and count < stackCount then
                                    PickupContainerItem(bag, slot)
                                    if not GetCursorInfo() then
                                        return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        -- Then put item in an empty slot
        for _, bag in pairs(S.Utils.ContainersOfType(containerType)) do
            -- Prevent putting a bag into itself
            if not pickupLocationInventoryID or S.Utils.InventoryIDToContainerID(pickupLocationInventoryID) ~= bag then
                for slot = 1, GetContainerNumSlots(bag) do
                    local _, _, _, _, _, _, _, _, _, itemID = GetContainerItemInfo(bag, slot)
                    if not itemID then
                        PickupContainerItem(bag, slot)
                        if not GetCursorInfo() then
                            cursorHasSplitStack = false
                            return
                        end
                    end
                end
            end
        end
    end
end
-- Record location items are picked up from 
local function OnContainerItemPickup(bag, slot)
    if GetCursorInfo() then
        pickupLocationBag = bag
        pickupLocationSlot = slot
        pickupLocationInventoryID = nil
        pickupLocationGuildTab = nil
        pickupLocationGuildSlot = nil
    end
end
if C_Container and C_Container.PickupContainerItem then
    hooksecurefunc(C_Container, "PickupContainerItem", OnContainerItemPickup)
else
    hooksecurefunc("PickupContainerItem", OnContainerItemPickup)
end
local function OnInventoryItemPickup(inventoryID)
    if GetCursorInfo() then
        pickupLocationBag = nil
        pickupLocationSlot = nil
        pickupLocationInventoryID = inventoryID
        pickupLocationGuildTab = nil
        pickupLocationGuildSlot = nil
    end
end
hooksecurefunc("PickupInventoryItem", OnInventoryItemPickup)
local function OnGuildItemPickup(tab, slot)
    if GetCursorInfo() then
        pickupLocationBag = nil
        pickupLocationSlot = nil
        pickupLocationInventoryID = nil
        pickupLocationGuildTab = tab
        pickupLocationGuildSlot = slot
    end
end
hooksecurefunc("PickupGuildBankItem", OnGuildItemPickup)

-- Record when an item is from a split stack
if C_Container and C_Container.SplitContainerItem then
    hooksecurefunc(C_Container, "SplitContainerItem", function()
        cursorHasSplitStack = true
    end)
else
    hooksecurefunc("SplitContainerItem", function()
        cursorHasSplitStack = true
    end)
end
hooksecurefunc("SplitGuildBankItem", function()
    cursorHasSplitStack = true
end)

-- Reset on CURSOR_CHANGED
if S.WoWVersion() > 1 then
    local eventHandlerFrame = CreateFrame("FRAME")
    eventHandlerFrame:RegisterEvent("CURSOR_CHANGED")
    eventHandlerFrame:SetScript("OnEvent", function(self) 
        if not CursorHasItem() then
            pickupLocationBag = nil
            pickupLocationSlot = nil
            cursorHasSplitStack = false
        end
    end)
end

-- TABLE UTILITIES
-- Prints a table in a neat format
function S.Utils.PrintTable(t,indent, key)
    local s = ""
    if indent then
        for i = 1,indent do s=s.."  " end
    else
        indent = 0
    end
    if type(t) == "table" then
        if key then print(s.."["..key.."] = {")
        else print(s.."{") end
        for k,v in pairs(t) do
            S.Utils.PrintTable(v,indent+1,k)
        end
        print(s.."},")
    else
        if key then print(s.."["..key.."] = "..tostring(t))
        else print(s..tostring(t)) end
    end
end

-- Copies contents of t1 into t2
function S.Utils.CopyTable(t1, t2)
    for key, value in pairs(t1) do
        if type(value) == "table" then
            t2[key] = {}
            S.Utils.CopyTable(value, t2[key])
        else
            t2[key] = value
        end
    end
end
-- Deletes empty inner tables
function S.Utils.CleanTable(t)
    if type(t) == "table" then
        local empty = true
        for k, v in pairs(t) do
            if S.Utils.CleanTable(v) then
                t[k] = nil
            else
                empty = false
            end
        end
        if empty then
            return true
        end
    end
    return false
end