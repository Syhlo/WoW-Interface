PVH = select(2, ...)


--[[ 
  AddonLoaded
]]
function PVH:AddonLoaded()
  -- Load saved variable or defaults
  PVHStore = PVHStore or {
    firstRun = true,
    selectedProfile = "PvE",
    profiles = {},
    spec = nil
  }

  self.store = PVHStore
end


--[[ 
  PlayerLogin
]]
function PVH:PlayerLogin()
  self.store.spec = GetSpecialization()

  if (self.store.firstRun) then
    self:StoreHotbarsAndTalents()
  end
end

function PVH:StoreHotbarsAndTalents()
  self.store.firstRun = false
  self.store.profiles[self.store.spec] = true
  print(self.store.profiles[self.store.spec])
end


--[[
  Event Listening and Delegation
]]
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, arg1)
  if (event == "ADDON_LOADED" and arg1 == "PlayerVsHotbar") then
    PVH:AddonLoaded()
    self:UnregisterEvent("ADDON_LOADED")
  end

  if (event == "PLAYER_LOGIN") then
    PVH:PlayerLogin()
    self:UnregisterEvent("PLAYER_LOGIN")
  end
end)