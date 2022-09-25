local _, S = ...

SortedDropdownButtonMixin = {}

function SortedDropdownButtonMixin:OnLoad()
    self.backdrop:SetPoint("TOPLEFT", -2, 0)
    self.backdrop:SetPoint("BOTTOMRIGHT", 2, 0)
    self:GetHighlightTexture():SetVertexColor(1, 0.9, 0.25, 0.6)
    self:GetHighlightTexture():SetPoint("TOPLEFT", -2, 0)
    self:GetHighlightTexture():SetPoint("BOTTOMRIGHT", 2, 0)
    self:GetNormalTexture():ClearAllPoints()
    self:GetNormalTexture():SetPoint("RIGHT", 0, -4)
    self:GetNormalTexture():SetSize(14, 16)
    self:GetPushedTexture():ClearAllPoints()
    self:GetPushedTexture():SetPoint("RIGHT", 0, -4)
    self:GetPushedTexture():SetSize(14, 16)
    self:RegisterForClicks("LeftButtonDown")

    self.valueText = self:CreateFontString(self:GetName().."ValueText", "ARTWORK", "Sorted11Font")
    self.valueText:SetJustifyH("LEFT")
    self.valueText:SetJustifyV("MIDDLE")
    self.valueText:SetPoint("TOPLEFT", 2, -2)
    self.valueText:SetPoint("BOTTOMRIGHT", -20, 2)
    function self:SetValue(text, r, g, b)
        self.valueText:SetText(text)
        if r then
            self.valueText:SetTextColor(r, g, b)
        end
    end
end

function SortedDropdownButtonMixin:OnMouseDown()
    self:GetHighlightTexture():SetAlpha(1)
end

function SortedDropdownButtonMixin:OnMouseUp()
    self:GetHighlightTexture():SetAlpha(0.6)
end

function SortedDropdownButtonMixin:OnHide()
    self:SetButtonState("NORMAL", false)
    self:UnlockHighlight()
    SortedDropdownMenuParent:ToggleOff(self)
    SortedDropdownMenuParent:Hide()
end

function SortedDropdownButtonMixin:OnClick()
    SortedDropdownMenuParent:Toggle(self)
    if SortedDropdownMenuParent.toggled then
        self:SetButtonState("PUSHED", true)
        self:LockHighlight()
    else
        self:SetButtonState("NORMAL", false)
        self:UnlockHighlight()
    end
end


SortedDropdownMenuMixin = {}

function SortedDropdownMenuMixin:OnLoad()
    SortedScrollFrameMixin.OnLoad(self)

    self.backdrop = self:CreateTexture()
    self.backdrop:SetAllPoints()
    self.backdrop:SetHorizTile(true)
    self.backdrop:SetVertTile(true)
    Sorted.RegisterBackdrop(self.backdrop)
    self:SetFrameLevel(1)
    self.shadowFrame:SetFrameLevel(0)

    self.scrollBar = CreateFrame("Slider", self:GetName().."ScrollBar", self, "MinimalScrollBarTemplate")
    self.scrollBar.trackBG:Hide()
    self.scrollBar:SetPoint("TOPRIGHT", 1, -18)
    self.scrollBar:SetPoint("BOTTOM", 0, 16)
    self.scrollBar:SetMinMaxValues(1, 1)
    self.scrollBar:SetValueStep(1)
    self.scrollBar.scrollStep = 16
    self.scrollBar:SetValue(0)
    self:SetScrollChild(self.scrollChild)
end

function SortedDropdownMenuMixin:UpdateSize()
    self.menuWidth = 128
    for _, items in ipairs(self.scrollChild.listItems) do
        for i, button in pairs(items) do
            if i < self.scrollChild.currentIndex and button:IsShown() then
                local width = button:ItemWidth()
                if width > self.menuWidth then
                    self.menuWidth = width
                end
            end
        end
    end
    self.menuWidth = self.menuWidth + 48
    self.menuHeight = self.scrollChild.currentIndex * 22
    self.scrollChild:SetSize(self.menuWidth, self.menuHeight)
    if self.menuHeight > 384 then
        self.scrollBar:Show()
        self.scrollBar:SetMinMaxValues(1, self.menuHeight - 384)
        self:SetSize(self.menuWidth + 24, 384)
        self.menuHeight = 384
    else
        self.scrollBar:Hide()
        self.scrollBar:SetMinMaxValues(1, 1)
        self:SetSize(self.menuWidth, self.menuHeight)
    end
end

