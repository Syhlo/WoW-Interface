-- ------------------------------------------------------------------------- --
-- Project: Executive Assistant - To-Do/Task List Manager
-- Author:  VincentSDSH				
-- ------------------------------------------------------------------------- --
local AddonName = ...
local debug = ExecAssist.debug
local LibQTip = LibStub("LibQTip-1.0moddedForExecAssist")
local L 		  = LibStub('AceLocale-3.0'):GetLocale(AddonName)
local LSM     = LibStub("LibSharedMedia-3.0")

local hf, sf, ssf = CreateFont("tw_headerFont"), CreateFont("tw_standardFont"), CreateFont("tw_snowflakeFont")

function ExecAssist:getHandle_TaskWindow()
	local sdb = self.db
	if sdb.char.CharSpecificTaskWindow then
		return sdb.char.taskWindow
	else
		return sdb.global.taskWindow
	end
end
function ExecAssist:setTaskWindowPos(rel)
	if not self.taskWindow then return end -- no update if not alive
	self.taskWindow:ClearAllPoints()
	self.taskWindow:SetPoint(rel, self.taskWindow_posAnchor, rel, 0, 0)
end

local function setAlphaResponse(fObj)
	local twStem = ExecAssist:getHandle_TaskWindow()
	fObj:SetScript("OnEnter", function() ExecAssist.taskWindow:SetAlpha(twStem.opacity_mouseover) end)
	fObj:SetScript("OnLeave", function() ExecAssist.taskWindow:SetAlpha(twStem.opacity_faded) end)
end
local function setMovable(fObj)
	fObj:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" and not ExecAssist:getHandle_TaskWindow().locked then
			ExecAssist.taskWindow_posAnchor:StartMoving(); ExecAssist.taskWindow:StartMoving()
		end
	end)
	fObj:SetScript("OnMouseUp", function(_, button)
		local twStem = ExecAssist:getHandle_TaskWindow()
		if button == "LeftButton" and not twStem.locked then
			ExecAssist.taskWindow_posAnchor:StopMovingOrSizing(); ExecAssist.taskWindow:StopMovingOrSizing()
			twStem.pos.posW_rel, _, twStem.pos.posW_relP, twStem.pos.xOff, twStem.pos.yOff = ExecAssist.taskWindow_posAnchor:GetPoint(1)
		end
	end)
end

function ExecAssist:dragFrame_Peek_A_Boo(twStem, hDF)
	if not self.taskWindow then return end -- no update if not alive
	local DF 
	
	if hDF then DF=hDF 
	else DF = ExecAssist.taskWindow_dragFrame 
	end
	
	if twStem.useDragFrame then 
		if twStem.locked then
			if DF:IsVisible() then DF:Hide() 
			end
		else
			if not DF:IsVisible() then DF:Show() 
			end
		end	
	else
		if DF:IsVisible() then DF:Hide() end
	end
end

function ExecAssist:taskWindow_toggleMoving(twStem, reReadStem)
	if not reReadStem then twStem.locked = not twStem.locked end

	if not self.taskWindow then return end -- no update if not alive
	self.taskWindow:SetMovable(not twStem.locked)
	self.taskWindow_dragFrame:SetMovable(not twStem.locked)

	if twStem.hidebuttons then
		self:UpdateWindow()
	else
		self:dragFrame_Peek_A_Boo(twStem)
	end

	if twStem.locked then self:alert( (L.tw_taskwindowis):format( (L.tw_locked ):cf("EAtan") ))
	else self:alert( (L.tw_taskwindowis):format( (L.tw_movable):cf("EAtan") ) ) 
	end 
end

function ExecAssist:StyleTaskWindow()
	if not self.taskWindow then return end -- no update if not alive
	local twStyle = self.db.global.taskWindow.style
    local bgFrame = {
			bgFile = AceGUIWidgetLSMlists.background[twStyle.background], -- "Interface/Tooltips/UI-Tooltip-Background", 
			edgeFile = AceGUIWidgetLSMlists.border[twStyle.border], -- "Interface/Tooltips/UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 6,
			insets = {left = 1, right = 1, top = 1, bottom = 1}
    }	
	self.taskWindow:SetBackdrop(bgFrame)
	self.taskWindow:SetBackdropColor(twStyle.bgcolor.r, twStyle.bgcolor.g, twStyle.bgcolor.b, twStyle.bgcolor.a)
	self.taskWindow:SetBackdropBorderColor(twStyle.bdrcolor.r, twStyle.bdrcolor.g, twStyle.bdrcolor.b, twStyle.bdrcolor.a)
end

