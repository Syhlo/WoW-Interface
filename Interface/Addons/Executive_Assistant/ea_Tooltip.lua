-- ------------------------------------------------------------------------- --
-- Project: Executive Assistant - To-Do/Task List Manager
-- Author:  VincentSDSH				
-- ------------------------------------------------------------------------- --
local AddonName = ...
local debug = ExecAssist.debug
local LibQTip = LibStub("LibQTip-1.0moddedForExecAssist")
local L   		= LibStub("AceLocale-3.0"):GetLocale(AddonName)
local LSM     = LibStub("LibSharedMedia-3.0")
local tooltipType -- this var intentionally left nil
local EXECASSIST_TOOLTIP = AddonName.."_Tooltip"
local ttData_idx = {["TW"] = {["player"] = {}}, ["char"] = {["player"] = {}}, ["GTP"] = {}}
	-- contains session-persistent collapse booleans and group-sibling data NB: char lack context in GTP (tooltip display data index)

	-- helper -- 
function ExecAssist:pushCollapseMap()
	local char = self.db.char
	if self.db.global.Options.SaveCollapseMap then
		if char.map.char then ttData_idx["char"][self.userCurrent] = char.map["char"] end
		if char.map.TW   then ttData_idx["TW"][self.userCurrent]   = char.map["TW"]   end
		if char.map.GTP  then ttData_idx["GTP"]                    = char.map["GTP"]  end
		
--[[ -- Pulled this back to :GarbageCollection()
		-- prune out garbage collected since last login
		local aggStem, hIdx = self.db.global.groupStem.agg
		local function executeHeretics(hIdx)
			if hIdx then	
				for handle, data in pairs(hIdx) do  -- note: __garden (!="garden") is nuked but it only contains a sibMap which is nuked/regened in the dataBuilder
					if not aggStem[handle] then hIdx[handle] = nil end
				end
			end
		end

		if ttData_idx.TW[self.userCurrent] then hIdx = ttData_idx.TW[self.userCurrent].PGT; executeHeretics(hIdx) end       -- TW
		if ttData_idx.char[self.userCurrent] then hIdx = ttData_idx.char[self.userCurrent].PGT; executeHeretics(hIdx); end  -- char-PGT
		hIdx = ttData_idx["GTP"]; if hIdx then executeHeretics(hIdx) end																										-- GTP
--]]
	else
		if char.map then char.map = {["char"] = nil, ["TW"] = nil, ["GTP"] = nil} end -- cleanup
	end
end	

function ExecAssist:getCheckedState(charName, taskID) -- Task
	local sdbg = ExecAssist.db.global

	if sdbg.groupStem.agg[taskID].isAcctWide then
		local AWagg = sdbg.acctwideStem.agg
		if AWagg[taskID] and AWagg[taskID].checked then
			return true 
		else 
			return false 
		end
	else
		local charStem = sdbg.charStem[charName]
		if not charStem.agg then return false end -- no agg = nothing checked
		if charStem.agg[taskID] and charStem.agg[taskID].checked then 
			return true 
		else 
			return false 
		end
	end	
end
function ExecAssist:getSnowflake()
	local idxTT, hGroup = ttData_idx.TW[ExecAssist.userCurrent]["PGT"]
	if idxTT.isSpecialSnowflake then
		hGroup = self.db.global.groupStem.agg[ idxTT.isSpecialSnowflake ]		
		if not hGroup then idxTT.isSpecialSnowflake = nil end
	end
return hGroup and hGroup.listName or nil
end
function ExecAssist:snowflake_putOld(listType)
	local idxTT = ttData_idx[listType][ExecAssist.userCurrent]["PGT"]
	if idxTT.isSpecialSnowflake and not idxTT.oldSnowflakeState then
		idxTT.oldSnowflakeState = {idxTT[idxTT.isSpecialSnowflake].isCollapsed} 				-- kludge to get around the pairs() throwing up over a boolean
		idxTT[idxTT.isSpecialSnowflake].isCollapsed = false
	end
end
function ExecAssist:snowflake_getOld(listType)
	local idxTT = ttData_idx[listType][ExecAssist.userCurrent]["PGT"]
	if idxTT.oldSnowflakeState and idxTT.isSpecialSnowflake and idxTT[idxTT.isSpecialSnowflake] then 
		idxTT[idxTT.isSpecialSnowflake].isCollapsed = idxTT.oldSnowflakeState[1] 			-- kludge to get around the pairs() throwing up over a boolean
		idxTT.oldSnowflakeState = nil
	end
end

function ExecAssist:ID_isActive(user, elementID)
 -- This really needs to be improved/streamlined
 -- -- maybe check datatype() of elementID in getBehavior_() so h_eleID can be direct passed
	local h_eleID = ExecAssist.db.global.groupStem.agg[elementID]

	local x = ExecAssist:getBehavior_isEnabled_OverrideOrDefault(user, elementID)
	local y = (not h_eleID.hideDays[date("*t").wday])
	local z = h_eleID.resetType ~= L.optsTable_base.TaskTypes["Reminder"].name -- L.optsTable_base.ResetTypes[6]
	return x and y and z
end

  -- gene checker --
local function geneChecker(user, groupID)
	local rc 
	local hGroup = ExecAssist.db.global.groupStem.agg[groupID]	

	if ExecAssist:ID_isActive(user, hGroup.id) then
		if not (hGroup.p == "garden") then
			rc = geneChecker(user, hGroup.p)
		else
			rc = true -- clean for char name all the way to the garden
		end			
	else
		rc = false -- group is disabled for char name
	end
	return rc	
end
function ExecAssist:hasCleanGenes(user, taskID)
	local rc
	if ExecAssist:ID_isActive(user, taskID) then -- query task itself; only check lineage if active
		rc = geneChecker(user, self.db.global.groupStem.agg[taskID].p)
	else
		rc = false -- task itself not active
	end
	return rc
end

	-- toggles --
function ExecAssist:toggleTask(mouseButton, taskID, isCurrentUser, charName, source)
	local function audioTask(isChecked) 
		if isChecked then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		else PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
		end 
	end

	local sdbg = self.db.global
	local hTask_cS, hTask
	if mouseButton == "LeftButton" then		
		if sdbg.groupStem.agg[taskID].isAcctWide then
			local AWagg = sdbg.acctwideStem.agg
			if not AWagg[taskID] then 
				AWagg[taskID] = {["checked"] = true}
			else
				AWagg[taskID].checked = not AWagg[taskID].checked
			end
			hTask_cS = AWagg[taskID] 
			audioTask(hTask_cS.checked)
		else
			if not isCurrentUser and not IsShiftKeyDown() then 
				ExecAssist:alert(L.alert_cannotToggleTask)
			else
				local charStem = sdbg.charStem[charName]
				if not charStem.agg[taskID] then 
					charStem.agg[taskID] = {["checked"] = true}
					hTask_cS = charStem.agg[taskID]
				else
					hTask_cS = charStem.agg[taskID]
					hTask_cS.checked = not hTask_cS.checked 
				end

				audioTask(hTask_cS.checked)		
			end
		end
	else	
		if sdbg[source].rightMouse_togglesShowChecked then sdbg[source].showChecked = not sdbg[source].showChecked  end
	end	

	-- module click handler call
	hTask = sdbg.groupStem.agg[taskID]
	if hTask.extCreate and self.loadedModules[hTask.extCreate] then
		-- if using an external module and the module is loaded, call the clickhandler
		self:GetModule(hTask.extCreate):intern_clickHandler(hTask, hTask_cS and hTask_cS.checked or nil, mouseButton)
	end
