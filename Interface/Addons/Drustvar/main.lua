-- Drustvar Pvp Rating Addon
-- My first addon, go easy
-- /console scriptErrors 1


-- Helper to view tables
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

 -- good way to clear memory use over time
 -- FlushTooltipCache()

 local addonName, cs = ...

local uiHooks = {}
local L;


local MAX_LEVEL = 60 -- old function not working in 9.0 MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_SHADOWLANDS]
local currentUNIT, currentGUID

local CONST_REGION_IDS = cs.regionIDs
local CONST_REALM_SLUGS = cs.realmSlugs

local REGIONS

local ratingDATA2 = {}
local wonDATA2 = {}
local lostDATA2 = {}
local winrateDATA2= {}
local likesData = {}

local ratingDATA3 = {}
local wonDATA3 = {}
local lostDATA3 = {}
local winrateDATA3 = {}

local playerData = {}

local ARENA_CASUAl = ARENA_CASUAL
local PVP_RATING = PVP_RATING
local STATISTICS = 'Record';

local prefixColor = '|cffffffff'
local detailColor = '|cffffcc00'

local GameToolTip = GameToolTip;

local DrustvarFrame = CreateFrame('Frame', 'DrustvarPVP')

DrustvarFrame:RegisterEvent('INSPECT_READY')
-- f:RegisterEvent('INSPECT_HONOR_UPDATE'); -- Deprecated 8.1.5

local FACTION = {
	["Alliance"] = 1,
	["Horde"] = 2,
}

local REGIONS = {
	"us",
	"kr",
	"eu",
	"tw",
	"cn"
}

local region = GetCurrentRegion()

if region == 1 then

	local loaded, rsn = LoadAddOn("Drustvar_DB_US")

	if loaded then
		DRUSTVAR_CHARACTERS = DRUSTVAR_CHARACTERS_US
	end
elseif region == 3 then
	local loaded, rsn = LoadAddOn("Drustvar_DB_EU")
	if loaded then
		DRUSTVAR_CHARACTERS = DRUSTVAR_CHARACTERS_EU
	end
else
	DRUSTVAR_CHARACTERS = {}
end

local function SetUnitRatedData(bracket2v2, bracket3v3, bracketRbg, gVAR)

	local _, unit = GameTooltip:GetUnit()
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end
	if (not gVAR)  then
		gVAR = CONTINUED
    end

	local infoLine2;
	local infoLine3;
	local infoLineRbg;

	local infoString2v2 = prefixColor..'2v2: Loading'
	local infoString3v3 = prefixColor..'3v3: Loading'
	local infoStringRbg = prefixColor..'RBG: Loading'
	
	for i = 2, GameTooltip:NumLines()+1 do
        local line = _G['GameTooltipTextLeft' .. i]
		if line and line:IsShown() then

			local text = line:GetText() or ''

			if (text == infoString2v2) then
				infoLine2 = line
			end

			if (text == infoString3v3) then
				infoLine3 = line
			end

			if (text == infoStringRbg) then
				infoLineRbg = line
				break
			end

		end
    end
	

    if (gVAR ~= CONTINUED) and (text~=CONTINUED) then
		if (bracket2v2['seasonWon'] + bracket2v2['seasonLost'] ~= 0) then
            infoString2v2 = prefixColor .. '2v2' .. ': ' .. GetScoreColor(bracket2v2['rating'])..bracket2v2['rating']..prefixColor..' | '..bracket2v2['seasonWon']..'-'..bracket2v2['seasonLost']..' | '..detailColor..'Highest ('..bracket2v2['highest']..')'
        else
            infoString2v2 =   prefixColor .. '2v2' .. ': '..'None';
		end
		
		if (bracket3v3['seasonWon'] + bracket3v3['seasonLost'] ~= 0) then
            infoString3v3 = prefixColor .. '3v3' .. ': ' ..GetScoreColor(bracket3v3['rating'])..bracket3v3['rating']..prefixColor..' | '..bracket3v3['seasonWon']..'-'..bracket3v3['seasonLost']..' | '..detailColor..'Highest ('..bracket3v3['highest']..')'
        else
            infoString3v3 =   prefixColor .. '3v3' .. ': '..'None';
		end
		
		if (bracketRbg['seasonWon'] + bracketRbg['seasonLost'] ~= 0) then
            infoStringRbg = prefixColor .. 'RBG' .. ': ' ..GetScoreColor(bracketRbg['rating'])..bracketRbg['rating']..prefixColor..' | '..bracketRbg['seasonWon']..'-'..bracketRbg['seasonLost']
        else
            infoStringRbg =   prefixColor .. 'RBG' .. ': '..'None';
        end
	end
	

	local infostringLikes
	local name, realm = UnitName(unit)

	-- local leaderName = bracket2v2['name']
	local charData;

	-- TODO MOVE TO CACHING SYSTEM LIKE RATINGS. DONT WANT TO SEARCH ARRAY EVERY MOUSE OVER.
	if(name) then

		if not realm then
			realm = GetRealmName()
		end

		-- remove spaces,-s from realm names (LFG realms come this way by default)
		if realm then
			realm = realm:gsub(" ", "")
			realm = realm:gsub("-", "")
		end
	end



	if infoLine2 then
		infoLine2:SetText(infoString2v2)
	else
		GameTooltip:AddLine(infoString2v2)
	end

	if infoLine3 then
		infoLine3:SetText(infoString3v3)
	else
		GameTooltip:AddLine(infoString3v3)
	end

	if infoLineRbg then
		infoLineRbg:SetText(infoStringRbg)
	else
		GameTooltip:AddLine(infoStringRbg)
	end

	if infoStringLikes then
		GameTooltip:AddLine(infoStringLikes)
	end

	GameTooltip:Show()
	
