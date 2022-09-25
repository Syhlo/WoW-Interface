local _, S = ...

local DEMO = false -- For screenshot taking with a white background
function Sorted_IsDemo()
    return DEMO
end
if DEMO then
    local f = CreateFrame("Frame", "White", UIParent)
    f:SetAllPoints()
    f:SetFrameStrata("HIGH")
    local t = f:CreateTexture("")
    t:SetColorTexture(1,1,1,1)
    t:SetAllPoints()
end

-- Detect Classic WoW
local classic = string.sub(GetBuildInfo(), 1, 1) == "1" or string.sub(GetBuildInfo(), 1, 1) == "2" or string.sub(GetBuildInfo(), 1, 1) == "3"
function Sorted_IsClassic()
    return classic
end
local tbc = string.sub(GetBuildInfo(), 1, 1) == "2"
function Sorted_IsTBC()
    return tbc
end
local wrath = string.sub(GetBuildInfo(), 1, 1) == "3"
function Sorted_IsWrath()
    return wrath
end
local bfa = string.sub(GetBuildInfo(), 1, 1) == "8"
function Sorted_IsBfA()
    return bfa
end
local shadowlands = string.sub(GetBuildInfo(), 1, 1) == "9"
function Sorted_IsShadowlands()
    return shadowlands
end
local WoWMajorVersionNumber = tonumber(string.sub(GetBuildInfo(), 1, 2))
function Sorted_WoWMajorVersionNumber()
    return WoWMajorVersionNumber
end


-- Settings
Sorted_settingsProfiles = {}
Sorted_defaultSettings = {   -- Defaults
    ["width"] = 800,
    ["height"] = 540,
    ["scale"] = 1,
    ["iconSize"] = 26,
    ["iconShape"] = 2,
    ["backdropAlpha"] = 1,
    ["font"] = "Friz Quadrata TT",
    ["fontSize"] = 2,
    ["smoothScrolling"] = 2,
    ["animations"] = 2,
    ["favoritesOnTop"] = 2,
    ["newOnTop"] = 2,
    ["newItemIndicators"] = 2,
    ["combineStacks"] = 1,
    ["fontOutline"] = 1,
    ["categoriesWidth"] = 160,
    ["categoriesUseIcons"] = 1,
    ["profileName"] = Sorted.Localize("CONFIG_PROFILES_DEFAULT_NAME"),
    ["scrollSpeed"] = 3,
    ["smoothingAmount"] = 0.15,
    ["tooltipDelay"] = 0.01,
    ["tooltipInfo"] = 2,
    ["iconBorders"] = 1,
    ["iconBorderThickness"] = 1.1,
    ["padding"] = 4,
    ["onOpenSortKeepPrev"] = 1,
    ["onOpenSortMethod"] = 31,
    ["onOpenSortAscending"] = 1,
    ["onOpenFilterKeepPrev"] = 0,
    ["onOpenFilterCategory"] = 1,
    ["onOpenKeepSearch"] = 1,
    ["onOpenPinFavorites"] = 2,
    ["lastSearch"] = "",
    ["lastSort"] = 31,
    ["lastCategory"] = nil,
    ["skinning"] = 2, -- 1: Default skin, 2: ElvUI (if available)
    ["autoOpenClose"] = 255,
    ["grouping"] = 0,
    ["backdrop"] = "Sorted Abstract",
    ["backdropColor"] = {0.6666,0.6666,0.6666,1}, -- {r,g,b,a}
}

-- Shared media
local LSM = LibStub("LibSharedMedia-3.0")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Original", "Interface\\Addons\\Sorted\\Textures\\UI-Background")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Oribos", "Interface\\Addons\\Sorted\\Textures\\UI-Background-Sky")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Night Fae", "Interface\\Addons\\Sorted\\Textures\\UI-Background-Ardenweald")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Ardenweald", "Interface\\Addons\\Sorted\\Textures\\UI-Background-Ardenweald-2")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Necrolord", "Interface\\Addons\\Sorted\\Textures\\UI-Background-Maldraxxus")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Maldraxxus", "Interface\\Addons\\Sorted\\Textures\\UI-Background-Maldraxxus-2")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Venthyr", "Interface\\Addons\\Sorted\\Textures\\UI-Background-Revendreth")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Revendreth", "Interface\\Addons\\Sorted\\Textures\\UI-Background-Revendreth-2")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Kyrian", "Interface\\Addons\\Sorted\\Textures\\UI-Background-Bastion")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Bastion", "Interface\\Addons\\Sorted\\Textures\\UI-Background-Bastion-2")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Abstract", "Interface\\Addons\\Sorted\\Textures\\Abstract")
LSM:Register(LSM.MediaType.BACKGROUND, "Sorted Abstract Light", "Interface\\Addons\\Sorted\\Textures\\Abstract-Light")

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

  -- Default fonts
local clientLocale = GetLocale()
local fontPath = "Fonts\\FRIZQT__.ttf"
if clientLocale == "koKR" then
    fontPath = "Fonts\\K_Pagetext.ttf"
elseif clientLocale == "zhCN" then
    fontPath = "Fonts\\ARKai_T.ttf"
elseif clientLocale == "zhTW" then
    fontPath = "Fonts\\blei00d.ttf"
elseif clientLocale == "ruRU" then
    fontPath = "Fonts\\MORPHEUS_CYR.ttf"