--? Nil return
	return hTask_cS
end
local function toggleTask(tbl, _, mouseButton) -- wrapper for self:toggleTask() to handle tooltip specific jiggery-pokery
	local args = tbl._OnMouseUp_arg
	local taskID = args.taskID
	local sdbg = ExecAssist.db.global
	local hTask_cS = ExecAssist:toggleTask(mouseButton, args.taskID, args.isCurrentUser, args.charName, args.source)

	if mouseButton == "LeftButton" then			
		if hTask_cS then -- something modified, update Tooltip
			if sdbg.tooltip.useCounts_onHeaders then
				-- refresh the tooltip; trying to retrofit the counts just isn't in the cards
				ExecAssist:displayTooltip(args.anchorFrame)
			else -- just update the task entry directly			
				ExecAssist.tooltip:SetCell(args.row, args.col, hTask_cS.checked and ExecAssist:mkLink(ExecAssist.icons.ldb_Complete, 16) or ExecAssist:mkLink(ExecAssist.icons.ldb_Incomplete, 16), nil, "LEFT")	
				ExecAssist.tooltip:UpdateScrolling()
			end
		end	
	else
		if sdbg.tooltip.rightMouse_togglesShowChecked then ExecAssist:displayTooltip(args.anchorFrame) end
	end
	if ExecAssist.taskWindow then ExecAssist:UpdateWindow() end -- TT and TW may have different layouts so both need to rebuild their maps
end

function ExecAssist:toggleCollapse(mouseButton, key, idxTT_key, charName )
	local idxTT
	if idxTT_key == "PGT" then idxTT = ttData_idx.char[charName]["PGT"]
	elseif idxTT_key == "TW" then idxTT = ttData_idx.TW[charName]["PGT"]	
	else idxTT = ttData_idx[idxTT_key]
	end

	if mouseButton == "LeftButton" then
		if IsControlKeyDown() then
			-- swap or unset cmdline target
			self:reset_CmdLineTarget(self.db.global.groupStem.agg[key])			
			
		else
			-- toggle Collapse State	
			idxTT[key].isCollapsed = not idxTT[key].isCollapsed -- toggle	
	
			if IsShiftKeyDown() then
				-- All Siblings should match
				local siblings = idxTT[idxTT[key].p].sibMap		
				for i=1,#siblings do
					idxTT[siblings[i]].isCollapsed = idxTT[key].isCollapsed
				end
			end
		end
	else		  					 	-- Zoom Group
		if self.userCurrent == charName then 
			idxTT.isSpecialSnowflake = (idxTT.isSpecialSnowflake ~= key) and key or nil -- store the groupID, update it, or remove it.
		else
			self:alert(L.ZoomIsLoggedInCharOnly:format( self.userCurrent:cf("EAtan")))
		end
	end
	
	if self.db.global.Options.SaveCollapseMap then
		if idxTT_key == "PGT" then    self.db.char.map["char"] = ttData_idx["char"][self.userCurrent]
		elseif idxTT_key == "TW" then self.db.char.map["TW"]   = ttData_idx["TW"][self.userCurrent]
		else													self.db.char.map["GTP"]  = ttData_idx["GTP"]
		end
	end
	
end
local function toggleCollapse(tbl, _, mouseButton) -- wrapper for self:toggleCollapse() to handle tooltip specific jiggery-pokery
	local args = tbl._OnMouseUp_arg
	ExecAssist:toggleCollapse(mouseButton, args.key, args.idxTT_key, args.charName )
	if mouseButton == "LeftButton" and IsControlKeyDown() and ExecAssist.db.char.useTaskWindow then ExecAssist:UpdateWindow() end
	ExecAssist:displayTooltip(args.anchorFrame)
end

  -- special flags --
function ExecAssist:isCharIgnored(charName, charStem)
	-- self.db.global.charStem[ >>charname<<].ignoreChar
	-- NB: Why, if foreshortened (e.g., charStem[charName]) not just check the charStem[charName].ignore in situ?
	--     Design choice to favor encapsulation over absolute efficiency (for maintenance and refactor benefits)
	if not charStem or not charStem.agg then -- if not supplied or not a foreshortened call (e.g., charStem[charName])
		charStem = self.db.global.charStem
		return charStem[charName].ignoreChar
	else -- return the tag
		return charStem.ignoreChar
	end
end
function ExecAssist:processIgnoredCharacters()
	-- reference: sdbg.charStem[self.userConfigDisplay].ignoreChar
  --            self.db.global.charStem[>>charname<<].ignoreChar
	local sdbg = self.db.global
	local charStem, garden = sdbg.charStem, sdbg.groupStem.agg["garden"].DO
	
	for char, stem in pairs(charStem) do
		if stem.ignoreChar then 
			debug("ignored", char)
			
			local charAgg = charStem[char].agg
			
			for i=1,#garden do
				local groupID = garden[i]
				debug(groupID, "groupID")
				
				if charAgg[groupID] then charAgg[ groupID ].userOverride = 3 -- stub already in place
				else charAgg[groupID] = {["userOverride"] = 3 }  -- need to create new stub
				end

			end		
		end
	end
	
	
end

	-- local libQtip funcs 
local function addSeparator(tooltip)    return tooltip:AddSeparator(2, .1, .9, .9, .9) end
local function addHSeparator(tooltip)   return tooltip:AddSeparator(2,  1,  1,  0, .9) end

	-- tooltip driver
