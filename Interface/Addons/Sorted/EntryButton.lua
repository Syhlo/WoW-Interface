local _, S = ...
local pairs, ipairs, string, type, time = pairs, ipairs, string, type, time

local function UpdateEntry(self)
    local data = self:GetData()
    data.color1 = S.Utils.GetItemQualityColor(data.quality)
    data.color2 = S.Utils.GetItemQualityHighlightColor(data.quality)
    data.tinted = S.Utils.GetItemQualityGreyedColor(data.quality)
    data.filtered = self.filtered
    local gridView = self.list.gridView
    for column, element in pairs(self.columnElements) do
        if not gridView then
            self.list.columns[column].UpdateElement(element, data)
        else
            if column == "NAME" or column == "QUANTITY" or column == "ICON" then
                self.list.columns[column].UpdateElement(element, data)
            end
        end
    end
end

local function UpdateIcons(self, iconSize, borderThickness, iconShape, iconBorders)
    for column, element in pairs(self.columnElements) do
        local func = self.list.columns[column].UpdateIcon
        if func then
            func(element, iconSize, borderThickness, iconShape, iconBorders)
        end
    end
end

local function SetFiltered(self, filtered)

end

local function GetFavorited(self)
    return 0
end
local function ToggleFavorited(self)
    
end
local function SetFavorited(self, value)
    
end
local function ClearFavorited(self)
    
end

local function Button_FollowMouseWithHighlight(self, elapsed)
    local parent = self.parent
    --self.highlight:ClearAllPoints()
    local x,y = GetCursorPosition()
    x = x / self:GetEffectiveScale()
    y = y / self:GetEffectiveScale()
    local x2,y2 = self:GetCenter()
    parent.highlight:SetWidth(self:GetWidth() * 3)
    parent.highlight:SetPoint("LEFT", self, "CENTER", (x - x2) - parent.highlight:GetWidth() / 2, y)
    --self.highlight:SetPoint("TOP", UIParent, "BOTTOMLEFT", 0, y2 + self:GetHeight() / 2)
    --self.highlight:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", 0, y2 - self:GetHeight() / 2)
end

local function AddFrameToColumn(self, frame, column)
    self.columnElements[column] = frame
    frame:SetPoint("TOP")
    frame:SetPoint("BOTTOM")
    frame:SetPoint("LEFT", self.list.columnHeadings[column])
    frame:SetPoint("RIGHT", self.list.columnHeadings[column])
end
local function DetachFramesFromColumns(self)
    for column, frame in pairs(self.columnElements) do
        frame:ClearAllPoints()
        frame:Hide()
    end
end
local function AttachFramesToColumns(self)
    for column, frame in pairs(self.columnElements) do
        frame:SetPoint("TOP")
        frame:SetPoint("BOTTOM")
        frame:SetPoint("LEFT", self.list.columnHeadings[column])
        frame:SetPoint("RIGHT", self.list.columnHeadings[column])
    end
end
local function AddColumn(self, columnKey)
    local f = CreateFrame("FRAME", "", self)
    f.parent = self
    self.list.columns[columnKey].CreateElement(f)
    self:AddFrameToColumn(f, columnKey)
end

local function OnIconBorderSettingChanged(self, event, value)
    self.iconBorder:SetShown(value > 0)
end
local function OnIconBorderThicknessSettingChanged(self, event)
    local size
    if self.list.gridView then
        size = S.Settings.Get("iconSizeGrid") + S.Settings.Get("iconBorderThicknessGrid")
    else
        size = S.Settings.Get("iconSize") + S.Settings.Get("iconBorderThickness")
    end
    self.iconBorder:SetSize(size, size)
end

