-- ------------------------------------------------------------------------- --
-- Project: Executive Assistant - Custom To-Do/Task List Manager
-- Author:  VincentSDSH				
-- Version: 1.4g - w9.0
-- ------------------------------------------------------------------------- --
-- Command: /ea or /exa
--
-- ------------------------------------------------------------------------- --
-- W9.x Notes
-- Blizzard: "Instead of always creating backdrops on every frame, they require each frame to explicitly inherit 
--            backdrops. There is no change in functionality, only the default setting has been changed in an effort 
--            to improve performance."
-- Adding "BackdropTemplate" as para4 to CreateFrame() to set things back to normal. Might be overkill but it'll save a lot of retesting
-- GameTooltip requires a mixin for backdrop if not present, adding a check call before usage rather than a wrapper for simplicity
--
-- ------------------------------------------------------------------------- --
-- 
-- Optional
-- See line 72 of ea_Options.lua to change from 60min to 30min time intervals
--
-- [ ] Option for Command Line Target to be Per Character, set per character.

-- Task Resets (Occ Intern) should trigger a LDB Update

-- ------------------------------------------------------------------------- --
local AddonName = ...
ExecAssist = LibStub("AceAddon-3.0"):NewAddon(AddonName, "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")
ExecAssist.Dialog = LibStub("AceConfigDialog-3.0")
ExecAssist.debug = function(data, label, colorize) if ExecAssist.db.sv.debug then local r, b, g if not colorize then r=1; g=1; b=.8 elseif (label and data) then r=0; g=1; b=0 else r=1; g=0; b=0 end; local eaColon = ("::"):cf("EAblue"); DEFAULT_CHAT_FRAME:AddMessage( eaColon..("EA_debug"):cf("EAtan")..eaColon .." ".. (label and (label.." is: ") or "").. tostring(data), r, g, b); end end
local debug = ExecAssist.debug
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)