end
for k,v in pairs(LSM:List("font")) do
    if fontPath == LSM:Fetch("font", v) then
        Sorted_defaultSettings["font"] = v
    end
end


local function Sorted_GetSettings(guid)
    if not guid then guid = UnitGUID("player") end
    local data = Sorted_GetData(guid)
    if not data then
        return nil
    end
    local settings
    if data.settingsProfile then
        settings = Sorted_settingsProfiles[data.settingsProfile]
    end
    return settings
end

function SortedSettings_SetDefault(self)
    for k,v in pairs(Sorted_defaultSettings) do
        if type(v) == "table" then
            self[k] = {}
            Sorted_CopyTable(v, self[k])
        else
            self[k] = v
        end
    end
end

function Sorted_CreateCopyOfSettingsProfile(origIndex)
    local newIndex = Sorted_CreateNewSettingsProfile(Sorted_settingsProfiles[origIndex].profileName.." - Copy")
    local originalSettings = Sorted_settingsProfiles[origIndex]
    local newSettings = Sorted_settingsProfiles[newIndex]
    for k,v in pairs(originalSettings) do
        if k ~= "profileName" then
            if type(v) == "table" then
                newSettings[k] = {}
                Sorted_CopyTable(v, newSettings[k])
            else
                newSettings[k] = v
            end
        end
    end
    return newIndex
end

function Sorted_CreateNewSettingsProfile(name)
    local index = 0
    for k, v in pairs(Sorted_settingsProfiles) do
        if k > index then
            index = k
        end
    end
    index = index + 1
    Sorted_settingsProfiles[index] = {}
    if not name then
        Sorted_settingsProfiles[index].profileName = UnitName("player").."  ("..GetRealmName()..")"
    else
        Sorted_settingsProfiles[index].profileName = name
    end
    return index
end

function Sorted_GetSetting(setting, guid)
    local t = Sorted_GetSettings(guid)
    if not t then 
        if setting == "categories" then
            return Sorted_defaultCategories
        else
            return Sorted_defaultSettings[setting] 
        end
    end
    if not t[setting] then
        if setting == "categories" then
            t[setting] = {}
            Sorted_CopyTable(Sorted_defaultCategories, t[setting])
        else
            t[setting] = Sorted_defaultSettings[setting]
        end
    end
    return t[setting]
end

function Sorted_SetSetting(setting, value, guid)
    local settings = Sorted_GetSettings(guid)
    if settings then settings[setting] = value end
end

function Sorted_HasSettings(guid)
    local settings = Sorted_GetSettings(guid)
    if not settings then return false end
    return true
end

function Sorted_ReloadAllSettings()
    Sorted_UpdateFonts()
    Sorted_SetScale(Sorted_GetSetting("scale"))
    SortedFrameRightPanel_Update()
    if not Sorted_GetData(UnitGUID("player")).minimized then
        SortedFrame_MinimizeRightPanel(false, true)
        SortedFrame_MaximizeRightPanel(false, true)
    else
        SortedFrame_MinimizeRightPanel(false, true)
    end
    Sorted_UpdateBackdropTexture()
    Sorted_UpdateBackdropColor()
    Sorted_UpdateBagContents()
    Sorted_UpdateItemButtons()
    --Sorted_SelectCategoryButton(nil)
    SortedFilterButtons_Update(SortedFrameFilterButtons)
    SortedSubcategoryFrame_Update()
    Sorted_FilterItems()
    Sorted_UpdateNewItemsPerCategory()
    Sorted_UpdateIconBorders()
    Sorted_ScrollToTop()
    Sorted_UpdateFrameSizes()
    Sorted_ToggleRoundIcons()
    SortedMoneyText:UpdateMoneyText()
end

function Sorted_UpdateFonts()
    local flags
    local shadowX, shadowY
    if Sorted_GetSetting("fontOutline") > 0 then
        flags = "OUTLINE"
        shadowX, shadowY = 0, 0
        if Sorted_GetSetting("fontOutline") > 1 then
            flags = "THICKOUTLINE"
        end
    else
        shadowX, shadowY = 2, -2
    end
    local sizeMod = Sorted_GetSetting("fontSize")
    local path = Sorted_GetFontPath(Sorted_GetSetting("font"))
    SortedSmallFont:SetFont(path, 10 + sizeMod, flags)
    Sorted11Font:SetFont(path, 11 + sizeMod, flags)
    Sorted12Font:SetFont(path, 12 + sizeMod, flags)
    Sorted13Font:SetFont(path, 13 + sizeMod, flags)
    SortedButtonFont:SetFont(path, 10 + sizeMod, flags)
    SortedCheckboxFont:SetFont(path, 10 + sizeMod, flags)
    SortedTitleFont:SetFont(path, 12 + sizeMod, flags)
    SortedTabFont:SetFont(path, 12 + sizeMod, flags)
    SortedTabSelectedFont:SetFont(path, 12 + sizeMod, flags)

    SortedSmallFont:SetShadowOffset(shadowX, shadowY)
    Sorted11Font:SetShadowOffset(shadowX, shadowY)
    Sorted12Font:SetShadowOffset(shadowX, shadowY)
    Sorted13Font:SetShadowOffset(shadowX, shadowY)
    SortedButtonFont:SetShadowOffset(shadowX, shadowY)
    SortedCheckboxFont:SetShadowOffset(shadowX, shadowY)
    SortedTitleFont:SetShadowOffset(shadowX, shadowY)
    SortedTabFont:SetShadowOffset(shadowX, shadowY)
    SortedTabSelectedFont:SetShadowOffset(shadowX, shadowY)

    SortedTabsFrame:UpdateWidths()