function ExecAssist:displayTooltip(anchorFrame)
	if not ExecAssist.h_meatPopcicle and not self.db.char.useDataBrokerTooltip then return end -- LDB tooltip table is not dynamic if user changes modes mid-session
	-- h_mP only set by OnClick not OnEnter so 'not clickmapped and not enabled = return'
	
	local groupStem, charStem, tooltipStem = ExecAssist.db.global.groupStem, ExecAssist.db.global.charStem[ExecAssist.userCurrent], ExecAssist.db.global.tooltip
	local tooltip = ExecAssist.tooltip
	local row
	if not LibQTip:IsAcquired(EXECASSIST_TOOLTIP) or not tooltip then -- Build Tooltip Base --
		ExecAssist.tooltip  = LibQTip:Acquire(EXECASSIST_TOOLTIP)
		ExecAssist.tooltip.OnRelease = function() ExecAssist.tooltip = nil; ExecAssist.h_meatPopcicle = nil end  -- bit of cleanup
		tooltip = ExecAssist.tooltip			
	
		tooltip:Clear()
		tooltip:SetCellMarginH(0)
		tooltip:SetCellMarginV(0)
		tooltip:EnableMouse(true)
			
		local hf, sf = CreateFont("headerFont"), CreateFont("standardFont")  		
		hf:SetFont(LSM:Fetch("font", tooltipStem.header_font), tooltipStem.header_size, "")     --			hf:SetFont(LSM:Fetch("font", "Friz Quadrata TT"), 12, "") 
		sf:SetFont(LSM:Fetch("font", tooltipStem.standard_font), tooltipStem.standard_size, "") --			sf:SetFont(LSM:Fetch("font", "Friz Quadrata TT"), 10, "") 

		hf:SetShadowColor(tooltipStem.fontshadow.shadowcolor.r, tooltipStem.fontshadow.shadowcolor.g, tooltipStem.fontshadow.shadowcolor.b, tooltipStem.fontshadow.shadowcolor.a); 
		hf:SetShadowOffset(tooltipStem.fontshadow.offset.x, tooltipStem.fontshadow.offset.y)
		sf:SetShadowColor(tooltipStem.fontshadow.shadowcolor.r, tooltipStem.fontshadow.shadowcolor.g, tooltipStem.fontshadow.shadowcolor.b, tooltipStem.fontshadow.shadowcolor.a); 
		sf:SetShadowOffset(tooltipStem.fontshadow.offset.x, tooltipStem.fontshadow.offset.y)
	
		tooltip:SetHeaderFont(hf)
		tooltip:SetFont(sf)
		
		tooltip.specialSnowflake_font = CreateFont("specialSnowflake_font")
		tooltip.specialSnowflake_font:SetFont(LSM:Fetch("font", tooltipStem.snowflake_font), tooltipStem.snowflake_size, "")
		
		tooltip:SetScale(1)
		if not tooltipStem.useMouseoverHighlight then tooltip:SetHighlightTexture(nil) end
		if tooltipStem.tooltipStyle.useStyle then
			local ttbgcolor = tooltipStem.tooltipStyle.bgcolor		
			tooltip:SetBackdropColor(ttbgcolor.r, ttbgcolor.g, ttbgcolor.b, ttbgcolor.a)
		end			

		tooltip:SetAutoHideDelay( self.db.global.tooltip.AutoHideDelay or .01, anchorFrame	)	
	end

	tooltip:Clear()

	-- -------------------------------------------------------------------------------------------------------------- --
	if tooltipType == nil then tooltipType = tooltipStem.default_tooltipType end
	local data, maxCols = self:fetchData(tooltipType)
	tooltip:SetColumnLayout(maxCols)

	local function tooltiptip_OnLeave()	if not tooltipStem.enableTooltipTooltips then return end; ExecAssist.tooltipQ:Release("ExecAssist_TooltipTooltip"); ExecAssist.tooltipQ=nil end
	local function tooltiptip_OnEnter(tbl) 
		if not tooltipStem.enableTooltipTooltips then return end -- done this way so that the toggle will work realtime
		local args = tbl._OnEnter_arg
		if not ExecAssist.tooltipQ then 
			ExecAssist.tooltipQ = LibQTip:Acquire("ExecAssist_TooltipTooltip")
		end
		tooltip = ExecAssist.tooltipQ			
		tooltip:Clear()
		tooltip:SetCellMarginH(0); tooltip:SetCellMarginV(0)		
		local tf = CreateFont("tiptipFont"); tf:SetFont(LSM:Fetch("font", tooltipStem.header_font), tooltipStem.header_size, ""); tooltip:SetFont(tf)
	
		tooltip:SetScale(1)
		tooltip:SetBackdropColor(0, 0, 0, 1) 
		tooltip:SetAutoHideDelay(.25, ExecAssist.tooltip	)	
		tooltip:SmartAnchorTo(ExecAssist.tooltip)   
	
		tooltip:SetColumnLayout(1)
		tooltip:AddLine()
		
		local tip = {
			["PGT"] = L.tt_tt_PGT,
			["GTP"] = L.tt_tt_GTP,
			["1"] = (L.tt_tt_1):format( (L.leftMouse_shift):cf("cyan"), (L.leftMouse):cf("cyan"), (L.rightMouse):cf("cyan") ),
			["2"] = (L.tt_tt_2):format( (L.leftMouse_shift):cf("cyan"), (L.leftMouse):cf("cyan"), (L.rightMouse):cf("cyan") ),
			["3"] = (L.tt_tt_3):format( (L.leftMouse_shift):cf("cyan"), (L.leftMouse):cf("cyan"), (L.rightMouse):cf("cyan") ),
			["4"] = (L.tt_tt_4):format( (L.leftMouse_shift):cf("cyan"), (L.leftMouse):cf("cyan"), (L.rightMouse):cf("cyan") ),
			["occ"] = L.tt_tt_occ,
			["ac"] = L.tt_tt_ac,
			["s1"] = (L.tt_tt_s1):format((L.tt_tt_s1_g):cf("sunshine"), (L.rightMouse):cf("cyan"), (L.ctrl_leftMouse):cf("cyan"), (L.leftMouse_shift):cf("cyan"), (L.tt_tt_s1_ts):cf("sunshine"), (L.rightMouse):cf("cyan"), (L.tt_tt_s1f):cf("grass")),
		} 
		
		local p = {
			["b1"] = tooltipType ,
			["b2"] = tostring(ExecAssist["mode_" .. args.tooltipType]) ,
			["b3"] = tooltipStem.OnlyCurrentChar and "occ" or "ac",
			["s1"] = "s1"
		}
	
		tooltip:SetCell(1, 1, tip[p[args.b]])
	 	tooltip:UpdateScrolling()	
		tooltip:Show()
				
	end

	local function displayTooltipButtons() -- Tooltip Button local func
		--==[ Last Row ]==-- -------------------------------------------------------------------------------------------- --
		row = tooltip:AddHeader()
		-- List Display Type	
		local function quickToggle_whoIsInChargeHere(tbl) 
			if tooltipType == "PGT" then tooltipType = "GTP" 
			else tooltipType = "PGT" 
			end
			PlaySound(SOUNDKIT.IG_QUEST_LIST_OPEN); ExecAssist:displayTooltip(tbl._OnMouseUp_arg.anchorFrame) 
		end
		
		tooltip:SetCell(row, 1, tooltipType=="PGT" and self:mkLink(self.icons.ldb_tt_PGT, 16) or self:mkLink(self.icons.ldb_tt_GTP, 16))
		tooltip:SetCellScript(row, 1, "OnMouseUp", quickToggle_whoIsInChargeHere, {["anchorFrame"] = anchorFrame}) 	
		tooltip:SetCellScript(row, 1, "OnEnter", tooltiptip_OnEnter, {["b"] = "b1", ["tooltipType"] = tooltipType})
		tooltip:SetCellScript(row, 1, "OnLeave", tooltiptip_OnLeave)
	
		-- Show / Hide / Show All / Show Only Selected Groups     					-- advance to the next 'used' option; nb: if non are selected, the default overrides the de-selected child
		local function quickToggle_neverWriteFunctionNamesAtFourThirtyAM_theyGetSilly(tbl, _, mouseButton) -- NB: tbl is passed but we don't pass anything to use
			local mode = ExecAssist["mode_" .. tooltipType]; 
			local start = mode; 

			if mouseButton == "LeftButton" then		
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
				repeat mode=mode+1; if mode>4 then mode=1 end until ( tooltipStem[ExecAssist.modePool[mode].b .. "_" .. tooltipType ] and ExecAssist.modePool[mode][tooltipType] ) or mode==start;
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
				repeat mode=mode-1; if mode<1 then mode=4 end until ( tooltipStem[ExecAssist.modePool[mode].b] and ExecAssist.modePool[mode][tooltipType] ) or mode==start;
			end		
			ExecAssist["mode_" .. tooltipType] = mode			

			if tooltipType=="PGT" then
				if start ~= 3 and mode == 3 then     self:snowflake_putOld("char") -- store the state of snowflake used by other modes
				elseif start == 3 and mode ~= 3 then self:snowflake_getOld("char") -- restore the other-display-mode collapsed state
				end
			end
				
			ExecAssist:displayTooltip(tbl._OnMouseUp_arg.anchorFrame)		
		end
		tooltip:SetCell(row, 2, ExecAssist.modePool[ExecAssist["mode_" .. tooltipType]].i)  

		tooltip:SetCellScript(row, 2, "OnMouseUp", quickToggle_neverWriteFunctionNamesAtFourThirtyAM_theyGetSilly, {["anchorFrame"] = anchorFrame}) 	
		tooltip:SetCellScript(row, 2, "OnEnter", tooltiptip_OnEnter, {["b"] = "b2", ["tooltipType"] = tooltipType})
		tooltip:SetCellScript(row, 2, "OnLeave", tooltiptip_OnLeave)
			
		-- Show Special Snowflake Tag
		if ExecAssist["mode_" .. tooltipType] ~= 4 and tooltipType=="PGT" then 
			tooltip:SetCell(row, 3, " ", "CENTER", (maxCols - 3))
			tooltip:SetCellScript(row, 3, "OnEnter", tooltiptip_OnEnter, {["b"] = "s1", ["tooltipType"] = tooltipType})
			tooltip:SetCellScript(row, 3, "OnLeave", tooltiptip_OnLeave)

			local idxTT, hGroup = ttData_idx.char[ExecAssist.userCurrent]["PGT"]
			if idxTT.isSpecialSnowflake then
				hGroup = self.db.global.groupStem.agg[ idxTT.isSpecialSnowflake ]		

				if not hGroup then 
					idxTT.isSpecialSnowflake = nil 			
				else
					tooltip:SetCell(row, 3, hGroup.listName, tooltip.specialSnowflake_font, "CENTER", (maxCols - 3))
	
					tooltip:SetCellTextColor(row, 3, tooltipStem.SM.snowflake.color.r, tooltipStem.SM.snowflake.color.g, tooltipStem.SM.snowflake.color.b, 1)
				end
			end
		end
		
		-- if PGT, toggle Only Show Current Character
		local function quickToggle_Highlander(tbl) tooltipStem.OnlyCurrentChar = not tooltipStem.OnlyCurrentChar; ExecAssist:displayTooltip(tbl._OnMouseUp_arg.anchorFrame) end
		if tooltipType == "PGT" and ExecAssist["mode_" .. tooltipType] ~= 3 then
			tooltip:SetCell(row, maxCols, (tooltipStem.OnlyCurrentChar and self:mkLink(self.icons.ldb_OneChar, 16) or self:mkLink(self.icons.ldb_AllChar, 16)) .. " ", nil, "RIGHT")
			tooltip:SetCellScript(row, maxCols, "OnMouseUp", quickToggle_Highlander, {["anchorFrame"] = anchorFrame, ["txt"] = "Col "..tostring(maxCols).." was Clicked"}) 	
			tooltip:SetCellScript(row, maxCols, "OnEnter", tooltiptip_OnEnter, {["b"] = "b3", ["tooltipType"] = tooltipType})
			tooltip:SetCellScript(row, maxCols, "OnLeave", tooltiptip_OnLeave)
		end
	-- ----------------------------------------------------------------------------------------------------------------------- --
	
	end
	
		-- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- ---
		local function addStyle(row, col, text, styleStem )	
			local l_txt, r_txt
			if styleStem.useText ~= 1 then
				if styleStem.useText == 2 or styleStem.useText == 4 then l_txt = styleStem.useText_text.." " end		
				if styleStem.useText == 3 or styleStem.useText == 4 then r_txt = " "..styleStem.useText_text end
				if styleStem.useColor == 2 then
					l_txt = l_txt and l_txt:cfc(ExecAssist:tbl_pcColorToHex(styleStem.color)) or nil
					r_txt = r_txt and r_txt:cfc(ExecAssist:tbl_pcColorToHex(styleStem.color)) or nil
				end
				text = ("%s"..text.."%s"):format(true and l_txt or "", true and r_txt or "" ) -- formatted text to be returned for additive construction
				tooltip:SetCell(row, col, text )
			end
			
			if styleStem.useColor > 2 then
				if styleStem.useColor==3 then
					tooltip:SetCellTextColor(row, col, styleStem.color.r, styleStem.color.g, styleStem.color.b)
				elseif styleStem.useColor==4 then
					tooltip:SetCellColor(row, col, styleStem.color.r, styleStem.color.g, styleStem.color.b)
				elseif styleStem.useColor==5 then
					tooltip:SetLineColor(row, styleStem.color.r, styleStem.color.g, styleStem.color.b)
				end
			end
			return text
		end		
		local function styleRow(row, col, text, isAcctWide, isPurgable, isCmdTarget, isHidden, isSnowflake)
			-- Styles should be complimentary so text is returned (allows left/right of different types
			if isAcctWide  and tooltipStem.SM.acctwide.useStyle 		 then text = addStyle(row, col, text, tooltipStem.SM.acctwide) end
			if isPurgable  and tooltipStem.SM.purgable.useStyle 		 then text = addStyle(row, col, text, tooltipStem.SM.purgable) end
			
			if isCmdTarget and tooltipStem.SM.cmdLineTarget.useStyle then text = addStyle(row, col, text, tooltipStem.SM.cmdLineTarget) end
			if isHidden 	 and tooltipStem.SM.hidden.useStyle      	 then text = addStyle(row, col, text, tooltipStem.SM.hidden) end
			if isSnowflake and tooltipStem.SM.snowflake.useStyle 		 then text = addStyle(row, col, text, tooltipStem.SM.snowflake) end
		end 
		-- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- ---
	
	if tooltipStem.tooltipButtonPos == 1 then displayTooltipButtons() end	
	if     tooltipType == "GTP" then -- -------------------------------------------------------------------------------- --==[ GTP Layout ]==--
		local function mkGroup(col, entry_isCollapsed, groupName, groupID, isTop, isCmdTarget, isHidden)
			row = tooltip:AddHeader()
			tooltip:SetCell(row, col, entry_isCollapsed and self:mkLink(self.icons.ldb_Collapsed_h, 16) or self:mkLink(self.icons.ldb_Expanded_h, 16))
			tooltip:SetCell(row, col+1, groupName, nil, "LEFT", (maxCols-1-col) )

			-- apply base color (per config) then apply styles
			tooltip:SetCellTextColor(row, col+1, tooltipStem.color_Group.r, tooltipStem.color_Group.g, tooltipStem.color_Group.b, 1)
			styleRow(row, col+1, groupName, nil, nil, isCmdTarget, isHidden) -- melt special snowflake
						
			tooltip:SetLineScript(row, "OnMouseUp", toggleCollapse, {["anchorFrame"] = anchorFrame, ["key"] = groupID, ["charName"] = charName, ["idxTT_key"] = "GTP"}) 
			if isTop then addHSeparator(tooltip) end
		end
		local function mkTask(col, entry_isCollapsed, taskName, taskID, resetType, isAcctWide, count)
			row = tooltip:AddHeader()

			tooltip:SetCell(row, col, entry_isCollapsed and self:mkLink(self.icons.ldb_Collapsed, 16) or self:mkLink(self.icons.ldb_Expanded, 16 ))
			tooltip:SetCell(row, col+1, taskName, nil, "LEFT", (maxCols-1-col) )

			-- apply base color (per config) then apply styles
			tooltip:SetCellTextColor(row, col+1, tooltipStem.color_TaskName.r, tooltipStem.color_TaskName.g, tooltipStem.color_TaskName.b, 1)
			styleRow(row, col+1, taskName, isAcctWide, resetType==L.Purgable)

			tooltip:SetCell(row, maxCols, count, nil, "CENTER") -- counts
			tooltip:SetCellTextColor(row, maxCols, tooltipStem.color_taskCounts.r, tooltipStem.color_taskCounts.g, tooltipStem.color_taskCounts.b, 1)

			tooltip:SetLineScript(row, "OnMouseUp", toggleCollapse, {["anchorFrame"] = anchorFrame, ["key"] = taskID, ["charName"] = charName, ["idxTT_key"] = "GTP"})
		end
		local function mkChar(col, isChecked, charName, r, g, b, taskID, isCurrentUser)
			row = tooltip:AddLine()
			tooltip:SetCell(row, col, isChecked and self:mkLink(self.icons.ldb_Complete, 16) or self:mkLink(self.icons.ldb_Incomplete, 16), nil, "RIGHT")

			tooltip:SetCell(row, col+1, tooltipStem.ShowServerNames and charName or charName:sub(1,string.find(charName," - ",1, true)), nil, "LEFT", (maxCols-1-col)) 
			tooltip:SetCellTextColor(row, col+1, r, g, b, 1)


			tooltip:SetLineScript(row, "OnMouseUp", toggleTask, {["anchorFrame"] = anchorFrame, ["groupID"] = groupID, ["taskID"] = taskID, ["charName"] = charName, ["isCurrentUser"] = isCurrentUser, ["source"] = "tooltip"})
		end

		for i=1, #data do
			local d = data[i]
			if     d.type == "group" then mkGroup( d.col, d.groupCollapsed, d.groupName, d.groupID, d.isTop, d.isCmdTarget, d.isHidden)
			elseif d.type == "task"  then mkTask( d.col, d.taskCollapsed, d.taskName, d.taskID, d.resetType, d.isAcctWide, d.count)
			elseif d.type == "char"  then mkChar( d.col, d.isChecked, d.charName, d.r, d.g, d.b, d.taskID, d.isCurrentUser )			
			else self:alert("Tooltip Generator found incorrect type: "..d.type, 1, 0, 0)
			end
			
		end	
	elseif tooltipType == "PGT" then -- -------------------------------------------------------------------------------- --==[ PGT Layout ]==--
		local function mkChar(col, entry_isCollapsed, count, charName, r, g, b)
			row = tooltip:AddHeader()
			tooltip:SetCell(row, col, entry_isCollapsed and self:mkLink(self.icons.ldb_Collapsed_h, 16) or self:mkLink(self.icons.ldb_Expanded_h, 16) )
			tooltip:SetCell(row, col+1, tooltipStem.ShowServerNames and charName or charName:sub(1,string.find(charName," - ",1, true)), nil, "LEFT", (maxCols - 1 - col) ) 
			tooltip:SetCellTextColor(row, col+1, r, g, b, 1)
			tooltip:SetCell(row, maxCols, count, nil, "CENTER")
			tooltip:SetLineScript(row, "OnMouseUp", toggleCollapse, {["anchorFrame"] = anchorFrame, ["key"] = charName, ["idxTT_key"] = "char"}) 	
			
			addHSeparator(tooltip)	
		end
		local function mkGroup(col, entry_isCollapsed, count, charName, groupName, groupID, isCmdTarget, isHidden, isSpecialSnowflake)
			row = tooltip:AddHeader()
			tooltip:SetCell(row, col, entry_isCollapsed and self:mkLink(self.icons.ldb_Collapsed, 16) or self:mkLink(self.icons.ldb_Expanded, 16) )
			tooltip:SetCell(row, col+1, groupName, nil, "LEFT", (maxCols - 1 - col), nil, 0, 0, 500, 150)

			-- apply base color (per config) then apply styles
			tooltip:SetCellTextColor(row, col+1, tooltipStem.color_Group.r, tooltipStem.color_Group.g, tooltipStem.color_Group.b, 1)
			styleRow(row, col+1, groupName, nil, nil, isCmdTarget, isHidden, isSpecialSnowflake)
			
			tooltip:SetCell(row, maxCols, count, nil, "CENTER")
			tooltip:SetCellTextColor(row, maxCols, tooltipStem.color_taskCounts.r, tooltipStem.color_taskCounts.g, tooltipStem.color_taskCounts.b, 1)

			tooltip:SetLineScript(row, "OnMouseUp", toggleCollapse, {["anchorFrame"] = anchorFrame, ["key"] = groupID, ["charName"] = charName, ["idxTT_key"] = "PGT"}) 
		end
		local function mkTask(col, isChecked, taskName, resetType, taskID, charName, isCurrentUser, isAcctWide)	
			row = tooltip:AddLine()
			tooltip:SetCell(row, col, isChecked and self:mkLink(self.icons.ldb_Complete, 16) or self:mkLink(self.icons.ldb_Incomplete, 16), nil, "LEFT")
			tooltip:SetCell(row, col+1, taskName, nil, "LEFT", (maxCols - 1 - col) ) --, nil, 0, 0, tooltipStem.TaskEntry_MaxWidth, tooltipStem.TaskEntry_MinWidth)
			-- apply base color (per config) then apply styles
			tooltip:SetCellTextColor(row, col+1, tooltipStem.color_TaskName.r, tooltipStem.color_TaskName.g, tooltipStem.color_TaskName.b, 1)
			styleRow(row, col+1, taskName, isAcctWide, resetType==L.Purgable)

			-- Reset Type...needs fleshing out									
			tooltip:SetCell(row, maxCols, self.taskTypes[resetType].letter:rpad(3), nil, "RIGHT")		
			tooltip:SetCellTextColor(row, maxCols, self.taskTypes[resetType].color.r, self.taskTypes[resetType].color.g, self.taskTypes[resetType].color.b, self.taskTypes[resetType].color.a)

			tooltip:SetLineScript(row, "OnMouseUp", toggleTask, {["row"] = row, ["col"] = col, ["anchorFrame"] = anchorFrame, ["groupID"] = groupID, ["taskID"] = taskID, ["charName"] = charName, ["isCurrentUser"] = isCurrentUser, ["source"] = "tooltip"}) 
		end
		-- --- --
		for i=1, #data do
			local d = data[i]			
			if     d.type == "char"  then mkChar ( d.col, d.charCollapsed,  tooltipStem.useCounts_onHeaders and d.count or "", d.charName, d.r, d.g, d.b )
			elseif d.type == "group" then mkGroup( d.col, d.groupCollapsed, tooltipStem.useCounts_onHeaders and d.count or "", d.charName, d.groupName, d.groupID, d.isCmdTarget, d.isHidden, d.isSpecialSnowflake)
			elseif d.type == "task"  then mkTask ( d.col, d.isChecked, d.taskName, d.resetType, d.taskID, d.charName, d.isCurrentUser, d.isAcctWide)
			else
				self:alert("Data Processing Error, incorrect type: "..type, 1, 0, 0)
			end
		end	

	-- ----------------------------------------------------------------------------------------------------------------------- --
	else
		self:alert("Improper tooltipType: "..tooltipType, 1, 1, 0)
	end	
	if tooltipStem.tooltipButtonPos == 2 then displayTooltipButtons() end

	tooltip:SmartAnchorTo(anchorFrame)   -- Use smart anchoring code to anchor the tooltip to our frame   
 	tooltip:UpdateScrolling()
 	tooltip:Show()