function ExecAssist:setFontStringShadow()
	local twStem = self.db.global.taskWindow
	hf:SetShadowColor(twStem.fontshadow.shadowcolor.r, twStem.fontshadow.shadowcolor.g, twStem.fontshadow.shadowcolor.b, twStem.fontshadow.shadowcolor.a); 
	hf:SetShadowOffset(twStem.fontshadow.offset.x, twStem.fontshadow.offset.y)
	sf:SetShadowColor(twStem.fontshadow.shadowcolor.r, twStem.fontshadow.shadowcolor.g, twStem.fontshadow.shadowcolor.b, twStem.fontshadow.shadowcolor.a); 
	sf:SetShadowOffset(twStem.fontshadow.offset.x, twStem.fontshadow.offset.y)
	ssf:SetShadowColor(twStem.fontshadow.shadowcolor.r, twStem.fontshadow.shadowcolor.g, twStem.fontshadow.shadowcolor.b, twStem.fontshadow.shadowcolor.a); 
	ssf:SetShadowOffset(twStem.fontshadow.offset.x, twStem.fontshadow.offset.y)
end

function ExecAssist:loadFontStrings(tooltipStem)
	-- fonts for fontstrings
	hf:SetFont(LSM:Fetch( "font", tooltipStem.header_font),    tooltipStem.header_size,    "") 
	sf:SetFont(LSM:Fetch( "font", tooltipStem.standard_font),  tooltipStem.standard_size,  "")
	ssf:SetFont(LSM:Fetch("font", tooltipStem.snowflake_font), tooltipStem.snowflake_size, "")	
	
	hf:SetJustifyH("LEFT");   hf:SetJustifyV("MIDDLE")
	sf:SetJustifyH("LEFT");   sf:SetJustifyV("MIDDLE")
	ssf:SetJustifyH("CENTER"); ssf:SetJustifyV("MIDDLE")  
	
	self:setFontStringShadow()
end