end

function Sorted_UpdateIconBorders()
    local thickness = Sorted_GetSetting("iconBorderThickness")
    if Sorted_GetSetting("iconBorders") == 1 then
        for _, itemList in pairs(Sorted_itemLists) do
            for _, itemButton in pairs(itemList.itemButtons) do
                itemButton.iconGlow:Hide()
            end
        end
    else
        for _, itemList in pairs(Sorted_itemLists) do
            for _, itemButton in pairs(itemList.itemButtons) do
                if not itemButton.filtered then
                    itemButton.iconGlow:Show()
                end
            end
        end
    end
end



function Sorted_TransmogCollected(itemID, itemLink)
    local _, sourceID = C_TransmogCollection.GetItemInfo(itemLink)
    if not sourceID then
        sourceID = C_TransmogCollection.GetItemInfo(itemID)
    end
    if sourceID then
        local categoryID, visualID, canEnchant, icon, isCollected, itemLink, transmogLink = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)
        if isCollected then
            return 4
        end
        for _, sourceID in pairs(C_TransmogCollection.GetAllAppearanceSources(visualID)) do
            categoryID, visualID, canEnchant, icon, isCollected, itemLink, transmogLink = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)
            if isCollected then
                return 3
            end
        end
        if C_TransmogCollection.PlayerCanCollectSource(sourceID) then
            return 2
        else
            return 1
        end
    end
    return 0
end

function S.IsContainerItemAnUpgrade(bag, slot)
    if PawnIsContainerItemAnUpgrade then
        return PawnIsContainerItemAnUpgrade(bag, slot)
    end
    return IsContainerItemAnUpgrade(bag, slot)
end

function S.GetItemSubClassInfo(classID, subClassID)
    if subClassID == S.CONDUIT_SUBCLASSID and classID == LE_ITEM_CLASS_CONSUMABLE then
        return Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_CONDUIT")
    end
    local a, b = GetItemSubClassInfo(classID, subClassID)
    if a then return a, b end
    return "", false
end


table.insert(UISpecialFrames, "SortedConfigFrame")


function Sorted_GetFonts()
    return LSM:List("font")
end
function Sorted_GetFontPath(font)
    return LSM:Fetch("font", font)
end

function Sorted_GetBackgrounds()
    return LSM:List(LSM.MediaType.BACKGROUND)
end
function Sorted_GetBackgroundPath(bg)
    return LSM:Fetch(LSM.MediaType.BACKGROUND, bg)
end
local backdrops = {}
function Sorted.RegisterBackdrop(textureObject)
    table.insert(backdrops, textureObject)
end
function Sorted_UpdateBackdropTexture()
    local path = Sorted_GetBackgroundPath(Sorted_GetSetting("backdrop"))
    for _, backdropObject in pairs(backdrops) do
        backdropObject:SetTexture(path, "MIRROR", "MIRROR")
    end
    --[[for _, itemList in pairs(Sorted_itemLists) do
        itemList.bg:SetTexture(path, "MIRROR", "MIRROR")
    end
    SortedConfigFrameContents.bg:SetTexture(path, "MIRROR", "MIRROR")]]
end


function Sorted_UpdateBackdropColor()
    local r, g, b, a = unpack(Sorted_GetSetting("backdropColor"))
    for _, backdrop in pairs(backdrops) do
        backdrop:SetAlpha(a)
        backdrop:SetVertexColor(r, g, b)
    end
    for _, itemList in pairs(Sorted_itemLists) do
        SortedItemList_SetBackdropAlpha(itemList, a)
    end
    for _, sortButton in pairs(Sorted_sortButtons) do
        if sortButton.columnSeparators then
            for _, colSep in pairs(sortButton.columnSeparators) do
                if not S.DoSkinning() then
                    colSep:SetAlpha(a)
                end
            end
        end
    end
    for _, tab in pairs(SortedTabsFrame.tabs) do
        tab.bgLeft:SetAlpha(a)
        tab.bgMiddle:SetAlpha(a)
        tab.bgRight:SetAlpha(a)
    end
    
    SortedFrameSearchBoxFrame.bg:SetAlpha(0.7 + a * 0.3)
    SortedFrameSearchBoxFrame.bgRight:SetAlpha(0.7 + a * 0.3)
end

function Sorted_CurrentPlayerName()
    return UnitName("player")
end

local SORTED_ITEM_QUALITY_COLORS = {
    [0] = { r=0.6,  g=0.6,  b=0.6  }, -- Poor
    [1] = { r=0.95, g=0.95, b=0.95 }, -- Common
    [2] = { r=0.45, g=1,    b=0.1  }, -- Uncommon
    [3] = { r=0,    g=0.65, b=1    }, -- Rare
    [4] = { r=0.9,  g=0.4,  b=1    }, -- Epic
    [5] = { r=1,    g=0.55, b=0.15 }, -- Legendary
    [6] = { r=1,    g=0.85, b=0.55 }, -- Artifact
    [7] = { r=0.25, g=0.9,  b=1    }, -- Heirloom
    [8] = { r=1,    g=0.8,  b=0    }  -- WoW Token
}
function Sorted_GetItemQualityColor(itemQuality)
    if itemQuality and SORTED_ITEM_QUALITY_COLORS[itemQuality] then
        return SORTED_ITEM_QUALITY_COLORS[itemQuality].r, SORTED_ITEM_QUALITY_COLORS[itemQuality].g, SORTED_ITEM_QUALITY_COLORS[itemQuality].b
    end
    return 1, 1, 1