end

local scanning = {}
for i in pairs(scanning) do
	local scanTip = CreateFrame('GameTooltip', 'CUnitScan' .. i, nil, 'GameTooltipTemplate')
	scanTip:SetOwner(WorldFrame, 'ANCHOR_NONE')
	ratingDATA2[i] = scanTip
	wonDATA2[i] = scanTip
	lostDATA2[i] = scanTip
    winrateDATA2[i] = scanTip
    
    -- ratingDATA3[i] = scanTip
	-- wonDATA3[i] = scanTip
	-- lostDATA3[i] = scanTip
	-- winrateDATA3[i] = scanTip
end


local function ScanUnit(unit, forced)


	name, realm = UnitName(unit)

	--realm = 'СвежевательДуш'
	--name = 'Холдгуард'

	realm = GetRealmSlug(realm)
	leaderName = name ..'-'..realm

	charData = DRUSTVAR_CHARACTERS[leaderName]

	-- Use DB if we found them, otherwise inspect them
	-- if (charData ~= nil) then
		createTooltip(leaderName)
		-- return
	-- end

	-- TODO inspect player to grab rating when not in Database
	if (true) then return end


	local cachedRating2,cachedWInsData2,cachedLosesData2, cachedWinrate2, cachedVAR2

	GameTooltip:AddLine('\nDrustvar.com PVP Stats\nNot in DB - Inspecting Player\n')
	
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end
		
	cachedVAR2 = '2v2'
	cachedRating2 = ratingDATA2[currentGUID]
	cachedWInsData2 = wonDATA2[currentGUID]
	cachedLosesData2 = lostDATA2[currentGUID]
	cachedWinrate2 = winrateDATA2[currentGUID]
	
	cachedVAR3 = '3v3'
	cachedRating3 = ratingDATA3[currentGUID]
	cachedWInsData3 = wonDATA3[currentGUID]
	cachedLosesData3 = lostDATA3[currentGUID]
	cachedWinrate3 = winrateDATA3[currentGUID]


	if cachedRating2 or forced then	
		SetUnitRatedData(playerData[currentGUID]['2v2'], playerData[currentGUID]['3v3'], playerData[currentGUID]['rbg'], '3v3')
	end
	
	if not (forced) then
		if cachedRating2 and cachedVAR2 then return end
		if UnitAffectingCombat('player') then return end
	end

	-- if (not UnitIsVisible(unit)) then return end
	-- if UnitIsDeadOrGhost('player') or UnitOnTaxi('player') then return end


	SetUnitRatedData(CONTINUED, cachedVAR2)
	
	local lastRequest = GetTime() - (GameTooltip.lastUpdate or 0)
	
	-- print(1)
	-- if (true) then return end
	
	if (lastRequest >= 1.5) then
		GameTooltip.nextUpdate = 0
	else
		GameTooltip.nextUpdate = 1.5 - lastRequest
	end


	GameTooltip:Show()

	-- print(1)
	-- if (true) then return end

		
	
end

-- inspectable players - Really need to redo this
DrustvarFrame:SetScript('OnEvent', function(self, event, ...)
	local guid = ...

	if (event == 'INSPECT_READY') then

		if (guid == currentGUID) then
		
			local ARENA_CASUAl = '2v2'

			local stats GetStatisticsCategoryList()
			
			local rating, seasonPlayed, seasonWon = GetInspectArenaData(1)
			local seasonLost = seasonPlayed - seasonWon
			local winrate = math.floor(100*seasonWon/seasonPlayed)
			local n = 0/0
			ratingDATA2[guid] = rating
			wonDATA2[guid] = seasonWon
			lostDATA2[guid] = seasonLost


			if (winrate ~= 0) then
				winrateDATA2[guid] = winrate
			else
				winrateDATA2[guid] = 0
				winrate = 0
			end

			-- local highest2s = GetStatistic(370)
			-- local highest3s = GetStatistic(595)

			local highest2s = GetComparisonStatistic(370)
			local highest3s = GetComparisonStatistic(595)

		
			playerData[guid] = 
			{ ["2v2"] =
					{["rating"]= rating, ["seasonWon"]=seasonWon, ["seasonLost"]=seasonLost, ["seasonPlayed"]=seasonPlayed,  ["winrate"]=winrate,  ["highest"]=highest2s},
					["3v3"] = 
					{["rating"]= rating, ["seasonWon"]=seasonWon, ["seasonLost"]=seasonLost, ["seasonPlayed"]=seasonPlayed,  ["winrate"]=winrate,  ["highest"]=highest3s },
					["rbg"] = 
					{["rating"]= rating, ["seasonWon"]=seasonWon, ["seasonLost"]=seasonLost, ["seasonPlayed"]=seasonPlayed,  ["winrate"]=winrate,  ["highest"]=0 },
			}



			if (not rating) or (not ARENA_CASUAl) then
				ScanUnit(currentUNIT, true)
			else
				-- SetUnitRatedData(rating, seasonWon, seasonLost, winrate, '2v2')
			end


			local ARENA_CASUAl = '3v3'


			local rating, seasonPlayed, seasonWon = GetInspectArenaData(2)
			local seasonLost = seasonPlayed - seasonWon
			local winrate = math.floor(100*seasonWon/seasonPlayed)
			local n = 0/0
			ratingDATA3[guid] = rating
			wonDATA3[guid] = seasonWon
			lostDATA3[guid] = seasonLost
			if (winrate ~= 0) then
				winrateDATA3[guid] = winrate
			else
				winrateDATA3[guid] = 0
				winrate = 0
			end
			
			playerData[guid]['3v3'] = 
					{["rating"]= rating, ["seasonWon"]=seasonWon, ["seasonLost"]=seasonLost, ["seasonPlayed"]=seasonPlayed,  ["winrate"]=winrate,  ["highest"]=highest3s }
					

					local rating, seasonPlayed, seasonWon = GetInspectArenaData(4)
					local seasonLost = seasonPlayed - seasonWon
					local winrate = math.floor(100*seasonWon/seasonPlayed)
					local n = 0/0
					ratingDATA3[guid] = rating
					wonDATA3[guid] = seasonWon
					lostDATA3[guid] = seasonLost
					if (winrate ~= 0) then
						winrateDATA3[guid] = winrate
					else
						winrateDATA3[guid] = 0
						winrate = 0
					end
					
					playerData[guid]['rbg'] = 
						{["rating"]= rating, ["seasonWon"]=seasonWon, ["seasonLost"]=seasonLost, ["seasonPlayed"]=seasonPlayed,  ["winrate"]=winrate,  ["highest"]=0 }


			if (not rating) or (not ARENA_CASUAl) then
				ScanUnit(currentUNIT, true)
			else
				SetUnitRatedData(playerData[guid]['2v2'], playerData[guid]['3v3'], playerData[guid]['rbg'], '2v2')
			end
			


		end
		self:UnregisterEvent('INSPECT_READY')
	end
end)




