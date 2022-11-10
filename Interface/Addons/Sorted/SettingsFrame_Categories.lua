local _, S = ...
local pairs, ipairs, string, type, time = pairs, ipairs, string, type, time

local f = S.categoriesSettingsFrame


-- Title
f.title = f:CreateFontString(nil, "OVERLAY", "SortedFont")
f.title:SetTextColor(S.Utils.GetButtonTextColor():GetRGB())
f.title:SetPoint("TOPLEFT", f, 20, -16)
f.title:SetText(S.Localize("GROUPING_CATEGORY"))
f.title:SetTextScale(1.2)


-- Category buttons
f.selectedCategory = 1
f.categoryButtons = {}

local dragging = nil

local function CategoryButtonOnMouseDown(self)
    dragging = self:GetID()
end
local function CategoryButtonOnMouseUp(self)
    dragging = nil
end
local function CategoryButtonOnEnter(self)
    if dragging then
        local data = S.Settings.Get("categories2")
        local category1 = data[dragging]
        local category2 = data[self:GetID()]
        data[self:GetID()] = category1
        data[dragging] = category2
        dragging = self:GetID()
        S.Utils.TriggerEvent("SettingChanged-categories2")
    end
    self.icon:SetDesaturated(false)
    if self.name then
        S.Tooltip.Schedule(function()
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self.name)
            GameTooltip:Show()
        end)
    end
end
local function CategoryButtonOnLeave(self)
    if not self:GetChecked() then
        self.icon:SetDesaturated(true)
    end
    S.Tooltip.Cancel()
end
local function CategoryButtonOnClick(self)
    f.selectedCategory = self:GetID()
    for _, button in pairs(f.categoryButtons) do
        local id = button:GetID()
        if id == f.selectedCategory then
            button:SetChecked(true)
            button.icon:SetDesaturated(false)
        else
            button:SetChecked(false)
            button.icon:SetDesaturated(true)
        end
    end
    S.Utils.TriggerEvent("SettingsFrame-CategorySelected")
end

for i = 1, S.Utils.GetMaxNumCategories() do
    local b = S.FrameTools.CreateCircleButton("CheckButton", f, false, "", true)
    b:SetID(i)
    b.icon:SetDesaturated(true)
    b:HookScript("OnMouseDown", CategoryButtonOnMouseDown)
    b:HookScript("OnMouseUp", CategoryButtonOnMouseUp)
    b:HookScript("OnEnter", CategoryButtonOnEnter)
    b:HookScript("OnLeave", CategoryButtonOnLeave)
    b:SetScript("OnClick", CategoryButtonOnClick)
    b:SetSize(32, 32)
    local x = (i - 1) % 18 * 31
    local y = 31 * (math.floor((i - 1) / 18) + 1)
    b:SetPoint("TOPLEFT", x + 44, -y - 4)
    table.insert(f.categoryButtons, b)
    b:SetScript("OnShow", function(self)
        self:SetChecked(self:GetID() == f.selectedCategory)
    end)
end

function f:UpdateCategoryButtons()
    local data = S.Settings.Get("categories2")
    if f.selectedCategory > #data then
        f.selectedCategory = 1
    end
    for _, button in pairs(self.categoryButtons) do
        local id = button:GetID()
        if data[id] then
            button:SetAlpha(1)
            button:Enable()
            button.name = data[id].name
            button:SetIconTexture(S.Category.GetIconTexture(id))
            if f.selectedCategory == id then
                CategoryButtonOnClick(button)
            end
        else
            button:SetAlpha(0.2)
            button:Disable()
            button:SetIconTexture("")
        end
    end
end
S.Utils.RunOnEvent(f, "SettingChanged-categories2", f.UpdateCategoryButtons)
f:HookScript("OnShow", f.UpdateCategoryButtons)

-- Add category button
f.addButton = CreateFrame("BUTTON", nil, f)
f.addButton:SetPoint("TOPLEFT", 10, -36)
f.addButton:SetSize(30, 30)
f.addButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Expand-Button")
f.addButton:GetNormalTexture():SetTexCoord(0, 0.375, 0, 0.375)
f.addButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Close-Button-Highlight")
f.addButton:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\Expand-Button")
f.addButton:GetPushedTexture():SetTexCoord(0.375, 0.75, 0, 0.375)
function f.addButton:Update()
    local data = S.Settings.Get("categories2")
    if #data >= S.Utils.GetMaxNumCategories() then
        self:Disable()
        self:GetNormalTexture():SetDesaturated(true)
    else
        self:Enable()
        self:GetNormalTexture():SetDesaturated(false)
    end