end

local SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS = {
    [0] = ITEM_QUALITY_COLORS[0],   -- Poor
    [1] = ITEM_QUALITY_COLORS[1],   -- Common
    [2] = {r=0.2,  g=1,    b=0   }, -- Uncommon
    [3] = {r=0,    g=0.6,  b=1   }, -- Rare
    [4] = {r=0.9,  g=0,    b=1   }, -- Epic
    [5] = {r=1,    g=0.3,  b=0.0 }, -- Legendary
    [6] = {r=1,    g=0.75, b=0.3 }, -- Artifact
    [7] = {r=0.15, g=1,    b=1   }, -- Heirloom
    [8] = {r=1,    g=0.8,  b=0   }  -- WoW Token
}
function Sorted_GetItemQualityHighlightColor(itemQuality)
    if itemQuality and SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS[itemQuality] then
        return SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS[itemQuality].r, SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS[itemQuality].g, SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS[itemQuality].b
    end
    return 1, 1, 1
end

local SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS = {}
-- Generate highlight text colours that are good enough for most quality levels
for k,v in pairs(SORTED_ITEM_QUALITY_COLORS) do
    SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[k] = {
        r = math.sqrt(v.r),
        g = math.sqrt(v.g),
        b = math.sqrt(v.b)
    }
end
SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[3] = {r=0.45, g=0.82, b=1}
SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[7] = {r=0.75, g=1, b=1}
function Sorted_GetItemQualityHighlightTextColor(itemQuality)
    if itemQuality and SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[itemQuality] then
        return SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[itemQuality].r, SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[itemQuality].g, SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[itemQuality].b
    end
    return 1, 1, 1
end

local SORTED_BAG_TYPES = {
    [0] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_BAG"),
    [1] = Sorted.Localize("SUBFILTER_SUBTYPE_QUIVER_QUIVER"),
    [2] = Sorted.Localize("SUBFILTER_SUBTYPE_QUIVER_AMMO_POUCH"),
    [4] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_SOUL"),
    [8] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_LEATHERWORKING"),
    [16] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_INSCRIPTION"),
    [32] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_HERB"),
    [64] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_ENCHANTING"),
    [128] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_ENGINEERING"),
    [256] = KEYRING,
    [512] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_GEM"),
    [1024] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_MINING")
}
function Sorted_GetBagTypeName(itemFamily)
    return SORTED_BAG_TYPES[itemFamily]
end




local SORTED_ALLCONTAINERS = {
    ["BANK"] = { BANK_CONTAINER },
    ["BAGS"] = { BACKPACK_CONTAINER },
    ["ALL"] = { BACKPACK_CONTAINER, BANK_CONTAINER }
}
for i = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do 
    table.insert(SORTED_ALLCONTAINERS["BANK"], i) 
    table.insert(SORTED_ALLCONTAINERS["ALL"], i) 
    SORTED_ALLCONTAINERS["CONTAINER"..i] = { i }
end
for i = 1, NUM_BAG_SLOTS do 
    table.insert(SORTED_ALLCONTAINERS["BAGS"], i) 
    table.insert(SORTED_ALLCONTAINERS["ALL"], i) 
    SORTED_ALLCONTAINERS["CONTAINER"..i] = { i }
end
if Sorted_IsClassic() then
    SORTED_ALLCONTAINERS["KEYRING"] = { KEYRING_CONTAINER }
    table.insert(SORTED_ALLCONTAINERS["ALL"], KEYRING_CONTAINER)
else
    SORTED_ALLCONTAINERS["REAGENT"] = { REAGENTBANK_CONTAINER }
    table.insert(SORTED_ALLCONTAINERS["ALL"], REAGENTBANK_CONTAINER)
end
function Sorted_ContainersOfType(type)
    return SORTED_ALLCONTAINERS[type]
end
function Sorted_GetContainerType(container)
    for containerType, t in pairs(SORTED_ALLCONTAINERS) do
        for k, containerID in pairs(t) do
            if containerType~="ALL" and string.sub(containerType, 1, 9) ~= "CONTAINER" and containerID == container then
                return containerType
            end
        end
    end
end
function Sorted_ContainerIsType(container, type)
    for _, containerID in pairs(Sorted_ContainersOfType(type)) do
        if container == containerID then
            return true
        end
    end
    return false
end
function Sorted_ItemGoesInBag(itemID, containerID)
    if containerID == BACKPACK_CONTAINER or containerID == BANK_CONTAINER then return true end
    if containerID == KEYRING_CONTAINER then
        return GetItemFamily(itemID) == 256
    else
        if GetContainerNumSlots(containerID) > 0 then
            local itemFamily = GetItemFamily(itemID)
            local containerFamily = GetItemFamily(GetInventoryItemID("player", ContainerIDToInventoryID(containerID)))
            if containerFamily == 0 then return true end
            return bit.band(itemFamily, containerFamily) ~= 0 and select(9, GetItemInfo(itemID)) ~= "INVTYPE_BAG"
        end
    end
