-- Create a frame to listen on
local events, handler = CreateFrame("Frame"), {};
local greycolor, defaultcolor = "|cFF777777", "|r";

-- Set the target marker (unless already set)
local function SetTargetMarker(unit, icon)
  if (GetRaidTargetIndex(unit) ~= icon) then
    SetRaidTarget(unit, icon);
  end
end

-- Event handlers
function handler:GROUP_ROSTER_UPDATE(...)
  local isArena, isRegistered = IsActiveBattlefieldArena();
  local unitIDs = {"player", "party1", "party2"};
  if (isArena) then
    for i = 1, GetNumGroupMembers() do
      SetTargetMarker(unitIDs[i], i);
    end
  end
end

-- Register the events
for k,v in pairs(handler) do
	events:RegisterEvent(k);
end

-- Handle any fired events
events:SetScript("OnEvent", function(self, event, ...)
  handler[event](self, ...);
end);