function ExecAssist:OnInitialize()
	self.wowVer = "9.0"
	self.FC = "Executive_Assistant_FileCabinet"

	-- Extend Plumbing ------------------------------------------------------- --
	self:extendStringFunc()

  -- Defaults -------------------------------------------------------------- --
	self.EventsRegistered = {}; self.prototype = {}
  self.prototype.Group = {
  	["isGroup"] = true,
  	["id"] = "", -- self handle :: pass (hGroup) rather than (hGroup, groupID) when asking a parent to operate on the child's /reference/ not just the child (e.g., .DO ops, etc)
		["p"] = "", -- parent GroupID
		["listName"] = "Default New Group Name",
		-- ["objbName"] = "Default New Group Name",
		["defaultEnabled"] = true, -- ENABLED
		["hideDays"] = {}, -- {Sun -> Sat}  
		["DO"] = {}
  }	
	self.prototype.Task = {
		["isTask"] = true,
		["id"] = "", -- taskID
		["p"] = "",  -- parent GroupID
		["taskName"] = "Default New Task Name",
		-- ["objbName"] = "Default New Task Name",
		["defaultEnabled"] = true, -- ENABLED
		["resetType"] = "Daily Automatic",	-- {Daily, Weekly, Other}
		["hideDays"] = {} -- {Sun -> Sat} Primed b/c the multiselect control returns 						
	}	
  self.icons = {
    ["defaultLDBIcon"]  = ([[Interface\Addons\%s\icons\ExecutiveAssistant_appIcon]]):format(AddonName),

  	["ldb_Complete"]    = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_on]]):format(AddonName),
  	["ldb_Incomplete"]  = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_off]]):format(AddonName),

  	["enabled"]  			  = ([[Interface\Addons\%s\icons\ExecutiveAssistant_on]]):format(AddonName),
  	["disabled"] 			  = ([[Interface\Addons\%s\icons\ExecutiveAssistant_off]]):format(AddonName),

  	["used"]  			    = ([[Interface\Addons\%s\icons\ExecutiveAssistant_used]]):format(AddonName),
  	["notused"] 			  = ([[Interface\Addons\%s\icons\ExecutiveAssistant_notused]]):format(AddonName),

  	["used_R"]  		    = ([[Interface\Addons\%s\icons\ExecutiveAssistant_used_reminder]]):format(AddonName),
  	["notused_R"] 		  = ([[Interface\Addons\%s\icons\ExecutiveAssistant_notused_reminder]]):format(AddonName),  	
  	
  	["disabledGroup"]   = ([[Interface\Addons\%s\icons\ExecutiveAssistant_disabled]]):format(AddonName),
  	["twExpanded"] 			= ([[Interface\Addons\%s\icons\ExecutiveAssistant_twExpanded]]):format(AddonName),
  	["twCollapsed"]     = ([[Interface\Addons\%s\icons\ExecutiveAssistant_twCollapsed]]):format(AddonName),
  	["ldb_Expanded_h"]  = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_Expanded_header]]):format(AddonName),  	
  	["ldb_Collapsed_h"] = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_Collapsed_header]]):format(AddonName),
  	["ldb_Expanded"]    = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_Expanded]]):format(AddonName),  	
  	["ldb_Collapsed"]   = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_Collapsed]]):format(AddonName),
  	["ldb_OneChar"]     = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_showOne]]):format(AddonName),
  	["ldb_AllChar"]     = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_showAll]]):format(AddonName),
  	["ldb_tt_PGT"]      = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_PGT]]):format(AddonName),
  	["ldb_tt_GTP"]      = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_GTP]]):format(AddonName),
  	["ldb_showGroups"]  = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_showGroups]]):format(AddonName),
  	["ldb_hideGroups"]  = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_hideGroups]]):format(AddonName),
  	["ldb_showALLgroups"] = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_showALLGroups]]):format(AddonName),
  	["ldb_ShowOnlySelectedGroup"] = ([[Interface\AddOns\%s\icons\ExecutiveAssistant_ShowOnlySelectedGroup]]):format(AddonName),
  	["tw_config"] = ([[Interface\Addons\%s\icons\ExecAssist_Config]]):format(AddonName),
  	["tw_config_push"] = ([[Interface\Addons\%s\icons\ExecAssist_Config_push]]):format(AddonName),
  } 

  -- Setup AceDB
	self.DBDefaults = {
		-- why GLOBAL vs PROFILE or CHAR for charStem data? Profiles coonotate being able to 'change hats' mid-session 
		-- 		which would mean 'being someone else' in the context of this addon, making it confusing to say the least,
		--    or to swap to different sub-sets of actions, which is understandable but a less-in-control way of doing it.
		-- 		Moreover, I'd still have to dig into the .sv[*] end of the db var to find the other profiles to list out
		--  	the other characters for the GTP orientation or the full PGT orientation.
		-- This same thinking applies to placing the data in Char. It doesn't make accessing it that much easier
		--  	(though it would be technically faster/more-efficient when only looking at the current character, that
		-- 		measurement is in miniscule fractions of a milisecond second) and I'd still have to traverse the .sv[*]
		--  	end of the AceDB structure when looking at all chars.
		-- Doing it this way means I can have a standard method (charStem vs self.db.char & self.db.sv.char) and
		-- 		have no chance of running afoul of some profile-related giggery-pokery of which I might be unaware.
		-- The db.char route is used for things I found a need to be character-specific, depending on the class &
		-- 		addons used, usage might differ (e.g., minimap button position & hide/show; task-window usage & position
		-- 		(heavy user) vs ldb-tooltip (alt with few tasks) )
		["char"] = {
			["charSpecificCmdLineTarget"] = false,
    	["DBIconTable"] = { ["hide"] = false },
    	["useTaskWindow"] = true,
    	["useDataBrokerTooltip"] = true,   	
    	["map"] = {["char"] = nil, ["TW"] = nil, ["GTP"] = nil},
		},
    ["global"] = {
    	["Options"] = {
    		["AllowAPI"] = false,
    		["configConfig"] = {
    			["scale"] = 1, -- ExecAssist.Dialog.OpenFrames[ExecAssist.opts.f_reg].frame:SetScale(1.2)
    			["width"] = 800,
    			["height"] = 700,
    		},
    		["ldbLabel"] = L.appName,
    		["showLoginAlerts"] = false,
    		["WeeklyResetDay"] = 3, 
    		["DailyResetTime"] = 6,
				["cfg_groupColor"] = {["r"] = 1, ["g"] = 1, ["b"] = 0},
				["ldbIcon"] = "defaultLDBIcon",
				["SaveCollapseMap"] = true,
    	},
    	["acctwideStem"] = { -- subbing agg to make space for possible future metadata...
				["agg"] = { -- Not /technically/ an agglomeration since only taskID completion tags would be in play 
				}    	
    	},
			["charStem"] = {
			},
			["groupStem"] = {
				["garden"] = { -- Starting Point (DO) for Groups (it was this or a hidden faux-'parent')
				},
				["agg"] = { -- The Great Agglomeration, groupIDs and taskIDs >> groupID.DO = Display Order
					["garden"] = { -- Starting Point (DO) for Groups (it was this or a hidden faux-'parent')
						["id"] = "garden",
						["listName"] = "garden",
						["DO"] = {}
					},				
				},
			},
			["taskWindow"] = {
				["locked"] = false,
				["hidebuttons"] = false,
				["widthMethod"] = false,
				["MinWidth_FontString"] = 120,
				["FixedWidth_FontString"] = 380,
	    	["useRemembered_toggleState"] = true, -- 0.9.9j
  	  	["toggleState_ToggledOff"] = nil,			-- 0.9.9j
				["useDragFrame"] = true,
				["strata"] = "LOW",
				["pos"] = {
					["idx"] = 1,
					["relTW"] = "CENTER",
					["posW_rel"] = "CENTER",
					["posW_relP"] = "CENTER",
					["xOff"] = 0,
					["yOff"] = 0,
				},
				["HideEmptyGroups"] = true,
				["defaultCollapse"] = false,
				["opacity_mouseover"] = 1,
				["opacity_faded"] = 1,
				["hideincombat"] = false,
				["ButtonPos"] = 2,
				["useMouseoverHighlight"] = true,
				["useCounts_onHeaders"] = true,
				["displayType_onHeaders"] = 1,
				["rightMouse_togglesShowChecked"] = true,
				["showChecked"] = true,
				["enableTooltipTooltips"] = true,
				["widthMethod"] = 1,
				["style"] = {
					["background"] = "Solid", -- "Blizzard Tooltip",
					["border"] = "Blizzard Tooltip",
					["bgcolor"]  = {["r"] = 0.01, ["g"] = 0.01, ["b"] = 0.01, ["a"] = 1},
					["bdrcolor"] = {["r"] = 0.01, ["g"] = 0.01, ["b"] = 0.01, ["a"] = 1},
				},
				["fontshadow"] = {
					["shadowcolor"] = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = .75},
					["offset"] = {["x"] = 1, ["y"] = -1}
				},				
			},
			["tooltip"] = {
				["AutoHideDelay"] = .01, -- seconds before the libQTip disappears
				["HideChar_ifNoIncomplete"] = false,
				["HideEmptyGroups"] = true,
				["defaultCollapse"] = false,			
				["rightMouse_togglesShowChecked"] = true,
				["showChecked"] = true,
				["defaultExpandSelf"] = true,
				["OnlyCurrentChar"] = true,				
				
				["AllChar_GroupCharNames"] = true,
				
				["ShowServerNames"] = true,
				["useMouseoverHighlight"] = true,
				["default_tooltipType"] = "PGT",
				["standard_font"] = "Friz Quadrata TT",
				["standard_size"] = 10,
				["header_font"] = "Friz Quadrata TT",
				["header_size"] = 12,
				["snowflake_font"] = "Friz Quadrata TT",
				["snowflake_size"] = 9,
				["fontshadow"] = {
					["shadowcolor"] = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = .75},
					["offset"] = {["x"] = 1, ["y"] = -1}
				},
				["npc"] = {
					["npcColor"]  = {["r"] = 0.4,   ["g"] = 0.4,   ["b"] = 0.4,   ["a"] = 1},
				},
				["tooltipStyle"] = { 
					["useStyle"] = false,
					["bgFile"] 	 = "Solid",   				 -- "Interface/Tooltips/UI-Tooltip-Background"
					["edgeFile"] = "Blizzard Tooltip", -- "Interface/Tooltips/UI-Tooltip-Border"
          ["edgeSize"] = 16, 
          ["insets"]   = 4,
          ["bgcolor"]  = {["r"] = 0,   ["g"] = 0,   ["b"] = 0,   ["a"] = 1},
          ["bdrcolor"] = {["r"] = 0.6, ["g"] = 0.6, ["b"] = 0.6, ["a"] = 1},
				},				
				["useCounts_onHeaders"] = true,
				["displayType_onHeaders"] = 1,
				["useCounts_onLDB"] = true,
				["displayType_onLDB"] = 1,
				["default_GroupDisplayMode_PGT"] = 1, -- default & override group display mode
				["ShowGroupNames_PGT"] = true,				-- group display modes
				["ShowAllGroups_PGT"] = true,					-- group display modes
				["ShowOnlySelectedGroup_PGT"] = true,	-- group display modes
				["HideGroupNames_PGT"] = true,				-- group display modes
				["default_GroupDisplayMode_GTP"] = 1, -- default & override group display mode
				["ShowAllGroups_GTP"] = true,					-- group display modes
				["HideGroupNames_GTP"] = true,				-- group display modes
				["tooltipButtonPos"] = 1,
  
				["color_Group"]      = {["r"] = 0.78, ["g"] = 0.61, ["b"] = 0.43},
				["color_TaskName"]   = {["r"] = 1,    ["g"] = 1,    ["b"] = 1   },
				["color_taskCounts"] = {["r"] = 0.43, ["g"] = 0.61, ["b"] = 0.78},

				["enableTooltipTooltips"] = true,
				["SM"] = { -- Style Manager
					["acctwide"] = {
						["useStyle"] = true,
						["useText"] = 2,
						["useText_text"] = "*",
						["useColor"] = 2,						
						["color"] = {["r"] = 0, ["g"] = 0.94, ["b"] = 0.94},
					},
					["purgable"] = {
						["useStyle"] = true,
						["useText"] = 2,
						["useText_text"] = "(p)",
						["useColor"] = 2,		
						["color"] = {["r"] = 1, ["g"] = 0, ["b"] = 0.5},
					},
					["hidden"] = {
						["useStyle"] = true,
						["useText"] = 2,
						["useText_text"] = "(i)",
						["useColor"] = 2,		
						["color"] = {["r"] = 0.73, ["g"] = 0.61, ["b"] = 0.78},
					},
					["cmdLineTarget"] = {
						["useStyle"] = true,
						["useText"] = 2,
						["useText_text"] = "(c)",
						["useColor"] = 2,		
						["color"] = {["r"] = 0.33, ["g"] = 0.54, ["b"] = 0.52},
					},
					["snowflake"] = {
						["useStyle"] = true,
						["useText"] = 2,
						["useText_text"] = "[Z]",
						["useColor"] = 2,		
						["color"] = {["r"] = 1, ["g"] = 0.49, ["b"] = 0.4},
					},
				},
			},
			-- ["clickmapOrder"] -> local clickmapOrder = {} in ea_Options to allow for safe injection from modules that isn't processed when they are disabled
			["clickmap"] = { -- LDB -- since it's not user alterable or put in the sv file, could move the full clickmap into this...but that would make any 3rd-party extensibility problematic at best; easy enough to stuff in for 1-index maint if the API idea is shelved
				["CONFIG"] 				   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = (L.clickmap_CONFIG_name):format(L.appName),
					["desc"] = (L.clickmap_CONFIG_desc):format(L.appName),
					["func"] = function() ExecAssist:doLoadConfig() end,
				},
				["HELP"]				 	   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = (L.clickmap_HELP_name):format(L.appName),
					["desc"] = (L.clickmap_HELP_desc):format(L.appName),
					["func"] = function() ExecAssist:doLoadHelp() end,
				},
				["CLICKMAP"] 			   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_CLICKMAP_name,
					["desc"] = L.clickmap_CLICKMAP_desc,
					["func"] = function() ExecAssist:doLoadClickMap() end,
				},
				["TACM"] 					   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_TACM_name,
					["desc"] = L.clickmap_TACM_desc,
					["func"] = function() ExecAssist:doLoadTaskMaint() end,
				},
				["STYLEMGR"] 			   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_STYLEMGR_name,
					["desc"] = L.clickmap_STYLEMGR_desc,
					["func"] = function() ExecAssist:doLoadSyleMgr() end,
				},
				["TOOLTIP CONFIG"]   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_TOOLTIPCONFIG_name,
					["desc"] = L.clickmap_TOOLTIPCONFIG_desc,
					["func"] = function() ExecAssist:doLoadTooltipConfig() end,
				},
				["TASKWIN CONFIG"]   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_TASKWINCONFIG_name,
					["desc"] = L.clickmap_TASKWINCONFIG_desc,
					["func"] = function() ExecAssist:doLoadTaskWindow() end,
				},
				["RESET"] 				   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_RESET_name,
					["desc"] = L.clickmap_RESET_desc,
					["func"] = function() ExecAssist:doLoadResetOpts() end,
				},
				["reset_Manual"] 	   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_reset_Manual_name,
					["desc"] = L.clickmap_reset_Manual_desc,
					["func"] = function() ExecAssist:resetTasks(nil, nil, true) end,
				},
				["purgePurgables"]   = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_purgePurgables_name,
					["desc"] = (L.clickmap_purgePurgables_desc):format(L.appName),
					["func"] = function() ExecAssist:resetTasks(nil, nil, nil, true) end, -- purge purgables
				},
				["ToggleTaskWindow"] = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_ToggleTaskWindow_name,
					["desc"] = L.clickmap_ToggleTaskWindow_desc,
					["func"] = function() ExecAssist:doToggleTaskWindow() end,
				},
				["ShowDataBrokerTT"] = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_ShowDataBrokerTT_name,
					["desc"] = L.clickmap_ShowDataBrokerTT_desc,
					["func"] = function() ExecAssist:doShowDataBrokerTooltip() end,
				},
				["ClickMap_Config"]  = {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_CLICKMAPconfig_name,
					["desc"] = L.clickmap_CLICKMAPconfig_desc,
					["func"] = function() ExecAssist:configureClickMap() end,
				},
				["ToggleTooltipTips"]= {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_ToggleTooltipTips_name,
					["desc"] = L.clickmap_ToggleTooltipTips_desc,
					["func"] = function() ExecAssist:toggleTooltipTips() end,
				},
				["ToggleShowTWControlButtons"]= {
					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
					["name"] = L.clickmap_HideTaskWindowControlButtons_name,
					["desc"] = L.clickmap_HideTaskWindowControlButtons_desc,
					["func"] = function() ExecAssist:doToggleShowTWControlButtons() end,
				},				
			},
    },
  }
  self.db = LibStub("AceDB-3.0"):New("ExecAssistDB", self.DBDefaults, true)    

	-- Prime char vars and charStem
	self.userCurrent = UnitName("player").." - "..GetRealmName(); self.userConfigDisplay = self.userCurrent
 	if not self.db.global.charStem[self.userCurrent] then self.db.global.charStem[self.userCurrent] = {["agg"] = {}} end -- new user, establish agglomeration
	debug("* Debugging Mode Active *") -- dev sanity check
	
	-- Register Options ------------------------------------------------------ --
	self:regOptions()

  -- Commandline ----------------------------------------------------------- --
	local cmdLine = {
		type = "group",
		name = "",
		args = {
      config = {
        type = "execute",
        name = "",
        desc = L.AddonConfiguration,
        func = function() ExecAssist:doLoadConfig() end,
        order = 0
      },
      manage = {
        type = "execute",
        name = "",
        desc = L.CommandLineHelp_manage,
        func = function() ExecAssist:doLoadTaskMaint() end,
        order = 2
      },
      task = {
        type = "execute",
        name = "",
        desc = L.CommandLineHelp_task,
        func = function(...) ExecAssist:doAddPurgableTask(...) end,
        order = 3
      },
      mytask = {
        type = "execute",
        name = "",
        desc = L.CommandLineHelp_mytask,
        func = function(...) ExecAssist:doAddPersonalPurgableTask(...) end,
        order = 4
      },
      setgroup = {
        type = "execute",
        name = "",
        desc = L.CommandLineHelp_setgroup,
        func = function(...) ExecAssist:doResetTargetGroup(...) end,
        order = 5
      },
      npc = {
      	type = "execute",
      	name = "",
      	desc = "Create an NPC", 
      	func = function(...) ExecAssist:doCreateNPC(...) end,
      	order = 6
      },
      debug = {
        cmdHidden = true, 
        type = "execute",
        name = "",
        desc = "Toggles Debug Mode",
        func = function() ExecAssist:doDebuggingMode() end,
        order = 30
      },      
    }
  }
 	LibStub("AceConfig-3.0"):RegisterOptionsTable(L.appName.." CmdLine", cmdLine, {"ea", "exa"})

  -- libDataBroker and DBIcon ---------------------------------------------- --
  self.meatPopcicle = self:ldb_ObjectCreate()
  LibStub("LibDBIcon-1.0"):Register(AddonName, self.meatPopcicle, self.db.char.DBIconTable)   