local loaded = false
DrustvarFrame:SetScript('OnUpdate', function(self, elapsed)


	-- helps set the script up when other addons use OnTooltipSetUnit
	if not loaded then
		-- GameTooltip:SetScript("OnTooltipSetUnit", setupTooltip)
		loaded = true
	end;


	self.nextUpdate = (self.nextUpdate or 0) - elapsed
	if (self.nextUpdate > 0) then return end

	self:Hide()
	ClearInspectPlayer()

	if currentUNIT and (UnitGUID(currentUNIT) == currentGUID) then
		self.lastUpdate = GetTime()
		self:RegisterEvent('INSPECT_READY')
		SetAchievementComparisonUnit(currentUNIT)
		NotifyInspect(currentUNIT)
		
	end
end)




function HostilePlayerTooltip(unit)

	local _, unit2 = GameTooltip:GetUnit()

	name, realm = UnitName(unit)

	--if not realm then
	realm = GetRealmSlug(realm)
	--end


	-- remove spaces,-s from realm names (LFG realms come this way by default)
	if realm then
		-- realm = GetRealmName()
		realm = realm:gsub(" ", "")
		realm = realm:gsub("-", "")
	end

	local leaderName = name .. '-' .. realm
	local region = GetRegion();
	local charData;

	createTooltip(leaderName);

end


	-- retrieves the url slug for a given realm name
function GetRealmSlug(realm)
	if not realm then
		realm = GetRealmName()
	end

	--realm = 'СвежевательДуш'
	realm = realm:gsub("%s+", "")

	return CONST_REALM_SLUGS[realm] or realm
end

-- returns the name, realm and possibly unit
function GetNameAndRealm(arg1, arg2)
	local name, realm, unit
	if UnitExists(arg1) then
		unit = arg1
		if UnitIsPlayer(arg1) then
			name, realm = UnitName(arg1)
			realm = realm and realm ~= "" and realm or GetNormalizedRealmName()
		end
	elseif type(arg1) == "string" and arg1 ~= "" then
		if arg1:find("-", nil, true) then
			name, realm = ("-"):split(arg1)
		else
			name = arg1 -- assume this is the name
		end
		if not realm or realm == "" then
			if type(arg2) == "string" and arg2 ~= "" then
				realm = arg2
			else
				realm = GetNormalizedRealmName() -- assume they are on our realm
			end
		end
	end
	return name, realm, unit
end


-- copy profile link from dropdown menu
local function CopyURLForNameAndRealm(...)
	local name, realm = GetNameAndRealm(...)
	local realmSlug = GetRealmSlug(realm)
	local url = format("https://drustvar.com/character/%s/%s/%s?utm_source=addon", PLAYER_REGION, realmSlug, name)
	if IsModifiedClick("CHATLINK") then
		local editBox = ChatFrame_OpenChat(url, DEFAULT_CHAT_FRAME)
		editBox:HighlightText()
	else
		StaticPopup_Show("RAIDERIO_COPY_URL", format("%s (%s)", name, realm), url)
	end
end