function SortedDropdownMenuMixin:ToggleOn(parent)
    if not Sorted_IsClassic() then
        self:RegisterEvent("GLOBAL_MOUSE_DOWN")
    end
    SortedDropdownMenuParent:SetParent(parent)
    self.toggled = true
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
    if SortedDropdownMenuParent.animating then
        SortedDropdownMenuParent:Hide()
    end
    SortedDropdownMenuParent:Show()
    self:Animate("Show")
    if parent.SetButtonState then
        parent:SetButtonState("PUSHED", true)
        parent:LockHighlight()
    end
end
function SortedDropdownMenuMixin:ToggleOff(parent)
    if not Sorted_IsClassic() then
        self:UnregisterEvent("GLOBAL_MOUSE_DOWN")
    end
    SortedDropdownMenuParent:SetParent(parent)
    self.toggled = false
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
    self:Animate("Hide")
    if parent.SetButtonState then
        parent:SetButtonState("NORMAL", false)
        parent:UnlockHighlight()
    end
end
function SortedDropdownMenuMixin:Toggle(parent)
    if parent == SortedDropdownMenuParent:GetParent() then
        if self.toggled then
            SortedDropdownMenuParent:ToggleOff(parent)
        else
            SortedDropdownMenuParent:ToggleOn(parent)
        end
    else
        SortedDropdownMenuParent:ToggleOn(parent)
    end
end

function SortedDropdownMenuMixin:Animate(animation)
    self.animating = true
    self.animation = animation
    self.animElapsed = 0
end

function SortedDropdownMenuMixin:OnUpdate(elapsed)
    SortedScrollFrameMixin.OnUpdate(self, elapsed)

    if self.animating then
        self.animElapsed = self.animElapsed + elapsed * 5
        if self.animElapsed > 1 or Sorted_GetSetting("animations") == 1 then
            self.animElapsed = 1
            self.animating = false
        end

        if self.animation == "Show" then
            local heightMult = math.sin(self.animElapsed * math.pi / 2) --1 - (1 - self.animElapsed) ^ 2
            local height = self.menuHeight * heightMult
            self:SetAlpha(1)
            self.shadowFrame:Show()
            self:SetHeight(height)
            for _, items in pairs(self.scrollChild.listItems) do
                for k,v in pairs(items) do
                    v:ClearAllPoints()
                    v:SetPoint("LEFT")
                    v:SetPoint("RIGHT")
                    v:SetPoint("TOP", 0, 11 - (self.scrollChild:GetHeight() * heightMult) / self.scrollChild.currentIndex * k)
                    v:SetAlpha(self.animElapsed)
                end
            end
        elseif self.animation == "Hide" then
            if not self.animating then
                self:Hide()
                return
            end
            self.shadowFrame:Hide()
            self:SetAlpha(1 - self.animElapsed)
        end
    end
end
function SortedDropdownMenuMixin:OnShow()
    Sorted_UpdateBackdropTexture()
    self:ClearAllPoints()
    self:SetPoint("TOPRIGHT", self:GetParent(), "BOTTOMRIGHT")
    self:SetFrameLevel(self:GetParent():GetFrameLevel() + 1000)
    self.scrollChild:Clear()
    self:GetParent():InitFunc()
    self:UpdateSize()
    self.scrollBar:SetValue(1)
    if Sorted_GetSetting("animations") then
        self:Animate("Show")
    end
end

function SortedDropdownMenuMixin:OnHide()
    if self:GetParent().SetButtonState then
        self:GetParent():SetButtonState("NORMAL", false)
        self:GetParent():UnlockHighlight()
    end
    self.animating = false
    self.animElapsed = 1
    self.animation = nil
end

function SortedDropdownMenuMixin:OnEvent()
    if not (self:GetParent():IsMouseOver() or self:IsMouseOver()) then 
        self:ToggleOff(self:GetParent())
    end
end