function ExecAssist:CreateTaskWindow()
	local tooltipStem = self.db.global.tooltip
	local twStem = self:getHandle_TaskWindow()
	
	-- tooltips ---------------------------------
	local tooltipMsg = {
		["fs"] = (L.tt_tt_s1):format((L.tt_tt_s1_g):cf("sunshine"), (L.rightMouse):cf("cyan"), (L.ctrl_leftMouse):cf("cyan"), (L.leftMouse_shift):cf("cyan"), (L.tt_tt_s1_ts):cf("sunshine"), (L.rightMouse):cf("cyan"), (L.tt_tt_s1f):cf("grass")),
	 	["ZoomGroup"] = L.tw_tt_singleGroup,
	 	["hideGroups"] = L.tw_tt_hideGroups,
	 	["showGroups"] = L.tw_tt_showGroups,
	 	["config"] = (L.tw_tt_config):format( (L.tw_tt_config_group):cf("cyan"), (L.tw_tt_config_task):cf("cyan"), (L.tw_tt_config_thisbutton):cf("cyan"), L.tw_tt_config_LeftClick:cf("grass"), L.tw_tt_config_ShiftLeftCLick:cf("grass"), L.tw_tt_config_RightClick:cf("grass")),
 	} 
	local function button_OnLeave()
		if ExecAssist.taskWindow.tooltip then 
			ExecAssist.taskWindow.tooltip:Release("ExecAssist_TaskWindowTooltip")
			ExecAssist.taskWindow.tooltip=nil
		end
	end	
	local function button_OnEnter(buttonAnchor)
		local tooltipStem = ExecAssist.db.global.tooltip
		if not ExecAssist.taskWindow.tooltip then 
			ExecAssist.taskWindow.tooltip = LibQTip:Acquire("ExecAssist_TooltipTooltip")
		end
		tooltip = ExecAssist.taskWindow.tooltip	
		tooltip:Clear()
		tooltip:SetCellMarginH(0); tooltip:SetCellMarginV(0)		
		local tf = CreateFont("tiptipFont"); tf:SetFont(LSM:Fetch("font", tooltipStem.header_font), tooltipStem.header_size, ""); tooltip:SetFont(tf)
	
		tooltip:SetScale(1)
		tooltip:SetBackdropColor(0, 0, 0, 1) 
		tooltip:SetAutoHideDelay(.25, buttonAnchor	)	
		if buttonAnchor.tooltipCode == "task" or buttonAnchor.tooltipCode == "group" then
			tooltip:SmartAnchorTo(ExecAssist.taskWindow)
		else
			tooltip:SmartAnchorTo(buttonAnchor)   
		end
	
		tooltip:SetColumnLayout(1)
		tooltip:AddLine()
	
		tooltip:SetCell(1, 1, tooltipMsg[buttonAnchor.tooltipCode])
	 	tooltip:UpdateScrolling()	
		tooltip:Show()				
	end	-----------------------------------------
	
	self.taskWindow_posAnchor = CreateFrame("Frame", "ExecAssist_TaskWindow_posAnchor", UIParent, "BackdropTemplate") -- self.taskWindow_posAnchor = CreateFrame("Frame", "ExecAssist_TaskWindow_posAnchor", UIParent)
	
	local pA = self.taskWindow_posAnchor

	self.taskWindow = CreateFrame("Frame", "ExecAssist_TaskWindow", pA, "BackdropTemplate") -- self.taskWindow = CreateFrame("Frame", "ExecAssist_TaskWindow", pA)	
	local TW = self.taskWindow	
	
	self.taskWindow_dragFrame = CreateFrame("Frame", "ExecAssist_TaskWindow_dragFrame", pA, "BackdropTemplate") -- self.taskWindow_dragFrame = CreateFrame("Frame", "ExecAssist_TaskWindow_dragFrame", pA) -- Proof of Concept
	local DF = self.taskWindow_dragFrame

	-- self.taskWindow_posAnchor
	pA:SetHeight(200); pA:SetWidth(200) -- reduce shuffle when changing orientations
	pA:SetPoint(twStem.pos.posW_rel, UIParent, twStem.pos.posW_relP, twStem.pos.xOff, twStem.pos.yOff)
	pA:SetMovable(true)
	
  -- self.taskWindow  
	self:setTaskWindowPos(twStem.pos.relTW)
	TW:SetFrameLevel(3)							 -- NB: ensures TW is always above DF
	TW:SetMovable(not twStem.locked) -- NB: pA can remain movable

	TW:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" and not twStem.locked then
			pA:StartMoving(); TW:StartMoving()
		end
	end)
	TW:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" and not twStem.locked then
			pA:StopMovingOrSizing(); TW:StopMovingOrSizing()
			local twStem = self:getHandle_TaskWindow() -- PerChar State can change; make sure the proper twStem is updating
			twStem.pos.posW_rel, _, twStem.pos.posW_relP, twStem.pos.xOff, twStem.pos.yOff = pA:GetPoint(1)
		end
	end) 
	TW:SetScript("OnHide", function()
		TW.sshhh_ImHuntingWabbits = true
	end) 
	TW:SetScript("OnShow", function()
		TW.sshhh_ImHuntingWabbits = false
		self:UpdateWindow()
	end) 	

	setAlphaResponse(TW)
	setMovable(TW) 
	self:StyleTaskWindow()
	TW:SetAlpha(twStem.opacity_faded)
	
	-- fonts for fontstrings
	self:loadFontStrings(tooltipStem)
	
	-- Tooltippy Buttons
	TW.ctrlButtons = {
		["showGroups"] = CreateFrame("Button", "EATW_showGroups", TW, "BackdropTemplate"), -- ["showGroups"] = CreateFrame("Button", "EATW_showGroups", TW ),
		["hideGroups"] = CreateFrame("Button", "EATW_hideGroups", TW, "BackdropTemplate"), -- ["hideGroups"] = CreateFrame("Button", "EATW_hideGroups", TW ),
		["ZoomGroup"]  = CreateFrame("Button", "EATW_ZoomGroup",  TW, "BackdropTemplate"), -- ["ZoomGroup"]  = CreateFrame("Button", "EATW_ZoomGroup",  TW ),
		["config"] 		 = CreateFrame("Button", "EATW_config", 		TW, "BackdropTemplate"), -- ["config"] 		 = CreateFrame("Button", "EATW_config", 		TW ),
		["fs"]    		 = CreateFrame("Button", "EATW_fs", 				TW, "BackdropTemplate"), -- ["fs"]    		 = CreateFrame("Button", "EATW_fs", 				TW ),
	}

	TW.f = TW:CreateFontString(nil, "OVERLAY")
	TW.f:SetFontObject(ssf)
					
	TW.ctrlButtons["showGroups"]:SetNormalTexture(self.icons.ldb_showGroups)
	TW.ctrlButtons["hideGroups"]:SetNormalTexture(self.icons.ldb_hideGroups)
	TW.ctrlButtons["ZoomGroup"]:SetNormalTexture(self.icons.ldb_ShowOnlySelectedGroup)
	TW.ctrlButtons["config"]:SetNormalTexture(self.icons.tw_config)
	TW.ctrlButtons["config"]:SetPushedTexture(self.icons.tw_config_push)

	-- TW.ctrlButtons["config"] -- HockeyPuck
	TW.ctrlButtons["ZoomGroup"]:SetPoint("RIGHT", TW.ctrlButtons["config"], "LEFT", -2, 0)
	TW.ctrlButtons["hideGroups"]:SetPoint("RIGHT", TW.ctrlButtons["ZoomGroup"], "LEFT", -2, 0)
	TW.ctrlButtons["showGroups"]:SetPoint("RIGHT",  TW.ctrlButtons["hideGroups"], "LEFT", -2, 0)
	
	TW.ctrlButtons["fs"]:SetPoint("LEFT", TW, "LEFT", 3, 0)
	TW.ctrlButtons["fs"]:SetPoint("TOPRIGHT", TW.ctrlButtons["showGroups"], "TOPLEFT",0, 0)
	TW.f:SetAllPoints(TW.ctrlButtons["fs"])

	local function allButtons(b)
		local B = TW.ctrlButtons
		B[b]:SetWidth(18)
		B[b]:SetHeight(18)
		B[b]:EnableMouse(true)
		B[b]:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		setAlphaResponse(B[b])
		if twStem.useMouseoverHighlight and b ~= "fs" then B[b]:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight") end
		B[b]:SetScript("OnEnter", function(theButton) self.taskWindow:SetAlpha(twStem.opacity_mouseover); if twStem.enableTooltipTooltips then button_OnEnter(theButton) end end)
		B[b]:SetScript("OnLeave", function(theButton) self.taskWindow:SetAlpha(twStem.opacity_faded);     if twStem.enableTooltipTooltips then button_OnLeave() end end)
		B[b].tooltipCode = b
	end	
	allButtons("showGroups")
	allButtons("hideGroups")
	allButtons("ZoomGroup")
	allButtons("config")
	allButtons("fs")
    
  TW.ctrlButtons["ZoomGroup"]:SetScript("OnClick", function(theButton, side) 
  		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
  		ExecAssist.twMode = 3
			self:snowflake_putOld("TW")  		
  		ExecAssist:UpdateWindow() 	
  	end)	  
  TW.ctrlButtons["hideGroups"]:SetScript("OnClick", function(theButton, side) 
  		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
  		ExecAssist.twMode = 4
  		-- No need to do the Snowflake Dance in this mode, only when going to full display
  		ExecAssist:UpdateWindow() 	
  	end)	
  TW.ctrlButtons["showGroups"]:SetScript("OnClick", function(theButton, side) 
  		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
  		ExecAssist.twMode = 1
			self:snowflake_getOld("TW")    		
  		ExecAssist:UpdateWindow() 	
  	end)	  	
  TW.ctrlButtons["config"]:SetScript("OnClick", function(theButton, side)
  		if side == "LeftButton" then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
  			if IsShiftKeyDown() then
					self:taskWindow_toggleMoving(twStem)
				else
					ExecAssist:doLoadTaskWindow()					
				end
			else
				twStem.enableTooltipTooltips = not twStem.enableTooltipTooltips
				self:alert(L.twTooltipsToggle..(twStem.enableTooltipTooltips and L.Enabled or L.Disabled):cf("EAtan") )
			end
  	end)	  
  TW.ctrlButtons["fs"]:SetScript("OnMouseDown", function(theButton, button)
		if button == "LeftButton" and not twStem.locked then
			pA:StartMoving(); TW:StartMoving()
		end  
  end)
	TW.ctrlButtons["fs"]:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" and not twStem.locked then
			pA:StopMovingOrSizing(); TW:StopMovingOrSizing()
			local twStem = self:getHandle_TaskWindow() -- PerChar State can change; make sure the proper twStem is updating
			twStem.pos.posW_rel, _, twStem.pos.posW_relP, twStem.pos.xOff, twStem.pos.yOff = pA:GetPoint(1)
		end
	end)

	-- self.taskWindow_dragFrame
	DF:Hide()
	DF:SetBackdrop({ bgFile = AceGUIWidgetLSMlists.background["Solid"] }	)
	DF:SetBackdropColor(1, .8, .8)
  DF:SetMovable(not twStem.locked) -- NB: pA can remain movable

	DF:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" and not twStem.locked then
			pA:StartMoving(); TW:StartMoving(); DF:StartMoving()
		end
	end)
	DF:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" and not twStem.locked then
			pA:StopMovingOrSizing(); TW:StopMovingOrSizing(); DF:StopMovingOrSizing()
			local twStem = self:getHandle_TaskWindow() -- PerChar State can change; make sure the proper twStem is updating
			twStem.pos.posW_rel, _, twStem.pos.posW_relP, twStem.pos.xOff, twStem.pos.yOff = pA:GetPoint(1)
		end
	end)
	
	DF:SetScript("OnLeave", function(_, button)
		if ExecAssist.taskWindow.dragFrame_tooltip then 
			ExecAssist.taskWindow.dragFrame_tooltip:Release("ExecAssist_TaskWindowDragFrameTooltip")
			ExecAssist.taskWindow.dragFrame_tooltip=nil
		end	
	end)
	DF:SetScript("OnEnter", function(_, button)
		local tooltipStem = ExecAssist.db.global.tooltip
		
		if not ExecAssist.taskWindow.dragFrame_tooltip then 
			ExecAssist.taskWindow.dragFrame_tooltip = LibQTip:Acquire("ExecAssist_TaskWindowDragFrameTooltip")
		end
		tooltip = ExecAssist.taskWindow.dragFrame_tooltip	
		tooltip:Clear()
		tooltip:SetCellMarginH(0); tooltip:SetCellMarginV(0)		
		local tf = CreateFont("tiptipFont"); tf:SetFont(LSM:Fetch("font", tooltipStem.standard_font), tooltipStem.standard_size, ""); tooltip:SetFont(tf)
	
		tooltip:SetScale(1)
		tooltip:SetBackdropColor(0, 0, 0, 1) 
		tooltip:SetAutoHideDelay(.25, DF)	
		
		tooltip:SmartAnchorTo(DF)
	
		tooltip:SetColumnLayout(1)
		tooltip:AddLine()	
		tooltip:SetCell(1, 1, L.dragFrameTooltip)
	 	tooltip:UpdateScrolling()	
		tooltip:Show()					
	end)

	-- Onward and Upward
	self:UpdateWindow()