end

function ExecAssist:OnEnable()
	local sdbg = self.db.global
	-- char prime
	sdbg.charStem[self.userCurrent].charClass = select(2, UnitClass("player")) -- reset each time in case a char is deleted and remade w/ new class and same name
	self:mkCharList() -- make Alphabetized Character List

	-- ------------------------------------------------------------------------------------------------------------------------------ --	
	-- taskTypes Loader
	self.taskTypes = L.optsTable_base.TaskTypes

	-- iterate intern modules --
	self.loadedModules = {}
	for name, module in self:IterateModules() do -- module:Enable() is implicit
		self.loadedModules[name] = true
		self:clickmapExtend(name, module:intern_getClickMap() )
		self:amalgamExtend(       module:intern_getOptionsPanel() )
	  self:helpExtend(          module:intern_getExtendedHelp() )
		self:taskTypeExtend(      module:intern_getNewTaskTypes() )
	end	
	
	-- taskTypes OrderedList (post all loaded modules so any extenders are captured)	
	self.taskTypes_Index = {}; self.isAvail_taskType = {}
	
	-- stublist keeps consistent order in default internal types
	for n = 1,7 do table.insert(self.taskTypes_Index, L.optsTable_base.TaskTypes_stublist[n]); self.isAvail_taskType[L.optsTable_base.TaskTypes_stublist[n]] = true end	
	for k, v in pairs(self.taskTypes) do if not self.isAvail_taskType[k] then table.insert(self.taskTypes_Index, k); self.isAvail_taskType[k]=true end end
	
	-- add Missing Module to taskType (must NOT be in Index
	self.taskTypes[L.optsTable_missingmodule_label] = L.optsTable_missingmodule
	-- ------------------------------------------------------------------------------------------------------------------------------ --	
	-- Load the DB into Options Tables
	self:loadGroups_toOptionsTable()			
	
	-- Check for Resets & set timer
	self.timers = {}
	self:doResetCheck()

	-- reset At Login tasks
	self:resetTasks(nil, nil, nil, nil, true)
	
	-- collapse map
	self:pushCollapseMap()

	-- Load the Task Window if needed 
	local sdbc = self.db.char
	if sdbc.useTaskWindow then -- useTaskWindow is always char specific; internal settings may or may not be, thus the getHandle 
		self:CreateTaskWindow() 
		
		local twStem = self:getHandle_TaskWindow()
		if twStem.hideincombat then self:registerCombatEvents(true) end -- Register Events
		
		if twStem.useRemembered_toggleState and twStem.toggleState_ToggledOff then 
			self:doToggleTaskWindow(true) -- forceHide=true
		else
			if twStem.toggleState_ToggledOff then twStem.toggleState_ToggledOff = false end -- If state isn't remembered, _ToggledOff must be false
			-- DevNote: should have a rummage and see if .toggleState_ToggledOff has any legacy connections, otherwise 
			--          if not .useRemembered_toggleState then this shoudln't even be set in the first place.
		end
	end

	-- Update LDB if needed
	if sdbg.tooltip.useCounts_onLDB and not self.taskWindow then self:ldb_refreshCounts() end
	
	-- tooltip mode pool
	local I = self.icons
	self.mode_PGT = sdbg.tooltip.default_GroupDisplayMode_PGT
	self.mode_GTP = sdbg.tooltip.default_GroupDisplayMode_GTP
	self.modePool = { 
		[1] = {["b"] = "ShowGroupNames", 			  ["i"] = self:mkLink(I.ldb_showGroups, 16),    				 ["PGT"] = true; ["GTP"] = false},
		[2] = {["b"] = "ShowAllGroups", 				["i"] = self:mkLink(I.ldb_showALLgroups, 16), 				 ["PGT"] = true; ["GTP"] = true },
		[3] = {["b"] = "ShowOnlySelectedGroup", ["i"] = self:mkLink(I.ldb_ShowOnlySelectedGroup, 16),  ["PGT"] = true; ["GTP"] = false}, 
		[4] = {["b"] = "HideGroupNames", 			  ["i"] = self:mkLink(I.ldb_hideGroups, 16), 					   ["PGT"] = true; ["GTP"] = true }
	}

	-- Brand New User, Setup Initial Tasks and Clickmapping
	if not sdbg.IsOldHat then
		local groupStem = sdbg.groupStem
		local groupID = self:AddGroup(L.NewUserTasks, groupStem.agg["garden"])
		local hGroup = groupStem.agg[groupID]
		
		hGroup.cmdLineTarget = true
		groupStem.cmdLineTarget = hGroup.id
		
		local function newTask(taskName, suppressRefresh_cmdline)
			local hTask = self:AddTask(hGroup, nil, suppressRefresh_cmdline)			
			hTask.taskName = taskName
			hTask.resetType = L.Manual
			hTask.isAcctWide = true
		end

		local hTask = sdbg.groupStem.agg[hGroup.DO[1]]
		hTask.taskName = L.BrandNewUserTask_0
		hTask.resetType = L.Manual
		hTask.isAcctWide = true

		newTask(L.BrandNewUserTask_1,  true)
		newTask(L.BrandNewUserTask_2,  true)
		newTask(L.BrandNewUserTask_3,  true)
		newTask(L.BrandNewUserTask_4,  true)
		newTask(L.BrandNewUserTask_5,  true)
		newTask(L.BrandNewUserTask_6,  true)
		newTask(L.BrandNewUserTask_7,  true)
		newTask(L.BrandNewUserTask_8,  true)
		newTask(L.BrandNewUserTask_9,  true)
		newTask(L.BrandNewUserTask_10, true)
		newTask(L.BrandNewUserTask_11, false) -- initial run has Task Window enabled
		
		-- Update GroupMaintenance var, so new tasks show in the list
		self:loadGroups_toOptionsTable()	

		hGroup.cmdLineTarget = false
		groupStem.cmdLineTarget = nil		
		
		-- inject defaults into the ClickMap
		local cm = self.db.global.clickmap
		cm["CONFIG"]["code"] = "Lm"; cm["CONFIG"]["m"] = "LeftButton"; cm["CONFIG"]["notify"] = false
		cm["TACM"]["code"] = "Rm"; cm["TACM"]["m"] = "RightButton"; cm["TACM"]["notify"] = false
		cm["HELP"]["code"] = "Rms"; cm["HELP"]["m"] = "RightButton"; cm["HELP"]["s"] = true; cm["HELP"]["notify"] = true
		cm["ClickMap_Config"]["code"] = "Rmsc"; cm["ClickMap_Config"]["m"] = "RightButton"; cm["ClickMap_Config"]["s"] = true; cm["ClickMap_Config"]["c"] = true; cm["ClickMap_Config"]["notify"] = true

		sdbg.IsOldHat = true
	end

	-- Init quickTaskEntry
	self:quickTaskEntry_SingleTask_Setup()

	-- establish the ClickMap
	self:build_clickmapServiceIndex() -- builds the Service Index (mouse/key combination)
	self:build_clickmapOptions() 			-- builds options dynamically from DBDefaults
end

 -- Time and Reset funcs --
function ExecAssist:doResetCheck()
	local sdbg = self.db.global
	-- Timer Trap -------------------------------------------------------------------------- --
	if not sdbg.nextMidnightReset then sdbg.nextMidnightReset = self:happyMidnight(time() ) end
 	if not sdbg.nextDailyReset    then sdbg.nextDailyReset    = self:happyDaily(   time() ) end
	if not sdbg.nextWeeklyReset   then sdbg.nextWeeklyReset   = self:happyWeekly(  time() ) end
	-- -------------------------------------------------------------------------- Timer Trap --

	-- rc > 0 tasks need to be reset
	if time() - sdbg.nextMidnightReset > 0 then self:resetTasks(nil, nil, nil, nil, nil, true, true) end
	if time() - sdbg.nextDailyReset    > 0 then self:resetTasks(true) end
	if time() - sdbg.nextWeeklyReset   > 0 then self:resetTasks(nil, true) end
	
	-- reset timer to next Resetcheck (cancel then set next-lowest as next doResetCheck (midnight or daily reset time)
	local timerResetCheck = self.timers.doResetCheck	
	if timerResetCheck then self:CancelTimer(timerResetCheck) end
	timerResetCheck = self:ScheduleTimer( "doResetCheck", sdbg.nextMidnightReset < sdbg.nextDailyReset and (sdbg.nextMidnightReset - time()) or (sdbg.nextDailyReset - time()) )	
end
-- normalizing the execution-time makes the comparitor a hard-trigger; wonder if there are n-day resetables worth worrying about -- debug( date("%Y-%m-%d %H:%M:%S", timedateObj) )
function ExecAssist:timeWarp(oriTime, daysToWarp)	return ( oriTime + (daysToWarp * 86400) ) end -- could have done last+(n*86400) but RHPS
function ExecAssist:happyMidnight(oriTime, Options_SetExplicitDay)
	-- returns midnight of the date given																-- returns Midnight Tomorrow (00:00am)
	local t
	if Options_SetExplicitDay then
		t = date("*t", oriTime) -- exact time
	else
		t = date("*t", oriTime + 86400) -- pushes 24hrs
	end 
	t.hour = 0 -- set happy hour
	t.min  = 0 -- set happy minute
	t.sec  = 0 -- set happy seconds
	return time(t)
end
function ExecAssist:happyWeekly(oriTime) -- Normalizes a time numeric to the last WeeklyResetDay (perfect comparitor)
	local real_weeklyDoW = date("*t", oriTime).wday -- find the oriTime day-of-week
	local walkbackDays = 0	                 				 -- # days that real_ needs to wind back to become perfect_
	local WeeklyResetDay = self.db.global.Options.WeeklyResetDay -- get proper weekly reset day
	
	if WeeklyResetDay == real_weeklyDoW then 							-- today = weekly reset day
		walkbackDays = 0
	elseif WeeklyResetDay < real_weeklyDoW then								
		walkbackDays = real_weeklyDoW - WeeklyResetDay			-- week has not wrapped
	else
		walkbackDays = (7-WeeklyResetDay) + real_weeklyDoW	-- week has wrapped
	end

-- print( tostring( date("*t", time()).wday ).." - "..tostring(ExecAssist.db.global.Options.WeeklyResetDay) )
-- /script print( date("%c",ExecAssist.db.global.nextWeeklyReset))
-- /script print( date("%c",ExecAssist.db.global.nextDailyReset))

	return self:happyTime( self:timeWarp(oriTime, (7 - walkbackDays) ) ) -- adjust the requsite # of days, normalize the time of day, then return
end
function ExecAssist:happyDaily(oriTime)  -- Normalizes a time numeric to the DailyResetTime (perfect comparitor)
	if difftime( time(), self:happyTime(time()) ) > 0 then
		return self:happyTime(self:timeWarp(oriTime, 1))
	else
		return self:happyTime(oriTime)
	end	
end
function ExecAssist:happyTime(oriTime)	 -- Inserts the user selected Reset Time into the time numeric
	local s_DailyResetTime = self.optValues.ResetTimesList[self.db.global.Options.DailyResetTime]
	local t = date("*t", oriTime) -- get a table of Time numeric, time() needs this table structure to reconstruct a time numeric
	t.hour = s_DailyResetTime:sub(1, 2) -- set happy hour
	t.min  = s_DailyResetTime:sub(4)    -- set happy minute
	t.sec  = 0 													-- set happy seconds
	return time(t)											-- return happy time
end
function ExecAssist:resetTasks(resetDaily, resetWeekly, resetManual, purgePurgables, resetAtLogins, resetReminder, resetCalendar)
	local sdbg = self.db.global
	local charStem_base = sdbg.charStem
	local aggStem = sdbg.groupStem.agg
	local self_happyMidnightToday = self:happyMidnight(time(), true)

	local function sendAlerts()
		if resetDaily     then self:alert(L.resetAlert_resetDaily) 		 end
		if resetWeekly    then self:alert(L.resetAlert_resetWeekly) 	 end
		if resetManual    then self:alert(L.resetAlert_resetManual) 	 end
		if purgePurgables then self:alert(L.resetAlert_purgePurgables) end
		if resetAtLogins  then self:alert(L.resetAlert_resetAtLogins)  end
		if resetReminder  then self:alert(L.resetAlert_resetReminder)  end
		if resetCalendar  then self:alert(L.resetAlert_resetCalendar)  end
	end

	local function reset_ifInScope(hTask_cS, taskID, charName) -- cS=charStem
		-- This handles PER-CHARACTER .checked field related activities. 
		-- DATE-RELATED activties (Calender Automatic, Reminder) are handled AFTER
		local hTask = aggStem[taskID]

-- if not hTask then ExecAssist.db.global.problemchild2 = taskID; return end

		if hTask_cS.checked then -- uncheck the .checked			
			if (resetDaily    and hTask.resetType == L.DailyAutomatic) 	or
			   (resetWeekly   and hTask.resetType == L.WeeklyAutomatic) or
			   (resetManual   and hTask.resetType == L.Manual)    			or
			   (resetAtLogins and hTask.resetType == L.AtEachLogin) 		or 
			   (resetReminder and hTask.resetType == L.Reminder) then -- L.Reminder MIGHT be converted from something else and .checked, better safe than sorry
						hTask_cS.checked = nil
			elseif purgePurgables and hTask.resetType == L.Purgable then
				if hTask.isAcctWide then 
					-- If Account Wide, we kill it now since we're here b/c for AW, checked = ALL CHECKED
					self:DeleteTask(hTask, aggStem[hTask.p].G)  -- hItem & parent Geneaology for hardPrune()
				else
					-- Disable for charName (leaving checked in case I ever have to debug an sv file) 
					hTask_cS.userOverride = 3 -- Disable
					hTask_cS.checked = nil    -- remove .checked so we don't keep reprocessing it
				end
				-- -----------------------------------------				
			elseif resetCalendar and hTask.resetType == L.CalendarAutomatic then
				if hTask.resetDate_Next <= self_happyMidnightToday then
					hTask_cS.checked = nil
				end
				-- ------------------------------------------	
			end
			
		end
	end
	 
	-- Char Level Scans
	for charName, charStem in pairs(charStem_base) do		 -- character-level completes
		for itemID, hItem in pairs(charStem.agg) do        -- agg=agglomeration
			if itemID:isTask() then 
				reset_ifInScope(hItem, itemID, charName) -- charStem entries don't carry .id & purged purgables need to find the actual task entry hTask to nix & prune
			end
		end
	end

	for itemID, hItem in pairs(sdbg.acctwideStem.agg) do -- account-wide completes (always items)
		reset_ifInScope(hItem, itemID)
	end
	
	-- Task Level Scans (Date-Related Activities and purgePurgables)
	if resetReminder or resetCalendar or purgePurgables then
		for itemID, hItem in pairs(aggStem) do        -- agg=agglomeration	
			if itemID:isTask() then
				if resetReminder and hItem.resetType ==L.Reminder then					-- Reminder
					if hItem.resetDate_Next and hItem.resetDate_Next <= self_happyMidnightToday then hItem.resetType = L.Purgable end
				elseif resetCalendar and hItem.resetType == L.CalendarAutomatic then			-- Calendar Automatic
					if hItem.resetDate_Next and hItem.resetDate_Next <= self_happyMidnightToday then
						-- Advance the _Next date to one in the future; then set _Last to 'previous cycle'
						local paranoia = 0
	 					while (hItem.resetDate_Next <= self_happyMidnightToday) and (paranoia < 100) do
	 						paranoia = paranoia + 1 
	 						hItem.resetDate_Next = hItem.resetDate_Next + (86400 * hItem.offsetDays)
	 					end
	 					hItem.resetDate_Last = hItem.resetDate_Next - (86400 * hItem.offsetDays)
	 					if paranoia >= 100 then self:alert(L.paranoia_Alert..hItem.taskName) end
					end
				elseif purgePurgables and hItem.resetType == L.Purgable then			-- purgePurgables
					-- hardCheck for Purgables ------------------------------------------------------------------------------------------------
					local purge = true
					for i=1, #ExecAssist.charList do if self:hasCleanGenes(ExecAssist.charList[i], itemID) then purge = false; break; end end
					if purge then self:DeleteTask(hItem, aggStem[hItem.p].G) end -- hItem & parent Geneaology for hardPrune()
					-- ------------------------------------------------------------------------------------------------------------------------
				end
			end
		end
	end
	
	-- alerts	
	if ExecAssist.notLoginReset then sendAlerts() 
	else ExecAssist.notLoginReset = true; 
		if sdbg.Options.showLoginAlerts then sendAlerts() end 
	end

	-- reset runtimes
	if resetDaily     then sdbg.nextDailyReset  = self:happyDaily(  time() )  end
	if resetWeekly    then sdbg.nextWeeklyReset = self:happyWeekly( time() )  end
	if resetReminder or resetCalendar then sdbg.nextMidnightReset = self:happyMidnight( time() )  end

	if sdbg.tooltip.useCounts_onLDB then self:ldb_refreshCounts() end  		
	self:UpdateWindow()
	
	-- notify Modules of reset
	for name, module in self:IterateModules() do	
		module:intern_resetHandler(resetDaily, resetWeekly, resetManual, purgePurgables, resetAtLogins, resetReminder, resetCalendar)
	end
	
end
 
-- Click-Map (active) --
local clickmapServiceIndex = {}
function ExecAssist:get_clickmapService(cmSvcTag) return self.db.global.clickmap[cmSvcTag] end -- used in building options
function ExecAssist:isBusy_clickmapServiceHandle(mouse, shift, alt, ctrl) 
	return clickmapServiceIndex[self:formatClick(mouse, shift, alt, ctrl)] 
end
function ExecAssist:formatClick(mouse, shift, alt, ctrl)	return (mouse == "LeftButton" and "Lm" or "Rm")..(shift and "s" or "")..(alt and "a" or "")..(ctrl and "c" or "") end
function ExecAssist:build_clickmapServiceIndex()
	local cmStem = self.db.global.clickmap
	clickmapServiceIndex = {} 
	for cmSvcTag, SvcOpts in pairs(cmStem) do
		if SvcOpts.m then -- m=add since all click kinda need a mouse
			clickmapServiceIndex[self:formatClick(SvcOpts.m, SvcOpts.s, SvcOpts.a, SvcOpts.c)] = cmSvcTag		
		end
	end
	
end
function ExecAssist:ldbClickMap(mouse, shift, alt, ctrl) 
	local userRequestedAction
	local clickmapService = clickmapServiceIndex[self:formatClick(mouse, shift, alt, ctrl)]
	local cm = self.db.global.clickmap
	if clickmapService then
		userRequestedAction = cm[clickmapService]
		if userRequestedAction.func then -- if .func=nil then Service is provided by an Intern or otherwise unloaded module/addon as .func is not saved into the savedvar file.
			if cm[clickmapService].notify then self:alert(L.cm_running..userRequestedAction.name) end
			userRequestedAction.func()
		end
	end	
end

	-- simple actions
function ExecAssist:doDebuggingMode() ExecAssist.db.sv.debug = not ExecAssist.db.sv.debug; ReloadUI() end

function ExecAssist:doUpdateStatusField(subSectionName, isCore) 
	self.Dialog.OpenFrames[self.opts.f_reg]:SetStatusText(
		(L.statusText):cf("cream"):format( 
				L.StatusField_appName:cf("EAtan", "cream"), 
				GetAddOnMetadata(AddonName, 'Version'):cf("grass", "cream"), 
				L.authorName:cf("EAtan"), 
				(isCore and ("Page"):cf("cyan", "white") or ("Module"):cf("fuglyYellow", "white") ), 
				subSectionName:cf("grass", "cream") 
		) 
	) 
end

function ExecAssist:doResetScale()
	local dlg = self.aceDlg 
	if dlg then
		dlg.frame:SetScale(dlg.scale)
		self:Unhook(dlg.frame, "OnHide")
		self.aceDlg = nil
	end
end

function ExecAssist:doOpenConfigWindow(pathTable) 
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	self.Dialog:Open(self.opts.f_reg)

	-- Ace window scale is 1.0 with no methods to change it; however, you never know when someone's done a universal upscale so...
	if not self.aceDlg then
		self.aceDlg = { ["frame"] = self.Dialog.OpenFrames[self.opts.f_reg].frame }
		local dlg = self.aceDlg; dlg.scale = self.aceDlg.frame:GetScale()

		dlg.frame:SetScale(self.db.global.Options.configConfig.scale)
		-- Only one hook is needed and many ':doOpenConfigWindow()' calls may be made using diffent ldb click actions before a window close
		if not self:IsHooked(dlg.frame, "OnHide") then self:HookScript(dlg.frame, "OnHide", "doResetScale") end -- :IsHooked() should always be nil; but paranoia rules the day
		-- ---------------------------------------------------------------------------------------------------------------------------
	end
	
	if type(pathTable) == "string" then
		self.Dialog:SelectGroup(self.opts.f_reg, pathTable)
	else
		self.Dialog:SelectGroup(self.opts.f_reg, unpack(pathTable) ); -- table.unpack() is nil but unpack() is a thing... 
	end
end
function ExecAssist:doLoadConfig()         					self:doOpenConfigWindow(self.opts.f_MainOpts)   							 end
function ExecAssist:doLoadHelp(subPage, subSubPage) self:doOpenConfigWindow({self.opts.f_Help, subPage, subSubPage}) end
function ExecAssist:doLoadClickMap() 			 					self:doOpenConfigWindow(self.opts.f_ClickMap)   							 end
function ExecAssist:doLoadSyleMgr() 			 					self:doOpenConfigWindow(self.opts.f_StyleMgr)   							 end
function ExecAssist:doLoadTaskMaint() 		 					self:doOpenConfigWindow(self.opts.f_TaskMaint)  							 end
function ExecAssist:doLoadTooltipConfig()  					self:doOpenConfigWindow(self.opts.f_ToolTip)  								 end
function ExecAssist:doLoadTaskWindow() 		 					self:doOpenConfigWindow(self.opts.f_TaskWindow)								 end
--		self.opts.f_CmdLine Intentionally Left Blank (not in clickmap and no reason it should be)
function ExecAssist:doLoadResetOpts()      					self:doOpenConfigWindow(self.opts.f_ResetOpts) 								 end
function ExecAssist:doToggleShowTWControlButtons()
	local twStem = self:getHandle_TaskWindow()
	twStem.hidebuttons = not twStem.hidebuttons
	self:UpdateWindow()
end

function ExecAssist:doToggleTaskWindow(forceHide)
	local sdbc = self.db.char
	if sdbc.useTaskWindow or forceHide then -- forceHide only comes from Options toggle OFF
		if self.taskWindow:IsShown() or forceHide then
			self.taskWindow:Hide()
			self.taskWindow_posAnchor:Hide()
			self.taskWindow_dragFrame:Hide()
			self:getHandle_TaskWindow().toggleState_ToggledOff = true
		else
			local twStem = self:getHandle_TaskWindow()
			self.taskWindow_posAnchor:Show()
			self.taskWindow:Show()
			if not twStem.locked and twStem.useDragFrame then self.taskWindow_dragFrame:Show() end
			twStem.toggleState_ToggledOff = false
		end
	else
		self:alert(L.TaskWindowNotEnabled, 1, .1, .1)
	end
end

function ExecAssist:doShowDataBrokerTooltip()
	self:displayTooltip(self.h_meatPopcicle, true)
end
function ExecAssist:toggleTooltipTips()	local ttStem = self.db.global.tooltip; ttStem.enableTooltipTooltips = not ttStem.enableTooltipTooltips end

 -- libDataBroker create func
function ExecAssist:ldb_ObjectCreate()
	local tmpBackdrop, savedBackdrop = {} -- tooltip style handling
	local ttsStem = ExecAssist.db.global.tooltip.tooltipStyle

	return LibStub("LibDataBroker-1.1"):NewDataObject(AddonName, {
		type = 'data source',
		label = self.db.global.Options.ldbLabel, -- L.appName
		text = "", 	
		icon = self.icons[ExecAssist.db.global.Options.ldbIcon],
			-- can have EITHER OnTooltipShow OR OnEnter, not both --> OnTooltipShow = function(tooltip) end				
		OnEnter = function(self) 
			if ttsStem.useStyle then
				ExecAssist:mixinCheck_GameTooltipBackdrop()
				savedBackdrop = GameTooltip:GetBackdrop()
				tmpBackdrop.bgFile   = AceGUIWidgetLSMlists.background[ttsStem.bgFile]
				tmpBackdrop.edgeFile = AceGUIWidgetLSMlists.border[ttsStem.edgeFile]
				tmpBackdrop.edgeSize = ttsStem.edgeSize
				tmpBackdrop.insets = { left = ttsStem.insets, right = ttsStem.insets, top = ttsStem.insets, bottom = ttsStem.insets }
				GameTooltip:SetBackdrop(tmpBackdrop)

				GameTooltip:SetBackdropBorderColor(ttsStem.bdrcolor.r, ttsStem.bdrcolor.g, ttsStem.bdrcolor.b, ttsStem.bdrcolor.a)
			end
			ExecAssist:displayTooltip(self) 
		end, -- self in this context is the ldbObject		
    OnLeave = function(self) 
    	-- Restore Border
			if ttsStem.useStyle then 
				ExecAssist:mixinCheck_GameTooltipBackdrop()
				GameTooltip:SetBackdrop(savedBackdrop) 
				GameTooltip:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
				GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
			end
    end,
				
		OnClick = function(self, button) ExecAssist.h_meatPopcicle = self; ExecAssist:ldbClickMap(button, IsShiftKeyDown(), IsAltKeyDown(), IsControlKeyDown()) end,
	})
end

 -- Task Window Related Combat Events
function ExecAssist:registerCombatEvents(combatEventsEnabled)
	if combatEventsEnabled then
	  self:Register("PLAYER_REGEN_DISABLED", "EVENT_combatStart")
  	self:Register("PLAYER_REGEN_ENABLED",  "EVENT_combatEnd")	
	else
	  self:Unregister("PLAYER_REGEN_DISABLED")
  	self:Unregister("PLAYER_REGEN_ENABLED")
	end
end
function ExecAssist:EVENT_combatStart() if self.taskWindow then self.taskWindow:Hide() end end
function ExecAssist:EVENT_combatEnd()   if self.taskWindow then self.taskWindow:Show() end end

 -- purgatorium
function ExecAssist:getFreshTaskStem()
	local groupStem = self.db.global.groupStem	
	if groupStem.cmdLineTarget ~= nil then
		if groupStem.agg[groupStem.cmdLineTarget] then
			local hTask = ExecAssist:AddTask(groupStem.cmdLineTarget, nil, true)
			return hTask
		else
			self:alert(L.cm_unableToFindGroup)
		end
	else
		self:alert(L.cm_NoTagetSelected)
	end
end

local function getArgTable(data)
	local data, argT, sendTo = data:trim(), {}
	local validArgs = {
		["+"] = {
				["+aw"] = true, 
				["+daily"] = L.DailyAutomatic, 
				["+weekly"] = L.WeeklyAutomatic, 
				["+manual"] = L.Manual,
				["+calendar"] = L.CalendarAutomatic,
				["+reminder"] = L.Reminder,
				["+login"] = L.AtEachLogin
				-- Module Injected Keys...
				-- Precise Control Name is already added into the Task Types list; would only need a diminutive key (+<...>)
				-- The /help/ for it would be the problem, getting it to display in an /ea list. That would mean extending
				-- the Localized text (annotating it in fact) Maybe hold off on this...see if there's really a call for it first.
		}, 
		[">"] = true 
	}

	local function getNextArg(data)
		local nextArg, validArg
		local f = data:find(" ")
		if f then
			nextArg = data:sub(1,f-1)
			data = data:sub(f+1):trim()
			validArg = true
		else
			nextArg = data
			data = ""
			validArg = true
		end
		return nextArg, data, validArg -- if abort, nextArg is invalid arg
	end

	local validArg = true
	while validArg and #data > 2 and validArgs[data:sub(1,1)] do -- smallest possible arg = 3 (+aw)
		local nextArg
		nextArg, data, validArg = getNextArg(data)
		if validArg then
			if nextArg:sub(1,1) == ">" then
				local charStem_base = ExecAssist.db.global.charStem
				nextArg = nextArg:sub(2):lower()

				local CCL = ExecAssist.compressed_charList -- for partial matches
				local bits 
				for comp_charName, charName in pairs(CCL) do
					bits = comp_charName:sub(1, nextArg:len()):lower()

					if nextArg == bits then
						if not sendTo then
							sendTo = charName
						else -- collision
							sendTo = nil
							ExecAssist:alert("["..nextArg.."] was not sufficiently unique, unable to establish character name.")
							break;
						end	
					end
				end

				if not sendTo then 
					ExecAssist:alert("Unable to find Character "..nextArg); validArg = nil; 
					break; 
				end
			else
				if validArgs["+"][nextArg] then
					if nextArg == "+aw" then
						argT["isAcctWide"] = true
					elseif validArgs["+"][nextArg] then -- cheat to check for 3x at once
						argT["resetType"] = validArgs["+"][nextArg]
					end
				else
					ExecAssist:alert("Unrecognized argument: "..nextArg); validArg=nil					
				end
			end	
		else
			ExecAssist:alert("Unrecognized argument: "..nextArg); validArg=nil	
		end
	end

	return argT, sendTo, data, validArg
end
local function mkTaskExclusive(hTask, charName)
	hTask.defaultEnabled = false
		
	local charStem = ExecAssist.db.global.charStem[charName]
	if not charStem.agg[hTask.id] then charStem.agg[hTask.id] = {} end
	charStem.agg[hTask.id].userOverride = 2
	
	if ExecAssist:isCharIgnored(charName, charStem) then
		ExecAssist:alert("Nota Bene: ["..charName.."] is flagged 'Ignore Character' and Task will not be usable", 1, 1, 0)
	end
end
function ExecAssist:doAddPurgableTask(aceTable, forceCurrentChar)
	local data = aceTable.input:sub(6):trim()
	local argT, sendTo, taskName, validArg = getArgTable(data)
	local groupStem = self.db.global.groupStem

	if validArg then
		local hTask = ExecAssist:getFreshTaskStem()
		if hTask then
			if taskName ~= "" then hTask.taskName = taskName:gsub("//", "|") end -- if no name, it will be default
			hTask.resetType = true and argT["resetType"] or L.Purgable 
			hTask.isAcctWide = argT["isAcctWide"]

			if sendTo or forceCurrentChar then mkTaskExclusive(hTask, forceCurrentChar and self.userCurrent or sendTo) end
				-- adds default dates and computes default offsets, otherwise the resetter function will have nils-to-numbers headaches
			if hTask.resetType==L.Reminder or hTask.resetType==L.CalendarAutomatic then self:primeDateBased_TaskTypes(hTask) end
		
			self:semiSmart_regrow(groupStem.agg[groupStem.cmdLineTarget].G) -- add to options table
			
			self:UpdateWindow()  -- since refresh was suppressed in :AddTask()
				self:alert( ( (forceCurrentChar and L.personal.." " or "")..L.taskCreated):format(( true and ((taskName ~= nil and taskName ~="") and taskName or nil) or L.DefaultTaskName):cf("EAtan")))
		end
	end -- msg already delivered
end
function ExecAssist:doAddPersonalPurgableTask(aceTable)
	-- easy redirector to make default->sendTo items for the current user
	aceTable.input = aceTable.input:sub(2) -- doAdd assumes 6chr of task input
	self:doAddPurgableTask(aceTable, true)
end

function ExecAssist:reset_CmdLineTarget(hGroup, mayNotBeNil)
	local groupStem = self.db.global.groupStem
	
	if hGroup.id == groupStem.cmdLineTarget then 
		if not mayNotBeNil then -- mayNotBeNil is passed by command line reset ops to keep to user from accidentally unsetting a target
			groupStem.cmdLineTarget = nil
			hGroup.cmdLineTarget=false
		end
	else
		if groupStem.cmdLineTarget then
			groupStem.agg[groupStem.cmdLineTarget].cmdLineTarget=false -- tell old target they can take the night off
		end
		hGroup.cmdLineTarget = true							-- new sherrif in town
		groupStem.cmdLineTarget = hGroup.id			-- making it official
	end
	return groupStem.cmdLineTarget
end

function ExecAssist:doResetTargetGroup(aceTable)
	local groupName = aceTable.input:sub(10):trim()
	local groupName_lower = groupName:lower()

	local groupStem = self.db.global.groupStem
	for elementID, hElement in pairs(groupStem.agg) do
		if elementID:isGroup() and hElement.listName:lower() == groupName_lower then
			if self:reset_CmdLineTarget(hElement, true) then 
				self:alert( (L.cmdlinetargetsetto):format( hElement.listName:cf("EAtan")  ))
			end

			return
		end
	end

	self:alert( (L.unabletofindgroup):format((groupName):cf("EAtan")))
end

function ExecAssist:doCreateNPC(aceTable)
	local charStem = self.db.global.charStem
	local npcName = aceTable.input:sub(4):trim()
	if npcName == "" then 
		self:alert( L.NPC_NoNameEntered:cf("hard_red") )
	else
		if charStem[npcName] then
			-- self:alert( (L.unabletofindgroup):format((groupName):cf("EAtan")))
			self:alert( L.NPC_openTag:cf("hard_red") .. npcName:cf("white") .. L.NPC_closingTag_Exists:cf("hard_red") )
		else
			charStem[npcName] = {["agg"] = {}}
			self:mkCharList() -- sort
			self:alert( L.NPC_openTag:cf("hard_green") .. npcName:cf("white") .. L.NPC_closingTag_Created:cf("hard_green") )
	 	end
	end
end