end

	-- data map builder	
function ExecAssist:mkCharList() -- Alphabetize Character List
	local charStem_base = self.db.global.charStem
	ExecAssist.charList = {}; ExecAssist.compressed_charList = {}
	local CL, CCL = ExecAssist.charList, ExecAssist.compressed_charList
	for charName, charStem in pairs(charStem_base) do table.insert(CL, charName) end
	
	if self.db.global.tooltip.AllChar_GroupCharNames then 
		table.sort(CL)
	else
		function compareCharacters(a, b)
			local aServer = string.match(a, [[.* - (.*)]])
			local bServer = string.match(b, [[.* - (.*)]])
			if aServer ~= bServer then
				return aServer < bServer
			end
			return a < b
		end
		table.sort(CL, compareCharacters)	
	end
	
	for i=1,#CL do CCL[ CL[i]:gsub(" ", "") ] = CL[i]	end

end	
function ExecAssist:formatCountData(checked, unchecked, displayType)	
	if     displayType == 1 then return ("%d/%d"):format(checked, checked + unchecked)
	elseif displayType == 2 then return ("%d/%d"):format(checked, unchecked)
	elseif displayType == 3 then return ("%d"):format(unchecked)
	else                         return ("%d%%"):format( ((checked+unchecked) > 0) and (checked/(checked+unchecked))*100 or 0  )
	end		