end

function ExecAssist:mkButton(frame, i) 
	local B = CreateFrame("Button", "EATW_button_"..tostring(i),  frame, "BackdropTemplate" ) -- local B = CreateFrame("Button", "EATW_button_"..tostring(i),  frame )

	B:EnableMouse(true)
	B:RegisterForClicks("LeftButtonUp", "RightButtonUp")
 	B:SetScript("OnClick", function(theButton, side) 
 		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
 		theButton.f:SetFontObject(sf)
 		
 		if B.bType == "T" then -- task
 			local hTask_cS = self:toggleTask(side, B.taskID, B.isCurrentUser, B.charName, "taskWindow")
 			if hTask_cS then -- hTask_cS is non-nil only if LeftClicked, if RightClick (no hTask_cS) then show-completed was toggled ( side == "LeftButton" )
 				if self.db.global.taskWindow.useCounts_onHeaders then ExecAssist:UpdateWindow() 
 				else B.t:SetTexture(hTask_cS.checked and self.icons.enabled or self.icons.disabled)
 				end
 			else ExecAssist:UpdateWindow() 
			end
 		elseif B.bType == "G" then -- group
 			self:toggleCollapse(side, B.key, B.idxTT_key, B.charName )
			ExecAssist:UpdateWindow()
 		else 
 			self:alert("Bad ButtionType making Task Window Button Pool: "..B.bType)
 		end
 		
 	end)	  -----------------------------------------------------------------------------------------------------------------------
	setAlphaResponse(B)
	
  B.t = B:CreateTexture(nil)
  B.t:SetHeight(B:GetHeight())
  B.t:SetWidth(B:GetHeight())
  B.t:SetPoint("LEFT", B, "LEFT", 2, 0)

  B.f = B:CreateFontString(nil, "OVERLAY")
  B.f:SetPoint("LEFT", B.t, "RIGHT", 5, 0)
  B.f:SetWordWrap(false) -- truncate, no wraping

  B.x = B:CreateFontString(nil, "OVERLAY")
  B.x:SetPoint("RIGHT", B, "RIGHT", -2, 0)

	if self.db.global.taskWindow.useMouseoverHighlight then B:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight") end
	return B