SortedDropdownMenuContentsMixin = {}
local ITEM_BUTTON = 1
local ITEM_CENTERED_BUTTON = 2
local ITEM_CHECK_BUTTON = 3
local ITEM_TEXT = 4
function SortedDropdownMenuContentsMixin:OnLoad()
    self.listItems = {
        [ITEM_BUTTON] = {},
        [ITEM_CENTERED_BUTTON] = {},
        [ITEM_CHECK_BUTTON] = {},
        [ITEM_TEXT] = {},
    }
    self.currentIndex = 1

    function self:Clear()
        for _, v in pairs(self.listItems) do
            for _, item in pairs(v) do
                item:Hide()
            end
        end
        self.currentIndex = 1
    end

    local function CreateButton()
        local b = CreateFrame("Button", self:GetName().."Button"..self.currentIndex, self, "SortedDropdownButtonTemplate")
        b:SetHeight(22)
        b:SetPoint("LEFT")
        b:SetPoint("RIGHT")

        b.leftText = b:CreateFontString(b:GetName().."LeftText", "ARTWORK", "Sorted11Font")
        b.leftText:SetPoint("LEFT", 8, 0)

        b.rightText = b:CreateFontString(b:GetName().."RightText", "ARTWORK", "Sorted11Font")
        b.rightText:SetPoint("RIGHT", -24, 0)

        b.deleteButton = CreateFrame("Button", b:GetName().."DeleteButton", b, "SortedDeleteButtonTemplate")
        b.deleteButton:SetPoint("RIGHT", -4, 0)
        if S.DoSkinning() then
            S.AS:SkinCloseButton(b.deleteButton)
        else
            b.deleteButton:SetScale(0.9)
            b:HookScript("OnEnter", function(self)
                self.deleteButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
            end)
            b:HookScript("OnLeave", function(self)
                self.deleteButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
            end)
        end

        function b:ItemWidth()
            local width = self.leftText:GetStringWidth() + self.rightText:GetStringWidth()
            if self.deleteButton:IsShown() then
                width = width + 16
            end
            return width
        end

        self.listItems[ITEM_BUTTON][self.currentIndex] = b
    end

    function self:AddSpace()
        self.currentIndex = self.currentIndex + 1
    end

    function self:AddButton(onClickFunc, leftText, rightText, hasDeleteButton, onDeleteFunc, leftColor, rightColor, highlightColor)
        if not self.listItems[ITEM_BUTTON][self.currentIndex] then
            CreateButton()
        end

        local b = self.listItems[ITEM_BUTTON][self.currentIndex]
        b:SetScript("OnClick", onClickFunc)
        b:HookScript("OnClick", function(self) 
            SortedDropdownMenuParent:GetParent():ValueFunc() 
            SortedDropdownMenuParent:ToggleOff(SortedDropdownMenuParent:GetParent())
        end)
        b:SetScript("OnEnter", nil)

        b.leftText:SetText(leftText)
        b.leftText:SetFontObject(Sorted12Font)
        b.rightText:SetText(rightText)
        b.rightText:SetFontObject(Sorted12Font)

        if hasDeleteButton then
            b.deleteButton:Show()
            b.deleteButton:SetScript("OnClick", onDeleteFunc)
            b.rightText:SetPoint("RIGHT", -24, 0)
            b:SetScript("OnMouseDown", function(self) 
                b.leftText:SetPoint("LEFT", 9, -1) 
                b.rightText:SetPoint("RIGHT", -23, -1)
            end)
            b:SetScript("OnMouseUp", function(self) 
                b.leftText:SetPoint("LEFT", 8, 0) 
                b.rightText:SetPoint("RIGHT", -24, 0)
            end)
        else
            b.deleteButton:Hide()
            b.rightText:SetPoint("RIGHT", -8, 0)
            b:SetScript("OnMouseDown", function(self) 
                b.leftText:SetPoint("LEFT", 9, -1) 
                b.rightText:SetPoint("RIGHT", -7, -1)
            end)
            b:SetScript("OnMouseUp", function(self) 
                b.leftText:SetPoint("LEFT", 8, 0) 
                b.rightText:SetPoint("RIGHT", -8, 0)
            end)
        end

        if leftColor then
            b.leftText:SetTextColor(unpack(leftColor))
        else
            b.leftText:SetTextColor(1, 1, 1)
        end
        if rightColor then
            b.rightText:SetTextColor(unpack(rightColor))
        else
            b.rightText:SetTextColor(1, 1, 1)
        end
        if highlightColor then
            b:GetHighlightTexture():SetVertexColor(unpack(highlightColor))
        else
            b:GetHighlightTexture():SetVertexColor(1, 0.9, 0.25, 0.6)
        end
        b:GetPushedTexture():SetVertexColor(0, 0, 0)

        b:Show()
        self.currentIndex = self.currentIndex + 1
        return b
    end

    local function CreateCenteredButton()
        local b = CreateFrame("Button", self:GetName().."CenteredButton"..self.currentIndex, self, "SortedDropdownButtonTemplate")
        b:SetHeight(22)
        b:SetPoint("LEFT")
        b:SetPoint("RIGHT")

        b.text = b:CreateFontString(b:GetName().."Text", "ARTWORK", "Sorted11Font")
        b.text:SetPoint("CENTER")
        b:SetScript("OnMouseDown", function(self) b.text:SetPoint("CENTER", 0.5, -1) end)
        b:SetScript("OnMouseUp", function(self) b.text:SetPoint("CENTER") end)

        function b:ItemWidth()
            return self.text:GetStringWidth()
        end

        self.listItems[ITEM_CENTERED_BUTTON][self.currentIndex] = b
    end
    function self:AddCenteredButton(onClickFunc, text, textColor, highlightColor)
        if not self.listItems[ITEM_CENTERED_BUTTON][self.currentIndex] then
            CreateCenteredButton()
        end

        local b = self.listItems[ITEM_CENTERED_BUTTON][self.currentIndex]
        b:SetScript("OnClick", onClickFunc)
        b:HookScript("OnClick", function(self)
            SortedDropdownMenuParent:GetParent():ValueFunc() 
            SortedDropdownMenuParent:ToggleOff(SortedDropdownMenuParent:GetParent())
        end)

        b.text:SetText(text)
        if textColor then
            b.text:SetTextColor(unpack(textColor))
        else
            b.text:SetTextColor(1, 1, 1)
        end
        if highlightColor then
            b:GetHighlightTexture():SetVertexColor(unpack(highlightColor))
        else
            b:GetHighlightTexture():SetVertexColor(1, 0.9, 0.25, 0.6)
        end
        b:GetPushedTexture():SetVertexColor(0, 0, 0)

        b:Show()
        self.currentIndex = self.currentIndex + 1
        return b
    end


    local function CreateCheckButton()
        local b = CreateFrame("Button", self:GetName().."CheckButton"..self.currentIndex, self, "SortedDropdownButtonTemplate")
        b:SetHeight(22)
        b:SetPoint("LEFT")
        b:SetPoint("RIGHT")

        b.box = CreateFrame("Frame", b:GetName().."Box", b)
        b.box:SetPoint("LEFT", 8, 0)
        b.box:SetSize(16, 16)
        b.box.bg = b.box:CreateTexture()
        b.box.bg:SetDrawLayer("ARTWORK")
        b.box.bg:SetColorTexture(0, 0, 0, 0.5)
        b.box.bg:SetAllPoints()

        b.check = b.box:CreateTexture()
        b.check:SetDrawLayer("OVERLAY")
        b.check:SetPoint("TOPLEFT", -4, 4)
        b.check:SetPoint("BOTTOMRIGHT", 4, -4)
        b.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
        b.check:Hide()
        b.checked = false

        b.text = b:CreateFontString(b:GetName().."Text", "ARTWORK", "Sorted11Font")
        b.text:SetPoint("LEFT", 32, 0)
        b:SetScript("OnMouseDown", function(self) b.text:SetPoint("CENTER", 0.5, -1) end)
        b:SetScript("OnMouseUp", function(self) b.text:SetPoint("CENTER") end)

        function b:ItemWidth()
            return self.text:GetStringWidth() + 24
        end

        function b:GetChecked()
            return self.checked
        end
        function b:SetChecked(checked)
            self.checked = checked
            self.check:SetShown(checked)
        end
        function b:Toggle()
            self:SetChecked(not self.checked)
        end

        self.listItems[ITEM_CHECK_BUTTON][self.currentIndex] = b
    end
    function self:AddCheckButton(onClickFunc, text, textColor, highlightColor)
        if not self.listItems[ITEM_CHECK_BUTTON][self.currentIndex] then
            CreateCheckButton()
        end

        local b = self.listItems[ITEM_CHECK_BUTTON][self.currentIndex]
        b:SetScript("OnClick", onClickFunc)
        b:HookScript("OnClick", function(self) 
            SortedDropdownMenuParent:GetParent():ValueFunc() 
        end)

        b.text:SetText(text)
        if textColor then
            b.text:SetTextColor(unpack(textColor))
        else
            b.text:SetTextColor(1, 1, 1)
        end
        if highlightColor then
            b:GetHighlightTexture():SetVertexColor(unpack(highlightColor))
        else
            b:GetHighlightTexture():SetVertexColor(1, 0.9, 0.25, 0.6)
        end
        b:GetPushedTexture():SetVertexColor(0, 0, 0)

        b:Show()
        self.currentIndex = self.currentIndex + 1
        return b
    end


    local function CreateText()
        local item = CreateFrame("Frame", self:GetName().."Text"..self.currentIndex, self)
        item:SetHeight(22)
        item:SetPoint("LEFT")
        item:SetPoint("RIGHT")

        item.text = item:CreateFontString(item:GetName().."Text", "ARTWORK", "Sorted12Font")
        item.text:SetPoint("LEFT", 4, 0)

        function item:ItemWidth()
            return self.text:GetStringWidth()
        end

        self.listItems[ITEM_TEXT][self.currentIndex] = item
    end
    function self:AddText(text, textColor)
        if not self.listItems[ITEM_TEXT][self.currentIndex] then
            CreateText()
        end

        local item = self.listItems[ITEM_TEXT][self.currentIndex]
        item.text:SetText(text)
        if textColor then
            item.text:SetTextColor(unpack(textColor))
        else
            item.text:SetTextColor(1, 0.82, 0)
        end

        item:Show()
        self.currentIndex = self.currentIndex + 1
        return item
    end
end