function S.CreateListEntry(list, template)
    --local parent = CreateFrame("FRAME", nil, list.listFrame) -- For item entry buttons to function with Blizzard's code untainted, there must be a parent frame to hold the bag ID
    --parent:SetAllPoints()
    local self = CreateFrame("FRAME", nil, list.listFrame--[[parent, template]])

    self.button = CreateFrame("BUTTON", nil, self, template)
    self.button:ClearAllPoints()
    self.button.parent = self

    if template then -- Only want to inherit methods, not any textures or children
        for k,v in pairs(self.button) do
            if type(v) == "table" and v.Hide then
                v:Hide()
                v:ClearAllPoints()
            end
        end
        if self.button:GetNormalTexture() then
            self.button:SetNormalTexture("")
        end
    end
    self:ClearAllPoints()
    self.parentFrame = self:GetParent()

    self.data = {}
    self.list = list
    self.columnElements = {}
    self.AddColumn = AddColumn
    self.Update = UpdateEntry
    self.UpdateIcons = UpdateIcons
    self.SetFiltered = SetFiltered
    self.GetFavorited = GetFavorited
    self.ToggleFavorited = ToggleFavorited
    self.ClearFavorited = ClearFavorited
    self.SetFavorited = SetFavorited
    self.AddFrameToColumn = AddFrameToColumn
    self.DetachFramesFromColumns = DetachFramesFromColumns
    self.AttachFramesToColumns = AttachFramesToColumns
    --self.OnIconChanged = OnIconChanged

    self.highlight = self.button:CreateTexture(nil, "OVERLAY")
    self.highlight:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
    self.highlight:SetBlendMode("ADD")
    self.highlight:SetPoint("TOP")
    self.highlight:SetPoint("BOTTOM")
    self.highlight:Hide()
    --self:GetHighlightTexture():SetAlpha(0.8)
    self.button:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
    self.button:GetPushedTexture():SetTexCoord(0.5, 0.6, 0, 1)
    self.button:GetPushedTexture():SetBlendMode("ADD")
    self:SetPoint("LEFT")
    self:SetPoint("RIGHT")
    self:SetHeight(20)
    self.button:SetAllPoints()
    self.button:Show()

    -- On mouse enter/leave, start/stop the mouse-following highlight texture
    -- Also zoom the icon and move the name
    self.button:SetScript("OnEnter", function(self)
        local parent = self.parent
        if not parent.list.gridView then
            local favorited = parent:GetFavorited()
            if not favorited or favorited == 0 then
                local favoriteButtonTexSize = 0.21875
                parent.columnElements["FAVORITES"].favoriteButton.backdrop:SetTexCoord(0,favoriteButtonTexSize,favoriteButtonTexSize*2,favoriteButtonTexSize*3)
            end
            parent.highlight:Show()
            self:SetScript("OnUpdate", Button_FollowMouseWithHighlight)
        end
        parent.mouseEntered = true

        -- Zoom icon and shift name to the right
        if not parent.filtered then
            local icon = parent.columnElements["ICON"]
            local name = parent.columnElements["NAME"]

            icon:SetFrameLevel(parent:GetFrameLevel() + 5)

            local size, extraSize, thickness
            if parent.list.gridView then
                size = S.Settings.Get("iconSizeGrid")
                extraSize = S.Settings.Get("iconSizeGrid") * 0.5
                thickness = S.Settings.Get("iconBorderThicknessGrid")
            else
                size = S.Settings.Get("iconSize")
                extraSize = S.Settings.Get("iconSize") * 0.5
                thickness = S.Settings.Get("iconBorderThickness")
            end
            size = size + extraSize
            icon.icon:SetSize(size, size)
            icon.iconMask:SetSize(size, size)
            icon.iconBorder:Show()
            icon.iconBorder:SetSize(size + thickness * 1.5, size + thickness * 1.5)
            icon.iconBorder:SetVertexColor(parent.data.color2:GetRGB())
            name.nameString:SetPoint("LEFT", 2 + extraSize / 2, 0)
            name.nameString:SetTextColor(parent.data.color2:GetRGB())
        end
    end)
    self.button:HookScript("OnLeave", function(self)
        local parent = self.parent
        if not parent.list.gridView then
            parent.columnElements["FAVORITES"].favoriteButton.backdrop:SetTexCoord(1,1,1,1)
        end
        parent.highlight:Hide()
        self:SetScript("OnUpdate", nil)
        parent.mouseEntered = false

        -- Reset icon and name
        local icon = parent.columnElements["ICON"]
        local name = parent.columnElements["NAME"]

        icon:SetFrameLevel(self:GetFrameLevel() + 1)
        local size, thickness, iconBorders
        if parent.list.gridView then
            size = S.Settings.Get("iconSizeGrid")
            thickness = S.Settings.Get("iconBorderThicknessGrid")
            iconBorders = S.Settings.Get("iconBordersGrid")
        else
            size = S.Settings.Get("iconSize")
            thickness = S.Settings.Get("iconBorderThickness")
            iconBorders = S.Settings.Get("iconBorders")
        end
        icon.icon:SetSize(size, size)
        icon.iconMask:SetSize(size, size)
        icon.iconBorder:SetShown(S.Settings.Get("iconBorders") == 1)
        icon.iconBorder:SetSize(size + thickness, size + thickness)
        name.nameString:SetPoint("LEFT", 2, 0)
        if not parent.filtered then
            icon.iconBorder:SetVertexColor(parent.data.color1:GetRGB())
            name.nameString:SetTextColor(parent.data.color1:GetRGB())
        end
    end)

    return self
end