end

function ExecAssist:UpdateWindow(reLoadAllOptions)
	local TW, DF = self.taskWindow, self.taskWindow_dragFrame
	if not TW or TW.sshhh_ImHuntingWabbits then return end -- don't update if hidden
	
	local twStem, tooltipStem = self:getHandle_TaskWindow(), self.db.global.tooltip
	-- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- ---
	local function addStyle(button, text, styleStem )	
		local l_txt, r_txt
		if styleStem.useText ~= 1 then
			if styleStem.useText == 2 or styleStem.useText == 4 then l_txt = styleStem.useText_text.." " end		
			if styleStem.useText == 3 or styleStem.useText == 4 then r_txt = " "..styleStem.useText_text end
			if styleStem.useColor == 2 then
				l_txt = l_txt and l_txt:cfc(ExecAssist:tbl_pcColorToHex(styleStem.color)) or nil
				r_txt = r_txt and r_txt:cfc(ExecAssist:tbl_pcColorToHex(styleStem.color)) or nil
			end
			text = ("%s"..text.."%s"):format(true and l_txt or "", true and r_txt or "" )
		end
		
		button.f:SetText(text)
		
		if styleStem.useColor > 2 then
			if styleStem.useColor==3 then
				button.f:SetTextColor(styleStem.color.r, styleStem.color.g, styleStem.color.b, 1)
			elseif styleStem.useColor==4 or  styleStem.useColor==5 then
				button:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
				button:SetBackdropColor(styleStem.color.r, styleStem.color.g, styleStem.color.b, 1)
			end
		end
		return text
	end		
	local function styleButton(button, text, isAcctWide, isPurgable, isCmdTarget, isHidden, isSnowflake)
		-- Styles should be complimentary so text is returned (allows left/right of different types
		if isAcctWide  and tooltipStem.SM.acctwide.useStyle 		 then text = addStyle(button, text, tooltipStem.SM.acctwide) end
		if isPurgable  and tooltipStem.SM.purgable.useStyle 		 then text = addStyle(button, text, tooltipStem.SM.purgable) end
		
		if isCmdTarget and tooltipStem.SM.cmdLineTarget.useStyle then text = addStyle(button, text, tooltipStem.SM.cmdLineTarget) end
		if isHidden 	 and tooltipStem.SM.hidden.useStyle      	 then text = addStyle(button, text, tooltipStem.SM.hidden) end
		if isSnowflake and tooltipStem.SM.snowflake.useStyle 		 then text = addStyle(button, text, tooltipStem.SM.snowflake) end
	end 
	-- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- --- -- -- --- ---- ---

	DF:SetFrameStrata(twStem.strata or "LOW"); TW:SetFrameStrata(twStem.strata or "LOW") --newOption

	local W, w, H = 0, 0, 24 -- 21
	local data, maxCols = self:fetchData("TW")
	if not self.taskWindow.buttons then self.taskWindow.buttons ={} end
	local BL = self.taskWindow.buttons
	if not self.taskWindow.dispTasks then self.taskWindow.dispTasks = {} end
	local dispTasks = self.taskWindow.dispTasks

	self:loadFontStrings(tooltipStem)
	TW.f:SetFontObject(ssf)	 
	
	if #BL < #data then -- make enough buttons
		for i = #BL, #data do
			table.insert(BL, self:mkButton(self.taskWindow, i+1) )
		end
	end
	
	local function mkChar(bIdx, col, entry_isCollapsed, count, charName, r, g, b)  
		debug(charName, "Woops...")
	end
 	local function mkGroup(bIdx, col, entry_isCollapsed, count, charName, groupName, groupID, isCmdTarget, isHidden, isSpecialSnowflake) 
		BL[bIdx].t:SetTexture(entry_isCollapsed and self.icons.ldb_Collapsed or self.icons.ldb_Expanded)
		BL[bIdx].f:SetFontObject(hf)
		BL[bIdx].f:SetText(groupName)
		
		-- Window Sizing via Font String Sizing
		if twStem.widthMethod == 1 then -- can't really ':GetWidth()' and get a 0 so setting
			BL[bIdx].f:SetWidth(0)			
			if BL[bIdx].f:GetWidth() < twStem.MinWidth_FontString then BL[bIdx].f:SetWidth(twStem.MinWidth_FontString) end
		elseif twStem.widthMethod == 2 then
			local BLf_getWidth = BL[bIdx].f:GetWidth()		
			if BLf_getWidth > twStem.FixedWidth_FontString then BL[bIdx].f:SetWidth(twStem.FixedWidth_FontString) 
			elseif BLf_getWidth < twStem.MinWidth_FontString then BL[bIdx].f:SetWidth(twStem.MinWidth_FontString) 
			end
		elseif twStem.widthMethod == 3 then -- set if not already set 
			if BL[bIdx].f:GetWidth() ~= twStem.FixedWidth_FontString then BL[bIdx].f:SetWidth(twStem.FixedWidth_FontString) end
		end
		
		
		BL[bIdx].x:SetFontObject(hf)
		BL[bIdx].x:SetText(count)
		BL[bIdx].x:SetTextColor(tooltipStem.color_taskCounts.r, tooltipStem.color_taskCounts.g, tooltipStem.color_taskCounts.b, 1)
		
		BL[bIdx]:SetHeight(   BL[bIdx].f:GetHeight() +4 ) -- reset these due to possible font changes
	  BL[bIdx].t:SetHeight( BL[bIdx]:GetHeight())
		BL[bIdx].t:SetWidth(  BL[bIdx]:GetHeight())
		
		BL[bIdx].bType = "G"
		BL[bIdx].key = groupID
		BL[bIdx].idxTT_key = "TW"
		BL[bIdx].charName = charName
		
		BL[bIdx]:SetBackdrop({ bgFile = ""})
		BL[bIdx].f:SetTextColor(tooltipStem.color_Group.r, tooltipStem.color_Group.g, tooltipStem.color_Group.b, 1)
		styleButton(BL[bIdx], groupName, nil, nil, isCmdTarget, isHidden, isSpecialSnowflake)
		BL[bIdx].tooltipCode = "group" 	
 	end
	local function mkTask(bIdx, col, isChecked, taskName, resetType, taskID, charName, isCurrentUser, isAcctWide)	
		BL[bIdx].t:SetTexture(isChecked and self.icons.enabled or self.icons.disabled)
		BL[bIdx].f:SetFontObject(sf)
		BL[bIdx].f:SetText(taskName)

		-- Window Sizing via Font String Sizing
		if twStem.widthMethod == 1 then -- can't really ':GetWidth()' and get a 0 so setting
			BL[bIdx].f:SetWidth(0)
			if BL[bIdx].f:GetWidth() < twStem.MinWidth_FontString then BL[bIdx].f:SetWidth(twStem.MinWidth_FontString) end
		elseif twStem.widthMethod == 2 then
			BL[bIdx].f:SetWidth(0) -- restore sizing, then trim if necessary	
			local BLf_getWidth = BL[bIdx].f:GetWidth()		
			if BLf_getWidth > twStem.FixedWidth_FontString then BL[bIdx].f:SetWidth(twStem.FixedWidth_FontString) 
			elseif BLf_getWidth < twStem.MinWidth_FontString then BL[bIdx].f:SetWidth(twStem.MinWidth_FontString) 
			end
		elseif twStem.widthMethod == 3 then -- set if not already set 
			if BL[bIdx].f:GetWidth() ~= twStem.FixedWidth_FontString then BL[bIdx].f:SetWidth(twStem.FixedWidth_FontString) end
		end
		
		BL[bIdx].x:SetFontObject(sf)
		BL[bIdx].x:SetText(self.taskTypes[resetType].letter)
		BL[bIdx].x:SetTextColor(self.taskTypes[resetType].color.r, self.taskTypes[resetType].color.g, self.taskTypes[resetType].color.b, 1)
		
		BL[bIdx]:SetHeight(   BL[bIdx].f:GetHeight() +4 ) -- reset these due to possible font changes
	  BL[bIdx].t:SetHeight( BL[bIdx]:GetHeight())
		BL[bIdx].t:SetWidth(  BL[bIdx]:GetHeight())
		
		BL[bIdx].bType = "T"
		BL[bIdx].taskID = taskID
		BL[bIdx].isCurrentUser = isCurrentUser
		BL[bIdx].charName = charName
		
		BL[bIdx]:SetBackdrop({ bgFile = ""})
		BL[bIdx].f:SetTextColor(tooltipStem.color_TaskName.r, tooltipStem.color_TaskName.g, tooltipStem.color_TaskName.b, 1)
		styleButton(BL[bIdx], taskName, isAcctWide, resetType==L.Purgable)
		BL[bIdx].tooltipCode = "task"
		
		dispTasks[taskID] = bIdx
	end 

	-- Hide / Show Task Window Control Buttons
	if twStem.locked and twStem.hidebuttons then
		if TW.ctrlButtons["config"]:IsShown() then self.taskWindow.f:Hide(); for k, v in pairs(TW.ctrlButtons) do v:Hide() end end    	-- hide ctrl buttons
	else	
		if not TW.ctrlButtons["config"]:IsShown() then self.taskWindow.f:Show(); for k, v in pairs(TW.ctrlButtons) do v:Show() end end	-- show ctrl buttons
	end

	TW.ctrlButtons["config"]:ClearAllPoints() -- Readying for reposition

	for i=1, #data do
		if not BL[i]:IsShown() then BL[i]:Show() end
		local d = data[i]			
		if     d.type == "char"  then mkChar ( i, d.col, d.charCollapsed,  twStem.useCounts_onHeaders and d.count or "", d.charName, d.r, d.g, d.b )
		elseif d.type == "group" then mkGroup( i, d.col, d.groupCollapsed, twStem.useCounts_onHeaders and d.count or "", d.charName, d.groupName, d.groupID, d.isCmdTarget, d.isHidden, d.isSpecialSnowflake)
		elseif d.type == "task"  then mkTask ( i, d.col, d.isChecked, d.taskName, d.resetType, d.taskID, d.charName, d.isCurrentUser, d.isAcctWide)
		else
			self:alert("Data Processing Error, incorrect type: "..type, 1, 0, 0)
		end
		
		-- Reposition Button Row Anchor BL[i] ------------------------------------------------- -- 
		BL[i]:ClearAllPoints()
		if i==1 then --- Guide Post :: i==1 :: Control Buttons Top
			if twStem.ButtonPos == 1 and TW.ctrlButtons["config"]:IsShown() then
				BL[i]:SetPoint("TOPRIGHT", TW.ctrlButtons["config"], "BOTTOMRIGHT", 0, -2)
			else
				BL[i]:SetPoint("TOPRIGHT", TW, "TOPRIGHT", -3, -3)	
			end
		else
			BL[i]:SetPoint("TOPRIGHT", BL[i-1], "BOTTOMRIGHT", 0, -2)
		end
		-- ------------------------------------------------- Reposition Button Row Anchor BL[i] -- 
		BL[i]:SetPoint("LEFT", self.taskWindow, "LEFT", 3+ ((d.col-1) * BL[i]:GetHeight()), 0) -- 2nd pt

		if BL[i].f:GetWidth() > W then W = BL[i].f:GetWidth() end
		if BL[i].x:GetWidth() > w then w = BL[i].x:GetWidth() end
		H=H+BL[i]:GetHeight()+2
	end	

	if TW.ctrlButtons["config"]:IsShown() then
		if twStem.ButtonPos == 1 or #data == 0 then 
				TW.ctrlButtons["config"]:SetPoint("TOPRIGHT", TW,        "TOPRIGHT",   -3, -3)		
		else                                                             
				TW.ctrlButtons["config"]:SetPoint("TOPRIGHT", BL[#data], "BOTTOMRIGHT", 0, -2)		
		end
	else
		-- do not reposition hidden control button
	end
	
	-- hide excess buttons
	if #BL > #data then for i = #data+1, #BL do BL[i]:Hide() end end 

	TW:SetWidth( W + w + 0 + (#data > 0 and (BL[1]:GetHeight() * (maxCols-1)) or 250) )
	TW:SetHeight(TW.ctrlButtons["config"]:IsShown() and H or H-18)
	
	-- Drag Window
	self:dragFrame_Peek_A_Boo(twStem, DF)
	DF:SetWidth(TW:GetWidth() + 16)
	DF:SetHeight(TW:GetHeight() + 16)
	DF:ClearAllPoints()
	DF:SetPoint("TOPLEFT", TW, "TOPLEFT", -8, 8)

	-- Set Zoom Group, if one
	local sf = self:getSnowflake()
	local styleStem = tooltipStem.SM.snowflake

	-- If Zoom Group (special snowflake) then display the name UNLESS ExecAssist.twMode = 3 (only show zoom group) b/c it's redundant
	if sf and ExecAssist.twMode ~= 3 then 
		self.taskWindow.f:SetWordWrap(false)
		if styleStem.useStyle then 
			self.taskWindow.f:SetText(sf:cfc(ExecAssist:tbl_pcColorToHex(styleStem.color))) 
		else 
			self.taskWindow.f:SetText(sf:cf("lightgray")) 
		end
	else
		self.taskWindow.f:SetWordWrap(true)
		self.taskWindow.f:SetText(L.appName:cf("cream")) 
	end

	if reLoadAllOptions then
		setAlphaResponse(TW)
		setMovable(TW) 
		self:StyleTaskWindow()
		TW:SetAlpha(twStem.opacity_faded)		
		self.taskWindow_posAnchor:ClearAllPoints()
		self.taskWindow_posAnchor:SetPoint(twStem.pos.posW_rel, UIParent, twStem.pos.posW_relP, twStem.pos.xOff, twStem.pos.yOff)
		debug("winUpdate:OnMouseUp"); debug(twStem.pos.xOff, "twStem.pos.xOff"); debug(twStem.pos.yOff, "twStem.pos.yOff")

	end
	
end

function ExecAssist:queryToggleTW_zeroUncomp_whileHideCompTasks(unchecked)
	local twStem = self.db.global.taskWindow
	if self.db.char.useTaskWindow and self.taskWindow then

		if twStem.hideTW_ifHideCompTaks_andNoUncompTasks and not twStem.showChecked then
			if (unchecked==0 and self.taskWindow:IsShown()) or (unchecked>0 and not self.taskWindow:IsShown()) then
				self:doToggleTaskWindow()
			end
		else
--			if not self.taskWindow:IsShown() then self:doToggleTaskWindow() end
		end
	end
end