local hooked = {}

	-- GameTooltip
	uiHooks[#uiHooks + 1] = function()

		local function setupTooltip(tooltip) 

			local _, unit = tooltip:GetUnit()
		
			if not UnitIsPlayer(unit) or UnitFactionGroup(unit) == nil then
				return
			end
		
			if unit and not CanInspect(unit) then
				HostilePlayerTooltip(unit)
			end
		
		
			if (not unit) or (not CanInspect(unit)) then return end
			
			if UnitLevel(unit) >= MAX_LEVEL and not InCombatLockdown() then
				currentUNIT, currentGUID = unit, UnitGUID(unit)
				ScanUnit(unit)
		
			end
		end

		GameTooltip:HookScript("OnTooltipSetUnit", setupTooltip)
		return 1
	end


-- LFG
uiHooks[#uiHooks + 1] = function()
	if _G.LFGListApplicationViewerScrollFrameButton1 then
		local hooked = {}
		local OnEnter, OnLeave
		-- application queue
		function OnEnter(self)
			
			-- if not ns.addonConfig.enableLFGTooltips then
			-- 	return
			-- end

			if self.applicantID and self.Members then
				for i = 1, #self.Members do
					local b = self.Members[i]
					if not hooked[b] then
						hooked[b] = 1
						b:HookScript("OnEnter", OnEnter)
						b:HookScript("OnLeave", OnLeave)
					end
				end
			elseif self.memberIdx then
				local fullName = C_LFGList.GetApplicantMemberInfo(self:GetParent().applicantID, self.memberIdx)

				-- print('fullname')
				-- print(fullName)
				
				
				if fullName then
					createTooltip(fullName)
				end
			end
		end
		function OnLeave(self)
			if self.applicantID or self.memberIdx then
				GameTooltip:Hide()
			end
		end
		-- search results
		local function SetSearchEntryTooltip(tooltip, resultID, autoAcceptOption)

			local results = C_LFGList.GetSearchResultInfo(resultID)
			if not results then
				return
			end

			local activityID = results.activityID
			local leaderName = results.leaderName



			if leaderName then

				if not string.match(leaderName, "-") then
					--realm = GetRealmName()
					realm = GetRealmSlug()

					leaderName = leaderName..'-'..realm
				
				else
					name =  splitString(leaderName,'-')
					leaderName = name[1] .. '-' .. GetRealmSlug(name[2])


				end

				-- print('lfg window')
				-- print(leaderName);
				createTooltip(leaderName)

				-- Update game tooltip with player info
				-- ShowTooltip(tooltip, bor(TooltipProfileOutput.PADDING(), ProfileOutput.ADD_LFD), leaderName, nil, PLAYER_FACTION, true, LFD_ACTIVITYID_TO_DUNGEONID[activityID], keystoneLevel)
				-- ns.PROFILE_UI.ShowProfile(leaderName, nil, PLAYER_FACTION, nil, tooltip, nil, activityID, keystoneLevel)
			end
		end
		hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", SetSearchEntryTooltip)
		-- execute delayed hooks
		for i = 1, 14 do
			local b = _G["LFGListApplicationViewerScrollFrameButton" .. i]
			b:HookScript("OnEnter", OnEnter)
			b:HookScript("OnLeave", OnLeave)
		end
		-- UnempoweredCover blocking removal
		do
			local f = LFGListFrame.ApplicationViewer.UnempoweredCover
			f:EnableMouse(false)
			f:EnableMouseWheel(false)
			f:SetToplevel(false)
		end
		return 1
	end
end

function createTooltip(leaderName)

	local region = GetRegion();
			local charData;
			
			charData = DRUSTVAR_CHARACTERS[leaderName]

			GameTooltip:AddLine('\nDrustvar.com PVP Stats')

			if (charData == nil) then
				GameTooltip:AddLine(prefixColor.."Player not in DB yet")
				GameTooltip:AddLine(prefixColor.."Use the Copy Drustvar PVP URL option")
				GameTooltip:Show()
				return
			end


			playerData[leaderName] = 
			{ ["2v2"] =
					{["rating"]= charData['r2'], ["seasonWon"]=charData['r2'], ["seasonLost"]=charData['r2'], ["seasonPlayed"]=charData['r2'],  ["winrate"]=charData['r2'],  ["highest"]=charData['r2'] },
					["3v3"] = 
					{["rating"]= charData['r2'], ["seasonWon"]=charData['r2'], ["seasonLost"]=charData['r2'], ["seasonPlayed"]=charData['r2'],  ["winrate"]=charData['r2'],  ["highest"]=charData['r2'] },
					["rbg"] = 
					{["rating"]= charData['r2'], ["seasonWon"]=charData['r2'], ["seasonLost"]=charData['r2'], ["seasonPlayed"]=charData['r2'],  ["winrate"]=charData['r2'],  ["highest"]=charData['r2'] },
			}

			
			local infoString2v2, infoString3v3, infoStringRbg, infoStringDate, infoStringSolo;
			local infoString2v2LastSeason, infoString3v3LastSeason, infoStringRbgLastSeason


			if (charData['w2'] + charData['l2'] ~= 0) then
				infoString2v2 = prefixColor .. '2v2' .. ': ' ..GetScoreColor(charData['r2'])..charData['r2']..prefixColor..' | '..prefixColor..charData['w2']..'-'..charData['l2']..' | '..detailColor..'Highest ('..GetScoreColor(charData['h2'])..charData['h2']..detailColor..')'
			else
				--infoString2v2 =   prefixColor .. '2v2' .. ': '..'None';
			end
		
			if (charData['w3'] + charData['l3'] ~= 0) then
				infoString3v3 = prefixColor .. '3v3' .. ': ' ..GetScoreColor(charData['r3'])..charData['r3']..prefixColor..' | '..prefixColor..charData['w3']..'-'..charData['l3']..' | '..detailColor..'Highest ('..GetScoreColor(charData['h3'])..charData['h3']..detailColor..')'
			else
				--infoString3v3 =   prefixColor .. '3v3' .. ': '..'None';
			end
		
			if (charData['wr'] + charData['lr'] ~= 0) then
				infoStringRbg = prefixColor .. 'RBG' .. ': ' ..GetScoreColor(charData['rr'])..charData['rr']..prefixColor..' | '..prefixColor..charData['wr']..'-'..charData['lr']..' | '..detailColor..'Highest ('..GetScoreColor(charData['hr'])..charData['hr']..detailColor..')'
			else
				--infoStringRbg =   prefixColor .. 'RBG' .. ': '..'None';
			end

			infoStringLikes = '';

	-- LAST SEASON Data

	if (charData['s1_w2']) then
		if (charData['s1_w2'] + charData['s1_l2'] ~= 0) then
			infoString2v2LastSeason = prefixColor .. '2v2' .. ': ' .. GetScoreColor(charData['s1_r2']) .. charData['s1_r2'] .. prefixColor .. ' | ' .. prefixColor .. charData['s1_w2'] .. '-' .. charData['s1_l2']
		else
			infoString2v2LastSeason = prefixColor .. '2v2' .. ': ' .. 'None';
		end

		if (charData['s1_w3'] + charData['s1_l3'] ~= 0) then
			infoString3v3LastSeason = prefixColor .. '3v3' .. ': ' .. GetScoreColor(charData['s1_r3']) .. charData['s1_r3'] .. prefixColor .. ' | ' .. prefixColor .. charData['s1_w3'] .. '-' .. charData['s1_l3']
		else
			infoString3v3LastSeason = prefixColor .. '3v3' .. ': ' .. 'None';
		end

		if (charData['s1_wr'] + charData['s1_lr'] ~= 0) then
			infoStringRbgLastSeason = prefixColor .. 'RBG' .. ': ' .. GetScoreColor(charData['s1_rr']) .. charData['s1_rr'] .. prefixColor .. ' | ' .. prefixColor .. charData['s1_wr'] .. '-' .. charData['s1_lr']
		else
			infoStringRbgLastSeason = prefixColor .. 'RBG' .. ': ' .. 'None';
		end
	end

	if (charData['sw'] > 0) then
		infoStringSolo = prefixColor .. charData['sw'] .. 'W'.. prefixColor .. ' - ' .. prefixColor  .. charData['sl'] ..'L'
	end




			-- Only doing this on LFG tooltip
			-- if (charData['li'] > 0) then
			-- print(leaderName)

			-- 	infoStringLikes = charData['li'].." people have enjoyed playing with "..leaderName
			-- end


			infoStringDate = prefixColor .. 'Updated' .. ': ' ..detailColor..charData['lu']


			GameTooltip:AddLine(infoStringDate)
	if (infoString2v2 or infoString3v3 or infoStringRbg) then
		if (infoString2v2) then
			GameTooltip:AddLine(infoString2v2)
		end

		if (infoString3v3) then
			GameTooltip:AddLine(infoString3v3)
		end

		if (infoStringRbg) then
			GameTooltip:AddLine(infoStringRbg)

		end
	else
		GameTooltip:AddLine('No PVP Data This Season')
	end

	if (charData['s1_w2']) then

		GameTooltip:AddLine(' ')
		GameTooltip:AddLine("Last Season")
		GameTooltip:AddLine(infoString2v2LastSeason)
		GameTooltip:AddLine(infoString3v3LastSeason)
		GameTooltip:AddLine(infoStringRbgLastSeason)

	end


	if (charData['sw'] > 0) then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine("Solo Shuffle")
		GameTooltip:AddLine(infoStringSolo)
	end



			-- if (infoStringLikes) then
				-- GameTooltip:AddLine(infoStringLikes)
			-- end

			GameTooltip:Show()
end

	local function ApplyHooks()
		for i = #uiHooks, 1, -1 do
			local func = uiHooks[i]
			-- if the function returns true our hook succeeded, we then remove it from the table
			if func() then
				table.remove(uiHooks, i)
			end
		end
	end


	function GetTimezoneOffset(ts)
		local u = date("!*t", ts)
		local l = date("*t", ts)
		l.isdst = false
		return difftime(time(l), time(u))
	end
	
	-- gets the current region name and index
	function GetRegion()
		-- use the player GUID to find the serverID and check the map for the region we are playing on
		local guid = UnitGUID("player")
		local server
		if guid then
			server = tonumber(strmatch(guid, "^Player%-(%d+)") or 0) or 0
			local i = CONST_REGION_IDS[server]
			if i then
				return REGIONS[i], i
			end
		end
		-- alert the user to report this to the devs
		--DEFAULT_CHAT_FRAME:AddMessage(format(L.UNKNOWN_SERVER_FOUND, addonName, guid or "N/A", GetNormalizedRealmName() or "N/A"), 1, 1, 0)
		-- fallback logic that might be wrong, but better than nothing...
		local i = GetCurrentRegion()
		return REGIONS[i], i
		end


	UnitPopupButtons = { }
	UnitPopupButtons["DRUSTVAR_ARMORY_LINK"] = { text = "Copy Drustvar PVP URL", dist = 0 }
	
	local frame = CreateFrame("Frame", "CheckDrustvarPvPFrame", UIParent, "UIPanelDialogTemplate")
	local edit = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
	frame.edit = edit
	
	
	--Frame Setup
	frame:Hide()
	frame:SetHeight(80)
	frame:SetWidth(500)
	frame:SetPoint("CENTER", UIParent, "TOP", 0, -1 * GetScreenHeight() / 4)
	frame:EnableKeyboard(false)
	frame.Title:SetText("Copy Drustvar PVP URL")
	frame:SetMovable(true)
	frame:SetScript("OnShow", function(self) self.edit:SetFocus() end)
	frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	frame:RegisterForDrag("LeftButton")
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	
	-- Editbox Setup
	edit:SetPoint("TOPLEFT", frame, "LEFT", 30, 0)
	edit:SetPoint("BOTTOMRIGHT", frame, "RIGHT", -30, -16)
	edit:SetScript("OnEnterPressed", function(self) self:GetParent():Hide() end)
	edit:SetScript("OnEscapePressed", function(self) self:GetParent():Hide() end)
	edit:SetScript("OnSpacePressed", function(self) self:GetParent():Hide() end)
	edit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
	edit:SetScript("OnUpdate", function(self) self:HighlightText() end)
	edit:SetJustifyH("CENTER")
	edit:SetAutoFocus(true)	
	
	-- PLAYER DROPDOWN
	hooksecurefunc("UnitPopup_ShowMenu", function(self,which, unit, name, userData)
		
		if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
			return
		end

		if (
			which == "COMMUNITIES_WOW_MEMBER" or 
			which == "COMMUNITIES_GUILD_MEMBER" or
			which == "PARTY" or which == "SELF" or which == "PLAYER" or
			which == "FRIEND" or which == "RAID_PLAYER" or
			which == "TARGET"
			 
		) then
			local info = UIDropDownMenu_CreateInfo()
			info.text = "Copy Drustvar PVP URL"
			info.owner = self.which
			info.notCheckable = 1
			-- info.func = blackListButton -- TODO instead of watching for name of click
			-- info.colorCode = "|cffff0000"
			info.value = "Armory_Link_Setup"
	
	
			UIDropDownMenu_AddSeparator()
			UIDropDownMenu_AddButton(info)
		end
	end)
	
	
	
	-- Causes blocked by blizzard ui when using set focus
	
	-- Add it to the FRIEND, PLAYER, PARTY, RAID, RAID_PLAYER, and SELF menus as the 2nd to last option (before Cancel)
	-- place it as 3rd to last on self so that its before 'leave party'
	-- table.insert(UnitPopupMenus["FRIEND"], #UnitPopupMenus["FRIEND"], "DRUSTVAR_ARMORY_LINK")
	-- table.insert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"], "DRUSTVAR_ARMORY_LINK")
	
	-- table.insert(UnitPopupMenus["PARTY"], #UnitPopupMenus["PARTY"], "DRUSTVAR_ARMORY_LINK")
	-- table.insert(UnitPopupMenus["RAID"], #UnitPopupMenus["RAID"], "DRUSTVAR_ARMORY_LINK")
	-- table.insert(UnitPopupMenus["RAID_PLAYER"], #UnitPopupMenus["RAID_PLAYER"], "DRUSTVAR_ARMORY_LINK")
	-- table.insert(UnitPopupMenus["SELF"], #UnitPopupMenus["SELF"] - 2, "DRUSTVAR_ARMORY_LINK")
	-- insertbefore(UnitPopupMenus["SELF"], "FOCUS", "METAGUILD_INVITE")
	
	
	-- --Bnet friend menu handle is "BN_FRIEND"
	table.insert(UnitPopupMenus["BN_FRIEND"], #UnitPopupMenus["BN_FRIEND"], "DRUSTVAR_ARMORY_LINK")
	table.insert(UnitPopupMenus["GUILD"], #UnitPopupMenus["GUILD"], "DRUSTVAR_ARMORY_LINK")
	table.insert(UnitPopupMenus["GUILD_OFFLINE"], #UnitPopupMenus["GUILD_OFFLINE"], "DRUSTVAR_ARMORY_LINK")
	table.insert(UnitPopupMenus["CHAT_ROSTER"], #UnitPopupMenus["CHAT_ROSTER"], "DRUSTVAR_ARMORY_LINK")
	-- table.insert(UnitPopupMenus["TARGET"], #UnitPopupMenus["TARGET"], "DRUSTVAR_ARMORY_LINK")
	
	-- table.insert(UnitPopupMenus["ARENAENEMY"], #UnitPopupMenus["ARENAENEMY"], "DRUSTVAR_ARMORY_LINK")
	-- table.insert(UnitPopupMenus["FOCUS"], #UnitPopupMenus["FOCUS"], "DRUSTVAR_ARMORY_LINK")
	-- table.insert(UnitPopupMenus["WORLD_STATE_SCORE"], #UnitPopupMenus["WORLD_STATE_SCORE"], "DRUSTVAR_ARMORY_LINK")
	-- table.insert(UnitPopupMenus["COMMUNITIES_GUILD_MEMBER"], #UnitPopupMenus["COMMUNITIES_GUILD_MEMBER"], "DRUSTVAR_ARMORY_LINK")
	-- table.insert(UnitPopupMenus["COMMUNITIES_WOW_MEMBER"], #UnitPopupMenus["COMMUNITIES_WOW_MEMBER"], "DRUSTVAR_ARMORY_LINK")
	
	
	-- Your function to setup your button
	local function Armory_Link_Setup(level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList, button, autoHideDelay)
		
		-- Make sure we have what we need to continue
		if dropDownFrame and level then
			local name, server, active, customaction, region
			region = GetRegion()
	
	
			if dropDownFrame.which == "BN_FRIEND" then
				
				--bnet friend menu
				if dropDownFrame.bnetIDAccount then
	
					--get the gameaccount id and the game
					local acc = C_BattleNet.GetAccountInfoByID(dropDownFrame.bnetIDAccount)
					local game = acc.gameAccountInfo
	
					if game.clientProgram == BNET_CLIENT_WOW then
	
						--if they are playing wow then get the character and server
						name = C_BattleNet.GetAccountInfoByID(dropDownFrame.bnetIDAccount)['gameAccountInfo']['characterName']
						server = C_BattleNet.GetAccountInfoByID(dropDownFrame.bnetIDAccount)['gameAccountInfo']['realmName']
						active = true
					else
						--otherwise, disable. they are playing a different game
						active = false
					end
				end
			else
				--other menu
				if dropDownFrame.name then
					name = dropDownFrame.name
					
	
					if(dropDownFrame.server == nil or dropDownFrame.server == "") then
						server = GetRealmName()
					else
						server = dropDownFrame.server
					end
	
					active = true
				else
					active = false
					if(menuList) then
						if(menuList[2].arg1) then
							customaction = true
						end
					end
				end
			end
	
	
			-- if server then 
			-- 	server = GetRealmSlug(server)
			-- end
			
			-- Just so we don't have to concat strings for each interval
			local buttonPrefix = "DropDownList" .. level .. "Button"
			-- Start at 2 because 1 is always going to be the title (i.e. player name) in our case
			local i = 2
			while (1) do
				-- Get the button at index i in the dropdown
				local button = _G[buttonPrefix..i]
				if not button then break end
				-- If the button is our button...
				if button:GetText() == UnitPopupButtons["DRUSTVAR_ARMORY_LINK"].text then

					if active == true then
						-- Make it execute function for player that this menu popped up for (button at index 1)
						button.func = function()
							-- Function for the button
							--Set edit box
							edit:SetText("https://drustvar.com/character/"..region.."/"..GetRealmSlug(server)..'/'..name..'?utm_source=addon')
							frame:Show()
						end
					else
						button.func = function()



							local splitName = splitString(menuList[2].arg1,'-')
							local server = GetRealmSlug(splitName[2])


							-- Function for the button
							if(customaction == true) then
								-- edit:SetText('test'..menuList[2].arg1)
								edit:SetText("https://drustvar.com/character/"..region.."/"..server..'/'..splitName[1]..'?utm_source=addon')
								frame:Show()
							else
							--player not playing wow
							end
						end
					end
					-- Break the loop; we got what we were looking for.
					break
				end
				i = i + 1
			end
		end
	end
	
	
	-- Hook ToggleDropDownMenu with your function
	hooksecurefunc("ToggleDropDownMenu", Armory_Link_Setup);
	
	--Remove interact distance requirement
	-- UnitPopupButtons["DRUSTVAR_ARMORY_LINK"].dist = nil;


local LFG_LIST_SEARCH_ENTRY_MENU = {
	{
		text = nil,	--Group name goes here
		isTitle = true,
		notCheckable = true,
	},
	{
		text = WHISPER_LEADER,
		func = function(_, name) ChatFrame_SendTell(name); end,
		notCheckable = true,
		arg1 = nil, --Leader name goes here
		disabled = nil, --Disabled if we don't have a leader name yet or you haven't applied
		tooltipWhileDisabled = 1,
		tooltipOnButton = 1,
		tooltipTitle = nil, --The title to display on mouseover
		tooltipText = nil, --The text to display on mouseover
	},
	{
		text = LFG_LIST_REPORT_GROUP_FOR,
		notCheckable = true,
		func = function(_, id, name)
			LFGList_ReportListing(id, name);
			LFGListSearchPanel_UpdateResultList(LFGListFrame.SearchPanel);
		end;
	},
		{
			text = "Copy Drustvar PVP URL",
			notCheckable = true,
			arg1 = nil, --Player name goes here
			disabled = nil, --Disabled if we don't have a name yet
		},
	{
		text = CANCEL,
		notCheckable = true,
	},
};


	-- doesnt work
	-- local LFGListUtil_GetSearchEntryMenu = LFGListUtil_GetSearchEntryMenu

function LFGListUtil_GetSearchEntryMenu(resultID)
	local searchResultInfo = C_LFGList.GetSearchResultInfo(resultID);
	local _, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(resultID);
	LFG_LIST_SEARCH_ENTRY_MENU[1].text = searchResultInfo.name;
	LFG_LIST_SEARCH_ENTRY_MENU[2].arg1 = searchResultInfo.leaderName;
	local applied = (appStatus == "applied" or appStatus == "invited");
	LFG_LIST_SEARCH_ENTRY_MENU[2].disabled = not searchResultInfo.leaderName;
	LFG_LIST_SEARCH_ENTRY_MENU[2].tooltipTitle = (not applied) and WHISPER
	LFG_LIST_SEARCH_ENTRY_MENU[2].tooltipText = (not applied) and LFG_LIST_MUST_SIGN_UP_TO_WHISPER;
	LFG_LIST_SEARCH_ENTRY_MENU[3].arg1 = resultID;
	LFG_LIST_SEARCH_ENTRY_MENU[3].arg2 = searchResultInfo.leaderName;
	return LFG_LIST_SEARCH_ENTRY_MENU;
end

function LFGList_ReportApplicant(applicantID, applicantName)
	local reportInfo = ReportInfo:CreateReportInfoFromType(Enum.ReportType.GroupFinderApplicant);
	reportInfo:SetGroupFinderApplicantID(applicantID);
	ReportFrame:InitiateReport(reportInfo, applicantName);
end

--
--local LFG_LIST_APPLICANT_MEMBER_MENU = {
--	{
--		text = nil, --Player name goes here
--		isTitle = true,
--		notCheckable = true,
--	},
--	{
--		text = WHISPER,
--		func = function(_, name) ChatFrame_SendTell(name); end,
--		notCheckable = true,
--		arg1 = nil, --Player name goes here
--		disabled = nil, --Disabled if we don't have a name yet
--	},
--	{
--		text = L.ARMORYQUICKLINK,
--		func = function(_, name) LFGShowUrl(name); end,
--		notCheckable = true,
--		arg1 = nil, --Player name goes here
--		disabled = nil, --Disabled if we don't have a name yet
--	},
--	{
--		text = WOWP_TEXT,
--		func = function(_, name) LFGShowUrlWOWP(name); end,
--		notCheckable = true,
--		arg1 = nil, --Player name goes here
--		disabled = nil, --Disabled if we don't have a name yet
--	},
--	{
--		text = LFG_LIST_REPORT_FOR,
--		hasArrow = true,
--		notCheckable = true,
--		menuList = {
--			{
--				text = LFG_LIST_BAD_PLAYER_NAME,
--				notCheckable = true,
--				func = function(_, id, memberIdx) C_LFGList.ReportApplicant(id, "badplayername", memberIdx); end,
--				arg1 = nil, --Applicant ID goes here
--				arg2 = nil, --Applicant Member index goes here
--			},
--			{
--				text = LFG_LIST_BAD_DESCRIPTION,
--				notCheckable = true,
--				func = function(_, id) C_LFGList.ReportApplicant(id, "lfglistappcomment"); end,
--				arg1 = nil, --Applicant ID goes here
--			},
--		},
--	},
--	{
--		text = IGNORE_PLAYER,
--		notCheckable = true,
--		func = function(_, name, applicantID) AddIgnore(name); C_LFGList.DeclineApplicant(applicantID); end,
--		arg1 = nil, --Player name goes here
--		arg2 = nil, --Applicant ID goes here
--		disabled = nil, --Disabled if we don't have a name yet
--	},
--	{
--		text = CANCEL,
--		notCheckable = true,
--	},
--};


local LFG_LIST_APPLICANT_MEMBER_MENU = {
	{
		text = nil,	--Player name goes here
		isTitle = true,
		notCheckable = true,
	},
	{
		text = WHISPER,
		func = function(_, name) ChatFrame_SendTell(name); end,
		notCheckable = true,
		arg1 = nil, --Player name goes here
		disabled = nil, --Disabled if we don't have a name yet
	},
	{
		text = LFG_LIST_REPORT_PLAYER,
		notCheckable = true,
		func = function(_, applicantID, applicantName) LFGList_ReportApplicant(applicantID, applicantName) end,
	},
	{
		text = IGNORE_PLAYER,
		notCheckable = true,
		func = function(_, name, applicantID) C_FriendList.AddIgnore(name); C_LFGList.DeclineApplicant(applicantID); end,
		arg1 = nil, --Player name goes here
		arg2 = nil, --Applicant ID goes here
		disabled = nil, --Disabled if we don't have a name yet
	},
	{
		text = CANCEL,
		notCheckable = true,
	},
};

--
--local LFG_LIST_APPLICANT_MEMBER_MENU = {
--	{
--		text = nil,	--Player name goes here
--		isTitle = true,
--		notCheckable = true,
--	},
--	{
--		text = WHISPER,
--		func = function(_, name) ChatFrame_SendTell(name); end,
--		notCheckable = true,
--		arg1 = nil, --Player name goes here
--		disabled = nil, --Disabled if we don't have a name yet
--	},
--	{
--		text = LFG_LIST_REPORT_PLAYER,
--		notCheckable = true,
--		func = function(_, applicantID, applicantName) LFGList_ReportApplicant(applicantID, applicantName) end,
--	},
--	{
--		text = IGNORE_PLAYER,
--		notCheckable = true,
--		func = function(_, name, applicantID) C_FriendList.AddIgnore(name); C_LFGList.DeclineApplicant(applicantID); end,
--		arg1 = nil, --Player name goes here
--		arg2 = nil, --Applicant ID goes here
--		disabled = nil, --Disabled if we don't have a name yet
--	},
--	{
--		text = "Copy Drustvar PVP URL",
--		notCheckable = true,
--		arg1 = nil, --Player name goes here
--		disabled = nil, --Disabled if we don't have a name yet
--	},
--	{
--		text = CANCEL,
--		notCheckable = true,
--	},
--};


function LFGListUtil_GetApplicantMemberMenu(applicantID, memberIdx)
	local name, class, localizedClass, level, itemLevel, tank, healer, damage, assignedRole = C_LFGList.GetApplicantMemberInfo(applicantID, memberIdx);
	local id, status, pendingStatus, numMembers, isNew, comment = C_LFGList.GetApplicantInfo(applicantID);
	LFG_LIST_APPLICANT_MEMBER_MENU[1].text = name or " ";
	LFG_LIST_APPLICANT_MEMBER_MENU[2].arg1 = name;
	LFG_LIST_APPLICANT_MEMBER_MENU[2].disabled = not name or (status ~= "applied" and status ~= "invited");
	-- AQL
	LFG_LIST_APPLICANT_MEMBER_MENU[3].arg1 = name;
	LFG_LIST_APPLICANT_MEMBER_MENU[3].disabled = not name or (status ~= "applied" and status ~= "invited");
	-- WOWP
	LFG_LIST_APPLICANT_MEMBER_MENU[4].arg1 = name;
	LFG_LIST_APPLICANT_MEMBER_MENU[4].disabled = not name or (status ~= "applied" and status ~= "invited");
	LFG_LIST_APPLICANT_MEMBER_MENU[5].menuList[1].arg1 = applicantID;
	LFG_LIST_APPLICANT_MEMBER_MENU[5].menuList[1].arg2 = memberIdx;
	LFG_LIST_APPLICANT_MEMBER_MENU[5].menuList[2].arg1 = applicantID;
	LFG_LIST_APPLICANT_MEMBER_MENU[5].menuList[2].disabled = (comment == "");
	LFG_LIST_APPLICANT_MEMBER_MENU[6].arg1 = name;
	LFG_LIST_APPLICANT_MEMBER_MENU[6].arg2 = applicantID;
	LFG_LIST_APPLICANT_MEMBER_MENU[6].disabled = not name;
	return LFG_LIST_APPLICANT_MEMBER_MENU;
end
	
	function splitString (inputstr, sep)
		if sep == nil then
				sep = "%s"
		end
		local t={}
		for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
				table.insert(t, str)
		end
		return t
	end
	
	
	function GetScoreColor(score)
		if score <= 1499 then
			return '|cff9d9d9d'
		elseif score <= 1799 then
			return '|cff1eff00'
		elseif score <= 2099 then
			return '|cff0070dd'
		elseif score <= 2399 then
			return '|cffa335ee'
		else 
			return '|cffff8000'
		end
	end
	
	
	
	-- register events and wait for the addon load event to fire
	-- f:SetScript("OnEvent", function(_, event, ...) [event](f, event, ...) end)
	-- addon:SetScript("OnEvent", function(_, event, ...) addon[event](addon, event, ...) end)
	ApplyHooks()