end
S.Utils.RunOnEvent(f.addButton, "SettingChanged-categories2", f.addButton.Update)

f.addButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:ClearLines()
    GameTooltip:AddLine(S.Localize("CONFIG_CATEGORIES_ADD"))
    GameTooltip:Show()
end)
f.addButton:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)
f.addButton:SetScript("OnClick", function(self)
    S.Category.AddNew()
end)


-- Delete category button
f.deleteButton = CreateFrame("BUTTON", nil, f)
f.deleteButton:SetPoint("TOPLEFT", 10, -66)
f.deleteButton:SetSize(30, 30)
f.deleteButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Expand-Button")
f.deleteButton:GetNormalTexture():SetTexCoord(0, 0.375, 0.375, 0.75)
f.deleteButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Close-Button-Highlight")
f.deleteButton:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\Expand-Button")
f.deleteButton:GetPushedTexture():SetTexCoord(0.375, 0.75, 0.375, 0.75)
f.deleteButton:SetScript("OnClick", function(self)
    if f.selectedCategory > 1 then
        f.selectedCategory = f.selectedCategory - 1
        S.Category.Delete(f.selectedCategory + 1)
    elseif #S.Settings.Get("categories2") > 1 then
        S.Category.Delete(f.selectedCategory)
    end
end)
f.deleteButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:ClearLines()
    GameTooltip:AddLine(DELETE.. " \""..S.Category.GetName(f.selectedCategory).."\"")
    GameTooltip:Show()
end)
f.deleteButton:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)


-- Spacer
f.spacer = f:CreateTexture()
f.spacer:SetPoint("LEFT", 2, 0)
f.spacer:SetPoint("RIGHT")
f.spacer:SetHeight(16)
f.spacer:SetPoint("TOP", 0, -100)
f.spacer:SetTexture("Interface\\Addons\\Sorted\\Textures\\Spacer")
f.spacer:SetTexCoord(0.1, 0.9, 0, 1)


-- Name
f.nameEditBox = S.FrameTools.CreateEditBox(f, S.Localize("CONFIG_CATEGORIES_NAME"), S.Localize("CONFIG_PROFILES_CHANGE_NAME_INSTRUCTION"))
f.nameEditBox:SetPoint("TOPLEFT", 24, -112)
f.nameEditBox.editBox:SetSize(320, 16)
function f.nameEditBox:Update()
    self.editBox:SetText(S.Category.GetName(f.selectedCategory))
end
S.Utils.RunOnEvent(f.nameEditBox, "SettingsFrame-CategorySelected", f.nameEditBox.Update)
S.Utils.RunOnEvent(f.nameEditBox, "SettingChanged-categories2", f.nameEditBox.Update)
f.nameEditBox:HookScript("OnShow", f.nameEditBox.Update)
f.nameEditBox.editBox:HookScript("OnTextChanged", function(self)
    S.Category.SetName(f.selectedCategory, self:GetText())
end)
f.nameEditBox.editBox:HookScript("OnEnterPressed", f.nameEditBox.editBox.ClearFocus)
f.nameEditBox.editBox:HookScript("OnEscapePressed", f.nameEditBox.editBox.ClearFocus)
f.nameEditBox.editBox:SetAutoFocus(false)

-- Icon
f.iconText = f:CreateFontString(nil, "OVERLAY", "SortedFont")
f.iconText:SetText(S.Localize("CONFIG_CATEGORIES_ICON"))
f.iconText:SetPoint("TOPLEFT", 384, -128)
f.iconText:SetTextColor(S.Utils.GetButtonTextColor():GetRGB())
f.iconText:SetTextScale(1.2)
f.icon = S.FrameTools.CreateCircleButton("Button", f, true, "", true)
f.icon:SetPoint("TOPLEFT", 384, -144)
f.icon:SetSize(48, 48)
function f.icon:Update()
    self:SetIconTexture(S.Category.GetIconTexture(f.selectedCategory))