end



local Sorted_StatSearchStrings = {
    ["ITEM_MOD_STAMINA"] = {"stam","stamina"},
    ["ITEM_MOD_STAMINA_SHORT"] = {"stam","stamina"},
    ["ITEM_MOD_STRENGTH"] = {"str","strength"},
    ["ITEM_MOD_STRENGTH_SHORT"] = {"str","strength"},
    ["ITEM_MOD_AGILITY"] = {"agi","agility"},
    ["ITEM_MOD_AGILITY_SHORT"] = {"agi","agility"},
    ["ITEM_MOD_INTELLECT"] = {"int","intellect"},
    ["ITEM_MOD_INTELLECT_SHORT"] = {"int","intellect"},
    ["ITEM_MOD_SPIRIT"] = {"spirit"},
    ["ITEM_MOD_SPIRIT_SHORT"] = {"spirit"},
    ["ITEM_MOD_ARMOR_PENETRATION_RATING"] = {"penetration"},
    ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = {"penetration"},
    ["ITEM_MOD_ATTACK_POWER"] = {"att","attack","power"},
    ["ITEM_MOD_ATTACK_POWER_SHORT"] = {"att","attack","power"},
    ["ITEM_MOD_MELEE_ATTACK_POWER_SHORT"] = {"att","attack","melee","power"},
    ["ITEM_MOD_RANGED_ATTACK_POWER"] = {"att","attack","range","ranged","power"},
    ["ITEM_MOD_RANGED_ATTACK_POWER_SHORT"] = {"att","attack","range","ranged","power"},
    ["ITEM_MOD_BLOCK_RATING"] = {"block"},
    ["ITEM_MOD_BLOCK_RATING_SHORT"] = {"block"},
    ["ITEM_MOD_BLOCK_VALUE"] = {"block"},
    ["ITEM_MOD_BLOCK_VALUE_SHORT"] = {"block"},
    ["ITEM_MOD_CRIT_MELEE_RATING"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_MELEE_RATING_SHORT"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_RANGED_RATING"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_RANGED_RATING_SHORT"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_RATING"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_RATING_SHORT"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_SPELL_RATING"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_SPELL_RATING_SHORT"] = {"crit","critical"},
    ["ITEM_MOD_CR_AVOIDANCE_SHORT"] = {"avoid","avoidance"},
    ["ITEM_MOD_CR_SPEED_SHORT"] = {"speed"},
    ["ITEM_MOD_DEFENSE_SKILL_RATING"] = {"defense"},
    ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = {"defense"},
    ["ITEM_MOD_HASTE_MELEE_RATING"] = {"haste"},
    ["ITEM_MOD_HASTE_MELEE_RATING_SHORT"] = {"haste"},
    ["ITEM_MOD_HASTE_RANGED_RATING"] = {"haste"},
    ["ITEM_MOD_HASTE_RANGED_RATING_SHORT"] = {"haste"},
    ["ITEM_MOD_HASTE_RATING"] = {"haste"},
    ["ITEM_MOD_HASTE_RATING_SHORT"] = {"haste"},
    ["ITEM_MOD_HASTE_SPELL_RATING"] = {"haste"},
    ["ITEM_MOD_HASTE_SPELL_RATING_SHORT"] = {"haste"},
    ["ITEM_MOD_HEALTH"] = {"health"},
    ["ITEM_MOD_HEALTH_SHORT"] = {"health"},
    ["ITEM_MOD_HEALTH_REGEN"] = {"health"},
    ["ITEM_MOD_HEALTH_REGENERATION"] = {"health"},
    ["ITEM_MOD_HEALTH_REGENERATION_SHORT"] = {"health"},
    ["ITEM_MOD_HEALTH_REGEN_SHORT"] = {"health"},
    ["ITEM_MOD_HIT_MELEE_RATING"] = {"hit"},
    ["ITEM_MOD_HIT_MELEE_RATING_SHORT"] = {"hit"},
    ["ITEM_MOD_HIT_RANGED_RATING"] = {"hit"},
    ["ITEM_MOD_HIT_RANGED_RATING_SHORT"] = {"hit"},
    ["ITEM_MOD_HIT_RATING"] = {"hit"},
    ["ITEM_MOD_HIT_RATING_SHORT"] = {"hit"},
    ["ITEM_MOD_HIT_SPELL_RATING"] = {"hit"},
    ["ITEM_MOD_HIT_SPELL_RATING_SHORT"] = {"hit"},
    ["ITEM_MOD_MANA"] = {"mana"},
    ["ITEM_MOD_MANA_SHORT"] = {"mana"},
    ["ITEM_MOD_MANA_REGENERATION"] = {"mana"},
    ["ITEM_MOD_MANA_REGENERATION_SHORT"] = {"mana"},
    ["ITEM_MOD_MASTERY_RATING"] = {"mast","master","mastery"},
    ["ITEM_MOD_MASTERY_RATING_SHORT"] = {"mast","master","mastery"},
    ["ITEM_MOD_MASTERY_RATING_SPELL"] = {"mast","master","mastery"},
    ["ITEM_MOD_MASTERY_RATING_TWO_SPELLS"] = {"mast","master","mastery"},
    ["ITEM_MOD_PARRY_RATING"] = {"parry"},
    ["ITEM_MOD_PARRY_RATING_SHORT"] = {"parry"},
    ["ITEM_MOD_POWER_REGEN0_SHORT"] = {"mana","mp5"},
    ["ITEM_MOD_POWER_REGEN1_SHORT"] = {"rage"},
    ["ITEM_MOD_POWER_REGEN2_SHORT"] = {"focus"},
    ["ITEM_MOD_POWER_REGEN3_SHORT"] = {"energy"},
    ["ITEM_MOD_PVP_POWER"] = {"pvp"},
    ["ITEM_MOD_PVP_POWER_SHORT"] = {"pvp"},
    ["ITEM_MOD_PVP_PRIMARY_STAT_SHORT"] = {"pvp"},
    ["ITEM_MOD_RESILIENCE_RATING"] = {"resil","resilience"},
    ["ITEM_MOD_RESILIENCE_RATING_SHORT"] = {"resil","resilience"},
    ["ITEM_MOD_SPELL_DAMAGE_DONE"] = {"spell","dmg","damage"},
    ["ITEM_MOD_SPELL_DAMAGE_DONE_SHORT"] = {"spell","dmg","damage"},
    ["ITEM_MOD_SPELL_HEALING_DONE"] = {"heal","healing"},
    ["ITEM_MOD_SPELL_HEALING_DONE_SHORT"] = {"heal","healing"},
    ["ITEM_MOD_SPELL_PENETRATION"] = {"spell","penetration"},
    ["ITEM_MOD_SPELL_PENETRATION_SHORT"] = {"spell","penetration"},
    ["ITEM_MOD_SPELL_POWER"] = {"spell","power"},
    ["ITEM_MOD_SPELL_POWER_SHORT"] = {"spell","power"},
    ["ITEM_MOD_VERSATILITY"] = {"vers","versa","versatile","versatility"},
    ["ITEM_MOD_CR_LIFESTEAL_SHORT"] = {"leech"},
}
function Sorted_SearchStatTable(statTable, searchString)
    if statTable then
        searchString = searchString:lower()
        for word in searchString:gmatch("%S+") do
            local wordFound = false
            for statName,v in pairs(statTable) do
                if Sorted_StatSearchStrings[statName] then
                    for k,s in pairs(Sorted_StatSearchStrings[statName]) do
                        if word==s then
                            wordFound = true
                        end
                    end
                end
            end
            if not wordFound then return false end
        end
        return true
    end
    return false
end

function Sorted_GetClassColor(class)
    return (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
end

function S.GetRaceName(raceID) 
    if type(raceID) == "number" then
        return C_CreatureInfo.GetRaceInfo(raceID).raceName
    else
        return raceID
    end
end

local markerIconStrings = {
    "|TInterface\\Addons\\Sorted\\Textures\\Favorite-Icons:20:20:0:0:128:128:0:28:0:28|t",
    "|TInterface\\Addons\\Sorted\\Textures\\Favorite-Icons:20:20:0:0:128:128:28:56:0:28|t",
    "|TInterface\\Addons\\Sorted\\Textures\\Favorite-Icons:20:20:0:0:128:128:56:84:0:28|t",
    "|TInterface\\Addons\\Sorted\\Textures\\Favorite-Icons:20:20:0:0:128:128:84:112:0:28|t",
    "|TInterface\\Addons\\Sorted\\Textures\\Favorite-Icons:20:20:0:0:128:128:0:28:28:56|t",
    "|TInterface\\Addons\\Sorted\\Textures\\Favorite-Icons:20:20:0:0:128:128:28:56:28:56|t",
    "|TInterface\\Addons\\Sorted\\Textures\\Favorite-Icons:20:20:0:0:128:128:56:84:28:56|t",
    "|TInterface\\Addons\\Sorted\\Textures\\Favorite-Icons:20:20:0:0:128:128:84:112:28:56|t"
}
markerIconStrings[0] = Sorted.Localize("SUBFILTER_MARKER_ICON_NONE")
function S.FormatMarkerIcon(iconID)
    if markerIconStrings[iconID] then
        return markerIconStrings[iconID]
    end
    return markerIconStrings[0]
end

local bindTypes = {
    [1] = Sorted.Localize("SUBFILTER_BINDING_ON_PICKUP_SHORT"),
    [2] = Sorted.Localize("SUBFILTER_BINDING_ON_EQUIP_SHORT"),
    [3] = Sorted.Localize("SUBFILTER_BINDING_ON_USE_SHORT"),
    [4] = Sorted.Localize("SUBFILTER_BINDING_ON_PICKUP_SHORT"),
    [9] = Sorted.Localize("SUBFILTER_BINDING_SOULBOUND_SHORT"),
}
local bindColors = {
    [1] = "|cffffaa55",
    [2] = "|cffffee77",
    [3] = "|cffee99bb",
    [4] = "|cffffaa55",

    -- Soulbound
    [5] = "|cff888899",
    [6] = "|cffaa8877",
    [7] = "|cffbbaa66",
    [8] = "|cffaa7799",
    [9] = "|cffaa8877",
}
function Sorted_FormatBindType(bindType, bound)
    if bound then 
        return bindColors[bindType + 5]..bindTypes[9]
    elseif bindType > 0 then
        return bindColors[bindType]..bindTypes[bindType]
    else
        return ""
    end
end

local expansionColors = {
    [0] = "|cffffe517",
    [1] = "|cff95c257",
    [2] = "|cff67baf5",
    [3] = "|cffff9924",
    [4] = "|cff5dc786",
    [5] = "|cffcf6348",
    [6] = "|cffd4f235",
    [7] = "|cffa9adc7",
    [8] = "|cfffae6cf",
}
local expansionStrings = {
    [0] = Sorted.Localize("SUBFILTER_EXPANSION_WOW_SHORT"),
    [1] = Sorted.Localize("SUBFILTER_EXPANSION_TBC_SHORT"),
    [2] = Sorted.Localize("SUBFILTER_EXPANSION_WOTLK_SHORT"),
    [3] = Sorted.Localize("SUBFILTER_EXPANSION_CATA_SHORT"),
    [4] = Sorted.Localize("SUBFILTER_EXPANSION_MOP_SHORT"),
    [5] = Sorted.Localize("SUBFILTER_EXPANSION_WOD_SHORT"),
    [6] = Sorted.Localize("SUBFILTER_EXPANSION_LEGION_SHORT"),
    [7] = Sorted.Localize("SUBFILTER_EXPANSION_BFA_SHORT"),
    [8] = Sorted.Localize("SUBFILTER_EXPANSION_SHADOW_SHORT"),
}
function Sorted_ExpacColor(expacID)
    return expansionColors[expacID]
end
function Sorted_FormatExpac(expacID, width, height)
    if expansionStrings[expacID] then
        local x = (expacID % 4) * 64
        local y = math.floor(expacID / 4) * 32
        if width and height then
            return string.format("|TInterface\\Addons\\Sorted\\Textures\\Expac-Icons:%d:%d:0:0:256:256:%d:%d:%d:%d|t", height, width, x, x+64, y, y+32)
        else
            return string.format("|TInterface\\Addons\\Sorted\\Textures\\Expac-Icons:%d:%d:0:0:256:256:%d:%d:%d:%d|t", 32, 64, x, x+64, y, y+32)
        end
    else
        return ""
    end
end

function Sorted_FormatFaction(faction)
    if faction == "Alliance" then
        return "|TInterface\\FriendsFrame\\PlusManz-Alliance:20:20|t"
    elseif faction == "Horde" then
        return "|TInterface\\FriendsFrame\\PlusManz-Horde:20:20|t"
    else
        return "|TInterface\\Addons\\Sorted\\Textures\\Pandaren-Logo:20:20|t"
    end
end

function Sorted_FormatTime(time)
    if time > 31536000 then
        if time > 63072000 then
            return math.floor(time / 31536000).." "..Sorted.Localize("SUBFILTER_TIME_YEARS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_YEAR_SHORT")
        end

    elseif time >= 2419200 then
        if time >= 4838400 then
            return math.floor(time / 2419200).." "..Sorted.Localize("SUBFILTER_TIME_MONTHS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_MONTH_SHORT")
        end

    elseif time >= 604800 then
        if time >= 1209600 then
            return math.floor(time / 604800).." "..Sorted.Localize("SUBFILTER_TIME_WEEKS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_WEEK_SHORT")
        end

    elseif time >= 86400 then
        if time >= 172800 then
            return math.floor(time / 86400).." "..Sorted.Localize("SUBFILTER_TIME_DAYS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_DAY_SHORT")
        end

    elseif time >= 3600 then
        if time >= 7200 then
            return math.floor(time / 3600).." "..Sorted.Localize("SUBFILTER_TIME_HOURS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_HOUR_SHORT")
        end

    elseif time >= 60 then
        if time >= 120 then
            return math.floor(time / 60).." "..Sorted.Localize("SUBFILTER_TIME_MINUTES_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_MINUTE_SHORT")
        end

    elseif time >= 0 then
        if time == 1 then
            return "1 "..Sorted.Localize("SUBFILTER_TIME_SECOND_SHORT")
        else
            return time.." "..Sorted.Localize("SUBFILTER_TIME_SECONDS_SHORT")
        end
    else
        return ""
    end
end

function Sorted_VendorGreys()
    if MerchantFrame:IsVisible() then
        for k,bagID in pairs(Sorted_ContainersOfType("BAGS")) do
            for slotID = 1,36 do
                local itemData = Sorted_GetContainerItemInfo(bagID, slotID)
                if (Sorted_GetTrash(itemData) <= 1) and (not itemData.noValue) then
                    UseContainerItem(bagID, slotID)
                end
            end
        end
    end
end

function Sorted_ItemKey(itemLink)
    if string.find(itemLink, "item:138019:") then
        return "138019"
    elseif string.find(itemLink, "|Hitem") then
        local a,b = string.match(itemLink, "|Hitem:(%d*:)[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:(.-)|h")
        return a..b
    else
        local a = string.match(itemLink, "|H(.-)|h")
        return a
    end
end

function Sorted_FormatValueString(value)
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

function Sorted_GetValueColor(value)
    if value < 100 then return {r=0.6, g=0.35, b=0.15}
    elseif value < 10000 then return {r=0.6, g=0.6, b=0.6}
    elseif value < 10000000 then return {r=0.8, g=0.6, b=0.1}
    elseif value < 10000000000 then return {r=1, g=0.9, b=0.25}
    else return {r=1, g=0.6, b=0.1}
    end
end

function S.GetItemTooltip(bag, slot)
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

function S.GetItemTooltipString(bag, slot, omitFirstLine)
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

function S.GetItemTooltipLine(bag, slot, line)
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

-- TABLE UTILITIES

-- Prints a table in a neat format
function Sorted.PrintTable(t,indent, key)
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
            Sorted.PrintTable(v,indent+1,k)
        end
        print(s.."},")
    else
        if key then print(s.."["..key.."] = "..tostring(t))
        else print(s..tostring(t)) end
    end
end

-- Copies contents of t1 into t2
function Sorted_CopyTable(t1, t2)
    for key, value in pairs(t1) do
        if type(value) == "table" then
            t2[key] = {}
            Sorted_CopyTable(value, t2[key])
        else
            t2[key] = value
        end
    end
end

-- Deletes empty inner tables
function Sorted_CleanTable(t)
    if type(t) == "table" then
        local empty = true
        for k, v in pairs(t) do
            if Sorted_CleanTable(v) then
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




-- Dealing with other bag frames
local killableFrames = {}
local function MakeFrameKillable(frame)
    if not frame.killableBySorted then
        frame.originalShow = frame.Show
        frame.Show = function(self)
            if not self.killedBySorted then
                self:originalShow()
            end
        end
        frame.originalOnShow = frame:GetScript("OnShow")
        if frame.originalOnShow then
            frame:SetScript("OnShow", function(self, ...) 
                if self.killedBySorted then
                    self:Hide()
                else
                    self.originalOnShow(self, ...)
                end
            end)
        end
        --[[frame.originalOnHide = frame:GetScript("OnHide")
        if frame.originalOnHide then
            frame:SetScript("OnHide", function(self, ...) 
                if not self.killedBySorted then
                    self.originalOnHide(self, ...)
                end
            end)
        end]]
        frame.originalOnEvent = frame:GetScript("OnEvent")
        if frame.originalOnEvent then
            frame:SetScript("OnEvent", function(self, ...) 
                if not self.killedBySorted then
                    self.originalOnEvent(self, ...)
                end
            end)
        end
        frame.killableBySorted = true
        table.insert(killableFrames, frame)
    end
end

local function KillFrame(frame)
    frame.killedBySorted = true
end

local function ResurrectFrame(frame)
    frame.killedBySorted = false
end


function Sorted_MakeBlizzBagsKillable()
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

function Sorted_KillBlizzBags()
    for _, frame in pairs(killableFrames) do
        KillFrame(frame)
    end
    CloseAllBags()
    OpenAllBags()
end
function Sorted_ResurrectBlizzBags()
    for _, frame in pairs(killableFrames) do
        ResurrectFrame(frame)
    end
    CloseAllBags()
    OpenAllBags()
end

local function CreateToggleButton(parent)
    local button = CreateFrame("Button", parent:GetName().."SortedButton", parent, "UIPanelButtonTemplate")
    button.text = button:CreateTexture()
    button.text:SetPoint("CENTER", 4, -1)
    button.text:SetSize(60, 20)
    button.text:SetTexCoord(0, 0.75, 0, 1)
    button.text:SetTexture("Interface\\Addons\\Sorted\\Textures\\title-no-bg")
    button:HookScript("OnMouseDown", function(self)
        self.text:SetPoint("CENTER", 3, -2)
        self.text:SetAlpha(0.75)
    end)
    button:HookScript("OnMouseUp", function(self)
        self.text:SetPoint("CENTER", 4, -1)
        self.text:SetAlpha(1)
    end)
    button:HookScript("OnEnter", function(self)
        SortedTooltip.CreateLocalized(self, "ANCHOR_RIGHT", "TOOLTIP_TOGGLE_SORTED")
    end)
    button:HookScript("OnLeave", function(self)
        SortedTooltip.Cancel()
    end)
    button:HookScript("OnClick", function(self)
        Sorted_ToggleBlizzardBags()
    end)
    return button
end

function Sorted_InitialiseBlizzToggleButton()
    Sorted_MakeBlizzBagsKillable()

    local cf1 = _G["ContainerFrame1"]
    cf1.ClickableTitleFrame:Hide()
    cf1.SortedButton = CreateToggleButton(cf1)
    cf1.SortedButton:SetPoint("RIGHT", _G["ContainerFrame1CloseButton"], "LEFT", 4, 0)
    cf1.SortedButton:SetPoint("TOPLEFT", _G["ContainerFrame1PortraitButton"], "TOPRIGHT", -4, -1)
    cf1.SortedButton:SetHeight(20)

    if _G["ElvUI_ContainerFrame"] then
        local f = _G["ElvUI_ContainerFrame"]
        f.SortedButton = CreateToggleButton(f)
        f.SortedButton:SetPoint("TOPRIGHT", -48, -2)
        f.SortedButton:SetSize(64, 22)
        if S.DoSkinning() then
            S.AS:SkinButton(f.SortedButton)
            f.SortedButton.text:SetTexture("Interface\\Addons\\Sorted\\Textures\\Title-Flat")
        end
    end
end

local blizzBags = false
function Sorted_ToggleBlizzardBags()
    if blizzBags then
        blizzBags = false
        Sorted_KillBlizzBags()
        SortedFrame.killed = false
        Sorted_OpenBags()
    else
        blizzBags = true
        Sorted_ResurrectBlizzBags()
        Sorted_CloseBags()
        SortedFrame.killed = true
    end
end