local _, S = ...
local pairs, ipairs, string, type, time = pairs, ipairs, string, type, time



local f = CreateFrame("FRAME", "SortedSettingsProfilesFrame", UIParent)
table.insert(UISpecialFrames, "SortedSettingsProfilesFrame")
S.settingsProfilesFrame = f
f:SetSize(384, 256)
f:SetPoint("CENTER")
f:SetClampedToScreen(true)
f:EnableMouse()
f:SetFrameStrata("HIGH")
f:SetFrameLevel(632)
S.FrameTools.AddOuterShadow(f, 100)
S.FrameTools.AddSortedBackdrop(f)
f.closeButton = S.FrameTools.CreateCloseButton(f)
f.closeButton:SetSize(24, 24)
f.closeButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\redbutton2x-Clean")
f.closeButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\redbutton2x-Clean")
f.closeButton:GetHighlightTexture():SetTexCoord(0.1484375, 0.296875, 0, 0.3125)
f.closeButton:GetHighlightTexture():SetAlpha(0.6)
f.closeButton:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\redbutton2x-Clean")
f:SetScript("OnMouseDown", function(self) end) -- Prevent click-through

f.text1 = f:CreateFontString(nil, "OVERLAY", "SortedFont")
f.text1:SetText(string.format(S.Localize("PROFILE_SELECTION_HEADER"), UnitName("player")))
f.text1:SetTextColor(S.Utils.GetButtonTextColor():GetRGB())
f.text1:SetTextScale(1.4)
f.text1:SetPoint("TOP", 0, -32)

f.text2 = f:CreateFontString(nil, "OVERLAY", "SortedFont")
f.text2:SetText(string.format(S.Localize("PROFILE_SELECTION_CHOOSE_EXISTING"), UnitName("player")))
f.text2:SetTextColor(S.Utils.GetButtonTextColor():GetRGB())
f.text2:SetTextScale(1.2)
f.text2:SetPoint("TOPRIGHT", f, "TOP", 72, -88)

f.dropdownButton = CreateFrame("BUTTON", nil, f)
f.dropdownButton:SetSize(20, 20)
f.dropdownButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Dropdown-Button")
f.dropdownButton:GetNormalTexture():SetDesaturated(true)
f.dropdownButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Dropdown-Button")
f.dropdownButton:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\Dropdown-Button-Pushed")
f.dropdownButton:SetPoint("LEFT", f.text2, "RIGHT", 4, 1)
local function OnDropdownEntryClick(self)
    S.Settings.SetProfile(self.data1)
    S.settingsProfilesFrame:Hide()
    S.settingsFrame:Show()
end
f.dropdownButton:SetScript("OnClick", function(self)
    S.Dropdown.Reset()
    for key, profile in pairs(Sorted_SettingsProfiles) do
        S.Dropdown.AddEntry(profile.profileName, OnDropdownEntryClick, key, profile)
    end
    S.Dropdown.Show(f.dropdownButton, "TOPRIGHT", "BOTTOM")
end)


f.text3 = f:CreateFontString(nil, "OVERLAY", "SortedFont")
f.text3:SetText(string.format(S.Localize("PROFILE_SELECTION_CREATE_NEW"), UnitName("player")))
f.text3:SetTextColor(S.Utils.GetButtonTextColor():GetRGB())
f.text3:SetTextScale(1.2)
f.text3:SetPoint("TOPLEFT", 32, -152)

f.editBox = CreateFrame("EditBox", nil, f)
f.editBox:SetFontObject("SortedFont")
f.editBox:SetPoint("TOPLEFT", 32, -184)
f.editBox:SetSize(256, 16)
f.editBox:SetAutoFocus(false)
f.editBox:SetFrameLevel(f:GetFrameLevel() + 2)
S.FrameTools.AddBorder(f.editBox, "border", "Interface\\Addons\\Sorted\\Textures\\Rounded-Border", 4, 4, true)
f.editBox.border:SetFrameLevel(f:GetFrameLevel() + 1)
for k,v in pairs(f.editBox.border.parts) do
    v:SetVertexColor(0.8, 0.8, 0.8)
end
f.editBox:SetScript("OnShow", function(self)
    self:SetText(UnitName("player").." ("..GetRealmName()..")")
end)

local function CreateButtonOnClick(self)
    if #f.editBox:GetText() > 0 then
        S.Settings.CreateNewProfile(f.editBox:GetText())
        S.settingsProfilesFrame:Hide()
        S.settingsFrame:Show()
    end
end
f.button = S.FrameTools.CreateBasicTextButton(f, S.Localize("PROFILE_SELECTION_CREATE"), CreateButtonOnClick)
f.button:SetSize(64, 28)
f.button:SetPoint("LEFT", f.editBox, "RIGHT", 8, -2)
--f.button.text = f.button:CreateFontString(nil, "OVERLAY", "SortedFont")
--f.button:SetFontString(f.button.text)
--f.button.text:SetText(S.Localize("PROFILE_SELECTION_CREATE"))