end
S.Utils.RunOnEvent(f.icon, "SettingsFrame-CategorySelected", f.icon.Update)
S.Utils.RunOnEvent(f.icon, "SettingChanged-categories2", f.icon.Update)
f.icon:SetScript("OnShow", f.icon.Update)
local function OnIconPicked(icon)
    S.Category.SetIcon(f.selectedCategory, icon)
end
f.icon:SetScript("OnClick", function(self, button, down)
    S.IconPicker.Show(self, OnIconPicked)
end)


-- Spacer
f.spacer = f:CreateTexture()
f.spacer:SetPoint("LEFT", 2, 0)
f.spacer:SetPoint("RIGHT")
f.spacer:SetHeight(16)
f.spacer:SetPoint("TOP", 0, -200)
f.spacer:SetTexture("Interface\\Addons\\Sorted\\Textures\\Spacer")
f.spacer:SetTexCoord(0.1, 0.9, 0, 1)



-- ATTRIBUTES

-- Attributes dropdown
f.selectedAttribute = "TYPE"
local function OnAttributesEntryClick(self)
    f.selectedAttribute = self.data1
    S.Utils.TriggerEvent("SettingsFrame-CategoryAttributeSelected")
    S.Dropdown.Hide()
end
local function BuildAttributesDropdown()
    local data = S.Settings.Get("categories2")[f.selectedCategory]
    for k, v in pairs(S.Category.attributesTable) do
        S.Dropdown.AddEntry(v.name, OnAttributesEntryClick, k)
        S.Dropdown.AddRadioButton(data.attributes[k])
    end
end
f.attributes = S.FrameTools.CreateDropdown(f, STAT_CATEGORY_ATTRIBUTES, BuildAttributesDropdown)
f.attributes:SetPoint("TOP", 0, -216)
function f.attributes:Update()
    self.button.text:SetText(S.Category.attributesTable[f.selectedAttribute].name)
end
f.attributes:SetScript("OnShow", f.attributes.Update)
S.Utils.RunOnEvent(f.attributes, "SettingsFrame-CategoryAttributeSelected", f.attributes.Update)



-- ATTRIBUTE SETTINGS
-- Make one frame to contain all the attribute settings
f.attributesFrame = CreateFrame("FRAME", nil, f)
local af = f.attributesFrame
af:SetPoint("TOPLEFT", 0, -300)
af:SetPoint("BOTTOMRIGHT")


-- Values (checkbuttons in a dropdown menu)
local function OnValuesEntryClick(self)
    local data = S.Category.ToggleAttributeValue(f.selectedCategory, f.selectedAttribute, self.data1)
end
local function SortValuesTable(v1, v2)
    return v1.key < v2.key
end
local function BuildValuesDropdown(data1)
    local data = S.Category.GetAttribute(f.selectedCategory, f.selectedAttribute)
    local valuesSorted = {}
    for k,v in pairs(data1) do
        table.insert(valuesSorted, {
            ["key"] = k, 
            ["value"] = v
        })
    end
    table.sort(valuesSorted, SortValuesTable)

    local heading = nil
    for i,v in ipairs(valuesSorted) do
        if v.value.heading ~= heading then
            S.Dropdown.AddEntry(v.value.heading, nil, nil, nil, S.Utils.GetButtonTextColor())
            heading = v.value.heading
        end
        S.Dropdown.AddEntry(v.value.name, OnValuesEntryClick, v.key)
        if data then
            S.Dropdown.AddCheckbox(data[v.key])
        else
            S.Dropdown.AddCheckbox(false)
        end
    end
end
local function CreateValues(parent, key, name, values)
    local f = S.FrameTools.CreateDropdown(parent, name, BuildValuesDropdown, values)
    f:SetPoint("TOP", 0, -64)
    f:SetWidth(384)
    f.button.text:SetText(S.Localize("DROPDOWN_MENU_INSTRUCTION_SELECT"))
    return f
end

-- Strings (list of edit boxes)
local function OnStringsEditBoxTextChanged(self)
    S.Category.SetAttributeString(f.selectedCategory, f.selectedAttribute, self.index, self:GetText())
    if #self:GetText() > 0 then
        self.parent:GetStringsEditBox(self.index + 1)
    end
    self.parent:UpdateStrings()