end
function ExecAssist:fetchData(listType)
	-- the fetcher context-formats the requests, overriding the user when necessary
	local tooltipStem = self.db.global.tooltip
	local OnlyCurrentChar = tooltipStem.OnlyCurrentChar
	local HideCharHeader_OnlyCurrentChar = tooltipStem.HideCharHeader_OnlyCurrentChar

	if     listType == "PGT" then
		-- no mod
	elseif listType == "GTP" then
		OnlyCurrentChar = false -- makes absolutely no sense to do this with only 1 char
	elseif listType == "TW"  then -- TaskWindow
		OnlyCurrentChar = true 
		HideCharHeader_OnlyCurrentChar = true
	else
		self:alert(" Unrecognized fetchData listType: "..listType, 1, 1, 0)
	end
															-- ShowGroup Names should be redacted as a parameter
	return self:getDataList(listType, tooltipStem.ShowGroupNames, OnlyCurrentChar, HideCharHeader_OnlyCurrentChar)
end
function ExecAssist:getDataList(listType, ShowGroupNames, OnlyCurrentChar, HideCharHeader_OnlyCurrentChar)
	local sdbg = self.db.global
	local isAvail_taskType = self.isAvail_taskType
	local charStem_base, groupStem, tooltipStem, twStem = sdbg.charStem, sdbg.groupStem, sdbg.tooltip, sdbg.taskWindow
	local npcColor = tooltipStem.npc.npcColor
	local maxCategoryDepth, maxDepth = 0, 0
	local idxTT 
	local rc = {} -- <-- this gets returned to the fetcher

	local function formatCounts(checked, unchecked)
		local displayType_onHeaders = listType == "TW" and twStem.displayType_onHeaders or tooltipStem.displayType_onHeaders
		return self:formatCountData(checked, unchecked, displayType_onHeaders)
	end
	local function formatResetTypes(resetType)
		if isAvail_taskType[resetType] then return resetType
		else return L.optsTable_missingmodule_label
		end		
	end

	if     listType == "GTP" then	-- ------------------------------------------------------------------------------------	--==[ GTP BUILD ]==--
		local HideEmptyGroups = tooltipStem.HideEmptyGroups
		local checked, unchecked = 0, 0 -- counting kludge for GTP to avoid the LDB default recount
		-- ------------------------------------------------------------------------------------------------
		local function mkChar(rc, maxDepth, collapsed, charName, taskID, r, g, b)  -- col=1 by default           
			local maxCat = maxDepth + 1; if maxCat > maxCategoryDepth then maxCategoryDepth = maxCat end  
			local isChecked = self:getCheckedState(charName, taskID)
			
			if not collapsed then
				if (not isChecked) or (isChecked and tooltipStem.showChecked) then
					table.insert(rc, {["type"] = "char",  ["col"] = maxCat, ["taskID"] = taskID, ["charName"] = charName, 
														["isChecked"] = isChecked,["isCurrentUser"] = (charName == self.userCurrent),
														["charName"] = charName, ["r"] = r, ["g"] = g, ["b"] = b}) -- !! NEED CLASS COLORS
				end			
			end

			if charName == ExecAssist.userCurrent and tooltipStem.useCounts_onLDB then 
				if isChecked then checked=checked+1 
				else unchecked=unchecked+1 
				end 
			end
				
			return isChecked
		end
		-- ------------------------------------------------------------------------------------------------
		local function doTask(rc, taskID, maxDepth, collapsed) 
			local hTask = groupStem.agg[taskID]
			local checked, unchecked, IDactive = 0, 0, 0 
			local maxCat = maxDepth + 1; if maxCat > maxCategoryDepth then maxCategoryDepth = maxCat end  
			local tIdx

			if not collapsed then
		 		table.insert(rc, {["type"] = "task",  ["col"] = maxCat,  ["taskCollapsed"] = idxTT[taskID].isCollapsed,
		 											["taskName"] = hTask.taskName, ["taskID"] = taskID, ["resetType"] = hTask.resetType:sub(1,1),
		 											["isAcctWide"] = hTask.isAcctWide, ["count"] = count})
		 		tIdx = #rc 		
		 	end

			for i=1, #ExecAssist.charList do
				local charName = ExecAssist.charList[i] -- debugging aspirin
				local hChar = charStem_base[charName] 	-- debugging aspirin
				if self:hasCleanGenes(charName, taskID) then -- replacing self:ID_isActive(charName, taskID)
					IDactive=IDactive+1 -- HERE HERE HERE HERE HERE HERE HERE HERE HERE HERE HERE HERE HERE HERE HERE HERE HERE
					if mkChar(rc, maxCat, true and collapsed or idxTT[taskID].isCollapsed, charName, taskID, 
											hChar.charClass and RAID_CLASS_COLORS[hChar.charClass].r or npcColor.r, 
											hChar.charClass and RAID_CLASS_COLORS[hChar.charClass].g or npcColor.g, 
											hChar.charClass and RAID_CLASS_COLORS[hChar.charClass].b or npcColor.b) then 
					checked = checked+1 
					else unchecked=unchecked+1 
					end
				end
			end

			if not collapsed then rc[tIdx].count = formatCounts(checked, unchecked) end
			if HideEmptyGroups and IDactive == 0 then
				if tIdx then table.remove(rc, #rc) end -- tIdx b/c if no tIdx then no group entry to remove
				IDactive = -1 -- removes count for empty group when added up the stack
			else
				IDactive = 0
			end
			return IDactive
		end   
		-- ------------------------------------------------------------------------------------------------
		local function doGroup(rc, groupID, maxDepth, collapsed)  --NB: mk vs do: mk makes things, do does and makes things.
			local DO = groupStem.agg[groupID].DO                        						                      
			local maxCat = maxDepth + 1; if maxCat > maxCategoryDepth then maxCategoryDepth = maxCat end  
			local IDactive, IDactive_adder = 0, 0
			local modeSuppressed, gpIdx

			if ExecAssist["mode_"..listType]==4 then modeSuppressed = true end -- HideGroupNames

			if not collapsed and not modeSuppressed then	-- write header	
				local hGroup = groupStem.agg[groupID]		
				table.insert(rc, {["type"] = "group", ["col"] = maxCat>0 and maxCat or 1, ["isTop"] = maxCat==0 and true or false, ["groupCollapsed"] = idxTT[groupID].isCollapsed,
												  ["groupName"] = hGroup.listName, ["groupID"] = groupID, ["isCmdTarget"] = hGroup.cmdLineTarget, ["isHidden"] = hGroup.hideFromDisplay,
												 })
				gpIdx = #rc
			end
			
			idxTT[groupID].sibMap = {} -- clear group sibling map

			for n=1,#DO do                                                                                
				table.insert(idxTT[groupID].sibMap, DO[n]) -- insert child into Sibling Map             
				if not idxTT[DO[n]] then idxTT[DO[n]] = {["p"] = groupID, ["isCollapsed"] = true} end -- preloads the child's (DO[n]) parent ID            
			
				IDactive=IDactive+1
				if DO[n]:isGroup() then                                                                   
					IDactive_adder = doGroup(rc, DO[n], maxCat, true and collapsed or idxTT[groupID].isCollapsed)      
				else                                                                                      
					IDactive_adder = doTask(rc, DO[n], maxCat, true and collapsed or idxTT[groupID].isCollapsed)     
				end		                                                                                    
				IDactive = IDactive + IDactive_adder
			end	

			if HideEmptyGroups and IDactive == 0 then
				if gpIdx then table.remove(rc, #rc) end -- gpIdx b/c if no gpIdx then no group entry to remove
				IDactive = -1 -- removes count for empty group when added up the stack
			else
				IDactive = 0
			end
			return IDactive				                                                                                      
		end				
		-- ------------------------------------------------------------------------------------------------
		idxTT = ttData_idx["GTP"]  -- contains groups and tasks, all initially closed
		local hdrIndex

		local garden = groupStem.agg["garden"].DO
		if not idxTT["__garden"] then 
			idxTT["__garden"] = {["sibMap"] = {}} 
		else 
			idxTT["__garden"].sibMap = {} 
		end -- set / clear __garden sibling map

		for j=1,#garden do -- .garden is always groups
			table.insert(idxTT["__garden"].sibMap, garden[j])
			if not idxTT[garden[j]] then idxTT[garden[j]] = {["p"] = "__garden", ["isCollapsed"] = true} end -- preloads the child's (DO[n]) parent ID  
		
		  doGroup(rc, garden[j], maxDepth-1) -- or -1? group layout issues...			 
		end    
		
		maxCategoryDepth = (maxCategoryDepth+2)>2 and maxCategoryDepth+2 or 3  -- adjust for additional fields

		if tooltipStem.useCounts_onLDB then self:ldb_refreshCounts(checked, unchecked) end 	

		-- ------------------------------------------------------------------------------------------------

	elseif listType == "PGT" or listType == "TW" then -- ---------------------------------------------------------------- --==[ PGT BUILD ]==--
		local displayMode, defaultCollapse, HideEmptyGroups
		if listType == "PGT" then displayMode = ExecAssist["mode_"..listType] ; defaultCollapse = tooltipStem.defaultCollapse; HideEmptyGroups = tooltipStem.HideEmptyGroups
		else displayMode = ExecAssist.twMode ; defaultCollapse = twStem.defaultCollapse; HideEmptyGroups = twStem.HideEmptyGroups
		end
	  -- ---------------------------------------------------------------------------------------------------
		local function mkChar(rc, isCollapsed, charName, count, r, g, b)  -- col=1 by default           
			table.insert(rc, {["type"] = "char",  ["col"] = 1, ["charCollapsed"] = isCollapsed, 
												["charName"] = charName, ["count"] = count, ["r"] = r, ["g"] = g, ["b"] = b}) 
		end	-- nothing to return																																				
	  -- ---------------------------------------------------------------------------------------------------
		local function mkTask(rc, col, charName, taskID, collapsed, forceDisplayTasks)
			local isChecked, isDisplayed = self:getCheckedState(charName, taskID), nil
			local hTask = groupStem.agg[taskID]

			if (not isChecked) or (isChecked and ( (twStem.showChecked and listType == "TW") or (listType == "PGT" and tooltipStem.showChecked)) ) then
				isDisplayed = true -- Evil, I know...but interior collapsing cascades need to know the response nature of the task display
													 -- thus a full traverse is needed even though not directly included in the data. Sometimes you can't avoid meta-constructs.
				if forceDisplayTasks or not collapsed then				
		 			table.insert(rc, {["type"] = "task",  ["col"] = col, ["isChecked"] = isChecked, 
		 												["taskName"] = hTask.taskName, ["resetType"] = formatResetTypes(hTask.resetType), --formatResetTypes(hTask.resetType),
		 												["taskID"] = taskID, ["charName"] = charName, 
		 												["isCurrentUser"] = (charName == self.userCurrent),
		 												["isAcctWide"] = hTask.isAcctWide})
		 		end
			end
			
			return isChecked, isDisplayed
		end                                                                                             
	  -- ---------------------------------------------------------------------------------------------------
		local function doGroup(rc, charName, groupID, parentID, maxDepth, collapsed, forceDisplayTasks)  --NB: mk vs do: mk makes things, do does things too.
			local checked, unchecked, IDactive = 0, 0, 0                                                  
			local adoptive_sibMapID
			local DO = groupStem.agg[groupID].DO                        						                      
			local maxCat = maxDepth + 1; if maxCat > maxCategoryDepth then maxCategoryDepth = maxCat end  
			local gpIdx, modeSuppressed
			
			if displayMode==4 then modeSuppressed = true -- only selected group / HideGroupNames
			elseif (displayMode==3 and idxTT.isSpecialSnowflake == groupID ) then
				-- NB: the (somewhat now misnamed) quicktoggle_ handles the idxTT[].isCollapsed capture & reset
				collapsed = false
				maxCat, maxCategoryDepth = 1, 1
			elseif groupStem.agg[groupID].hideFromDisplay and displayMode ~= 2 then --force it open if not display 2		
				maxCat = maxCat-1 -- bring it down a rung
				modeSuppressed = true
				idxTT[groupID].isCollapsed = false
				adoptive_sibMapID = parentID -- forces the parent group and not current 'hidden' group to 'adopt' the children
			end

			if not collapsed and not modeSuppressed then		
				local hGroup = groupStem.agg[groupID]
				table.insert(rc, {["type"] = "group", ["col"] = maxCat, ["count"] = count, 
													["groupCollapsed"] = idxTT[groupID].isCollapsed, ["charName"] = charName, 
												  ["groupName"] = hGroup.listName, ["groupID"] = groupID,
												  ["isCmdTarget"] = hGroup.cmdLineTarget, ["isHidden"] = hGroup.hideFromDisplay,
												  ["isSpecialSnowflake"] = (idxTT.isSpecialSnowflake and idxTT.isSpecialSnowflake == groupID)
												 })
				gpIdx = #rc
			end
			
			idxTT[groupID].sibMap = {}  -- clear group sibling map
			for n=1,#DO do
				if self:ID_isActive(charName, DO[n]) then
					IDactive=IDactive+1
					if DO[n]:isGroup() then
						table.insert(idxTT[true and adoptive_sibMapID or groupID].sibMap, DO[n]) -- insert child into Sibling Map             
						if not idxTT[DO[n]] then idxTT[DO[n]] = {
							["p"] = true and adoptive_sibMapID or groupID, 
							["isCollapsed"] = true and ((listType == "TW" and twStem.defaultCollapse) or (listType == "PGT" and tooltipStem.defaultCollapse)) or false
						} end -- preloads the child's (DO[n]) parent ID            

						local rc_c, rc_uc, IDactive_adder = doGroup(rc, charName, DO[n], groupID, maxCat, true and collapsed or idxTT[groupID].isCollapsed, forceDisplayTasks)                                
						checked   = checked+rc_c                                                                
						unchecked = unchecked+rc_uc                                                             
						IDactive=IDactive+IDactive_adder	-- passes back the # of active down the line or -1 if empty to 'remove' the group itself				
					else
						local isChecked, isDisplayed = mkTask(rc, maxCat+1, charName, DO[n], true and collapsed or idxTT[groupID].isCollapsed, forceDisplayTasks)
						if isChecked then checked = checked+1 
						else unchecked = unchecked+1 
						end
						if not isDisplayed then IDactive=IDactive-1 end
					end
				end
			end

 			if not collapsed and not modeSuppressed then rc[gpIdx].count = formatCounts(checked, unchecked) end
			if HideEmptyGroups and IDactive == 0 then
				if gpIdx then table.remove(rc, #rc) end -- gpIdx b/c if no gpIdx then no group entry to remove
				IDactive = -1 -- removes count for empty group when added up the stack
			end

			return checked, unchecked, IDactive
		end
	  -- ===================================================================================================
		local idxCH
		if listType == "TW" then 
			idxCH = ttData_idx["TW"] 
		else 
			idxCH = ttData_idx["char"] 
		end 

		if idxCH.player then idxCH.player.sibMap = {} end	-- clear character sibling Map
		for i=1,#ExecAssist.charList do
			local checked, unchecked = 0, 0
			local charName, charStem = ExecAssist.charList[i], charStem_base[ExecAssist.charList[i]]		  
			local hdrIndex
			if (OnlyCurrentChar and charName == ExecAssist.userCurrent) or (not OnlyCurrentChar) then
				-- Process Player																																						
				if not idxCH[charName] then 
					local isCollapsed
					if charName == self.userCurrent then isCollapsed = (not tooltipStem.defaultExpandSelf) 
					else isCollapsed=true 
					end
					idxCH[charName] = {["isCollapsed"] = isCollapsed, ["p"] = "player"} 
					idxCH[charName]["PGT"] = {}
				end
				idxTT = idxCH[charName]["PGT"] -- makes the group collapse toggle char specific
				for k, v in pairs(idxTT) do if v.sibMap then v.sibMap = {} end end  -- remove existing sibMaps to refresh the pattern; note: no attempt at clean up is done as any garbage is outside the sibling map
				table.insert(idxCH.player.sibMap, charName)																										
	
				local showCharHeader
				if displayMode == 4 then maxDepth = -1  end -- this 'pulls' the checkboxes over into the otherwise empty column.
				if (OnlyCurrentChar and HideCharHeader_OnlyCurrentChar) or (displayMode==3) then 
					showCharHeader = false
				else 
					showCharHeader = true 
				end

				if showCharHeader then 	
							mkChar( rc,
											idxCH[charName].isCollapsed, 
											charName, 
											nil, -- if used, 'count' will be filled in when tabulations are done

											charStem.charClass and RAID_CLASS_COLORS[charStem.charClass].r or npcColor.r,      
											charStem.charClass and RAID_CLASS_COLORS[charStem.charClass].g or npcColor.g,      
											charStem.charClass and RAID_CLASS_COLORS[charStem.charClass].b or npcColor.b
										 )
							hdrIndex = #rc
				end

				-- Proceess Groups and Tasks
				local garden = groupStem.agg["garden"].DO																											
		    if not idxTT["__garden"] then 
		    	idxTT["__garden"] = {["sibMap"] = {}} 
		    else 
		    	idxTT["__garden"].sibMap = {} 
		    end -- set / clear __garden sibling map
		    
				for j=1,#garden do -- .garden is always groups                           											
					if self:ID_isActive(charName, garden[j]) then																								
						table.insert(idxTT["__garden"].sibMap, garden[j])                                					
						if not idxTT[garden[j]] then idxTT[garden[j]] = {
							["p"] = "__garden", 
							["isCollapsed"] = true and ((listType == "TW" and twStem.defaultCollapse) or (listType == "PGT" and tooltipStem.defaultCollapse)) or false
						} end -- preloads the child's (DO[n]) parent ID  

						local rc_c, rc_uc = doGroup(rc, charName, garden[j], garden[j], maxDepth, 
								displayMode == 3 and idxTT.isSpecialSnowflake or idxCH[charName].isCollapsed,
								(displayMode == 4 and not idxCH[charName].isCollapsed )
						)			-- (cascade 'collapse' till snowflake is found)

							checked   = checked+rc_c
							unchecked = unchecked+rc_uc
					end																																													
				end                                                                                           
				-- ---------------------- --
				if charName ~= ExecAssist.userCurrent and (
						(HideEmptyGroups and (checked+unchecked) == 0)  				-- Hide + No Groups/Tasks Assigned
						or
						( (not tooltipStem.showChecked) and (tooltipStem.HideChar_ifNoIncomplete and unchecked==0) )  -- Hide Entire Char when no UNCOMPLETED tasks and not SHOW_COMPLETED
					) then 
					for i=hdrIndex,#rc do -- pull off enteries
						table.remove(rc, i) 
					end 
				elseif tooltipStem.useCounts_onHeaders and showCharHeader then 	
					rc[hdrIndex]["count"] = formatCounts(checked, unchecked)		
				end
	
				if charName == ExecAssist.userCurrent then
					if tooltipStem.useCounts_onLDB then 
						self:ldb_refreshCounts(checked, unchecked)
					else
						self:queryToggleTW_zeroUncomp_whileHideCompTasks(unchecked)
					end
				end
			end					                                                                                    
	
		end -- for i=1,#ExecAssist.charList do 
		
		maxCategoryDepth = (maxCategoryDepth+3)>3 and maxCategoryDepth+3 or 4  -- adjust for additional fields
	  -- ===================================================================================================
	end

	return rc, maxCategoryDepth
end

	-- update LDB
function ExecAssist:ldb_refreshCounts(checked, unchecked)
	local sdbg = self.db.global
	if not checked then -- do count if not supplied --
		local aggStem = sdbg.groupStem.agg
		local garden = aggStem["garden"].DO
		checked, unchecked = 0, 0
	 	local function doGroup(charName, groupID, maxDepth) 
			local checked, unchecked, DO = 0, 0, aggStem[groupID].DO
			for n=1,#DO do                                                  
				if self:ID_isActive(charName, DO[n]) then	
					if DO[n]:isGroup() then local rc_c, rc_uc = doGroup(charName, DO[n], maxCat); checked = checked+rc_c; unchecked = unchecked+rc_uc 
					else 
						if self:getCheckedState(charName, DO[n]) then checked = checked+1 
						else unchecked = unchecked+1 
						end 
					end 
				end
			end 
			return checked, unchecked                                       
		end				                                                        		
		for j=1,#garden do if self:ID_isActive(self.userCurrent, garden[j]) then local rc_c, rc_uc = doGroup(self.userCurrent, garden[j], 0); checked = checked+rc_c; unchecked = unchecked+rc_uc end end
	end -- ---------------------------
	ExecAssist.meatPopcicle.text = self:formatCountData(checked, unchecked, sdbg.tooltip.displayType_onLDB)

	self:queryToggleTW_zeroUncomp_whileHideCompTasks(unchecked)
end