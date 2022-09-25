local _, S = ...

SortedScrollFrameMixin = {}

function SortedScrollFrameMixin:OnLoad()
    self:EnableMouseWheel(1)

    function self:IsScrolling()
        return self.isScrolling
    end
    
    function self:StopScrolling()
        self.scrollElapsed = 0
        self.scrollStart = nil
        self.scrollTarget = nil
        self.isScrolling = false
    end
end

function SortedScrollFrameMixin:OnUpdate(elapsed)
    if self:IsScrolling() then
        if Sorted_GetSetting("smoothingAmount") == 0 then
            self.scrollValue = self.scrollTarget
            self:StopScrolling()
        else
            self.scrollElapsed = self.scrollElapsed + elapsed
            local distance = self.scrollTarget - self.scrollStart
            local smoothElapsed = math.sin((self.scrollElapsed / Sorted_GetSetting("smoothingAmount")) * math.pi / 2)
            
            self.scrollValue = self.scrollStart + distance * smoothElapsed

            if self.scrollElapsed >= Sorted_GetSetting("smoothingAmount") then
                self.scrollValue = self.scrollTarget
                self:StopScrolling()
            end
        end

        local min,max = self.scrollBar:GetMinMaxValues()
        if self.scrollValue < min then
            self.scrollValue = min
            self:StopScrolling()
        elseif self.scrollValue > max then
            self.scrollValue = max
            self:StopScrolling()
        end

        self.scrollBar:SetValue(self.scrollValue)
    end
end

function SortedScrollFrameMixin:OnMouseWheel(delta)
    if not SortedIconSelectionMenu:IsShown() then
        local mult = 1
        if IsAltKeyDown() then mult = mult * 3 end

        if Sorted_GetSetting("smoothScrolling") == 2 then
            if self:IsScrolling() and ((delta < 0 and self.scrollTarget < self.scrollStart) or (delta > 0 and self.scrollTarget > self.scrollStart)) then
                self:StopScrolling()
            end

            if self:IsScrolling() then
                self.scrollStart = self.scrollBar:GetValue()
                self.scrollTarget = self.scrollTarget - delta * Sorted_GetSetting("scrollSpeed") * mult * Sorted_GetSetting("iconSize")
                self.scrollElapsed = 0
            else
                self.isScrolling = true
                self.scrollStart = self.scrollBar:GetValue()
                self.scrollElapsed = 0
                self.scrollTarget =  self.scrollStart - delta * Sorted_GetSetting("scrollSpeed") * mult * Sorted_GetSetting("iconSize")
            end
        else
            local scrollValue = self.scrollBar:GetValue() - delta * Sorted_GetSetting("scrollSpeed") * mult * Sorted_GetSetting("iconSize")
            local min,max = self.scrollBar:GetMinMaxValues()
            if scrollValue < min then
                scrollValue = min
            elseif scrollValue > max then
                scrollValue = max
            end
            self.scrollBar:SetValue(scrollValue)
        end
    end
 end