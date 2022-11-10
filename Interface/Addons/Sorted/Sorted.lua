local _, S = ...
local pairs, ipairs, string, type, time = pairs, ipairs, string, type, time


-- EVENT HANDLING
local eventHandlerFrame = CreateFrame("FRAME")
eventHandlerFrame:RegisterEvent("BANKFRAME_OPENED")
eventHandlerFrame:RegisterEvent("BANKFRAME_CLOSED")
eventHandlerFrame:SetScript("OnEvent", function(self, event, param1, param2, param3)
    if event == "BANKFRAME_OPENED" then
        S.OpenBag()
    elseif event == "BANKFRAME_CLOSED" then
        S.CloseBag()
    end
end)



-- BAG OPENING / CLOSING
local enabled = true
function S.Enable()
    enabled = true
end
function S.Disable()
    enabled = false
end
local lastToggledTime = 0
local lastShownTime = 0
local lastHiddenTime = 0
local TOGGLE_TIMEOUT = 0.01

local newItemsToRemove = {}
function S.ScheduleNewItemToRemove(bag, slot)
    if not newItemsToRemove[bag] then
        newItemsToRemove[bag] = {}
    end
    newItemsToRemove[bag][slot] = true
end
-- Function naming at its best
function S.IsItemScheduledToBeNotNew(bag, slot)
    if not newItemsToRemove[bag] then
        return false
    end
    return newItemsToRemove[bag][slot]
end

S.primaryFrame:SetScript("OnShow", function(self)
    S.Utils.TriggerEvent("PrimaryFrameOpened")
end)

S.primaryFrame:SetScript("OnHide", function(self)
    -- Remove new items that have been hovered over
    for bag, v in pairs(newItemsToRemove) do
        for slot, _ in pairs(v) do
            C_NewItems.RemoveNewItem(bag, slot)
        end
    end
    newItemsToRemove = {}

    S.Utils.TriggerEvent("PrimaryFrameClosed")
end)

function S.OpenBag(bag)
    if enabled then
        if (force or lastToggledTime < GetTime() - TOGGLE_TIMEOUT) and not S.primaryFrame:IsShown() then
            PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)

            --local startTime = debugprofilestop()

            S.primaryFrame:Show()

            --print(debugprofilestop() - startTime)

            lastToggledTime = GetTime()
            lastShownTime = GetTime()
        end
        --[[if bag == KEYRING_CONTAINER then
            _G["SortedBag-2Frame"]:Show()
        end]]
    end
end
function S.CloseBag(bag)
    if (force or lastToggledTime < GetTime() - TOGGLE_TIMEOUT) and S.primaryFrame:IsShown() then
        PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
        S.primaryFrame:Hide()
        lastToggledTime = GetTime()
        lastHiddenTime = GetTime()

        --[[for k,v in pairs(S.bagFrames) do
            v:Hide()
        end]]
    end
end
function S.ToggleBag(bag)
    if S.primaryFrame:IsShown() then
        S.CloseBag(bag)
    else
        S.OpenBag(bag)
        if S.WoWVersion() == 1 and bag == KEYRING_CONTAINER then
            S.primaryFrame.SelectSideTab(1, true)
        elseif S.WoWVersion() <= 3 and bag == KEYRING_CONTAINER then
            S.primaryFrame.SelectSideTab(3, true)
        else
            S.primaryFrame.SelectSideTab(nil)
        end
    end
end
hooksecurefunc('OpenBackpack', S.ToggleBag)
hooksecurefunc('CloseBackpack', S.CloseBag)
hooksecurefunc('ToggleBackpack', S.ToggleBag)
hooksecurefunc('OpenBag', S.ToggleBag)
hooksecurefunc('ToggleBag', S.ToggleBag)