end
local function CreateStringsEditBox(self, index)
    self.editBoxes[index] = S.FrameTools.CreateEditBox(self, "", S.Localize("FILTER_NAME_SEARCH"))
    self.editBoxes[index]:SetPoint("TOPLEFT", 48, -index * 40 + 80)
    self.editBoxes[index].editBox:SetWidth(480)
    self.editBoxes[index].editBox:HookScript("OnTextChanged", OnStringsEditBoxTextChanged)
    self.editBoxes[index].editBox.parent = self
    self.editBoxes[index].editBox.index = index
end
local function GetStringsEditBox(self, index)
    if not self.editBoxes[index] then
        CreateStringsEditBox(self, index)
    end
    self.editBoxes[index]:Show()
    return self.editBoxes[index]
end
local function UpdateStrings(self)
    local data = S.Category.GetAttribute(f.selectedCategory, f.selectedAttribute)
    if data then
        local i = 1
        while i <= #data do
            GetStringsEditBox(self, i).editBox:SetText(data[i])
            i = i + 1
        end
        -- Add one more empty edit box
        GetStringsEditBox(self, i).editBox:SetText("")
        self.parent.scrollBar:SetMinMaxValues(0, i * 32 - 32)
        i = i + 1
        while i <= #self.editBoxes do
            self.editBoxes[i]:Hide()
            i = i + 1
        end
    else
        for i,v in ipairs(self.editBoxes) do
            v:SetShown(i == 1)
            v.editBox:SetText("")
            self.parent.scrollBar:SetMinMaxValues(0, 0)
        end
    end
end
local function CreateStrings(parent, key, name)
    local f = CreateFrame("SCROLLFRAME", nil, parent)
    f:SetAllPoints()

    f.scrollBar = CreateFrame("SLIDER", "", f, "MinimalScrollBarTemplate")
    f.scrollBar.trackBG:Hide()
    f.scrollBar:SetPoint("TOPRIGHT")
    f.scrollBar:SetPoint("BOTTOM", 0, 16)
    f.scrollBar:SetMinMaxValues(0, 200)
    f.scrollBar:SetValue(0)
    f.scrollBar.Update = function(self)
        f:SetVerticalScroll(f.scrollBar:GetValue())
    end
    f.scrollBar:SetScript("OnValueChanged", f.scrollBar.Update)
    f:SetScript("OnMouseWheel", function(self, delta)
        f.scrollBar:SetValue(f.scrollBar:GetValue() - delta * 20)
        f.scrollBar:Update()
    end)

    f.scrollChild = CreateFrame("FRAME", nil, f)
    f.scrollChild:SetSize(f:GetWidth(), 200)
    f:SetScrollChild(f.scrollChild)

    f.scrollChild.editBoxes = {}
    CreateStringsEditBox(f.scrollChild, 1)

    f.scrollChild.UpdateStrings = UpdateStrings
    f.scrollChild.GetStringsEditBox = GetStringsEditBox
    f.scrollChild.parent = f
    f.scrollChild:SetScript("OnShow", UpdateStrings)
    S.Utils.RunOnEvent(f.scrollChild, "SettingsFrame-CategorySelected", function(self)
        if S.categoriesSettingsFrame.selectedAttribute == key then
            UpdateStrings(self)
        end
    end)
end


-- Build a settings frame for each attribute
local attributeFrames = {}
for k, v in pairs(S.Category.attributesTable) do
    local frame = CreateFrame("FRAME", nil, f.attributesFrame)
    frame:SetAllPoints()
    attributeFrames[k] = frame

    if v.type == "VALUES" then
        CreateValues(frame, k, v.name, v.values)
    elseif v.type == "STRINGS" then
        CreateStrings(frame, k, v.name)
    end

    frame:Hide()
end
local function UpdateAttributeFrames()
    for k,v in pairs(attributeFrames) do
        if f.selectedAttribute == k then
            v:Show()
        else
            v:Hide()
        end
    end
end
S.Utils.RunOnEvent(nil, "SettingsFrame-CategoryAttributeSelected", UpdateAttributeFrames)
f.attributesFrame:SetScript("OnShow", UpdateAttributeFrames)