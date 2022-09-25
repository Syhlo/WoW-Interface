-- ------------------------------------------------------------------------- --
-- Project: Executive Assistant - To-Do/Task List Manager
-- Author:  VincentSDSH
-- ------------------------------------------------------------------------- --
local AddonName = ...
local debug = ExecAssist.debug
local charList, revCharList = {}, {}
local LibQTip = LibStub("LibQTip-1.0moddedForExecAssist")
local LSM = LibStub("LibSharedMedia-3.0")

local L   = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local mainOpts, ClickMap, TaskAndCharMaintenance, HelpPanel -- TACM is dynamically created, pruned, and maintained so it's made context-local but it still needs to be self.[*] aware so it's loaded in regOptions, mainOpts has a FirstTimeUser prune, ClickMap is updated to match the dynamic map changes
local GROUP_IDENTIFIER, TASK_IDENTIFIER = "g", "t"
local MOVE_UP, MOVE_DOWN = "UP", "DOWN"
local frameStrataOptions = {"BACKGROUND", "LOW", "MEDIUM", "HIGH", "DIALOG", "TOOLTIP"}
	-- Initialize Options: reg opt tables & add to blizz opts
local function simpleTcopy(tOri) local tNew = {} if tOri then for i=1,#tOri do tNew[i]=tOri[i] end end return tNew end 

local amalgam = {}
local clickmapOrder = {"HELP", "CONFIG", "CLICKMAP", "ClickMap_Config", "TACM", "STYLEMGR", "TOOLTIP CONFIG", "TASKWIN CONFIG", "RESET", "reset_Manual", "ToggleTaskWindow", "ShowDataBrokerTT", "ToggleShowTWControlButtons", "ToggleTooltipTips", "purgePurgables" }

function ExecAssist:clickmapExtend(moduleKey, moduleClickMap, func)	
	--[ moduleKey ] ------------------------------------------------
--	moduleKey = "NewTestModule"
	--[ moduleClickMap ]--------------------------------------------	
--	moduleClickMap = {
--					["code"] = nil, ["m"] = false, ["s"] = nil, ["a"] = nil, ["c"] = nil, ["notify"] = true,
--					["name"] = "My Name",
--					["desc"] = "My Description",
--					["func"] = function() debug("WOOHOO!!") end, -- pity you can't save inlines, in a way
--				}
	if moduleClickMap and func then
		table.insert(clickmapOrder, moduleKey)
		local cmStem = self.db.global.clickmap
		if not cmStem[moduleKey] then cmStem[moduleKey] = moduleClickMap; cmStem[moduleKey].isModule = true end
		cmStem[moduleKey]["func"] = func
	end
end
function ExecAssist:amalgamExtend(k, v) if k and v then amalgam.args[k]   = v end end -- adds new control panels
function ExecAssist:helpExtend(k, v)    if k and v then HelpPanel.args[k] = v end end -- adds new help panels
function ExecAssist:taskTypeExtend(newTaskType) 
	if newTaskType then 
		for k, v in pairs(newTaskType) do 
			self.taskTypes[k] = v 
		end 
	end 
end

function ExecAssist:regOptions()
	local sdbg, sdbc = self.db.global, self.db.char 
	local ttStem, cfgOpts = sdbg.tooltip, sdbg.Options.configConfig
	local twStem = self:getHandle_TaskWindow()
	local SM = ttStem.SM

	local function mkHeader(hdrName, numOrder, label) -- Give Me Similar Headers Or Give Me Death ----
		return { 
							order = true and numOrder or 0, 
							type = "description", 
							fontSize = "large",
							name = function() 
								-- :doUpdateStatusField() placed /here/ is a full-on cheat to update the status field when tabs change
								--   Not the worst kludge/cheat I've done in the past few decades but there really seems no way to 
								--   trap cleanly the opt-table change in the standard Ace library. And this /is/ simple and clean...
								--   There MIGHT be a better way but for now I'm just gonna be a bad, bad bear.
								self:doUpdateStatusField( label or hdrName, true ) 
								return hdrName:cf("fuglyYellow").."\n"							
							end
					 }
	end

	self.optValues = L.optsTable_base
	-- AceLocale loads before the icons table is ready so gotta sneak these in

	-- Reset Times List: 60min intervals and 30min intervals. Realtime toggle may be added one day.
	-- Change which of the two lines below are remarked out by moving the two --s
	self.optValues["ResetTimesList"] = {"00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"}
	-- self.optValues["ResetTimesList"] = {}; local RTL = self.optValues.ResetTimesList; for i=0,23 do local j = i>9 and tostring(i) or ("0"..tostring(i)); table.insert(RTL, j..":00"); table.insert(RTL, j..":30") end

	
	self.optValues["GroupDisplayModes"] = {
		self:mkLink(self.icons.ldb_showGroups, 16).." "..L.optsTable_GroupDisplayModes_1, 
		self:mkLink(self.icons.ldb_showALLgroups, 16).." "..L.optsTable_GroupDisplayModes_2, 
		self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 16).." "..L.optsTable_GroupDisplayModes_3, 
		self:mkLink(self.icons.ldb_hideGroups, 16).." "..L.optsTable_GroupDisplayModes_4
	}
	self.optValues["GroupDisplayModes_GTP"] = {
		self:mkLink(self.icons.ldb_showALLgroups, 16).." "..L.optsTable_GroupDisplayModes_2, 
		self:mkLink(self.icons.ldb_hideGroups, 16).." "..L.optsTable_GroupDisplayModes_4
	}
	self.optValues["ldbIcons_GET"] = { self:mkLink(self.icons.defaultLDBIcon, 16) .. " " ..L.optsTable_ldbIcons_GET_1, 
									 					 				 self:mkLink(self.icons.enabled, 16) .. " " ..L.optsTable_ldbIcons_GET_2, 
									 				 	 				 self:mkLink(self.icons.used, 16) .. " " ..L.optsTable_ldbIcons_GET_3
												   				 }
	self.optValues["tooltipDisplay"] = {self:mkLink(self.icons.ldb_tt_PGT, 16).." "..L.optsTable_tooltipDisplay_1, self:mkLink(self.icons.ldb_tt_GTP, 16).." "..L.optsTable_tooltipDisplay_2}

	-- Options Tables 
	blizzy_Opts = {		
		type = "group",
		order = 10,
		name = self:mkLink(self.icons.enabled, 22).." "..L.appName,
		args = {
			introspacer = { order = 4, type = "description", name = "  "}, 
			intro = {
				order = 5,
				type = "description",
				fontSize = "medium",
				name = (L.mainOpts_intro):cf("cream"):format(
					L.appName:cf("EAtan", "cream"),
					L.libExecAssist:cf("lightgray", "cream"), 
					L.Interns_intro:cf("grass","cream"),
					L.appName:cf("EAtan", "cream"),
					L.Interns_intro:cf("grass","cream"),
					L.Interns_intro:cf("grass","cream"),
					L.cmdline_ea:cf("cyan", "cream"),
					L.cmdline_exa:cf("cyan")
				),
			},

			spacer2 = { hidden = sdbg.hideHelp, order = 4, type = "description", name = "  "},
			FirstTimeUser = {
				hidden = sdbg.hideHelp,
		    type = "group", 
				inline = true, 
		    name = "First Time User", 
		    order = 5,
				args = {
					intro = {
						order = 3,
						type = "description",
						fontSize = "large",
						name = function()
							local LappName = L.appName:cf("EAtan", "cream")
							local Lhelp = (L.HelpAndInformation):cf("EAblue", "cream")	
							return (L.FirstTimeUser):cf("cream"):format(LappName,("Getting Started"):cf("EAblue", "cream"), Lhelp, LappName, Lhelp, ("Click Map"):cf("EAblue", "cream"), LappName)
						end,
					},
					removeMsg = {
					  type = "execute",
					  name = ("Hide This Message"):cf("white"),
					  order = 40,
					  width = "full",
						func = function() self.db.global.hideHelp = true; mainOpts.args.FirstTimeUser = nil end, -- dynamic prune		
					},
				},
			},
			
			quickDirections = {
				type = "group",
				order = 10,
				name = "  ",
				inline = true,
				args = {			
					intro1 = {
						order = 1,
						type = "description",
						fontSize = "medium",
						name = (L.blizzyOpts_blurb):format(
							L.appName:cf("EAtan", "cream"),
							L.blizzyOpts_buttonName_config:cf("cyan", "cream"),
							L.blizzyOpts_buttonName_help:cf("cyan", "cream"),
							L.blizzyOpts_buttonName_clickmap:cf("cyan", "cream")
						),
					},
					-- IOFC must come before GMBC b/c GameMenu is hidden when IOF is shown, when closed, the Game Menu re-openes 
					-- if IOF opened from there; calling GMBC:Click() has no harmful effects regardless of Game Menu status.
					configure = {
					  type = "execute",
					  name = (L.blizzyOpts_buttonName_config):cf("white"),
					  order = 50,
						func = function() GameTooltip:Hide(); InterfaceOptionsFrameCancel:Click(); GameMenuButtonContinue:Click(); self:doLoadConfig(); end, 
					},							
					help = {
					  type = "execute",
					  name = (L.blizzyOpts_buttonName_help):cf("white"),
					  order = 60,
						func = function() GameTooltip:Hide(); InterfaceOptionsFrameCancel:Click(); GameMenuButtonContinue:Click(); self:doLoadHelp(); end, 
					},							
					ClickMap = {
					  type = "execute",
					  name = (L.blizzyOpts_buttonName_clickmap):cf("white"),
					  order = 70,
						func = function() GameTooltip:Hide(); InterfaceOptionsFrameCancel:Click(); GameMenuButtonContinue:Click(); self:configureClickMap(); end, 
					},
				}							
			},

			verionData = {
				order = 20,
				type = "description",
				fontSize = "medium",
				name = ((L.versionData):cf("cream")):format(GetAddOnMetadata(AddonName, 'Version'):cf("grass", "cream"), self.wowVer:cf("grass", "cream"), L.authorName:cf("EAtan")),
			},			
		},
	}
	
	mainOpts = {
		--hdr = {order=0, type="header", name="<header name>"}, 
		type = "group",
		order = 10,
		name = self:mkLink(self.icons.enabled, 22).." "..L.appName,
		args = {
			header = mkHeader(L.appName, 0, L.MainOpts_Label),
			intro = {
				order = 1,
				type = "description",
				fontSize = "medium",
				name = L.mainOpts_intro:format(
					L.appName:cf("EAtan", "cream"),
					L.libExecAssist:cf("EAblue", "cream"),
					L.Interns_intro:cf("afternoon", "cream"),
					L.appName:cf("EAtan", "cream"),
					L.Interns_intro:cf("afternoon", "cream"),
					L.Interns_intro:cf("afternoon", "cream"),
					L.cmdline_ea:cf("cyan", "cream"),
					L.cmdline_exa:cf("cyan", "cream")			
				):cf("cream"),
			},
			introspacer = { order = 2, type = "description", name = "  "}, 
			verionData = {
				order = 3,
				type = "description",
				fontSize = "medium",
				name = ((L.versionData):cf("cream")):format(GetAddOnMetadata(AddonName, 'Version'):cf("grass", "cream"), self.wowVer:cf("grass"), L.authorName:cf("EAtan")),
			},

			spacer2 = { hidden = sdbg.hideHelp, order = 4, type = "description", name = "  "},
			FirstTimeUser = {
				hidden = sdbg.hideHelp,
		    type = "group", 
				inline = true, 
		    name = "First Time User", 
		    order = 50,
				args = {
					intro = {
						order = 3,
						type = "description",
						fontSize = "large",
						name = function()
							local LappName = L.appName:cf("EAtan", "cream")
							local Lhelp = (L.HelpAndInformation):cf("EAblue", "cream")	
							return (L.FirstTimeUser):cf("cream"):format(LappName,("Getting Started"):cf("EAblue", "cream"), Lhelp, LappName, Lhelp, ("Click Map"):cf("EAblue", "cream"), LappName)
						end,
					},
					removeMsg = {
					  type = "execute",
					  name = ("Hide This Message"):cf("white"),
					  order = 40,
					  width = "full",
						func = function() self.db.global.hideHelp = true; mainOpts.args.FirstTimeUser = nil; blizzy_Opts.args.FirstTimeUser = nil end, -- dynamic prune		
					},
				},
			},			
				
			ldbAnchors = {
		    type = "group", 
		    inline = true, 
		    name = " ", 
		    order = 100,
				args = {
					hideMinimapIcon = {
						order = 20, 
						type = "toggle", 
						name = L.HideMapIcon, 
						get = function(info) return sdbc.DBIconTable.hide end,
						set = function(info, value)
							local MM = sdbc.DBIconTable
							MM.hide = value
							if MM.hide then 
								LibStub("LibDBIcon-1.0"):Hide(AddonName) 
							else 
								LibStub("LibDBIcon-1.0"):Show(AddonName) 
							end
						end,
					},				
				  ldbIcon = {
				  	name = L.ldbIcon_Name,
				  	desc = L.ldbIcon_desc,
				  	type = "select",
					  width= "double", 
				  	order = 30,
				  	values = self.optValues.ldbIcons_GET,
				  	get = function() 
				  		for i = 1, #self.optValues.ldbIcons_SET do
				  			if sdbg.Options.ldbIcon == self.optValues.ldbIcons_SET[i] then
					  			return i
				  			end
				  		end
				  	 end,
				  	set = function(i, v) sdbg.Options.ldbIcon = self.optValues.ldbIcons_SET[v]; self.meatPopcicle.icon = self.icons[self.optValues.ldbIcons_SET[v]] end,
				  },
				  ldbLabel = {
				  	name = "Label for DataBroker",
				  	desc = "Allows you to use a shortened Label for DataBroker addons as 'Executive Assistant' is fairly long",
				  	type = "input",
				  	width = "double",
				  	order = 40,
				  	get = function() return sdbg.Options.ldbLabel end,
				  	set = function(info, value)
				  		value = value:trim()
				  		if value == "" then
				  			sdbg.Options.ldbLabel = L.appName
				  		else
				  			sdbg.Options.ldbLabel = value
				  			ExecAssist.meatPopcicle.label = value
				  		end
				  	end
				  
				  }
				},
			},				
			AutomaticResetsGroup = {
		    type = "group", 
		    inline = true, 
		    name = "Automatic Resets", 
		    order = 100,
				args = {
					intro = {
						order = 3,
						type = "description",
						fontSize = "medium",
						name = (L.AutoReset_Name_1):cf("cream"):format( L.AutoReset_Name_2:cf("white", "cream"))
					},
	
					DailyResetTime = {
						type = "select",
						name = L.LocalDailyResetTime,
						desc = L.LocalDailyResetDesc,
						values = self.optValues.ResetTimesList,
						order = 20,
					  get = function(i) return sdbg.Options.DailyResetTime end,
					  set = function(i, v)
					  	sdbg.Options.DailyResetTime = v
					  	sdbg.nextDailyReset = self:happyDaily( time() )
					  	sdbg.nextWeeklyReset = self:happyWeekly( time() ) -- weekly needs to get the new reset time too
					  end,
					},
					WeeklyResetDay = {
					  type = "select",
					  name = L.WeeklyResetDay,
						desc = L.LocalDailyResetDesc,
					  values = self.optValues.DaysOfWeek,
					  order = 40,
					  style = "dropdown",
					  get = function(i) return sdbg.Options.WeeklyResetDay end,
					  set = function(i, v)
					  	sdbg.Options.WeeklyResetDay = v
					  	sdbg.nextWeeklyReset = self:happyWeekly( time() )
					  end,
					},
					
					showLoginAlerts = {
						type = "toggle",
						name = L.showLoginAlerts_name,
						desc = L.showLoginAlerts_desc,
						width = "double",
						order = 50,
						get = function() return sdbg.Options.showLoginAlerts end,
						set = function(i, v) sdbg.Options.showLoginAlerts = v end,
					}
					
				},
			},
			saveCollapseMapGroup = {
				type = "group", 
				inline = true, 
				name = "Expand / Collapse",
				order=110,
				args = {
					saveCollapseMap = {
						type = "toggle",
						name = L.saveCollapseMap_name,
						desc = L.saveCollapseMap_desc,
						order=10,
						width="full",
						get = function() return sdbg.Options.SaveCollapseMap end,
						set = function(i, v) sdbg.Options.SaveCollapseMap = v; if not v then self.db.char.map = {["char"] = nil, ["TW"] = nil, ["GTP"] = nil} end end,
					},
					
					tooltip_defaultCollapse = {
						disabled = function() return sdbg.Options.SaveCollapseMap end,
						type = "toggle",
						name = L.defaultCollapse_name,
						desc = L.defaultCollapse_desc,
						width="double",
						order = 20,
						get = function() return ttStem.defaultCollapse end,
						set = function(i, v) ttStem.defaultCollapse = v end,				
					},					

					taskWindow_defaultCollapse = {
						disabled = function() return sdbg.Options.SaveCollapseMap end,
						type = "toggle",
						name = L.twdefaultCollapse_name,
						desc = L.twdefaultCollapse_desc,
						width="double",
						order = 30,
						get = function() return twStem.defaultCollapse end,
						set = function(i, v) twStem.defaultCollapse = v end,				
					},	
					
				}
			},			
			configConfig = {
				type = "group",
				inline = true,
				name = L.configConfig_name,
				order = 120,
				args = {
					scale = {
						type = "range",
						name = L.scale_name,
						desc = L.scale_desc,
						min = .1, max = 2, step = .1,
						get = function(info) return cfgOpts.scale end,
						set = function(info, value)
							cfgOpts.scale = value
							self.aceDlg.frame:SetScale( value)
						end,
						order = 10,
						width = "double",
					},
					width = {
						type = "range",
						name = L.width_name,
						min = 100, max = 4096, step = 10,
						get = function(info) return cfgOpts.width end,
						set = function(info, value)
							cfgOpts.width = value
							self.Dialog:SetDefaultSize(self.opts.f_reg, cfgOpts.width, cfgOpts.height ) 
						end,
						order = 40,
						width = "normal",
					},
					height = {
						type = "range",
						name = L.height_name,
						min = 100, max = 2048, step = 10,
						get = function(info) return cfgOpts.height end,
						set = function(info, value)
							cfgOpts.height = value
							self.Dialog:SetDefaultSize(self.opts.f_reg, cfgOpts.width, cfgOpts.height ) 
						end,
						order = 50,
						width = "normal",
					},      	
				}
			},			
		},
	}
	
	HelpPanel = {
		type = "group",
		order = 20,
		name = self:mkLink(self.icons.used, 22).." "..L.configLabels_Help,
		args = {
			header = mkHeader(L.HelpAndInformation),
			intro = {
				order = 1,
				type = "description",
				fontSize = "medium",
				name = (L.helpPanel_intro):cf("cream"):format( (L.appName):cf("EAtan", "cream"), (L.gettingstarted):cf("EAblue", "cream")),
			},
			introspacer = {order = 2,type = "description",name = "  "},

			gettingStarted = {
				type = "group",
				name = "Getting Started",
				order=10, 
				args = {
							hdr = {order=0, type="header", name=L.GettingStarted_Title}, 
							intro = {
								order = 1, 
								type = "description",
								fontSize = "medium",
								name = (L.GettingStarted_Body):cf("cream"):format(								
									L.appName:cf("EAtan", "cream"),
									L.GettingStarted_CAPS:cf("white", "cream"),
									L.ClickMap_Name:cf("EAblue", "cream"),
									L.appName:cf("EAtan", "cream"),
									L.ClickMap_Name:cf("EAblue", "cream"),
									L.Configuration:cf("EAblue", "cream"),
									L.configLabels_TaskMaint:cf("EAblue", "cream"),
									L.configLabels_Help:cf("EAblue", "cream"),
									L.ClickMapConfigDialog:cf("EAblue", "cream"),									
									L.TACM:cf("EAblue", "cream"),									
									L.IsItReally:cf("white", "cream"),
									L.appName:cf("EAtan", "cream"),
									L.FIRSTCONSIDERATIONS:cf("white", "cream"),									
									L.appName:cf("EAtan", "cream")
								),
							},
					firstConsideration = {
						type = "group",
						name = L.FirstConsiderations_Label,
						order=0, 
						args = {
							hdr = {order=0, type="header", name=L.FirstConsiderations_Label}, 
							nowThatYouHaveStarted = {
								order = 20, 
								type = "description",
								fontSize = "medium",
								name = (L.FirstConsiderations_Body):cf("cream"):format(
									L.FileCabinet:cf("EAtan", "cream"), L.appName:cf("EAtan", "cream"), L.FileCabinet:cf("EAblue", "cream"),
									L.COLLAPSEEXPAND:cf("afternoon", "cream"),
									L.appName:cf("EAtan", "cream"),
									L.MainConfigPanel:cf("EAblue", "cream"),
									L.BUTTONPOSITIONS:cf("afternoon", "cream"),
									L.configLabels_ToolTip:cf("EAblue", "cream"),
									L.configLabels_TaskWindow:cf("EAblue", "cream"),
									L.TASKWINDOWREDUNDANT:cf("afternoon", "cream"),
									L.TOOLTIPISREDUNDANT:cf("afternoon", "cream"),

									L.TOOLTIPISDISTRACTING:cf("afternoon", "cream"),
									L.clickmap_ShowDataBrokerTT_name:cf("grass", "cream"),
									L.configLabels_TaskWindow:cf("EAblue", "cream"),

									L.FONTSANDSIZES:cf("afternoon", "cream"),
									L.StyleManager_Label:cf("EAblue", "cream"),
									L.SpecialTypeHighlights:cf("EAblue", "cream")
									
									)								
							},							
						}
					}, 
					UsefulTricks = {
						type = "group",
						name = L.usefulTricks,
						order=0, 
						args = {
							hdr = {order=0, type="header", name="Useful Tricks"}, 
							UsefulTricks = {
								order = 30, 
								type = "description",
								fontSize = "medium",
								name = (L.gettingstarted_usefultricks):cf("cream"):format( 
											L.appName:cf("EAtan", "cream"),
											L.SpecialTypes:cf("EAblue", "cream"), 
											L.SpecialTypes:cf("EAblue", "cream")
								),
							},
						}
					}, 

				}
			},
			
			MainOpts = {
				type = "group",
				name = L.MainOpts_Label,
				order=15, 
				args = {
					hdr = {order=0, type="header", name=L.MainOpts_Label}, 
					intro = {
						order = 1, 
						type = "description",
						fontSize = "medium",
						name = (L.MainOpts_Help):cf("cream"):format(
								L.HideMinimapIcon:cf("cyan", "cream"),
								L.SelectDataBroker:cf("cyan", "cream"),
								L.AutomaticResets:cf("cyan", "cream"),
								L.showLoginAlerts_name:cf("cyan", "cream"), L.showLoginAlerts_desc,
								L.ExpandCollapse:cf("cyan", "cream"),
								L.appName:cf("EAtan", "cream"),
								L.SaveGroupCollapseExpand:cf("cyan", "cream"),
								L.CollapseTooltipGroups:cf("cyan", "cream"),
								L.CollapseTaskWindowGroups:cf("cyan", "cream"),
								L.configConfig_name:cf("cyan", "cream"),
								L.scale_name:cf("afternoon", "cream"),
								L.width_name:cf("afternoon", "cream"),
								L.height_name:cf("afternoon", "cream")
						),
					},
				},
			},

			ClickMap = {
				type = "group",
				name = L.ClickMap_Name,
				order=20, 
				args = {
					hdr = {order=0, type="header", name=L.ClickMap_Name}, 
					expand = {
						order = 20, 
						type = "description",
						fontSize = "medium",
						name = (L.CLickMap_Help):cf("cream"):format(
								L.ClickMap_Name:cf("EAblue", "cream"),
								L.appName:cf("EAtan", "cream"),
								L.Configuration:cf("cyan", "cream"),
								L.ConfigureClickmap:cf("afternoon", "cream"),
								L.ClickMapConfiguration:cf("grass", "cream"),
								L.ClickMap_Name:cf("EAblue", "cream"),
								L.Display:cf("cyan", "cream"),
								L.ClickMap_Name:cf("EAblue", "cream")
						),
					},
				},
			},

			SpecialTypes = {
				type = "group",
				name = L.SpecialTypes,
				order=29, 
				args = {
							hdr = {order=0, type="header", name=L.SpecialTypes}, 
							intro = {
								order = 1, 
								type = "description",
								fontSize = "medium",
								name = L.SpecialTypes_help:cf("cream"):format(
										L.spctype_TASK:cf("white", "cream"), L.spctype_aw:cf("cyan", "cream"),
										L.spctype_TASK:cf("white", "cream"), L.spctype_pwc:cf("cyan", "cream"),
										L.spctype_TASK:cf("white", "cream"), L.spctype_reminder:cf("cyan", "cream"), L.spctype_pwc:cf("cyan", "cream"),
										L.spctype_GROUP:cf("white", "cream"), L.spctype_i:cf("cyan", "cream"),
										L.spctype_GROUP:cf("white", "cream"), L.spctype_cmt:cf("cyan", "cream"),
										L.spctype_GROUP:cf("white", "cream"), L.spctype_zg:cf("cyan", "cream")
								),
							},
					AccountWide = {
						type = "group",
						name = L.AccountWideTask_HelpLabel,
						order=10, 
						args = {
							hdr = {order=0, type="header", name = L.AccountWideTask_HelpLabel}, 
							intro = {
								order = 1, -- |cffff9966  |r  |cff6699ff |r
								type = "description",
								fontSize = "medium",
								name = L.AccountWideTask_Help:cf("cream"):format(L.PurgableTask_HelpLabel:cf("EAblue", "cream")),
							},
						}
					}, 
					Purgable = {
						type = "group",
						name = L.PurgableTask_HelpLabel,
						order=22, 
						args = {
							hdr = {order=0, type="header", name = L.PurgableTask_HelpLabel}, 
							intro = {
								order = 1, -- |cffff9966  |r  |cff6699ff |r
								type = "description",
								fontSize = "medium",
								name = L.PurgableTask_Help:cf("cream"):format(
									L.PurgableTask_HelpLabel:cf("cyan", "cream"),
									L.PurgePurgables:cf("grass", "cream"),
									L.configLabels_ClickMap:cf("sky", "cream"),
									L.configLabels_ResetOpts:cf("sky", "cream"),
									L.appName:cf("EAtan", "cream")									
								)
							},							
							cmdLineExample = {
								type = "group",
								name = L.PurgableTask_cmdilne_HelpLabel,
								order=20, 
								args = {
									hdr = {order=0, type="header", name = L.PurgableTask_cmdilne_HelpLabel}, 							
									intro = {
										order = 1, -- |cffff9966  |r  |cff6699ff |r
										type = "description",
										fontSize = "medium",
										name = function() 
											local slashEA    = L.slashEA:cf("grass", "cream")
											local paraTask   = L.paraTask:cf("cyan", "cream")
											local paraMytask = L.paraMytask:cf("lilac", "cream")
											local paraAW     = L.paraAW:cf("afternoon", "cream")
											local paraVector = L.paraVector:cf("attn", "cream")
										  
										
											return L.PurgableTask_cmdilne_Help:cf("cream"):format(
												slashEA, paraMytask,
												slashEA, paraMytask,
												slashEA, paraTask, paraAW,
												slashEA, paraTask, paraVector,
												slashEA, paraTask, paraAW,
												slashEA, paraTask, paraVector,
												slashEA, paraMytask,
												slashEA, paraTask, paraAW,
												slashEA, paraTask, paraVector,
												paraTask, paraMytask, paraMytask, paraVector, 
												paraAW
											)
										end,
									},
								},
							}
							
						}
					}, 
					Reminder = {
						type = "group",
						name = L.ReminderTask_HelpLabel,
						order=23, 
						args = {
							hdr = {order=0, type="header", name = L.ReminderTask_HelpLabel}, 
							intro = {
								order = 1, -- |cffff9966  |r  |cff6699ff |r
								type = "description",
								fontSize = "medium",
								name = L.ReminderTask_Help:cf("cream"):format(
										L.Reminder_shortName:cf("cyan", "cream"),
										L.PurgableTask:cf("grass", "cream"),
										L.reminder_NextTrigger:cf("afternoon", "cream"),
										L.PurgableTask:cf("grass", "cream"),										
										L.resetType_typeCalendar:cf("sky", "cream"),
										L.configLabels_TaskMaint:cf("sky", "cream"),
										L.ResetType_HelpHeader:cf("sky", "cream")
									),
							},
						}
					}, 

					InvisibleGroup = {
						type = "group",
						name = L.InvisibleGroup_HelpLabel,
						order=30, 
						args = {
							hdr = {order=0, type="header", name = L.InvisibleGroup_HelpLabel}, 
							intro = {
								order = 1, -- |cffff9966  |r  |cff6699ff |r
								type = "description",
								fontSize = "medium",
								name = function()
									local ig_aw = L.ig_AW:cf("afternoon", "cream")
									local ig_purg = L.ig_purg:cf("purple", "cream")
								
									return L.InvisibleGroup_Help:cf("cream"):format(
											L.InvisibleGroup_HelpLabel:cf("cyan", "cream"),
											L.G1:cf("EAtan", "cream"),
											ig_aw, ig_purg, 
											ig_aw, ig_purg, 
											ig_aw, ig_purg, 

											L.G2:cf("EAtan", "cream"),
											ig_purg, L.task_1:cf("white", "cream"), L.task_2:cf("white", "cream"),
											
											L.G3:cf("EAtan", "cream"),
											ig_purg,
											L.G4:cf("EAtan", "cream"),
											ig_purg,
											ig_aw, ig_purg,
											
											L.G1:cf("EAtan", "cream"),
											ig_aw, ig_purg, 
											ig_aw, ig_purg, 
											ig_aw, ig_purg, 
											ig_purg, L.task_1:cf("white", "cream"), L.task_2:cf("white", "cream"),
											ig_aw, ig_purg,
											L.InvisibleGroup_HelpLabel:cf("cyan", "cream")											
									)
								end,
							},
						}
					}, 
					CommandLineTarget = {
						type = "group",
						name = L.CommandLineTarget	,
						order=30, 
						args = {
							hdr = {order=0, type="header", name = L.CommandLineTarget}, 
							intro = {
								order = 1, -- |cffff9966  |r  |cff6699ff |r
								type = "description",
								fontSize = "medium",
								name = L.CommandLineTarget_Help:cf("cream"):format(
										L.TACM:cf("EAblue", "cream"),
										L.eaSetGroup:cf("grass", "cream"),
										L.CLC:cf("attn", "cream")
								),
							},
						}
					}, 
					ZoomGroup = {
						type = "group",
						name = L.ZoomGroup_Label,
						order=30, 
						args = {
							hdr = {order=0, type="header", name = L.ZoomGroup_Label}, 
							intro = {
								order = 1, -- |cffff9966  |r  |cff6699ff |r
								type = "description",
								fontSize = "medium",
								name = L.ZoomGroup_Help:cf("cream"):format( L.DisplayInterface:cf("EAblue", "cream") ),
							},
						}
					}, 								
				}
			},			

			iconHelpTACM = {
				type = "group",
				name = L.TACM,
				order=30, 
				args = {
							hdr = {order=0, type="header", name="Getting Started"}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = (L.TACM_help):cf("cream"):format(
										L.appName:cf("EAtan", "cream"),
										L.AddOnce_UseMany:cf("afternoon", "cream"),
										L.forExample_1:cf("cyan", "cream"),
										L.forExample_2:cf("cyan", "cream")
								),
							},
					
					BasicConfiguration = {
						type = "group",
						name = L.BasicConfigurationLabel,
						order=5, 
						args = {
							hdr = {order=0, type="header", name=L.BasicConfigurationLabel}, 
							intro = {
								order = 1, -- |cffff9966  |r
								type = "description",
								fontSize = "medium",
								name = L.BasicConfiguration_Help:cf("cream"):format(
										L.DisplayPOVChar:cf("cyan", "cream"),
										L.button_Reset:cf("cyan", "cream"),
										L.button_Remove:cf("cyan", "cream"),
										L.appName:cf("EAtan", "cream"),
										L.ignoreChar_name:cf("cyan", "cream"),									
										L.HideChar_ifNoIncomplete_name:cf("cyan", "cream"),						
										L.Tooltip_label:cf("afternoon", "cream"),
										L.EntryField:cf("cyan", "cream"),
										L.gpcolor:cf("cyan", "cream"),
										L.Reorganization_ControlName:cf("cyan", "cream"),
										L.Reorganization_HelpLabel:cf("EAblue", "cream"),
										L.Reorganization_HelpLabel:cf("EAblue", "cream")
								)
							},
						}
					}, 					
					
					GroupOptions = {
						type = "group",
						name = L.GroupOptionsLabel,
						order=7, 
						args = {
							hdr = {order=0, type="header", name=L.GroupOptionsLabel}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",					
								name = L.GroupOptions_Help:cf("cream"):format(
										L.MoveUp:cf("cyan", "cream"),
										L.MoveDown:cf("cyan", "cream"),
										L.DeleteGroup:cf("cyan", "cream"),
										L.AddTask:cf("cyan", "cream"),
										L.AddGroup:cf("cyan", "cream"),
										L.GroupOptions_help:cf("afternoon", "cream"),
										L.DefaultForAllChars:cf("cyan", "cream"),
										L.ForThisChar:cf("cyan", "cream"),
										L.NB:cf("white", "cream"),
										L.Invisible:cf("cyan", "cream"),
										L.CmdLineTarget:cf("cyan", "cream"),
										L.RenameGroup:cf("cyan", "cream"),
										L.HideDays_help:cf("cyan", "cream")
								)
							},
						}
					}, 
					TaskOptions = {
						type = "group",
						name = L.TaskOption_HelpLabel,
						order=10, 
						args = {
							hdr = {order=0, type="header", name = L.TaskOption_HelpLabel}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.TaskOptions_Help:cf("cream"):format(
										L.TaskOptions_TaskActions:cf("afternoon", "cream"),
										L.MoveUp:cf("cyan", "cream"),
										L.MoveDown:cf("cyan", "cream"),
										L.plusTask:cf("cyan", "cream"),
										L.DeleteTask:cf("cyan", "cream"),
										L.TaskOptions_TaskOptions:cf("afternoon", "cream"),
										L.DefaultForAllChars:cf("cyan", "cream"),
										L.ForThisChar:cf("cyan", "cream"),
										L.NB:cf("white", "cream"),
										L.taskName:cf("cyan", "cream"),
										L.ResetType_HelpLabel:cf("cyan", "cream"), L.ResetType_HelpHeader:cf("sky", "cream"),
										L.awTask_Help:cf("cyan", "cream"),
										L.HideDays_help:cf("cyan", "cream")								
								),
							},
						}
					}, 
					
					Reorganization = {
						type = "group",
						name = L.Reorganization_HelpLabel,
						order=11, 
						args = {
							hdr = {order=0, type="header", name = L.Reorganization_HelpLabel}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.Reorganization_Help:cf("cream"):format(
										L.TaskOption_HelpLabel:cf("sky", "cream"),
										L.GroupOptionsLabel:cf("sky", "cream"),										
										L.Reorganization_ControlName:cf("cyan", "cream"),
										L.BasicConfigurationLabel:cf("cyan", "cream"),
										L.Reorg_ReorgMode:cf("afternoon", "cream"),
										L.Reorg_GroupTaskConfigMode:cf("afternoon", "cream"),										
										L.Reorg_ReorgMode:cf("afternoon", "cream"), --
										L.Reorg_GA:cf("grass", "cream"),
										L.Rerog_TA:cf("grass", "cream"),
										L.reorg_ReorgTitle:cf("cyan", "cream"), --					
										L.reorg_PickUp:cf("cyan", "cream"),
										L.reorg_PutDown:cf("cyan", "cream"),
										L.reorg_PutInRoot:cf("cyan", "cream")
									)

							},
						}
					}, 
					
					ResetTypes = {
						type = "group",
						name = L.ResetType_HelpHeader,
						order=20, 
						args = {
							hdr = {order=0, type="header", name = L.ResetType_HelpHeader}, 
							intro = {
								order = 1, -- |cffff9966  |r  |cff6699ff |r
								type = "description",
								fontSize = "medium",
								name = L.ResetType_Help:cf("cream"):format(
										L.appName:cf("EAtan", "cream"),
										L.autoReset:cf("afternoon", "cream"),
										L.LocalDailyResetTime:cf("grass", "cream"),
										L.WeeklyResetDay:cf("grass", "cream")
								),
							},

							hdr2 = {order=3, type="header", name = L.ResetCategory_Automatic}, 
							intro2 = {
								order = 4, -- |cffff9966  |r  |cff6699ff |r
								type = "description",
								fontSize = "medium",
								name = L.ResetType_Help_Automatic:cf("cream"):format(
									L.resetType_typeLogin:cf("cyan", "cream"), 
									L.resetType_typeDaily:cf("cyan", "cream"), 
									L.resetType_typeWeekly:cf("cyan", "cream"), 
									L.resetType_typeCalendar:cf("cyan", "cream"), 
									L.reminder_NextTrigger:cf("grass", "cream"),									
									L.indentS, L.reminder_LastTrigger:cf("sky", "cream"),
									L.reminder_OffsetDays:cf("afternoon", "cream"),
									L.reminder_NextTrigger:cf("cream", "cream"),
									L.reminder_NextTrigger:cf("grass", "cream"),
									L.indentS, L.reminder_NextTrigger:cf("sky", "cream")
								),
							},

							hdr3 = {order=5, type="header", name = L.ResetCategory_Other}, 
							intro3 = {
								order = 6, -- |cffff9966  |r  |cff6699ff |r
								type = "description",
								fontSize = "medium",
								name = L.ResetType_Help_Other:cf("cream"):format(
									L.resetType_typePurgable:cf("cyan", "cream"), 
									L.Clickmap_Label:cf("sky", "cream"),
									L.resetType_typeReminder:cf("cyan", "cream"), 
									L.PurgableTask:cf("grass", "cream"),
									L.indentS,
									L.reminder_NextTrigger:cf("sky", "cream"),
									L.PurgableTask:cf("grass", "cream"),				
									L.resetType_typeManual:cf("cyan", "cream")
								),
							},
						}
					},
					DefaultSpecialFlags = {
						type = "group",
						name = L.StyleMgr_DefaultSpecialFlags_HelpHeader,
						order=25, 
						args = {
							hdr = {order=0, type="header", name = L.StyleMgr_DefaultSpecialFlags_HelpHeader}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.StyleMgr_DefaultSpecialFlags_Help:cf("cream"):format(
										L.configLabels_StyleMgr:cf("EAblue", "cream"),
										L.StyleMgr_cmdline:cf("defaultStyleMgr_cmdLineTarget", "cream"),
										L.StyleMgr_Invisible:cf("defaultStyleMgr_hidden", "cream"),
										L.StyleMgr_Zoom:cf("defaultStyleMgr_snowflake", "cream"),
										L.StyleMgr_AcctWide:cf("defaultStyleMgr_acctwide", "cream"),
										L.StyleMgr_Purgeable:cf("defaultStyleMgr_purgable", "cream")

								),
							},
						}
					},
					UseThisChar = {
						type = "group",
						name = L.UseThisChar_Label:format( self:mkLink(self.icons.used, 32)),
						order=30, 
						args = {
							hdr = {order=0, type="header", name=L.UseThisChar_header}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.UseThisChar_help:cf("cream"):format(self:mkLink(self.icons.used, 58), L.UseThisChar_H:cf("white", "cream")),
							},
						}
					}, 
					DoNotUseThisChar = {
						type = "group",
						name = L.DoNotUseThisChar_Label:format(self:mkLink(self.icons.notused, 32)),
						order=40, 
						args = {
							hdr = {order=0, type="header", name=L.DoNotUseThisChar_header}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.DoNotUseThisChar_help:cf("cream"):format(self:mkLink(self.icons.notused, 58), L.DoNotUseThisChar_H:cf("white", "cream")),
							},
						}
					}, 

					UseThisChar_reminder = {
						type = "group",
						name = L.UseThisChar_Label:format( self:mkLink(self.icons.used_R, 32)),
						order=44, 
						args = {
							hdr = {order=0, type="header", name=L.UseThisChar_header}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.UseThisChar_help_R:cf("cream"):format(self:mkLink(self.icons.used_R, 58), L.resetType_typeReminder:cf("grass", "cream"), L.SpecialTypes:cf("cyan", "cream"), L.UseThisChar_H:cf("white", "cream")),
							},
						}
					}, 
					DoNotUseThisChar_reminder = {
						type = "group",
						name = L.DoNotUseThisChar_Label:format(self:mkLink(self.icons.notused_R, 32)),
						order=45, 
						args = {
							hdr = {order=0, type="header", name=L.DoNotUseThisChar_header}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.DoNotUseThisChar_help_R:cf("cream"):format(self:mkLink(self.icons.notused_R, 58), L.resetType_typeReminder:cf("grass", "cream"), L.SpecialTypes:cf("cyan", "cream"), L.DoNotUseThisChar_H:cf("white", "cream")),
							},
						}
					}, 
										
					GroupDisabled = {
						type = "group",
						name = L.GroupDisabled_Label:format(self:mkLink(self.icons.disabledGroup, 32)),
						order=50, 
						args = {
							hdr = {order=0, type="header", name=L.GroupDisabled_header}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.GroupDisabled_help:cf("cream"):format(self:mkLink(self.icons.disabledGroup, 58), L.GroupDisabled_H:cf("white", "cream")),
							},
						}
					}, 
				}
			},

			StyleManager = {
				type = "group",
				name = L.StyleManager_Label,
				order=40, 
				args = {
							hdr = {order=0, type="header", name=L.StyleManager_Label}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.StyleManager_Intro:cf("cream"):format(
									L.StyleManager_Label:cf("EAblue", "cream")
								),
							},
					FontsAndColors = {
						type = "group",
						name = L.FontsAndColors,
						order=0, 
						args = {
							hdr = {order=9, type="header", name=L.Fonts_hdr}, 
							introf = {
								order = 10, 
								type = "description",
								fontSize = "medium",
								name = L.Fonts_help:cf("cream"):format(
										L.Font_1:cf("cyan", "cream"),
										L.Font_2:cf("cyan", "cream"),
										L.Font_3:cf("cyan", "cream")
								),
							},
							hdr2 = {order=19, type="header", name=L.Colors_hdr }, 
							introc = {
								order = 20, 
								type = "description",
								fontSize = "medium",
								name = L.Colors_help:cf("cream"):format(
										L.color_1:cf("cyan", "cream"),
										L.color_2:cf("cyan", "cream"),
										L.color_3:cf("cyan", "cream")
								),
							},							
						}
					}, 
					SpecialTypeControls = {
						type = "group",
						name = L.SpecialTypeControls,
						order=30, 
						args = {
							hdr = {order=0, type="header", name=L.SpecialTypeControls}, 
							intro = {
								order = 1, 
								type = "description",
								fontSize = "medium",
								name = L.SpecialTypeControls_help:cf("cream"):format(
										L.SpecialTypeControls:cf("EAblue", "cream"),

										L.STcontrols_us:cf("cyan", "cream"),
										L.STcontrols_rd:cf("cyan", "cream"),

										L.STcontrols_ut:cf("cyan", "cream"),
											L.st_us_1:cf("grass", "cream"),
											L.st_us_2:cf("grass", "cream"),
											L.st_us_3:cf("grass", "cream"),
											L.st_us_4:cf("grass", "cream"),
											L.STcontrols_ttu:cf("cyan", "cream"),

										L.STcontrols_ttu:cf("cyan", "cream"),

										L.STcontrols_uc:cf("cyan", "cream"),
											L.st_us_1:cf("grass", "cream"),
											L.st_uc_2:cf("grass", "cream"),
											L.st_uc_3:cf("grass", "cream"),
											L.st_uc_4:cf("grass", "cream"),
											L.st_uc_5:cf("grass", "cream"),

										L.STcontrols_ctbu:cf("cyan", "cream")								
								),
							},
						}
					}, 
				}
			},
			
			DisplayInterface = {
				type = "group",
				name = L.DisplayInterface,
				order=45, 
				args = {
							hdr = {order=0, type="header", name=L.di_GettingStarted_L}, 
							intro = {
								order = 1, 
								type = "description",
								fontSize = "medium",
								name = (L.DisplayInterface_Intro):cf("cream"):format(
										L.appName:cf("EAtan", "cream"),
										L.you:cf("white", "cream"),										
										L.appName:cf("EAtan", "cream"),
										L.appName:cf("EAtan", "cream"),
										L.DT:cf("afternoon", "cream"),
										L.AQ:cf("afternoon", "cream"),
										L.appName:cf("EAtan", "cream")
								),
							},					
					Similar = {
						type = "group",
						name = L.Similar,
						order=10,
						args = {
							hdr = {order=0, type="header", name=L.Similar}, 
							intro = {
								order = 1, 
								type = "description",
								fontSize = "medium",
								name = L.DisplayInterface_SimilarIntro:cf("cream"):format(
									L.di_Group:cf("white", "cream"),
									L.di_Task:cf("white", "cream"),
									self:mkLink(self.icons.ldb_showGroups, 16),
									self:mkLink(self.icons.ldb_hideGroups, 16),
									self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 16)
								)
							},					
						}								
					},
					Different = {
						type = "group",
						name = L.Different,
						order=20,
						args = {
							hdr = {order=0, type="header", name=L.Different}, 
							intro = {
								order = 1, 
								type = "description",
								fontSize = "medium",
								name = L.DisplayInterface_DifferentIntro:cf("cream"):format(
										L.GroupDisplayModes:cf("grass", "cream"),
										L.Diff_TaskWindow:cf("cyan", "cream"),
										L.Diff_Tooltip:cf("cyan", "cream"),
										L.Diff_Tooltip:cf("cyan", "cream"),										
										L.Diff_TaskWindow:cf("afternoon", "cream"), 
										self:mkLink(self.icons.tw_config, 16),										
										L.Diff_Tooltip:cf("afternoon", "cream"),
										self:mkLink(self.icons.ldb_showALLgroups, 16),							
										L.TACM_longLabel:cf("EAblue", "cream"),								
  									self:mkLink(self.icons.ldb_OneChar, 16), self:mkLink(self.icons.ldb_AllChar, 16),
  									self:mkLink(self.icons.ldb_tt_PGT, 16),  self:mkLink(self.icons.ldb_tt_GTP, 16)
								)
							},					
						}								
					},

					Completed = {
						type = "group",
						name = self:mkLink(self.icons.ldb_Complete, 22).." "..L.Complete,
						order=30, 
						args = {
							hdr = {order=0, type="header", name=L.Complete_full}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_Complete, 58)..
										L.Complete_help:cf("cream"),
							},
						}
					}, 
					NotComplete = {
						type = "group",
						name = self:mkLink(self.icons.ldb_Incomplete, 22).." "..L.NotComplete,
						order=40, 
						args = {
							hdr = {order=0, type="header", name=L.NotComplete_full}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_Incomplete, 58)..
										L.NotComplete_help:cf("cream"),
							},
						}
					}, 
					GroupDisplayModes = {
						type = "group",
						name = self:mkLink(self.icons.ldb_showGroups, 16)..""..self:mkLink(self.icons.ldb_showALLgroups, 16)..""..self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 16)..""..self:mkLink(self.icons.ldb_hideGroups, 16).." "..L.GroupDisplayModes,
						order=100, 
						args = {
							hdr = {order=0, type="header", name=L.GroupDisplayModes}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_showGroups, 58).."   "..self:mkLink(self.icons.ldb_showALLgroups, 58).."   "..self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 58).."   "..self:mkLink(self.icons.ldb_hideGroups, 58)..
												L.DisplayInterface_GroupDisplayModes:cf("cream"):format(
												L.appName:cf("EAtan", "cream"),
												L.Diff_TaskWindow:cf("grass", "cream"),
												L.Diff_Tooltip:cf("grass", "cream"),
										self:mkLink(self.icons.ldb_showGroups, 22), L.GroupDisplayModes_1:cf("white", "cream"),
												L.SpecialTypes:cf("EAblue", "cream"),
										self:mkLink(self.icons.ldb_showALLgroups, 22), L.GroupDisplayModes_2:cf("white", "cream"),
												L.GroupDisplayModes_1:cf("cyan", "cream"), L.InvisAsNorm:cf("lilac", "cream"),
												L.Ifyoudonotuse:cf("afternoon", "cream"), L.GroupDisplayModes_1:cf("cyan", "cream"),
										self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 22), L.GroupDisplayModes_3:cf("white", "cream"),
											L.GroupDisplayModes_1:cf("cyan", "cream"), L.SpecialTypes:cf("EAblue", "cream"),
										self:mkLink(self.icons.ldb_hideGroups, 22), L.GroupDisplayModes_4:cf("white", "cream")
												
								),
							},
						}
					}, 					
					layoutType = {
						type = "group",
						name = self:mkLink(self.icons.ldb_tt_PGT, 16).." "..self:mkLink(self.icons.ldb_tt_GTP, 16).." "..L.LayoutType,
						order=110, 
						args = {
							hdr = {order=0, type="header", name=L.LayoutType}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_tt_PGT, 58).." "..self:mkLink(self.icons.ldb_tt_GTP, 58)..
											L.LayoutType_help:cf("cream"):format(
													L.appName:cf("EAtan", "cream"), L.Diff_Tooltip:cf("grass", "cream"),
													self:mkLink(self.icons.ldb_tt_PGT, 22), L.TaskByChar:cf("white", "cream"),
													self:mkLink(self.icons.ldb_tt_GTP, 22), L.CharByTask:cf("white", "cream")
								),
							},
						}
					}, 
					CharDisplay = {
						type = "group",
						name = self:mkLink(self.icons.ldb_OneChar, 16).." "..self:mkLink(self.icons.ldb_AllChar, 16).." "..L.DispChars,
						order=120, 
						args = {
							hdr = {order=0, type="header", name=L.DispChars}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_OneChar, 58).."   "..self:mkLink(self.icons.ldb_AllChar, 58)..
											L.DispChars_help:cf("cream"):format(
													L.appName:cf("EAtan", "cream"), L.Diff_Tooltip:cf("grass", "cream"),
													self:mkLink(self.icons.ldb_OneChar, 22), L.CurrentChar:cf("white", "cream"),
													self:mkLink(self.icons.ldb_AllChar, 22), L.AllChars:cf("white", "cream")
								),
							},
						}
					}, 					
				}			
			},
			
			ToolTip = {
				type = "group",
				name = L.Tooltip_label,
				order=200, 
				args = {
							hdr = {order=0, type="header", name = L.di_GettingStarted_L}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.ToolTip_GettingStarted:cf("cream"):format(
									L.TooltipConfig:cf("cyan", "cream"), 
									L.Diff_Tooltip:cf("grass", "cream"),
									L.DisplayInterface:cf("EAblue", "cream")
								),
							},

					Configuration = {
						type = "group",
						name = L.TooltipConfig,
						order=10, 
						args = {
							hdr = {order=0, type="header", name = L.TooltipConfig}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.TooltipConfig_Help:cf("cream"):format(
									L.useDataBrokerTooltip:cf("grass", "cream"),																
									L.CharSpecificI:cf("EAtan", "cream"), L.CharSpecific:cf("acyan", "cream"), L.CharSpecificO:cf("EAtan", "cream"),
									L.ClickMap_Name:cf("EAblue", "cream"),
									
									L.AutoHideDelay_name:cf("cyan", "cream"),
									
									L.tooltipButtonLocation_name:cf("cyan", "cream"),
									L.enableTooltipTips_name:cf("cyan", "cream"),
									L.ClickMap_Name:cf("EAblue", "cream"),
									L.default_tooltipType_name:cf("cyan", "cream"),
									L.LayoutType:cf("grass", "cream"),
									L.Diff_TaskWindow:cf("afternoon", "cream"),
									L.CharByTask:cf("lilac", "cream"),
									L.LayoutType:cf("EAblue", "cream"),
									L.groupDisplayButton_name_TaskByChar_h:cf("cyan", "cream"),
									L.groupDisplayButton_name_CharByTask_h:cf("cyan", "cream"),
									L.Diff_TaskWindow:cf("afternoon", "cream"),
									L.GroupDisplayModes:cf("grass", "cream"),
									L.DisplayInterface:cf("EAblue", "cream"),
									L.OnlyCurrentChar:cf("cyan", "cream"),
									L.DispChars:cf("grass", "cream"),
									L.DisplayInterface:cf("EAblue", "cream"),
									L.HideCharHeader_OnlyCurrentChar_name:cf("cyan", "cream"),
									L.defaultExpandSelf_name:cf("cyan", "cream"),
									L.HideEmptyGroups_name:cf("cyan", "cream"),
									
									L.HideChar_ifNoIncomplete_name:cf("cyan", "cream"),
									L.twshowChecked_name:cf("cyan", "cream"),
									
									L.ShowServerNames_name:cf("cyan", "cream"),
									L.appName:cf("EAtan", "cream"),
									
									L.allChars_GroupCharNames_name, 
									
									L.useMouseoverHighlight_name:cf("cyan", "cream"),
									L.displayCounts:cf("cyan", "cream"),
									L.useCounts_onHeaders_name:cf("attn", "cream"),
									L.useCounts_onLDB_name:cf("attn", "cream"),
									L.twshowChecked_name:cf("cyan", "cream"),
									L.twrightMouseOnTask_togglesShowChecked_name:cf("cyan", "cream")
								),
							},
						}
					}, 

					Completed = {
						type = "group",
						name = self:mkLink(self.icons.ldb_Complete, 22).." "..L.Complete,
						order=30, 
						args = {
							hdr = {order=0, type="header", name=L.Complete_full}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_Complete, 58)..
										L.Complete_help:cf("cream"),
							},
						}
					}, 
					NotComplete = {
						type = "group",
						name = self:mkLink(self.icons.ldb_Incomplete, 22).." "..L.NotComplete,
						order=40, 
						args = {
							hdr = {order=0, type="header", name=L.NotComplete_full}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_Incomplete, 58)..
										L.NotComplete_help:cf("cream"),
							},
						}
					}, 

					GroupDisplayModes = {
						type = "group",
						name = self:mkLink(self.icons.ldb_showGroups, 16)..""..self:mkLink(self.icons.ldb_showALLgroups, 16)..""..self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 16)..""..self:mkLink(self.icons.ldb_hideGroups, 16).." "..L.GroupDisplayModes,
						order=100, 
						args = {
							hdr = {order=0, type="header", name=L.GroupDisplayModes}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_showGroups, 58).."   "..self:mkLink(self.icons.ldb_showALLgroups, 58).."   "..self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 58).."   "..self:mkLink(self.icons.ldb_hideGroups, 58)..
												L.DisplayInterface_GroupDisplayModes:cf("cream"):format(
												L.appName:cf("EAtan", "cream"),
												L.Diff_TaskWindow:cf("grass", "cream"),
												L.Diff_Tooltip:cf("grass", "cream"),
										self:mkLink(self.icons.ldb_showGroups, 22), L.GroupDisplayModes_1:cf("white", "cream"),
												L.SpecialTypes:cf("EAblue", "cream"),
										self:mkLink(self.icons.ldb_showALLgroups, 22), L.GroupDisplayModes_2:cf("white", "cream"),
												L.GroupDisplayModes_1:cf("cyan", "cream"), L.InvisAsNorm:cf("lilac", "cream"),
												L.Ifyoudonotuse:cf("afternoon", "cream"), L.GroupDisplayModes_1:cf("cyan", "cream"),
										self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 22), L.GroupDisplayModes_3:cf("white", "cream"),
											L.GroupDisplayModes_1:cf("cyan", "cream"), L.SpecialTypes:cf("EAblue", "cream"),
										self:mkLink(self.icons.ldb_hideGroups, 22), L.GroupDisplayModes_4:cf("white", "cream")
												
								),
							},
						}
					}, 					
					layoutType = {
						type = "group",
						name = self:mkLink(self.icons.ldb_tt_PGT, 16).." "..self:mkLink(self.icons.ldb_tt_GTP, 16).." "..L.LayoutType,
						order=110, 
						args = {
							hdr = {order=0, type="header", name=L.LayoutType}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_tt_PGT, 58).." "..self:mkLink(self.icons.ldb_tt_GTP, 58)..
											L.LayoutType_help:cf("cream"):format(
													L.appName:cf("EAtan", "cream"), L.Diff_Tooltip:cf("grass", "cream"),
													self:mkLink(self.icons.ldb_tt_PGT, 22), L.TaskByChar:cf("white", "cream"),
													self:mkLink(self.icons.ldb_tt_GTP, 22), L.CharByTask:cf("white", "cream")
								),
							},
						}
					}, 
					CharDisplay = {
						type = "group",
						name = self:mkLink(self.icons.ldb_OneChar, 16).." "..self:mkLink(self.icons.ldb_AllChar, 16).." "..L.DispChars,
						order=120, 
						args = {
							hdr = {order=0, type="header", name=L.DispChars}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_OneChar, 58).."   "..self:mkLink(self.icons.ldb_AllChar, 58)..
											L.DispChars_help:cf("cream"):format(
													L.appName:cf("EAtan", "cream"), L.Diff_Tooltip:cf("grass", "cream"),
													self:mkLink(self.icons.ldb_OneChar, 22), L.CurrentChar:cf("white", "cream"),
													self:mkLink(self.icons.ldb_AllChar, 22), L.AllChars:cf("white", "cream")
								),
							},
						}
					}, 					
				}
			},
			
			TaskWindow = {
				type = "group",
				name = "Task Window",
				order=300, 
				args = {
							hdr = {order=0, type="header", name=L.di_GettingStarted_L}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.TaskWindow_GettingStarted:cf("cream"):format(
									L.TaskWindowConfig:cf("cyan", "cream"), 
									L.Diff_TaskWindow:cf("grass", "cream"),
									L.DisplayInterface:cf("EAblue", "cream")
								),
							},

					Configuration = {
						type = "group",
						name = L.TaskWindowConfig,
						order=10, 
						args = {
							hdr = {order=0, type="header", name = L.TaskWindowConfig}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = function() 
									local TaskWindow = L.Diff_TaskWindow:cf("afternoon", "cream")

									return L.TaskWindowConfig_Help:cf("cream"):format(
									L.useTaskWindow :cf("grass", "cream"),
									L.CharSpecific:cf("acyan", "cream"),
									TaskWindow,
									L.ClickMap_Name:cf("EAblue", "cream"),
									
									L.rememberToggleState_name:cf("cyan", "cream"),

									L.perCharTaskPositionWindow_name:cf("cyan", "cream"),														
									
									L.CharSpecific:cf("acyan", "cream"),
									TaskWindow,
									L.twButtonLocation_name:cf("cyan", "cream"),
									TaskWindow,
									L.twenableTooltips_name:cf("cyan", "cream"),
									TaskWindow, TaskWindow,
									L.twuseMouseoverHighlight_name:cf("cyan", "cream"),
									L.twhideDuringCombat_name:cf("cyan", "cream"),
									TaskWindow,
									L.twOpacity_Normal_name:cf("cyan", "cream"),
									L.twOpacity_Mouseover_name:cf("cyan", "cream"),
									TaskWindow,
									L.winPosition:cf("cyan", "cream"),
									L.relPos_name:cf("cyan", "cream"),
									TaskWindow, TaskWindow, TaskWindow, TaskWindow,
									L.locked_name:cf("cyan", "cream"),
									TaskWindow,
									L.useDragFrame_Name:cf("cyan", "cream"),
									TaskWindow,
									L.HideEmptyGroups_name:cf("cyan", "cream"),
																		
									L.widthMethod_name:cf("cyan", "cream"), L.widthMethod_desc,
									L.twFixedWidth_name:cf("cyan", "cream"), L.twFixedWidth_desc,								
									
									L.displayCounts:cf("cyan", "cream"),
									L.twuseCounts_onHeaders_name:cf("cyan", "cream"),
									L.twshowChecked_name:cf("cyan", "cream"),
									L.twrightMouseOnTask_togglesShowChecked_name:cf("cyan", "cream"),
									
									L.hideTW_ifHideCompTaks_andNoUncompTasks_name:cf("cyan", "cream"),
									L.twuseCounts_onHeaders_name:cf("cyan", "cream"),
									
									L.StrataName:cf("cyan", "cream"),
									
									L.WindowStyle:cf("cyan", "cream"),
									TaskWindow)
								
								end,
							},
						}
					}, 
					GroupDisplayModes = {
						type = "group",
						name = self:mkLink(self.icons.ldb_showGroups, 16)..""..self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 16)..""..self:mkLink(self.icons.ldb_hideGroups, 16).." "..L.GroupDisplayModes,
						order=100, 
						args = {
							hdr = {order=0, type="header", name=L.GroupDisplayModes}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_showGroups, 58).."   "..self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 58).."   "..self:mkLink(self.icons.ldb_hideGroups, 58)..
												L.DisplayInterface_GroupDisplayModes_short:cf("cream"):format(
												L.appName:cf("EAtan", "cream"),
												L.Diff_TaskWindow:cf("grass", "cream"),
												L.Diff_Tooltip:cf("grass", "cream"),
										self:mkLink(self.icons.ldb_showGroups, 22), L.GroupDisplayModes_1:cf("white", "cream"),
												L.SpecialTypes:cf("EAblue", "cream"),
										self:mkLink(self.icons.ldb_ShowOnlySelectedGroup, 22), L.GroupDisplayModes_3:cf("white", "cream"),
											L.GroupDisplayModes_1:cf("cyan", "cream"), L.SpecialTypes:cf("EAblue", "cream"),
										self:mkLink(self.icons.ldb_hideGroups, 22), L.GroupDisplayModes_4:cf("white", "cream")
												
								),
							},
						}
					}, 
					Completed = {
						type = "group",
						name = self:mkLink(self.icons.ldb_Complete, 22).." "..L.Complete,
						order=30, 
						args = {
							hdr = {order=0, type="header", name=L.Complete_full}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_Complete, 58)..
										L.Complete_help:cf("cream"),
							},
						}
					}, 
					NotComplete = {
						type = "group",
						name = self:mkLink(self.icons.ldb_Incomplete, 22).." "..L.NotComplete,
						order=40, 
						args = {
							hdr = {order=0, type="header", name=L.NotComplete_full}, 
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = self:mkLink(self.icons.ldb_Incomplete, 58)..
										L.NotComplete_help:cf("cream"),
							},
						}
					}, 

				}
			},

			ColorCodes = {
				type = "group",
				name = L.ColorCodes_Label,
				order=305, 
				args = {
					hdr1 = {order=0, type="header", name = L.ColorCodes_header1}, 
					intro1 = {
						order = 1,
						type = "description",
						fontSize = "medium",
						name = L.ColorCodes_help1:cf("cream"):format(
							L.cc__double_forward_slash:cf("white", "cream"),
							L.cc__pipe:cf("white", "cream"),
							L.cc__slash_124:cf("white", "cream"),
							L.cc__urgent:cf("hard_red", "cream")
						),
					},

					hdr2 = {order=10, type="header", name = L.ColorCodes_header2}, 
					intro2 = {
						order = 11,
						type = "description",
						fontSize = "medium",
						name = L.ColorCodes_help2:cf("cream"):format(
							L.cc__pipe:cf("white", "cream"),
							L.cc__char_124:cf("white", "cream"),
							L.cc__slash_124:cf("white", "cream"),
							L.highlightWord_display:cf("sunshine", "cream"),
							L.cc_hexcode_slash:cf("white", "cream"),
							L.cc_hexcode_pipe:cf("white", "cream"),
							L.cc_hexcode_pipe:cf("white", "cream"),
							L.cc_hexcode_slash:cf("white", "cream")

						),
					},
					
					hdr3 = {order=20, type="header", name = L.ColorCodes_header3}, 
					intro3 = {
						order = 21,
						type = "description",
						fontSize = "medium",
						name = L.ColorCodes_help3:cf("cream"):format(
							L.cc_EscapeSequence:cf("EAblue", "cream"),
							L.cc_Colorization:cf("grass", "cream"),
							L.cc_Alpha:cf("cyan", "cream"),
							L.cc_Red:cf("sunshine", "cream"),
							L.cc_Green:cf("sunshine", "cream"),
							L.cc_Blue:cf("sunshine", "cream"),
							L.cc_Text:cf("cyan", "cream"),
							L.cc_EscapeSequence:cf("EAblue", "cream"),
							L.cc_ColorizationStop:cf("grass", "cream"),

							L.cc_EscapeSequence:cf("EAblue", "cream"),
							L.cc_Colorization:cf("grass", "cream"),
							L.cc_Alpha:cf("cyan", "cream"),
							L.cc_Red:cf("sunshine", "cream"),
							L.cc_Green:cf("sunshine", "cream"),
							L.cc_Blue:cf("sunshine", "cream"),
							L.cc_Text:cf("cyan", "cream"),
							L.cc_ColorizationStop:cf("grass", "cream"),
							L.highlightWord_Colorized:cf("colorizeExample", "cream")
						),
					},
					hdr4 = {order=30, type="header", name = L.ColorCodes_header4}, 
					intro4 = {
						order = 31,
						type = "description",
						fontSize = "medium",
						name = L.ColorCodes_help4:cf("cream"),
					},
				}
			},

			CommandLine = {
				type = "group",
				name = L.CommandLine_Label,
				order=310, 
				args = {
							hdr1 = {order=0, type="header", name = L.CommandLine_Label}, 
							intro0 = {
								order = 09, type = "description", fontSize = "medium",
								name = (L.CommandLineHelp_Introduction):cf("cream"):format(L.cmdline_ea:cf("white","cream"), L.cmdline_exa:cf("white","cream")).."\n\n"
							},

							intro10 = {
								order = 19, type = "description", fontSize = "medium",
								name = "config - "..(L.CommandLineHelp_config):cf("cream").."\n"
							},

							intro20 = {
								order = 29, type = "description", fontSize = "medium",
								name = "manage - "..(L.CommandLineHelp_manage):cf("cream").."\n"
							},

							intro30 = {
								order = 39, type = "description", fontSize = "medium",
								name = "task - "..(L.CommandLineHelp_task):cf("cream").."\n"
							},

							intro40 = {
								order = 49, type = "description", fontSize = "medium",
								name = "mytask - "..(L.CommandLineHelp_mytask):cf("cream").."\n"
							},

							intro50 = {
								order = 59, type = "description", fontSize = "medium",
								name = "setgroup - "..(L.CommandLineHelp_setgroup):cf("cream").."\n"
							},
							
							intro60 = {
								order = 69, type = "description", fontSize = "medium",
								name = "npc - "..(L.CommandLineHelp_npc):cf("cream").."\n"
							}

				}
			},
			
			ResetAutoreset = {
				type = "group",
				name = L.ResetAutoreset,
				order=400, 
				args = {
					hdr = {order=0, type="header", name=L.ResetAutoreset}, 
					intro = {
						order = 1, -- |cffff9966  |r
						type = "description",
						fontSize = "medium",
						name = L.ResetAutoreset_help:cf("cream"):format(
								L.ResetAutoreset:cf("EAblue", "cream"),
								L.resetManualOnly:cf("afternoon", "cream"), 
								L.resetDailyAutomatic:cf("afternoon", "cream"), 
								L.resetWeeklyAutomatic:cf("afternoon", "cream"), 
								L.resetAll:cf("afternoon", "cream"), 
								L.PurgePurgables:cf("afternoon", "cream"),
								L.ClickMap_Name:cf("EAblue", "cream")
						),
					},
				}                   			
			},
			
			NPC = {
				type = "group",
				name = L.NPC_help_Label,
				order=310, 
				args = {
							hdr = {order=0, type="header", name=L.NPC_help_Label}, 				
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = L.NPC_help_Body:cf("cream"):format(
									L.CommandLine_Label:cf("EAblue", "cream")
								),
							},

				}
			},
			
			FileCabinet = {
				type = "group",
				name = L.FileCabinet,
				order=10000, 
				args = {
					hdr = {order=0, type="header", name=L.FileCabinet}, 
					intro = {
						order = 1, -- |cffff9966  |r
						type = "description",
						fontSize = "medium",
						name = (L.FileCabinet_intro):cf("cream"):format(L.FileCabinet:cf("EAtan", "cream"), L.appName:cf("EAtan", "cream"), L.FileCabinet:cf("EAtan", "cream"), L.FileCabinet_NB:cf("afternoon", "cream")),
					},
				}                   			
			},			
		},
	}

	ClickMap = {
		type = "group",
		order = 30,
		name = L.configLabels_ClickMap,
		args = {
			header = mkHeader(L.Clickmap_Label .. (L.ClickMap_LabelExtended):cf("cream")),
			ldbClickMap = {
		    type = "group", 
		    inline = true, 
		    name = "", 
		    order = 10,
				args = {
					whatIsAClickMap = {
				    type = "group", 
				    inline = true, 
				    name = L.WhatIsAClickMap, 
				    order = 1,
						args = {
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = (L.whatIsAClickMap):cf("cream"):format((L.clickmap):cf("EAtan", "cream"), L.appName:cf("EAtan", "cream"), (L.ImChg):cf("white", "cream"), L.appName:cf("EAtan", "cream"), L.ClickMapConfiguration:cf("EAblue", "cream")),
							},
						},
					},
					configure = {
					  type = "execute",
					  name = (L.ConfigureClickmap):cf("white"),
					  order = 40,
					  width = "full",
						func = function() self:configureClickMap(); self.Dialog:Close(self.opts.f_reg); GameTooltip:Hide(); end, 
					},							
					handlerClickMap = {
				    type = "group", 
				    inline = true, 
				    name = "", 
				    order = 901,
						args = { -- arg list is dynamically built by ExecAssist:build_clickmapOptions()
						},
					},									
				},
			},
			gateClickMap = {
				hidden=true, -- hmm... this needs to be baked in more deeply. The error response (e.g., shift key needed for other-than-logged-in-char 
										 -- in the example) would have to be map-aware as would any tooltips... and to-gate-arrival keys would have to be precluded 
										 -- (i.e., if LM to start routine, RM=true;s=nil;a=nil;ctrl=nil cannot be a clickmap option -- WELL, in truth if you wanted
										 -- a full pass-through it /could/ but it feels more like just a really efficient way to annoy the user.
										 -- And it may not be either that popular ANYway or, worse, it is and it's just hard to understand well enough to use properly.
		    type = "group", 
		    inline = true, 
		    name = "", 
		    order = 10,
				args = {
					Intro = {
				    type = "group", 
				    inline = true, 
				    name = "How is this Click-Map different?",
				    order = 1,
						args = {
							intro = {
								order = 1,
								type = "description",
								fontSize = "medium",
								name = ("This type of %s is a way for you to configure how certain special actions are performed. For example, in the tooltip allows toggling objectives' complete state characters other than that logged in if the SHIFT key is held when left-clicked. This map pairs user-entered configurations with program gates, allowing you to use ALT rather than SHIFT or a different mouse button, etc. Select the mouse & key profile for an action and %s compares the mouse & key state to the stored profile, if they match, the gated action occurs."):cf("cream"):format(("Click-Map"):cf("EAtan", "cream"), L.appName:cf("EAtan", "cream")),
							},
						},
					},
					handlerClickMap = {
				    type = "group", 
				    inline = true, 
				    name = "", 
				    order = 901,
						args = { -- arg list is dynamically built by ExecAssist:build_clickmapOptions()
						},
					},					
				},
			},			
		}
	}
			
	TaskAndCharMaintenance = {
	  type = "group", 
		order = 40,
	 	name = L.configLabels_TaskMaint,
		args = {
			header = mkHeader(L.TACM_longLabel),
			intro = {
				order = 1,
				type = "description",
				fontSize = "medium",
				name = (L.TACM_intro):cf("cream"):format( 
					L.TACM_intro_TasksAndGroups:cf("grass", "cream"),
					L.TACM_intro_global:cf("grass", "cream"),
					L.TACM_intro_checkmarks:cf("cyan", "cream"),
					L.TACM_intro_selectedchar:cf("cyan", "cream")
				),				
			},			
			selectChar_Group = {
				type = "group",
				name = " ", 
				desc = " ",
				inline = true,
				order = 10,
				args = {		
					charSelect = {
		      	name = L.charSelect_name,
		      	desc = L.charSelect_desc,
		      	type = "select",
			      width= "double", 
		      	order = 10,
		      	values = function()  
							charList, revCharList = {}, {}
		      		local charStem = self.db.global.charStem
		      		
							if self.db.global.tooltip.AllChar_GroupCharNames then 
			      		for k, v in pairs(charStem) do
			      			table.insert(charList, k)
			      			revCharList[k] = #charList
			      		end
							else
			      		for k, v in pairs(charStem) do
			      			table.insert(charList, k)
								end
								
								function compareCharacters(a, b)
									local aServer = string.match(a, [[.* - (.*)]])
									local bServer = string.match(b, [[.* - (.*)]])
									if aServer ~= bServer then
										return aServer < bServer
									end
									return a < b
								end
								table.sort(charList, compareCharacters)
								
								for k, v in pairs(charList) do
									revCharList[v] = k
							  end
							end
							    		
							return charList		      		
		      	end,
		      	get = function() return revCharList[self.userConfigDisplay] end,
		      	set = function(i, v) self.userConfigDisplay = charList[v]; end,
		      },
					resetChar = {
		      	name = L.resetChar_name,
		        desc = L.resetChar_desc,
		        type = "execute",
		        width="half",
		        order = 13,
						func = function() sdbg.charStem[self.userConfigDisplay].agg = {}; sdbg.charStem[self.userConfigDisplay].ignoreChar = nil end,
		      },
					removeChar = {
		      	name = L.removeChar_name,
		        desc = L.removeChar_desc,
		        type = "execute",
		        width="half",
		        order = 16,
		        disabled = function() if self.userCurrent == self.userConfigDisplay then return true end end,
						func = function() sdbg.charStem[self.userConfigDisplay] = nil; self.userConfigDisplay = self.userCurrent; self:mkCharList() end,
		      },
					ignoreChar = {
		      	name = L.ignoreChar_name, -- L.ignoreChar_name = "Ignore Character"
		        desc = L.ignoreChar_desc, -- L.ignoreChar_desc = "Ignore Character will auto-force all root-Groups to be 'disabled for this character'\n\nUnchecking Ignore Character WILL NOT re-enable root-Groups, you will have to do that manually.\n\nNota Bene: you WILL be able to CREATE specific tasks for the character (e.g., /ea task +charname), they will simply be in a disabled group."
		        type = "toggle",
		        -- width="half",
		        order = 20,
		        --disabled = function() if self.userCurrent == self.userConfigDisplay then return true end end,
						get = function() return sdbg.charStem[self.userConfigDisplay].ignoreChar end,
						set = function(i, v)   
							sdbg.charStem[self.userConfigDisplay].ignoreChar = v
							if v then 
								self:processIgnoredCharacters() 
								if sdbg.useCounts_onLDB then self:ldb_refreshCounts() end  
							end
						end
		      },		
				},
			},
			addGroup_Group = {
				type = "group",
				name = "", -- Even blank, it makes a visual container...but it takes up room. Ponder, ponder...
				desc = "",
				inline = true,
				order = 90,
				args = {		
		      newGroupName = {
		      	name = L.newGroupName_name,
		      	desc = L.newGroupName_desc,
		      	type = "input",
		      	width= "double", 
		      	order = 10,
		      	get = function() return nil end, -- want it to remain blank
		      	set = function(i, v) 
							local groupID = self:AddGroup(v:gsub("//", "|"), self.db.global.groupStem.agg["garden"]) -- NB: THIS add will always be in the .garden, nil will default it to .garden
								
							local p = simpleTcopy(Genealogy)
							table.insert(p, 1, {["id"] = "TaskMaint"})
							table.insert(p, {["id"] = groupID, ["oo"] = 0})
							self:fauxAceConfig_SelectGroup_tableAware(self.opts.f_reg, p)
							self:processIgnoredCharacters()
							if sdbc.useTaskWindow then self:UpdateWindow() end		
		      	end,
		      },
					GroupColor = {
				    order = 20,
				    type = "color",
				    name = L.GroupColor_config_name,
				    desc = L.GroupColor_config_desc,
				    get = function()
				        local col = sdbg.Options.cfg_groupColor
				        return col.r, col.g, col.b
				    end,
				    set = function(info, r, g, b)
				        local col = sdbg.Options.cfg_groupColor
				        col.r = r or 0
				        col.g = g or 0
				        col.b = b or 0
				    end,
				  },		      
					Reorg = {
					  name = L.Reorganization_ControlName ,
					  desc = L.Reorganization_desc,
					  type = "toggle",
					  order = 22,
						get = function() return ExecAssist.isReorging end,
						set = function(i, v)    
							ExecAssist.isReorging = v; 
							self:loadGroups_toOptionsTable(); 
							if not v then 
								ExecAssist.reorgObjectName = nil; 
								ExecAssist.reorgObjectID = nil;
								self:loadGroups_toOptionsTable() -- Ugly but needed to clear the moving-text. Gotta be a better way.
							end 
						end,
					},	
				},
			},
		}		
	} 
			
	local StyleMgr = {
	  type = "group", 
		order = 50,
	  name = L.configLabels_StyleMgr, 
		args = {
			header = mkHeader(L.StyleManager_Name),
			Fonts = {
	   		type = "group", 
	   		inline = true, 
	   		name = "Fonts", 
	   		order = 10,
				args = {
					hFont = {
						type="group",
						name="",
						order=10,
						args={
							headerfont = {
								type = "select",
								name = L.headerfont,
								values = LSM:List("font"),
								get = function(info)					
									for i, v in next, LSM:List("font") do
										if v == ttStem.header_font then return i end
									end
								end,
								set = function(info, value)
									local list = LSM:List("font")
									ttStem.header_font = list[value]
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
								order = 20,
								width = "normal",
							},
							headerfontSize = {
								type = "range",
								name = L.fontsize,
								min = 6, max = 30, step = 1,
								get = function(info) return ttStem.header_size end,
								set = function(info, value)
									ttStem.header_size = value
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
								order = 21,
								width = "normal",
							},
						},
					},
					sFont = {
						type="group",
						name="",
						order=20,
						args={											
							standardfont = {
								type = "select",
								name = L.standardFont,
								values = LSM:List("font"),
								get = function()					
									for i, v in next, LSM:List("font") do
										if v == ttStem.standard_font then return i end
									end
								end,
								set = function(i, v)
									local list = LSM:List("font")
									ttStem.standard_font = list[v]
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
								order = 10,
								width = "normal",
							},
							standardfontSize = {
								type = "range",
								name = L.fontsize,
								min = 6, max = 30, step = 1,
								get = function(i) return ttStem.standard_size end,
								set = function(i, v)
									ttStem.standard_size = v			
									if sdbc.useTaskWindow then self:UpdateWindow() end		
								end,
								order = 11,
								width = "normal",
							},				

						},
					},
					snowflakeFont = {
						type="group",
						name="",
						order=40,
						args={
							selectedgpfont = {
								type = "select",
								name = L.selectedgpfont,
								values = LSM:List("font"),
								get = function(info)					
									for i, v in next, LSM:List("font") do
										if v == ttStem.snowflake_font then return i end
									end
								end,
								set = function(info, value)
									local list = LSM:List("font")
									ttStem.snowflake_font = list[value]
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
								order = 20,
								width = "normal",
							},
							selectedgpfontSize = {
								type = "range",
								name = L.fontsize,
								min = 6, max = 30, step = 1,
								get = function(info) return ttStem.snowflake_size end,
								set = function(info, value)
									ttStem.snowflake_size = value			
									if sdbc.useTaskWindow then self:UpdateWindow() end		
								end,
								order = 21,
								width = "normal",
							},
						},
					},
				},
			},	
			Colors = {
	   		type = "group", 
	   		inline = true, 
	   		name = L.normalColors,
	   		order = 20,
				args = {
					GroupColor = {
		        order = 10,
		        type = "color",
		        name = L.GroupColor_name,
		        desc = L.GroupColor_desc,
		        get = function()
		            local col = ttStem.color_Group
		            return col.r, col.g, col.b
		        end,
		        set = function(info, r, g, b)
		            local col = ttStem.color_Group
		            col.r = r or 0
		            col.g = g or 0
		            col.b = b or 0
		            if sdbc.useTaskWindow then self:UpdateWindow() end
		        end,
		    	},											
					TaskNameColor = {
		        order = 20,
		        type = "color",
		        name = L.TaskNameColor_name,
		        desc = L.TaskNameColor_desc,
		        get = function()
		            local col = ttStem.color_TaskName
		            return col.r, col.g, col.b
		        end,
		        set = function(info, r, g, b)
		            local col = ttStem.color_TaskName
		            col.r = r or 0
		            col.g = g or 0
		            col.b = b or 0
		            if sdbc.useTaskWindow then self:UpdateWindow() end 
		        end,
		    	},
					countColor = {
					  order = 30,
					  type = "color",
					  name = L.countColor_group_,
					  desc = L.countColor_group_,
					  get = function()
					      local col = ttStem.color_taskCounts
					      return col.r, col.g, col.b
					  end,
					  set = function(info, r, g, b)
					      local col = ttStem.color_taskCounts
					      col.r = r or 0
					      col.g = g or 0
					      col.b = b or 0
					      if sdbc.useTaskWindow then self:UpdateWindow() end
					  end,
					},
		    	
				},
			},
			EscapeCodes = {
	   		type = "group", 
	   		inline = true, 
	   		name = L.escapeCodes_Label,
	   		order = 20,
				args = {
					intro = {
						order = 1,
						type = "description",
						fontSize = "medium",
						name = L.escapeCodes_Intro:cf("cream"):format(
							L.appName:cf("EAtan", "cream"),
							L.cc__double_forward_slash:cf("white", "cream"),
							L.cc__pipe:cf("white", "cream"),
							L.cc__slash_124:cf("white", "cream")
						),
					},
					colorizationHelp = { 
					  type = "execute",
					  name = (L.ColorizingNames_Help):cf("white"),
					  order = 11, width="full",
						func = function() ExecAssist:doLoadHelp("ColorCodes"); GameTooltip:Hide(); end, 
					},			    	
				},
			},
			specialTypes = { 
	   		type = "group", 
	   		inline = true, 
	   		name = L.specialTypes_name, 
	   		order = 40,
				args = {
					intro = {
						order = 1,
						type = "description",
						fontSize = "medium",
						name = ((L.specialTypes_intro):cf("cream")):format(
																															(L.AcctWide):cf("EAtan", "cream") ,
																															(L.PurgeWhenComplete):cf("EAtan", "cream") ,
																															(L.CommandLineEntryTarget):cf("EAtan", "cream") ,
																															(L.HiddenFromDisplay):cf("EAtan", "cream") ,
																															(L.quoteSelected):cf("EAtan", "cream"),
																															(L.PleaseNote):cf("white", "cream"),
																															(L.TACM):cf("EAblue", "cream")
																														),
					},
					task_AccountWide = { -- SM.acctwide.
						type = "group", 
	   				inline = true, 
	   				name = L.task_AccountWide, 
	   				order = 10,
						args = {
							useStyle = {
								name = L.UseStyle,
								desc = "",
								type = "toggle",
								width="double",	
								order = 1,
								get = function() return SM.acctwide.useStyle end,
								set = function(i, v) 
									SM.acctwide.useStyle = v	
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
							},
							resetDefault = {
							  type = "execute",
							  name = (L.resetDefault):cf("white"),
							  order = 5,
								func = function() 
									SM.acctwide= self:rCopyTable(self.DBDefaults.global.tooltip.SM.acctwide) 
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
							},		
							textGroup = {type="group",order=10,inline=true,name="",
								args={
									useText = {
										type = "select",
										name = L.useText_name,
										desc = L.useText_desc,
										values = self.optValues.SM_useText,
										order = 5,
										get = function(i) return SM.acctwide.useText end,
										set = function(i, v) SM.acctwide.useText = v; if sdbc.useTaskWindow then self:UpdateWindow() end end,
										width = "normal",										
									},
									useText_text = {
				      			name = L.text,
				      			disabled = function() return (SM.acctwide.useText == 1) end,
				      			type = "input",
				      			width= "half", 
				      			order = 20,
				      			get = function() return SM.acctwide.useText_text end, -- want it to remain blank
				      			set = function(i, v) 
				      				SM.acctwide.useText_text = v:trim() ~= "" and v or "*"
				      				if sdbc.useTaskWindow then self:UpdateWindow() end
				      			end,
				      		},
								} 
							},
							useColor = {
								type = "select",
								name = L.useColor_name,
								desc = L.useColor_desc,
								values = self.optValues.SM_useColor,
								order = 25,
								get = function(i) return SM.acctwide.useColor end,
								set = function(i, v) SM.acctwide.useColor = v 
									if v==2 then -- force other controls active
										if SM.acctwide.useText==1 then SM.acctwide.useText=2 end
									end
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
								width = "normal",										
							},
							Color = {
		      		  order = 30,
		      		  type = "color",
		      		  name = L.color,
		      		  desc = "",
		      		  disabled = function() return SM.acctwide.SM_useColor==1 end,
		      		  get = function()
		      		      local col = SM.acctwide.color
		      		      return col.r, col.g, col.b
		      		  end,
		      		  set = function(info, r, g, b)
		      		      local col = SM.acctwide.color
		      		      col.r = r or 0
		      		      col.g = g or 0
		      		      col.b = b or 0
		      		      if sdbc.useTaskWindow then self:UpdateWindow() end
		      		  end,
		    			},	    	
						}
					},
					task_Purgable = { -- SM.purgable.
						type = "group", 
	   				inline = true, 
	   				name = L.PurgableTask, 
	   				order = 20,
						args = {
							useStyle = {
								name = L.UseStyle,
								desc = "",
								type = "toggle",
								width="double",	
								order = 1,
								get = function() return SM.purgable.useStyle end,
								set = function(i, v) 
									SM.purgable.useStyle = v	
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
							},
							resetDefault = {
							  type = "execute",
							  name = (L.resetDefault):cf("white"),
							  order = 5,
								func = function() SM.purgable= self:rCopyTable(self.DBDefaults.global.tooltip.SM.purgable); if sdbc.useTaskWindow then self:UpdateWindow() end end,
							},		
							textGroup = {type="group",order=10,inline=true,name="",
								args={
									useText = {
										type = "select",
										name = L.useText_name,
										desc = L.useText_desc,
										values = self.optValues.SM_useText,
										order = 5,
										get = function(i) return SM.purgable.useText end,
										set = function(i, v) SM.purgable.useText = v ; if sdbc.useTaskWindow then self:UpdateWindow() end end,
										width = "normal",										
									},
									useText_text = {
				      			name = L.text,
				      			type = "input",
				      			disabled = function() return (SM.purgable.useText == 1) end,
				      			width= "half", 
				      			order = 20,
				      			get = function() return SM.purgable.useText_text end, -- want it to remain blank
				      			set = function(i, v) 
				      				SM.purgable.useText_text = v:trim() ~= "" and v or "*"
				      				if sdbc.useTaskWindow then self:UpdateWindow() end
				      			end,
				      		},
								} 
							},
							useColor = {
								type = "select",
								name = L.useColor_name,
								desc = L.useColor_desc,
								values = self.optValues.SM_useColor,
								order = 25,
								get = function(i) return SM.purgable.useColor end,
								set = function(i, v) SM.purgable.useColor = v 
									if v==2 then -- force other controls active
										if SM.purgable.useText==1 then SM.purgable.useText=2 end
									end
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
								width = "normal",										
							},
							Color = {
		      		  order = 30,
		      		  type = "color",
		      		  name = L.color,
		      		  desc = "",
		      		  disabled = function() return SM.purgable.SM_useColor==1 end,
		      		  get = function()
		      		      local col = SM.purgable.color
		      		      return col.r, col.g, col.b
		      		  end,
		      		  set = function(info, r, g, b)
		      		      local col = SM.purgable.color
		      		      col.r = r or 0
		      		      col.g = g or 0
		      		      col.b = b or 0
		      		      if sdbc.useTaskWindow then self:UpdateWindow() end
		      		  end,
		    			},	    	
						}
					},

					group_Invisible = { -- SM.hidden.
						type = "group", 
	   				inline = true, 
	   				name = L.InvisibleGroup, 
	   				order = 30,
						args = {
							useStyle = {
								name = L.UseStyle,
								desc = "",
								type = "toggle",
								width="double",	
								order = 1,
								get = function() return SM.hidden.useStyle end,
								set = function(i, v) SM.hidden.useStyle = v	; if sdbc.useTaskWindow then self:UpdateWindow() end end,
							},
							resetDefault = {
							  type = "execute",
							  name = (L.resetDefault):cf("white"),
							  order = 5,
								func = function() SM.hidden= self:rCopyTable(self.DBDefaults.global.tooltip.SM.hidden); if sdbc.useTaskWindow then self:UpdateWindow() end end,
							},		
							textGroup = {type="group",order=10,inline=true,name="",
								args={
									useText = {
										type = "select",
										name = L.useText_name,
										desc = L.useText_desc,
										values = self.optValues.SM_useText,
										order = 5,
										get = function(i) return SM.hidden.useText end,
										set = function(i, v) SM.hidden.useText = v ; if sdbc.useTaskWindow then self:UpdateWindow() end end,
										width = "normal",										
									},
									useText_text = {
				      			name = L.text,
				      			disabled = function() return (SM.hidden.useText == 1) end,
				      			type = "input",
				      			width= "half", 
				      			order = 20,
				      			get = function() return SM.hidden.useText_text end, -- want it to remain blank
				      			set = function(i, v) 
				      				SM.hidden.useText_text = v:trim() ~= "" and v or "*"
				      				if sdbc.useTaskWindow then self:UpdateWindow() end
				      			end,
				      		},
								} 
							},
							useColor = {
								type = "select",
								name = L.useColor_name,
								desc = L.useColor_desc,
								values = self.optValues.SM_useColor,
								order = 25,
								get = function(i) return SM.hidden.useColor end,
								set = function(i, v) SM.hidden.useColor = v 
									if v==2 then -- force other controls active
										if SM.hidden.useText==1 then SM.hidden.useText=2 end
									end
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
								width = "normal",										
							},
							Color = {
		      		  order = 30,
		      		  type = "color",
		      		  name = L.color,
		      		  desc = "",
		      		  disabled = function() return SM.hidden.SM_useColor==1 end,
		      		  get = function()
		      		      local col = SM.hidden.color
		      		      return col.r, col.g, col.b
		      		  end,
		      		  set = function(info, r, g, b)
		      		      local col = SM.hidden.color
		      		      col.r = r or 0
		      		      col.g = g or 0
		      		      col.b = b or 0
		      		      if sdbc.useTaskWindow then self:UpdateWindow() end
		      		  end,
		    			},	    	
						}
					},
					group_cmdLineTarget= { -- SM.cmdLineTarget.
						type = "group", 
	   				inline = true, 
	   				name = L.CommandLineTarget_SM, 
	   				order = 40,
						args = {
							useStyle = {
								name = L.UseStyle,
								desc = "",
								type = "toggle",
								width="double",	
								order = 1,
								get = function() return SM.cmdLineTarget.useStyle end,
								set = function(i, v) SM.cmdLineTarget.useStyle = v	; if sdbc.useTaskWindow then self:UpdateWindow() end end,
							},
							resetDefault = {
							  type = "execute",
							  name = (L.resetDefault):cf("white"),
							  order = 5,
								func = function() SM.cmdLineTarget= self:rCopyTable(self.DBDefaults.global.tooltip.SM.cmdLineTarget) ; if sdbc.useTaskWindow then self:UpdateWindow() end end,
							},		
							textGroup = {type="group",order=10,inline=true,name="",
								args={
									useText = {
										type = "select",
										name = L.useText_name,
										desc = L.useText_desc,
										values = self.optValues.SM_useText,
										order = 5,
										get = function(i) return SM.cmdLineTarget.useText end,
										set = function(i, v) SM.cmdLineTarget.useText = v ;if sdbc.useTaskWindow then self:UpdateWindow() end end,
										width = "normal",										
									},
									useText_text = {
				      			name = L.text,
				      			disabled = function() return (SM.cmdLineTarget.useText == 1) end,
				      			type = "input",
				      			width= "half", 
				      			order = 20,
				      			get = function() return SM.cmdLineTarget.useText_text end, -- want it to remain blank
				      			set = function(i, v) 
				      				SM.cmdLineTarget.useText_text = v:trim() ~= "" and v or "*"
				      				if sdbc.useTaskWindow then self:UpdateWindow() end
				      			end,
				      		},
								} 
							},
							useColor = {
								type = "select",
								name = L.useColor_name,
								desc = L.useColor_desc,
								values = self.optValues.SM_useColor,
								order = 25,
								get = function(i) return SM.cmdLineTarget.useColor end,
								set = function(i, v) SM.cmdLineTarget.useColor = v 
									if v==2 then -- force other controls active
										if SM.cmdLineTarget.useText==1 then SM.cmdLineTarget.useText=2 end
									end
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
								width = "normal",										
							},
							Color = {
		      		  order = 30,
		      		  type = "color",
		      		  name = L.color,
		      		  desc = "",
		      		  disabled = function() return SM.cmdLineTarget.SM_useColor==1 end,
		      		  get = function()
		      		      local col = SM.cmdLineTarget.color
		      		      return col.r, col.g, col.b
		      		  end,
		      		  set = function(info, r, g, b)
		      		      local col = SM.cmdLineTarget.color
		      		      col.r = r or 0
		      		      col.g = g or 0
		      		      col.b = b or 0
		      		      if sdbc.useTaskWindow then self:UpdateWindow() end
		      		  end,
		    			},	    	
						}
					},
					group_snowflake = { -- SM.snowflake.
						type = "group", 
	   				inline = true, 
	   				name = L.ZoomGroup_SM, 
	   				order = 50,
						args = {
							useStyle = {
								name = L.UseStyle,
								desc = "",
								type = "toggle",
								width="double",	
								order = 1,
								get = function() return SM.snowflake.useStyle end,
								set = function(i, v) SM.snowflake.useStyle = v; if sdbc.useTaskWindow then self:UpdateWindow() end	end,
							},
							resetDefault = {
							  type = "execute",
							  name = (L.resetDefault):cf("white"),
							  order = 5,
								func = function() SM.snowflake= self:rCopyTable(self.DBDefaults.global.tooltip.SM.snowflake); if sdbc.useTaskWindow then self:UpdateWindow() end end,
							},		
							textGroup = {type="group",order=10,inline=true,name="",
								args={
									useText = {
										type = "select",
										name = L.useText_name,
										desc = L.useText_desc,
										values = self.optValues.SM_useText,
										order = 5,
										get = function(i) return SM.snowflake.useText end,
										set = function(i, v) SM.snowflake.useText = v; if sdbc.useTaskWindow then self:UpdateWindow() end end,
										width = "normal",										
									},
									useText_text = {
				      			name = L.text,
				      			disabled = function() return (SM.snowflake.useText == 1) end,
				      			type = "input",
				      			width= "half", 
				      			order = 20,
				      			get = function() return SM.snowflake.useText_text end, -- want it to remain blank
				      			set = function(i, v) 
				      				SM.snowflake.useText_text = v:trim() ~= "" and v or "*"
				      				if sdbc.useTaskWindow then self:UpdateWindow() end
				      			end,
				      		},
								} 
							},
							useColor = {
								type = "select",
								name = L.useColor_name,
								desc = L.useColor_desc,
								values = self.optValues.SM_useColor,
								order = 25,
								get = function(i) return SM.snowflake.useColor end,
								set = function(i, v) SM.snowflake.useColor = v 
									if v==2 then -- force other controls active
										if SM.snowflake.useText==1 then SM.snowflake.useText=2 end
									end
									if sdbc.useTaskWindow then self:UpdateWindow() end
								end,
								width = "normal",										
							},
							Color = {
		      		  order = 30,
		      		  type = "color",
		      		  name = L.color,
		      		  desc = "",
		      		  disabled = function() return SM.snowflake.SM_useColor==1 end,
		      		  get = function()
		      		      local col = SM.snowflake.color
		      		      return col.r, col.g, col.b
		      		  end,
		      		  set = function(info, r, g, b)
		      		      local col = SM.snowflake.color
		      		      col.r = r or 0
		      		      col.g = g or 0
		      		      col.b = b or 0
		      		      if sdbc.useTaskWindow then self:UpdateWindow() end
		      		  end,
		    			},	    	
						}
					},
				},
			},		
		},
	}
	
	local TooltipDisplay = {
	  type = "group", 
		order = 60,
	  name = L.configLabels_ToolTip,
		args = {
			header = mkHeader(L.TooltipOptions),
			useDataBrokerTooltip = {
				name = L.useDataBrokerTooltip,
				desc = "",
				type = "toggle",
				width="double",
				order = 1,
				get = function() return sdbc.useDataBrokerTooltip end,
				set = function(i, v) sdbc.useDataBrokerTooltip = v end,
			},			

			autoHideDelay = {
				type = "range",
				name = L.AutoHideDelay_name,
				desc = L.AutoHideDelay_desc,
				step = .01, min = .01, max = 2,
				isPercent = false,
				get = function() return ttStem.AutoHideDelay end,
				set = function(i, v) ttStem.AutoHideDelay = v end,
				order = 5,
				disabled = function() return not sdbc.useDataBrokerTooltip end,
			},
			
			intro = { 
				type="group", 
				order=10, 
			  inline=true, 
				name = L.FontsAndColors, 
				args = {
					intro = {
						order = 1,
						type = "description",
						fontSize = "medium",
						name = ((L.TooltipIntro):cf("cream")):format( (L.StyleManager_Label):cf("EAblue", "cream") ),
					},
				},
			},

			tooltipButtonLocation = {
				type = "select",
				name = L.tooltipButtonLocation_name,
				desc = L.tooltipButtonLocation_desc,
				order = 20,
				values = self.optValues.tooltipButtonPos, 
				get = function(i) return ttStem.tooltipButtonPos end,
				set = function(i, v) ttStem.tooltipButtonPos = v end,
			},
			enableTooltipTooltips = {
				name = L.enableTooltipTips_name,
				desc = L.enableTooltipTips_desc,
				type = "toggle",
				width="double",
				order = 30,
				get = function() return ttStem.enableTooltipTooltips end,
				set = function(i, v) ttStem.enableTooltipTooltips = v end,
			},				
		
			default_tooltipType = {
				type = "select",
				name = L.default_tooltipType_name,
				desc = L.default_tooltipType_desc,
				values = self.optValues.tooltipDisplay, -- internal codes != English Codes
				order = 40,
				get = function(i) return self.db.global.tooltip.default_tooltipType=="PGT" and 1 or 2 end,
				set = function(i, v)
					if v == 1 then 
						ttStem.default_tooltipType = "PGT"
					else
						ttStem.default_tooltipType = "GTP"
					end
				end,
				width = "double",
			},

			groupDisplayButton = {
				type = "group",
				name = L.GroupDisplayModes,
				inline=true,
				order=60,
				args = {
					intro = {
						order = 0,
						type = "description",
						fontSize = "medium",
						name = (L.groupDisplayButton_intro):cf("cream"):format( L.appName:cf("EAtan", "cream")),
					},
				
				-- TASK BY CHARACTER
					TaskByCharacter = {
						type = "group",
						name = L.groupDisplayButton_name_TaskByChar,
						inline=true,
						order=61,
						args = {
							default_groupDisplay = {
								type = "select",
								name = L.defaultGroupDisplay_name,
								desc = L.defaultGroupDisplay_desc,
								values = self.optValues.GroupDisplayModes,
								get = function(i) return ttStem.default_GroupDisplayMode_PGT or 1 end,
								set = function(i, v) ttStem.default_GroupDisplayMode_PGT = v end,
								order = 1,
								width = "double",
							},
		
							ShowGroupNames = {
								name = self:mkLink(self.icons.ldb_showGroups)..L.ShowGroupNames_Name,
								desc = "",
								type = "toggle",
								width="double",	
								order = 10,
								get = function() return ttStem.ShowGroupNames_PGT end,
								set = function(i, v) ttStem.ShowGroupNames_PGT = v end,
							},
							HideGroupNames = {
								name = self:mkLink(self.icons.ldb_hideGroups)..L.HideGroupNames,
								desc = "",
								type = "toggle",
								width="double",	
								order = 40,
								get = function() return ttStem.HideGroupNames_PGT end,
								set = function(i, v) ttStem.HideGroupNames_PGT = v end,
							},  
							ShowALLGroupNames = {
								name = self:mkLink(self.icons.ldb_showALLgroups)..L.ShowAllGroupNames_name,
								desc = L.ShowAllGroupNames_desc,
								type = "toggle",
								width="full",	
								order = 20,
								get = function() return ttStem.ShowAllGroups_PGT end,
								set = function(i, v) ttStem.ShowAllGroups_PGT = v	end,
							},
							ShowOnlySelectedGroup = {
								name = self:mkLink(self.icons.ldb_ShowOnlySelectedGroup)..L.ShowOnlySelectedGroup_Name,
								desc = L.ShowOnlySelectedGroup_desc,
								type = "toggle",
								width="double",	
								order = 30,
								get = function() return ttStem.ShowOnlySelectedGroup_PGT end,
								set = function(i, v) ttStem.ShowOnlySelectedGroup_PGT = v	end,
							},
						}
					},
					
				-- CHARACTER BY TASK	
					CharacterByTask = {
						type = "group",
						name = L.groupDisplayButton_name_CharByTask, -- L.groupDisplayButton_name,
						inline=true,
						order=62,
						args = {
							default_groupDisplay = {
								type = "select",
								name = L.defaultGroupDisplay_name,
								desc = L.defaultGroupDisplay_desc,
								values = self.optValues.GroupDisplayModes_GTP,
								get = function(i) return ttStem.default_GroupDisplayMode_GTP or 1 end,
								set = function(i, v) ttStem.default_GroupDisplayMode_GTP = v end,
								order = 1,
								width = "double",
							},
		
						
							HideGroupNames = {
								name = self:mkLink(self.icons.ldb_hideGroups)..L.HideGroupNames,
								desc = "",
								type = "toggle",
								width="double",	
								order = 40,
								get = function() return ttStem.HideGroupNames_GTP end,
								set = function(i, v) ttStem.HideGroupNames_GTP = v end,
							},  
							ShowALLGroupNames = {
								name = self:mkLink(self.icons.ldb_showALLgroups)..L.ShowAllGroupNames_name,
								desc = L.ShowAllGroupNames_desc,
								type = "toggle",
								width="full",	
								order = 20,
								get = function() return ttStem.ShowAllGroups_GTP end,
								set = function(i, v) ttStem.ShowAllGroups_GTP = v	end,
							},
						}
					},
				}
			},
			PGT = {
				type = "group",
				name = L.PGT_name,
				inline = true,
				order= 90,
				args =  {
					OnlyCurrentChar = {
						name = L.OnlyCurrentChar,
						desc = "",
						type = "toggle",
						width="double",	
						order = 10,
						get = function() return ttStem.OnlyCurrentChar end,
						set = function(i, v) ttStem.OnlyCurrentChar = v	end,
					},	
					HideCharHeader_OnlyCurrentChar = {
						name = L.HideCharHeader_OnlyCurrentChar_name,
						desc = "",
						type = "toggle",
						width="double",	
						order = 20,
						get = function() return ttStem.HideCharHeader_OnlyCurrentChar end,
						set = function(i, v) ttStem.HideCharHeader_OnlyCurrentChar = v	end,
					},
					defaultExpandSelf = {
						name = L.defaultExpandSelf_name,
						desc = L.defaultExpandSelf_desc,
						type = "toggle",
						width="double",	
						order = 65,
						get = function() return ttStem.defaultExpandSelf end,
						set = function(i, v) ttStem.defaultExpandSelf = v	end,
					},
					hideemptygroups = {
						name = L.HideEmptyGroups_name,
						desc = L.HideEmptyGroups_desc,
						type = "toggle",
						width="double",	
						order = 80,
						get = function() return ttStem.HideEmptyGroups end,
						set = function(i, v) ttStem.HideEmptyGroups = v	end,
					},	
					HideChar_ifNoIncomplete = {
						name = L.HideChar_ifNoIncomplete_name,
						desc = L.HideChar_ifNoIncomplete_desc,
						type = "toggle",
						width="full",	
						order = 90,
						get = function() return ttStem.HideChar_ifNoIncomplete end,
						set = function(i, v) ttStem.HideChar_ifNoIncomplete = v	end,
					},
				},
			},
		
			Options = {
	   		type = "group", 
	   		inline = true, 
	   		name = "Options", 
	   		order = 100,
				args = {				
					ShowServerNames = {
						name = L.ShowServerNames_name,
						desc = L.ShowServerNames_desc,
						type = "toggle",
						width="full",
						order = 40,
						get = function() return ttStem.ShowServerNames end,
						set = function(i, v) ttStem.ShowServerNames = v	end,
					},
					
					allChars_GroupCharNames = {
						name = L.allChars_GroupCharNames_name,
						desc = L.allChars_GroupCharNames_desc,
						type = "toggle",
						width="full",
						order = 40,
						get = function() return ttStem.AllChar_GroupCharNames end,
						set = function(i, v) ttStem.AllChar_GroupCharNames = v; ExecAssist:mkCharList()	end,					
					},
					
					
					useMouseoverHighlight = {
						name = L.useMouseoverHighlight_name,
						desc = L.useMouseoverHighlight_desc,
						type = "toggle",
						width="double",	
						order = 45,
						get = function() return ttStem.useMouseoverHighlight end,
						set = function(i, v) ttStem.useMouseoverHighlight = v	end,
					},
					counts	= {
						type = "group",
						name = "Display Task Counts...",
						desc = "", 
						inline = true,
						order= 80,
						args =  {
							onHeaders	= {
								type = "group",
								name = "",
								inline = true,
								order= 10,
								args =  {
									useCounts_onHeaders = {
										name = L.useCounts_onHeaders_name,
										desc = L.useCounts_onHeaders_desc,
										type = "toggle",
										order = 10,
										get = function() return ttStem.useCounts_onHeaders end,
										set = function(i, v) ttStem.useCounts_onHeaders = v	end,
									},				
									displayType_onHeaders = {
										type = "select",
										name = L.displayType_onHeaders_name,
										desc = L.displayType_onHeaders_desc,
										order = 20,
										values = self.optValues.counts_DispTypes,
										get = function() return ttStem.displayType_onHeaders end,
										set = function(i, v)ttStem.displayType_onHeaders = v end,
									},
									
								},
							},	
							onLDB	= {
								type = "group",
								name = "",
								desc = "", 
								inline = true,
								order= 50,
								args =  {							
									useCounts_onLDB = {
										name = L.useCounts_onLDB_name,
										desc = L.useCounts_onLDB_desc,
										type = "toggle",
										order = 50,
										get = function() return ttStem.useCounts_onLDB end,
										set = function(i, v) 
											ttStem.useCounts_onLDB = v
											if v then self:ldb_refreshCounts() 
											else self.meatPopcicle.text = "" 
											end 
										end,
									},
									displayType_onLDB = {
										type = "select",
										name = L.displayType_onLDB_name,
										desc = L.displayType_onLDB_desc,
										order = 60,
										values = self.optValues.counts_DispTypes,
										get = function() return ttStem.displayType_onLDB end,
										set = function(i, v) ttStem.displayType_onLDB = v; self:ldb_refreshCounts() end,
									},
								},
							},
						},

					},
					checkingOptions	= {
						type = "group",
						name = L.CompletedTasks,
						inline = true,
						order= 90,
						args =  {
							showChecked = {
								name = L.showChecked_name,
								desc = L.showChecked_desc,
								type = "toggle",
								width="double",	
								order = 50,
								get = function() return ttStem.showChecked end,
								set = function(i, v) ttStem.showChecked = v	end,
							},
							rightMouseOnTask_togglesShowChecked = {
								name = L.rightMouseOnTask_name,
								desc = L.rightMouseOnTask_desc,
								type = "toggle",
								width="double",	
								order = 60,
								get = function() return ttStem.rightMouse_togglesShowChecked end,
								set = function(i, v) ttStem.rightMouse_togglesShowChecked = v	end,
							},
						}
					},
					styleNPC = {
						type = "group",
						name = L.NPC_StyleNPC_name,
						desc = "",
						inline = true,
						order = 90,
						args = {
							npcColor = {
							  order = 10,
							  type = "color",
							  name = L.NPC_npcColor_name,
							  desc = L.NPC_npcColor_desc,
							  hasAlpha = true,
							  get = function()
							      local col = ttStem.npc.npcColor
							      return col.r, col.g, col.b, col.a
							  end,
							  set = function(info, r, g, b, a)
							      local col = ttStem.npc.npcColor
							      col.r = r or 0.4; col.g = g or 0.4; col.b = b or 0.4; col.a = a or 1
							  end,
							},	
													
						}
					},
					styleTooltip = {
						type = "group",
						name = L.styleTooltip_name,
						desc = "", 
						inline = true,
						order= 100,
						args =  {
							styleTooltip = {
								name = L.StyleTooltip,
								desc = L.StyleTooltip,
								type = "toggle",
								width="full",	
								order = 10,
								get = function() return ttStem.tooltipStyle.useStyle end,
								set = function(i, v) ttStem.tooltipStyle.useStyle = v	end,
							},
							background = {
								type = "select",
								name = L.Background,
								order=20,
								disabled = function() return not ttStem.tooltipStyle.useStyle end,
								width = "double",
								dialogControl = "LSM30_Background",
								values = LSM:HashTable("background"),
								get = function() return ttStem.tooltipStyle.bgFile end,
								set = function(i, v) ttStem.tooltipStyle.bgFile = v end,
							},
							backgroundColor = {
							  order = 25,
							  disabled = function() return not ttStem.tooltipStyle.useStyle end,
							  type = "color",
							  name = L.BackgroundColor,
							  hasAlpha = true,
							  get = function()
							      local col = ttStem.tooltipStyle.bgcolor
							      return col.r, col.g, col.b, col.a
							  end,
							  set = function(info, r, g, b, a)
							      local col = ttStem.tooltipStyle.bgcolor
							      col.r = r or 0; col.g = g or 0; col.b = b or 0; col.a = a or 1
							  end,
							},	
							
							border = {
								type = "select",
								name = L.Border,
								order=30,
								disabled = function() return not ttStem.tooltipStyle.useStyle end,
								width = "double",
								dialogControl = "LSM30_Border",
								values = LSM:HashTable("border"),
								get = function() return ttStem.tooltipStyle.edgeFile end,
								set = function(i, v) ttStem.tooltipStyle.edgeFile = v end,
							},
							borderColor = {
							  order = 40,
							  disabled = function() return not ttStem.tooltipStyle.useStyle end,
							  type = "color",
							  name = L.BorderColor,
							  hasAlpha = true,
							  get = function()
							      local col = ttStem.tooltipStyle.bdrcolor
							      return col.r, col.g, col.b, col.a
							  end,
							  set = function(info, r, g, b, a)
							      local col = ttStem.tooltipStyle.bdrcolor
							      col.r = r or 0; col.g = g or 0; col.b = b or 0; col.a = a or 1
							  end,
							},	
							
							-- ["edge_size"] = 6,
							edge_size = {
							  type = "range",
							  name = L.BorderEdgeSize,
							  desc = L.BorderEdgeSize,
							  step = 1, min = 1, max = 1024,
							  isPercent = false,
								get = function() return ttStem.tooltipStyle.edgeSize end,
								set = function(i, v) ttStem.tooltipStyle.edgeSize = v end,
							  order = 50,
							  disabled = function() return not ttStem.tooltipStyle.useStyle end,
							},   
							
							-- ["edge_inset"] = 1,
							edge_inset = {
							  type = "range",
							  name = L.BorderInset,
							  desc = L.BorderInset,
							  step = 1, min = 1, max = 1024,
							  isPercent = false,
								get = function() return ttStem.tooltipStyle.insets end,
								set = function(i, v) ttStem.tooltipStyle.insets = v end,
							  order = 60,
							  disabled = function() return not ttStem.tooltipStyle.useStyle end,
							},   
														
							
				    	interiorHeader = {
				    		order = 61,
				    		type = "header",
				    		name = L.TextShadow,
				    	},
							FontShadow = {
				        order = 70,
				        type = "color",
				        hasAlpha = true,
				        name = L.FontShadowColor,
				        get = function()
				            local col = ttStem.fontshadow.shadowcolor
				            return col.r, col.g, col.b, col.a
				        end,		        							        
				        set = function(info, r, g, b, a)
				            local col = ttStem.fontshadow.shadowcolor
				            col.r = r or 0
				            col.g = g or 0
				            col.b = b or 0
				            col.a = a or 1
				        end,
							
							},
							X_offset = {
								type = "range",
								name = L.FontShadowXOffset,
								order=80,
								min = -10, max = 15, step = .5, isPercent = false,
								get = function() return ttStem.fontshadow.offset.x end,
								set = function(i, v) ttStem.fontshadow.offset.x = v end,
							},
							Y_offset = {
								type = "range",
								name =  L.FontShadowYOffset,
								order=90,
								min = -15, max = 10, step = .5, isPercent = false,
								get = function() return ttStem.fontshadow.offset.y end,
								set = function(i, v) ttStem.fontshadow.offset.y = v end,
							},							
							

						},
					},
				},
			},			
		},
	}	

	local TasklistWindow = {	
	  type = "group", 
		order = 70,
	  name = L.configLabels_TaskWindow, 
		args = {
			header = mkHeader(L.TaskWindow_Label),
			useTaskWindow = {
				name = L.useTaskWindow,
				desc = "",
				type = "toggle",
				order = 1,
				get = function() return sdbc.useTaskWindow end,
				set = function(i, v) 
					sdbc.useTaskWindow = v					
					if v then -- use Task Window
						if not self.taskWindow then self:CreateTaskWindow() 
						else self:doToggleTaskWindow() 
						end 
						if twStem.toggleState_ToggledOff then twStem.toggleState_ToggledOff = false end		
						
						self:registerCombatEvents(self:getHandle_TaskWindow().hideincombat)	
					else -- do not, and hide the existing
						self:registerCombatEvents(false)
						self:doToggleTaskWindow(true)							
					end
				end,
			},
			ifUsed_isHidden = {
				name = L.ifUsed_isHidden_name,
				desc = L.ifUsed_isHidden_desc,
				type = "toggle",
				order = 2,
				disabled = function() return not sdbc.useTaskWindow end,
				get = function() return ExecAssist:getHandle_TaskWindow().toggleState_ToggledOff end,
				set = function(i, v) 
					ExecAssist:doToggleTaskWindow()
				end,
			},				

			rememberToggleState = {
				name = L.rememberToggleState_name,
				desc = L.rememberToggleState_desc,
				type = "toggle",
				disabled = function() return not sdbc.useTaskWindow end,
				width="double",	
				order = 5,
				get = function() return twStem.useRemembered_toggleState end,
				set = function(i, v) twStem.useRemembered_toggleState = v	end,
			},	

			intro = { 
				type="group", 
				order=9, 
			  inline=true, 
				name = L.FontsAndColors, 
				args = {
					intro = {
						order = 1,
						type = "description",
						fontSize = "medium",
						name = ((L.TooltipIntro):cf("cream")):format( (L.StyleManager_Label):cf("EAblue", "cream") ),
					},
				},
			},		
			Options = {
	   		type = "group", 
	   		inline = true, 
	   		name = L.Options, 
	   		order = 10,
				args = {
					perCharTaskPositionWindow = {
						name = L.perCharTaskPositionWindow_name,
						desc = L.perCharTaskPositionWindow_desc,
						type = "toggle",
						width="double",	
						order = 20,
						get = function() return sdbc.CharSpecificTaskWindow end,
						set = function(i, v) 
							sdbc.CharSpecificTaskWindow = v
							if v then										
								sdbc.taskWindow = self:rCopyTable(self.db.global.taskWindow) -- copy global TW to charspec TW
								twStem = self:getHandle_TaskWindow()
								self:UpdateWindow()
							else
								twStem = self:getHandle_TaskWindow()
								self:UpdateWindow(true)
								self:taskWindow_toggleMoving(twStem, true) -- twStem, reReadStem (no toggle)
								self.db.char.taskWindow = nil 									
							end							
						end,
					},

					ButtonLocation = {
						type = "select",
						name = L.twButtonLocation_name,
						desc = L.twButtonLocation_desc,
						order = 30,
						values = self.optValues.tooltipButtonPos, 
						get = function(i) return twStem.ButtonPos end,
						set = function(i, v) twStem.ButtonPos = v; if sdbc.useTaskWindow then self:UpdateWindow() end  end,
					},		
					enableTooltips = {
						name = L.twenableTooltips_name,
						desc = L.twenableTooltips_desc,
						type = "toggle",
						width="double",
						order = 40,
						get = function() return twStem.enableTooltipTooltips end,
						set = function(i, v) twStem.enableTooltipTooltips = v end,
					},	
									
					useMouseoverHighlight = {
						name = L.twuseMouseoverHighlight_name,
						desc = L.twuseMouseoverHighlight_desc,
						type = "toggle",
						width="double",	
						order = 60,
						get = function() return twStem.useMouseoverHighlight end,
						set = function(i, v) twStem.useMouseoverHighlight = v	; 
							if self.taskWindow then
								for k, b in pairs(self.taskWindow.ctrlButtons) do
									if v then b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
									else b:SetHighlightTexture("")
									end
								end
								local BL = self.taskWindow.buttons
								for i=1,#BL do
									if v then BL[i]:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
									else BL[i]:SetHighlightTexture("")
									end
								end
							end
						end,
					},

					hideDuringCombat = {
						name = L.twhideDuringCombat_name,
						desc = L.twhideDuringCombat_desc,
						type = "toggle",
						order = 70,
						get = function() return twStem.hideincombat end,
						set = function(i, v) 
							twStem.hideincombat = v 
							self:registerCombatEvents(v) -- registers or unregisters combat events
						end,
					},
					Opacity_Normal = {
						type = "range",
						name = L.twOpacity_Normal_name,
						desc = L.twOpacity_Normal_desc,
						order=80,
						min = 0, max = 1, step = .005, isPercent = true,
						get = function() return twStem.opacity_faded end,
						set = function(i, v) twStem.opacity_faded = v; if self.taskWindow then self.taskWindow:SetAlpha(v) end end, -- dynamically set since unlkely mouse-over during it
					},
					Opacity_mouseover = {
						type = "range",
						name = L.twOpacity_Mouseover_name,
						desc = L.twOpacity_Mouseover_desc,
						order=90,
						min = .1, max = 1, step = .005, isPercent = true,
						get = function() return twStem.opacity_mouseover end,
						set = function(i, v) twStem.opacity_mouseover = v end,
					},
										
					hideemptygroups = {
						name = L.HideEmptyGroups_name,
						desc = L.HideEmptyGroups_desc,
						type = "toggle",
						width="double",	
						order = 200,
						get = function() return twStem.HideEmptyGroups end,
						set = function(i, v) twStem.HideEmptyGroups = v; if sdbc.useTaskWindow then self:UpdateWindow() end	end,
					},	

					hidebuttons = {
						name = L.HideTaskWindowControlButtons_name,
						desc = L.HideTaskWindowControlButtons_desc,
						type = "toggle",
						width="double",	
						order = 230,
						get = function() return twStem.hidebuttons end,
						set = function(i, v) self:doToggleShowTWControlButtons() end,
					},

					winPosition = {
						name = L.winPosition,
						type = "group",
						order = 250,
						args = {
							relPos = {
								name = L.relPos_name,
								desc = L.relPos_desc,
								type = "select",
								width="double",
								order=10,
								values = self.optValues.relativePoints,
								get = function() return twStem.pos.idx end,
								set = function(i, v)
									twStem.pos.idx = v
									twStem.pos.relTW = self.optValues.relativePoints[v]									
									self:setTaskWindowPos(twStem.pos.relTW) 
								end
							},
							locked = {
								name = L.locked_name,
								desc = L.locked_desc,
								type = "toggle",
								order=20,
								width="half",
								get = function() return twStem.locked end,
								set = function(i, v)
									self:taskWindow_toggleMoving(twStem)
								end,
							},
							useDragFrame = {
								name = L.useDragFrame_Name,
								desc = L.useDragFrame_Desc,
								type = "toggle",
								order=30,
								width="half",
								get = function() return twStem.useDragFrame end,
								set = function(i, v)
									twStem.useDragFrame = v
									self:dragFrame_Peek_A_Boo(twStem)
								end,
							},
						},						
					},
							
				},
			},			
		
			checkingOptions	= {
				type = "group",
				name = L.CompletedTasks,
				desc = "", 
				inline = true,
				order= 40,
				args =  {
					showChecked = {
						name = L.twshowChecked_name,
						desc = L.twshowChecked_desc,
						type = "toggle",
						width="double",	
						order = 50,
						get = function() return twStem.showChecked end,
						set = function(i, v) 
							twStem.showChecked = v; 
							if sdbc.useTaskWindow then 
								if not v and twStem.hideTW_ifHideCompTaks_andNoUncompTasks then 
									self:ldb_refreshCounts() -- gets counts then decides what to do with the base TW via :queryToggleTW_zeroUncomp_whileHideCompTasks()
								end
								self:UpdateWindow() 
							end  
						end,
					},
					rightMouseOnTask_togglesShowChecked = {
						name = L.twrightMouseOnTask_togglesShowChecked_name,
						desc = L.twrightMouseOnTask_togglesShowChecked_desc,
						type = "toggle",
						width="double",	
						order = 60,
						get = function() return twStem.rightMouse_togglesShowChecked end,
						set = function(i, v) twStem.rightMouse_togglesShowChecked = v	end,
					},
					hideTW_ifHideCompTaks_andNoUncompTasks = {
						name = L.hideTW_ifHideCompTaks_andNoUncompTasks_name,
						desc = L.hideTW_ifHideCompTaks_andNoUncompTasks_desc,
						type = "toggle",
						width="full",	
						order = 65,
						get = function() return twStem.hideTW_ifHideCompTaks_andNoUncompTasks end,
						set = function(i, v) 
							twStem.hideTW_ifHideCompTaks_andNoUncompTasks = v
							if v then
								self:ldb_refreshCounts() -- gets counts then decides what to do with the base TW via :queryToggleTW_zeroUncomp_whileHideCompTasks()
							else
								if sdbc.useTaskWindow and not self.taskWindow:IsShown() then
									self:doToggleTaskWindow()
								end
							end
						end,
					},				
					
				}
			},

			counts	= {
				type = "group",
				name = L.displayCounts,
				desc = "", 
				inline = true,
				order= 80,
				args =  {
					onHeaders	= {
						type = "group",
						name = "",
						desc = "", 
						inline = true,
						order= 10,
						args =  {
							useCounts_onHeaders = {
								name = L.twuseCounts_onHeaders_name,
								desc = L.twuseCounts_onHeaders_desc,
								type = "toggle",
								order = 10,
								get = function() return twStem.useCounts_onHeaders end,
								set = function(i, v) twStem.useCounts_onHeaders = v; if sdbc.useTaskWindow then self:UpdateWindow() end end,
							},				
							displayType_onHeaders = {
								type = "select",
								name = L.twdisplayType_onHeaders_name,
								desc = L.twdisplayType_onHeaders_desc,
								order = 20,
								values = self.optValues.counts_DispTypes,
								get = function() return twStem.displayType_onHeaders end,
								set = function(i, v)twStem.displayType_onHeaders = v; if sdbc.useTaskWindow then self:UpdateWindow() end end,
							},
							
						},
					},	
				},
			},

			TaskWindowWidth	= {
				type = "group",
				name = "Task Window Width",
				desc = "", 
				inline = true,
				order= 90,
				args =  {
					widthMethod = {
						name = L.widthMethod_name,
						desc = L.widthMethod_desc,
						type = "select",
						order = 230,
						values = L.widthMethod_values,
						get = function() return twStem.widthMethod end, 
						set = function(i, v) twStem.widthMethod = v	; 
							self:UpdateWindow()
						end,
					},										
					MaxWidth = {
						type = "range",
						name = L.twFixedWidth_name,
						desc = L.twFixedWidth_desc,
						disabled = function() 
							if twStem.widthMethod == 1 then return true 
							else return false 
							end 
						end,
						order=235,
						min = 120, max = 800, step = 1, isPercent = false,
						get = function() return twStem.FixedWidth_FontString end,
						set = function(i, v) twStem.FixedWidth_FontString = v; self:UpdateWindow()
						end,
					},
				},

			},


			Strata = {
	   		type = "group", 
	   		inline = true, 
	   		name = L.StrataName, 
	   		order = 930,
				args = {
					widthMethod = {
						name = L.strata_name,
						desc = L.strata_desc,
						type = "select",
						order = 230,
						values = frameStrataOptions,
						get = function() for i = 1, #frameStrataOptions do if twStem.strata == frameStrataOptions[i] then return i end end return 2 end, 
						set = function(i, v) 
							twStem.strata = frameStrataOptions[v] 
							self:UpdateWindow()
						end,
					},				
				},
			},


			WindowStyle = {
	   		type = "group", 
	   		inline = true, 
	   		name = L.WindowStyle, 
	   		order = 930,
				args = {
					background = {
						type = "select",
						name = L.background,
						order=10,
						dialogControl = "LSM30_Background",
						values = LSM:HashTable("background"),
						get = function() return twStem.style.background end,
						set = function(i, v) 
							twStem.style.background = v
							if sdbc.useTaskWindow then self:StyleTaskWindow() end
						end,
					},
					BackdropColor = {
		        order = 20,
		        type = "color",
		        name = L.BackdropColor,
		        hasAlpha = true,
		        width="double",
		        get = function()
		            local col = twStem.style.bgcolor
		            return col.r, col.g, col.b, col.a
		        end,
		        set = function(info, r, g, b, a)
		            local col = twStem.style.bgcolor
		            col.r = r or 0
		            col.g = g or 0
		            col.b = b or 0
		            col.a = a or 1
								if sdbc.useTaskWindow then self:StyleTaskWindow() end
		        end,
		    	},	
				
					Border = {
						type = "select",
						name = L.Border,
						order=30,
						dialogControl = "LSM30_Border",
						values = LSM:HashTable("border"),
						get = function() return twStem.style.border end,
						set = function(i, v) 
							twStem.style.border = v
							if sdbc.useTaskWindow then self:StyleTaskWindow() end
						end,
					},
					BorderColor = {
		        order = 40,
		        type = "color",
		        name = L.BorderColor,
		        hasAlpha = true,
		        get = function()
		            local col = twStem.style.bdrcolor
		            return col.r, col.g, col.b, col.a
		        end,
		        set = function(info, r, g, b, a)
		            local col = twStem.style.bdrcolor
		            col.r = r or 0
		            col.g = g or 0
		            col.b = b or 0
		            col.a = a or 1
								if sdbc.useTaskWindow then self:StyleTaskWindow() end
		        end,
		    	},
		    	
		    	interiorHeader = {
		    		order = 60,
		    		type = "header",
		    		name = L.TextShadow,
		    	},
					FontShadow = {
		        order = 70,
		        type = "color",
		        hasAlpha = true,
		        name = L.FontShadowColor,
		        get = function()
		            local col = twStem.fontshadow.shadowcolor
		            return col.r, col.g, col.b, col.a
		        end,		        							        
		        set = function(info, r, g, b, a)
		            local col = twStem.fontshadow.shadowcolor
		            col.r = r or 0
		            col.g = g or 0
		            col.b = b or 0
		            col.a = a or 1
								if sdbc.useTaskWindow then self:setFontStringShadow() end
		        end,
					
					},
					X_offset = {
						type = "range",
						name = L.FontShadowXOffset,
						order=80,
						min = -10, max = 15, step = .5, isPercent = false,
						get = function() return twStem.fontshadow.offset.x end,
						set = function(i, v) 
							twStem.fontshadow.offset.x = v
							if sdbc.useTaskWindow then self:setFontStringShadow() end
						end,
					},
					Y_offset = {
						type = "range",
						name = L.FontShadowYOffset,
						order=90,
						min = -15, max = 10, step = .5, isPercent = false,
						get = function() return twStem.fontshadow.offset.y end,
						set = function(i, v) 
							twStem.fontshadow.offset.y = v 
							if sdbc.useTaskWindow then self:setFontStringShadow() end
						end,
					},
					
				},
			},			
		},
	}

	
	local ResetOpts = { 
		type = "group",
		order = 90,
		name = L.configLabels_ResetOpts,
		args = {
			header = mkHeader(L.ResetOpts_Label),
			ManualResetsGroup = {
		    type = "group", 
				inline = true, 
		    name = "Manual Resets", 
		    order = 50,
				args = {
					intro = {
						order = 3,
						type = "description",
						fontSize = "medium",
						name = (L.ResetIntro):cf("cream"),
					},

					ResetManualTasks = {
					  type = "execute",
					  name = (L.resetManualOnly):cf("white"),
					  order = 20,
					  width = "double",
						func = function() self:resetTasks(nil, nil, true) end,
		
					},	
					ResetDailyTasks = {
					  type = "execute",
					  name = (L.resetDailyAutomatic):cf("white"),
					  order = 30,
					  width = "double",
						func = function() self:resetTasks(true, nil, nil) end,
		
					},
					ResetWeeklyTasks = {
					  type = "execute",
					  name = (L.resetWeeklyAutomatic):cf("white"),
					  order = 40,
					  width = "double",
						func = function() self:resetTasks(nil, true, nil) end,
		
					},
					
					ResetALLTasks = {
					  type = "execute",
					  name = (L.resetAll):cf("white"),
					  desc = L.resetAll_desc,
					  order = 50,
					  width = "double",
						func = function() self:resetTasks(true, true, true, true, true, true, true) end,
		
					},					

					PurgePurgables = {
					  type = "execute",
					  name = (L.PurgePurgables):cf("white"),
					  order = 60,
					  width = "double",
						func = function() self:resetTasks(nil, nil, nil, true) end,
		
					},					
		
				},
			},			
		},
	}

	amalgam = { -- glue 'em together
		type = "group", 
		childGroups = "tab",
	  name = L.appName, 
		args = {
			mainOpts   = mainOpts,
			HelpPanel  = HelpPanel,
			ClickMap   = ClickMap,
			TaskMaint  = TaskAndCharMaintenance,
			StyleMgr   = StyleMgr,
			ToolTip    = TooltipDisplay,
			TaskWindow = TasklistWindow,
			CmdLine    = CmdLine,
			ResetOpts  = ResetOpts,
		}			
	}

	-- Register Options Tables
	self.opts = {		
		f_reg        = "ExecAssistConfig",
		f_MainOpts   = "mainOpts",
		f_Help 		   = "HelpPanel",
		f_ClickMap   = "ClickMap",
		f_TaskMaint  = "TaskMaint",
		f_StyleMgr   = "StyleMgr",
		f_ToolTip    = "ToolTip",
		f_TaskWindow = "TaskWindow",
		f_CmdLine    = "CmdLine",
		f_ResetOpts  = "ResetOpts",
 	}
 	local opts = self.opts
	local RegOpts = LibStub("AceConfigRegistry-3.0")
	RegOpts:RegisterOptionsTable(AddonName, blizzy_Opts)	--------- Blizzy Opts -
	self.Dialog:AddToBlizOptions(AddonName, L.appName)    -----------------------
	

	local cfgOpts = sdbg.Options.configConfig
	RegOpts:RegisterOptionsTable( opts.f_reg, amalgam )  -- ExecAssist Opts -----
	self.Dialog:SetDefaultSize(   opts.f_reg, cfgOpts.width, cfgOpts.height ) ---



	
end 

	-- Click-Map Funcs
local function decode(SvcOpts)
	local rc = ""		
	if SvcOpts.m then 
		if SvcOpts.m == "LeftButton" then rc=(L.LEFTMOUSE):cf("white") else rc=(L.RIGHTMOUSE):cf("white") end
		if SvcOpts.s then rc=rc..(" +"..L.SHIFT):cf("grass") end
		if SvcOpts.a then rc=rc..(" +"..L.ALT  ):cf("lilac") end
		if SvcOpts.c then rc=rc..(" +"..L.CTRL ):cf("cyan") end 
	end
	return rc
end		
	
function ExecAssist:build_clickmapOptions()
	local cmStem, cmOrder = self.db.global.clickmap, clickmapOrder -- self.db.global.clickmapOrder
	local cmOpt = ClickMap.args.ldbClickMap.args.handlerClickMap
	if cmOpt.args then cmOpt.args = {} end
	local i=0
	local svcInfo, SvcOpts

	for j = 1,#cmOrder do
		i=i+5
		svcInfo = self:get_clickmapService(cmOrder[j])  -- cmSvcTag
		SvcOpts = cmStem[cmOrder[j]]

		local rcKeys = decode(SvcOpts)
		if rcKeys == "" then rcKeys = ("<%s>"):cf("cream"):format(L.notset) end 

		cmOpt.args["name"..tostring(i)] = {
			type = "description",
			name = ("%s"):cf("cyan"):format(svcInfo.name),
			order = 1+i,
			fontSize = "medium",
			width="full",
		}
		cmOpt.args["Keys"..tostring(i)] = {
			type = "description",
			name = rcKeys,
			width= "double", 
			fontSize = "medium",
			order = 2+i,
		}
		cmOpt.args["notify"..tostring(i)] = {
			type = "description",
			name = ("(%s)"):cf("EAtan"):format( (SvcOpts.notify and L.notify or L.silent):cf("cream", "EAtan")),
			order = 3+i,
			fontSize = "medium",
			width = "normal",
		}
		cmOpt.args["spc"..tostring(i)] = {
			type = "description",
			name = " ",
			order = 4+i,
			fontSize = "medium",
			width="full",
		}		
	end	
end
function ExecAssist:configureClickMap()
	local tooltipStem = self.db.global.tooltip
	local twStem = self:getHandle_TaskWindow()

	-- tooltips ---------------------------------
	helpMsg = {
		["B"] = L.clickmap_tooltip_keys,
		["C"] = L.clickmap_tooltip_clear,
		["D"] = L.clickmap_tooltip_notify,
		["E"] = L.clickmap_tooltip_notify,
	}
	local function button_OnLeave()
		self.configClickMap.tooltip:Release("ExecAssist_ClickMapTooltip")
		self.configClickMap.tooltip=nil
	end	
	local function button_OnEnter(key, msg)
		local tooltipStem = self.db.global.tooltip
		if not self.configClickMap.tooltip then 
			self.configClickMap.tooltip = LibQTip:Acquire("ExecAssist_ClickMapTooltip")
		end
		tooltip = self.configClickMap.tooltip	
		tooltip:Clear()
		tooltip:SetCellMarginH(0); tooltip:SetCellMarginV(0)		
		local tf = CreateFont("tiptipFont"); tf:SetFont(LSM:Fetch("font", tooltipStem.header_font), tooltipStem.header_size, ""); tooltip:SetFont(tf)
	
		tooltip:SetScale(1)
		tooltip:SetBackdropColor(0, 0, 0, 1) 
		tooltip:SetAutoHideDelay(.25, self.configClickMap	)	
		tooltip:SmartAnchorTo(self.configClickMap)
	
		tooltip:SetColumnLayout(1)
		tooltip:AddLine()
	
		tooltip:SetCell(1, 1, true and msg or helpMsg[key])
	 	tooltip:UpdateScrolling()	
		tooltip:Show()
				
	end	-----------------------------------------
		
	if not self.configClickMap then
	
		self.configClickMap = CreateFrame("Frame", "ExecAssist_configClickMap", UIParent, "BackdropTemplate")
		self.configClickMap.bMap = {}		
		local cm = self.configClickMap		
		
		cm:SetHeight(200); cm:SetWidth(670) -- reduce shuffle when changing orientations
		cm:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		cm:SetMovable(true)
		cm:SetScript("OnMouseDown", function(_, button) cm:StartMoving() end)
		cm:SetScript("OnMouseUp",   function(_, button) cm:StopMovingOrSizing(); end) 
		cm:SetFrameStrata("DIALOG")
	
	  local bgFrame = {bgFile = AceGUIWidgetLSMlists.background["Solid"]}	  
	  
		cm:SetBackdrop(bgFrame); cm:SetBackdropColor(0, 0, 0, 1)

		-- fonts for fontstrings
		local hf, kf, sf = CreateFont("headerFont_map"), CreateFont("keyFont_map") , CreateFont("standardFont_map")  	
		hf:SetJustifyH("CENTER"); hf:SetJustifyV("MIDDLE")
			
		hf:SetFont(LSM:Fetch("font", "Friz Quadrata TT"), 14, "")
		kf:SetFont(LSM:Fetch("font", "Friz Quadrata TT"), 11, "")
		sf:SetFont(LSM:Fetch("font", "Friz Quadrata TT"), 10, "")
		
		cm.tA = CreateFrame("Button", nil, cm, "BackdropTemplate")
		cm.tB = CreateFrame("Button", nil, cm, "BackdropTemplate")
		cm.tZ = CreateFrame("Button", nil, cm, "BackdropTemplate")
		local bgFrame2 = {bgFile = AceGUIWidgetLSMlists.background["Blizzard Tooltip"]}
		cm.tZ:SetBackdrop(bgFrame2); cm.tZ:SetBackdropColor(7, 0, 0, .5)
		
		cm.tA:SetPoint("TOPLEFT",  cm, "TOPLEFT",   5, -5)
		cm.tB:SetPoint("TOPRIGHT", cm, "TOPRIGHT", -5, -5)
		cm.tZ:SetPoint("BOTTOM",   cm, "BOTTOM",    0,  5)
	
		cm.tA:SetWidth(330)	cm.tA:SetHeight(20)
		cm.tB:SetWidth(330)	cm.tB:SetHeight(20)
		cm.tZ:SetWidth(cm:GetWidth())	cm.tZ:SetHeight(20)
	
		cm.tA.f = cm:CreateFontString(nil, Overlay)
		cm.tB.f = cm:CreateFontString(nil, Overlay)
		cm.tZ.f = cm:CreateFontString(nil, Overlay)
	
	  cm.tA.f:SetFontObject(hf)
		cm.tB.f:SetFontObject(hf)
		cm.tZ.f:SetFontObject(hf)
	
		cm.tA.f:SetText(L.clickmap_config)
		cm.tB.f:SetText(L.appName)
		cm.tZ.f:SetText(L.clickmap_config_close)
	
		cm.tA.f:SetAllPoints(cm.tA)
		cm.tB.f:SetAllPoints(cm.tB)
		cm.tZ.f:SetAllPoints(cm.tZ)
		
		local EAtan = self:Marker("EAtan")	
		local cream = self:Marker("cream")
		cm.tA.f:SetTextColor(cream.r, cream.g, cream.b)
		cm.tB.f:SetTextColor(EAtan.r, EAtan.g, EAtan.b)
		cm.tZ.f:SetTextColor(EAtan.r, EAtan.g, EAtan.b)

		cm.tA:SetScript("OnMouseDown", function(_, button) cm:StartMoving() end)
		cm.tA:SetScript("OnMouseUp",   function(_, button) cm:StopMovingOrSizing(); end) 
		cm.tB:SetScript("OnMouseDown", function(_, button) cm:StartMoving() end)
		cm.tB:SetScript("OnMouseUp",   function(_, button) cm:StopMovingOrSizing(); end) 

		
		cm.tZ:SetScript("OnClick", function(theButton, side)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
			self:build_clickmapOptions()
			cm:Hide()
	  end)	  
		-- -------------------------------------------------- -- 	
		local function mkEntry(cmSvcTag, SvcOpts)
			local M = self.configClickMap.bMap
			local svcInfo = self:get_clickmapService(cmSvcTag)	
			M[cmSvcTag] = {
				["A"] = CreateFrame("Button", nil, cm, "BackdropTemplate"),
				["B"] = CreateFrame("Button", nil, cm, "BackdropTemplate"),
				["C"] = CreateFrame("Button", nil, cm, "BackdropTemplate"),
				["D"] = CreateFrame("Button", nil, cm, "BackdropTemplate"),
				["E"] = CreateFrame("Button", nil, cm, "BackdropTemplate"),
			}
			local A, B, C, D, E = M[cmSvcTag].A, M[cmSvcTag].B, M[cmSvcTag].C, M[cmSvcTag].D, M[cmSvcTag].E

			A.f, B.f, C.f, D.f = A:CreateFontString(nil, Overlay), B:CreateFontString(nil, Overlay), C:CreateFontString(nil, Overlay), D:CreateFontString(nil, Overlay)
		  A.f:SetFontObject(sf); B.f:SetFontObject(kf); C.f:SetFontObject(sf); D.f:SetFontObject(sf)
		  A.f:SetPoint("LEFT", A, "LEFT", 2, 0); B.f:SetPoint("CENTER", B, "CENTER", 2, 0); C.f:SetPoint("CENTER", C, "CENTER", 2, 0); D.f:SetPoint("CENTER", D, "CENTER", 2, 0)

		  local bgFrame = {
		  	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			 	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			 	tile = true, tileSize = 16, edgeSize = 16,
			 	insets = { left = 3, right = 3, top = 3, bottom = 3 }
			}	
			B:SetBackdrop(bgFrame); B:SetBackdropColor(.2, .2, .2, .5); B:SetBackdropBorderColor(cream.r, cream.g, cream.b, 1)
			C:SetBackdrop(bgFrame); C:SetBackdropColor(.8, 0, 0, .5); C:SetBackdropBorderColor(cream.r, cream.g, cream.b, 1)
			D:SetBackdrop(bgFrame); D:SetBackdropColor(EAtan.r-.4, EAtan.g-.4, EAtan.b-.4, .5); D:SetBackdropBorderColor(cream.r, cream.g, cream.b, 1)

			A:SetHeight(20); A:SetWidth(340); A.cmSvcTag = cmSvcTag; A.msg = svcInfo.desc;
			B:SetHeight(20); B:SetWidth(190); B.cmSvcTag = cmSvcTag;
			C:SetHeight(20); C:SetWidth(50);  C.cmSvcTag = cmSvcTag;
			D:SetHeight(20); D:SetWidth(60);  D.cmSvcTag = cmSvcTag;
			E:SetHeight(20); E:SetWidth(20);  E.cmSvcTag = cmSvcTag;
		
			B:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			C:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			D:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			E:RegisterForClicks("LeftButtonUp", "RightButtonUp")

		  A.f:SetText(("%s"):cf("white"):format(svcInfo.name))
			B.f:SetText( decode(SvcOpts) )
		  C.f:SetText(L.clear)
		  D.f:SetText(L.notify)
		  E:SetNormalTexture(SvcOpts.notify and self.icons.ldb_Complete or self.icons.ldb_Incomplete)

			E:SetPoint("TOPLEFT", D, "TOPRIGHT", 0, 0); D:SetPoint("TOPLEFT", C, "TOPRIGHT", 0, 0); C:SetPoint("TOPLEFT", B, "TOPRIGHT", 0, 0); B:SetPoint("TOPLEFT", A, "TOPRIGHT", 0, 0)
			
			local function toggleNotify(cmSvcTag)
				local tag = self.db.global.clickmap[cmSvcTag]
				tag.notify = not tag.notify
				M[cmSvcTag].E:SetNormalTexture(SvcOpts.notify and self.icons.ldb_Complete or self.icons.ldb_Incomplete)
			end	
			
			A:SetScript("OnEnter", function() button_OnEnter("A", A.msg) end); B:SetScript("OnEnter", function() button_OnEnter("B") end); C:SetScript("OnEnter", function() button_OnEnter("C") end); D:SetScript("OnEnter", function() button_OnEnter("D") end); E:SetScript("OnEnter", function() button_OnEnter("E") end)
			A:SetScript("OnLeave", function() button_OnLeave() end); B:SetScript("OnLeave", function() button_OnLeave() end); C:SetScript("OnLeave", function() button_OnLeave() end); D:SetScript("OnLeave", function() button_OnLeave() end); E:SetScript("OnLeave", function() button_OnLeave() end)

			B:SetScript("OnClick", function(theButton, mouseButton) 
				local cmStem = self.db.global.clickmap
				local tag = cmStem[theButton.cmSvcTag]		
				
				local shift   = IsShiftKeyDown()
				local alt     = IsAltKeyDown()
				local control = IsControlKeyDown()

			
				local isBusy = self:isBusy_clickmapServiceHandle(mouseButton, shift, alt, control)
				if isBusy then -- if Busy but used by a Module not Loaded, 
					local h_cmService = self.db.global.clickmap[isBusy]
					if h_cmService.isModule then
						if not self.loadedModules[isBusy] then
							local busySvc = cmStem[isBusy]
							busySvc.m = nil
							busySvc.s = nil
							busySvc.a = nil
							busySvc.c = nil
							busySvc.code = nil
						
							isBusy = false							
						end
					end				
				end
								
				if isBusy then -- if true, item was busy and should not be set			
					self:alert( (L.ClickMapAlert):format(
							(mouseButton..(shift and " +"..L.cm_shift_name or "")..(alt and " +"..L.cm_alt_name or "")..(control and " +"..L.cm_ctrl_name or "")):cf("EAblue", "cream"),
							(cmStem[isBusy].name):cf("EAtan", "cream")
						)	
					)
					PlaySound(SOUNDKIT.RAID_WARNING)					
				else
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
					
					tag.m = mouseButton
					tag.s = shift
					tag.a = alt
					tag.c = control
					tag.code = self.formatClick(mouseButton, shift, alt, control)
								
					M[theButton.cmSvcTag].B.f:SetText( decode(tag) )	
					self:alert(L.KeyCombinationSet.." :: "..tag.name)
					self:build_clickmapServiceIndex()
			end
				
			end)
			C:SetScript("OnClick", function(theButton, side) 
				local tag = self.db.global.clickmap[theButton.cmSvcTag]
				tag.code = nil; tag.m = nil; tag.s = nil; tag.a = nil; tag.c = nil; tag.notify=true
				M[theButton.cmSvcTag].B.f:SetText("")
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) 
				self:build_clickmapServiceIndex()						
			end)
			D:SetScript("OnClick", function(theButton, side) PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON); toggleNotify(theButton.cmSvcTag) end)
			E:SetScript("OnClick", function(theButton, side) PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON); toggleNotify(theButton.cmSvcTag) end)
			
			
			return A
		end

		local cmStem, cmOrder = self.db.global.clickmap, clickmapOrder -- self.db.global.clickmapOrder
		local cmOpt = ClickMap.args.ldbClickMap.args.handlerClickMap
		local i=0	
		local lastObj
		
		local svcInfo, SvcOpts

		for j = 1,#cmOrder do
			i=i+1
	    local line = mkEntry(cmOrder[j], cmStem[cmOrder[j]])
	    if not lastObj then line:SetPoint("TOPLEFT", cm.tA, "BOTTOMLEFT", 0, -2)
	    else line:SetPoint("TOPLEFT", lastObj, "BOTTOMLEFT", 0, -2)			    	
	    end
	    lastObj = line
		end

		cm:SetHeight( (i*22) + 54 )
		-- -------------------------------------------------- -- 	
  end		
  
  self.configClickMap:Show()
end
	
  -- Sanity Functions
function ExecAssist:getBehavior_isEnabled_OverrideOrDefault(user, elementID)
	local charStem = self.db.global.charStem[user]
	local E, returnValue
	-- This check is element agnostic.
	E = self.db.global.groupStem.agg[elementID] -- 1: Enabled, 2: Disabled

	if E.defaultEnabled then returnValue = true 
	else returnValue = false 
	end
	
	if charStem.agg[elementID] and charStem.agg[elementID].userOverride then
		if charStem.agg[elementID].userOverride == 2 then     -- ENABLE
			returnValue = true
		elseif charStem.agg[elementID].userOverride == 3 then -- DISABLE
			returnValue = false
		-- else -- value is nil or 1 :: default behavior
		end
	end
return returnValue
end
local function getUniqueElementID(eType) 
	local function mkNewID(eType) return eType..tostring(math.random(999999)) end; 
	
	local aggStem = ExecAssist.db.global.groupStem.agg; 
	local eID = mkNewID(eType); 
	while aggStem[eID] do eID = mkNewID end; 
	
	return eID		
end
local function hardPrune_TACM(Genealogy)
	-- Does a hard-prune of the TACM OptTable for removing groups and tasks (or anything in the 'Genealogy' table passed)
	local G, pos = Genealogy, TaskAndCharMaintenance.args
	for i = 1, #G do
		if i==#G then
			pos[G[i].id] = nil
		else
			pos = pos[G[i].id].args
		end
	end
	return pos
end
function ExecAssist:semiSmart_regrow(Genealogy)
	-- Prunes part of the optTable and regrows it (move up/down/etc, anything sibling related that isn't properly updated)
	-- Doesn't work in the Garden b/c of nil-parentage
	local pos = hardPrune_TACM(Genealogy)
	local G = simpleTcopy(Genealogy)
	local optOrder = G[#G].oo
	local groupID = table.remove(G, #G).id  -- Have to take out the last gene b/c it's passed to AddSingleGroup to be 'combined'

	pos[ groupID ] = self:AddSingleGroup(groupID, optOrder, G )	
end

	-- Reorganize Funcs
function ExecAssist:reorg_PickUp(hElement_move) 
		-- Store object Vital Operational Data
	ExecAssist.reorgObjectID = hElement_move.id; 
	if hElement_move.id:isGroup() then
		ExecAssist.reorgObjectName = (L.reorg_group):cf("white")..hElement_move.listName:cf("cream")
	else
		ExecAssist.reorgObjectName = (L.reorg_task):cf("white")..hElement_move.taskName:cf("cream") 
	end

		-- Ug, horribly bruit force; the control doesn't refresh with other data change...have to rebuild all elements to have it diplay. blech.
	self:loadGroups_toOptionsTable()
end 
function ExecAssist:reorg_SetDown(hGroup)
	local agg = self.db.global.groupStem.agg
	local hReorgItem         = agg[ExecAssist.reorgObjectID]
	local hFormerParentGroup = agg[hReorgItem.p]
	
		-- Wipe Element Hook Storage
	ExecAssist.reorgObjectID   = nil  					
	ExecAssist.reorgObjectName = nil

	if hFormerParentGroup.id ~= hGroup.id then  -- if adding back to the same parent, we just need to clear the reorg objectid
			-- Unadoption:  Remove object from former parent Display Order
		for i=1,#hFormerParentGroup.DO do if hFormerParentGroup.DO[i] == hReorgItem.id then table.remove(hFormerParentGroup.DO, i) end end	

			-- Adoption
		table.insert(hGroup.DO, hReorgItem.id) 		-- Add to New Parent Display Order
		hReorgItem.p = hGroup.id               		-- Reassign Reorged Item's Parent
			
			-- Update Counts, as things have shifted around
		self:ldb_refreshCounts() 

			-- Update Window if used
		self:UpdateWindow()
		
			-- Ug, horribly bruit force; should use smart-pruner/-regrower
		self:loadGroups_toOptionsTable()		
	end
end
	-- Move Func
function ExecAssist:moveElement(hElement, direction)   -- MOVE_UP, MOVE_DOWN (works for Tasks and Groups)
	local DO = self.db.global.groupStem.agg[hElement.p].DO
	local tmp
	
	if IsShiftKeyDown() then -- move to TOP or BOTTOM
		for i=1,#DO do
			if DO[i] == hElement.id then
				table.remove(DO, i)
				break;
			end
		end

		if direction==MOVE_UP then 				table.insert(DO, 1, hElement.id)
		elseif direction==MOVE_DOWN then  table.insert(DO, hElement.id) -- bottom
		else alert("Bad Shift+Move Parameter: "..tostring(direction).." (developer must need more sleep or coffee or both)")
		end
	else
		for i=1,#DO do
			if DO[i] == hElement.id then
				if direction==MOVE_UP then        tmp = DO[i-1]; DO[i-1] = DO[i]			
				elseif direction==MOVE_DOWN then  tmp = DO[i+1]; DO[i+1] = DO[i]			
				else alert("Bad Move Parameter: "..tostring(direction).." (developer must need more sleep or coffee or both)")
				end
				DO[i] = tmp
				break;
			end
		end
	end
	if self.db.char.useTaskWindow then self:UpdateWindow() end
end
 	-- Add Funcs	
function ExecAssist:AddGroup(groupName, hParent, noProgeny) -- hParent = handle group creating the child Group
	local groupStem = self.db.global.groupStem
	local groupID = getUniqueElementID(GROUP_IDENTIFIER)
	if not hParent then hParent = groupStem.agg["garden"] end

	-- Add Default Group
	local hGroup = self:rCopyTable(self.prototype.Group)
	groupStem.agg[groupID] = hGroup
	hGroup.listName = groupName or "Default New Group Name";
	hGroup.p = hParent.id
	hGroup.id = groupID
	
	-- Insert in proper Display Order
	table.insert(hParent.DO, groupID) -- adds the group to the bottom... 
	
	-- Add 1st Task
	if not noProgeny then self:AddTask(groupID, nil, hGroup) end  -- sending hGroup & no pos key, mk @ bottom of group

	-- Update GroupMaintenance var
	self:loadGroups_toOptionsTable()	
	
	if self.db.char.useTaskWindow then self:UpdateWindow() end		
	return groupID -- only the ID tag needs to be returned as a para for :fauxAceConfig_SelectGroup_tableAware()
end
function ExecAssist:AddTask(hGroup, positioning_taskID, suppressRefresh_cmdline)
	if type(hGroup) == "string" then hGroup = self.db.global.groupStem.agg[hGroup] end

	local taskID = getUniqueElementID(TASK_IDENTIFIER) 
	local hTask = self:rCopyTable(self.prototype.Task)
	self.db.global.groupStem.agg[taskID] = hTask
	
	hTask.p = hGroup.id
	hTask.id = taskID
	
	if positioning_taskID then for i=1,#hGroup.DO do if hGroup.DO[i] == positioning_taskID then table.insert(hGroup.DO, i+1, taskID) end end
	else table.insert(hGroup.DO, taskID) -- adds to display order bottom
	end
	
	-- Update Counts
	self:ldb_refreshCounts()
	
	if self.db.char.useTaskWindow and not suppressRefresh_cmdline then self:UpdateWindow() end		
	return hTask
end
	-- Delete Funcs
function ExecAssist:notifyInterns_ofDelete(trashbin) -- table
	-- I really dislike this but some modules store states in ExecAssist and need to know when those states 'change'
	-- due to deletion of the relevant tasks, even if it's just knowing to 'reassess' its innards. Intern Modules can
	-- build a reactive list to cut down the activity but it's still pretty brutal. Really needs a better architecture.
	for name, module in self:IterateModules() do	
		module:intern_elementDeletionHandler(trashbin) -- table
	end	
end
function ExecAssist:DeleteGroup(hGroup, Genealogy, noDOupdate, trashBin) -- remove all associated flags in charStem
	-- noDOupdate is used when deleting child groups to keep them from pruning themselves from parent DOs
	local groupStem = self.db.global.groupStem
	local aggStem = groupStem.agg
	local DO = hGroup.DO

	local parentDO = aggStem[hGroup.p].DO
	if not trashBin then trashBin = {} end
	table.insert(trashBin, hGroup.id)

		-- check cmdLine Target
	if groupStem.cmdLineTarget == hGroup.id then groupStem.cmdLineTarget = nil end
	
		-- process the display order, 
	for i=1,#DO do
		if DO[i]:isGroup() then -- run recursively, no G, suppress Parent Update, send the garbage pail
			self:DeleteGroup(aggStem[DO[i]], nil, true, trashBin) 	
		else
			table.insert(trashBin, DO[i]) -- for cleaning charStem/acctwideStem 
			aggStem[DO[i]] = nil					-- Bedtime for Bonzo
		end
	end

	local groupID = hGroup.id		-- suicide note (yeah, I know that hGroup hangs around after aggStem is pruned)
	aggStem[hGroup.id] = nil 		-- good buy cruel world

	if not noDOupdate	then
		-- remove from parent
		for i=1,#parentDO do if parentDO[i] == groupID then table.remove(parentDO, i); break; end end
			
		-- Remove group from active OptTable
		hardPrune_TACM(Genealogy)

		-- Garbage Collection: clean groups and task fragments from charStem and acctwideStem
		self:GarbageCollection(trashBin)
		
		-- Update Counts
		self:ldb_refreshCounts() -- can't guarantee a delete-task was run

		self:UpdateWindow()
--		self:notifyInterns_ofDelete(groupID)
	end	
	
end
function ExecAssist:DeleteTask(hTask, Genealogy)  -- remove all associated flags in charStem
	local aggStem = self.db.global.groupStem.agg
	local hGroup = aggStem[hTask.p]
	local taskID, groupID = hTask.id, hTask.p -- store so we can nix hTask

	-- Remove group from Display Order
	for i=1,#hGroup.DO do if hGroup.DO[i] == taskID then table.remove(hGroup.DO, i) end end

  local p = simpleTcopy(Genealogy)
  table.insert(p, {["id"] = hTask.id, ["oo"] = 0}) -- put the chicken on the chopping block
 	hardPrune_TACM(p)

	-- clean out charStem and aggStem
	self:GarbageCollection({hTask.id})

	-- Remove Group from db and Options Table 
	aggStem[hTask.id] = nil -- nuke
	
	-- Update Counts
	self:ldb_refreshCounts()
	
	self:UpdateWindow()
end
	-- Garbage Collection
function ExecAssist:GarbageCollection(trashBin)
	local sdbg = self.db.global
	local charStem_base, AWagg = sdbg.charStem, sdbg.acctwideStem.agg
	local sv_charList = self.db.sv.char

	-- empty out charStem agglomerations and sv.char collapseMap entries
	for charName, charStem in pairs(charStem_base) do
		for i=1,#trashBin do 
			if charStem.agg[trashBin[i]] then charStem.agg[trashBin[i]] = nil end

			local sv_charList = sv_charList[charName]
			if sv_charList then
				local map = sv_charList.map
				if map then
					if map.char then map.char.PGT[trashBin[i]] = nil end
					if map.TW   then map.TW.PGT[trashBin[i]]   = nil end
					if map.GTP  then map.GTP[trashBin[i]]      = nil end
				end
			end
		end
	end
	
	-- Cleanup Fragmental Data
	for i=1,#trashBin do 			
		-- empty out account wide agglomeration
		if AWagg[trashBin[i]] then AWagg[trashBin[i]] = nil end
	end

	-- Notify Interns of Deletion
	self:notifyInterns_ofDelete(trashBin)

		
	trashBin = nil
end	
-- ------------------------------------------------------------------------------------ --
-- ------------------------------------------------------------------------------------ --
function ExecAssist:getState_GroupEnabledForUser(userConfigDisplay, Genealogy)
	-- This routine is called /entirely/ too often and gBiEOOD() is just spammed... Have to see about
	-- setting a group-local I-Am-Off-You-Should-Be-Too var that the tasks can read instad of banging
	-- this like it gives away free espresso
	for i=#Genealogy, 1, -1 do
		if not self:getBehavior_isEnabled_OverrideOrDefault(userConfigDisplay, Genealogy[i].id) then return false end	
	end
	return true
end

function ExecAssist:loadGroups_toOptionsTable()
	local garden = self.db.global.groupStem.agg["garden"].DO -- NB: Garden is /always/ a group, if the user wants a simple list then can make 1 group w/ hide the group in the display
	local optOrder = 0
	-- Prune Options Table of Task Groups so they aren't duplicated or lingering after removal. 
	-- 		Not exactly best-practice but there doesn't seem to be any other way but using hammers, bloody immature frameworks
	local safetable = {["header"] = true, ["intro"]=true, ["addGroup_Group"]=true, ["selectChar_Group"]=true, ["prefooter"]=true, ["footer"]=true}
	for k,v in pairs(TaskAndCharMaintenance.args) do if not safetable[k] then TaskAndCharMaintenance.args[k] = nil end end
	
	-- Reload from garden
	for i=1, #garden do
		local Genealogy = {}
		local groupID = garden[i]
		optOrder = optOrder+10

		TaskAndCharMaintenance.args[ groupID ] = self:AddSingleGroup(groupID, optOrder, Genealogy )
	end

end

function ExecAssist:AddSingleGroup(groupID, optOrder, Genealogy)
	local sdbg = self.db.global
	local ttStem = sdbg.tooltip
	local G = simpleTcopy(Genealogy)  
	local hGroup = sdbg.groupStem.agg[groupID]
	table.insert(G, {["id"] = groupID, ["oo"] = optOrder})	 -- Each time this routine is called, it copies and grows the parental history so that child groups and tasks know can be all nice and spiffy to the user
  hGroup.G = G -- store genealogy in group handle; this lets command-line entries use the semi-smart pruner to add option table entries for them w/o regrowing the entire hierarchy (gotta save those .0036 miliseconds) We could reverse-engineer the genealogy using hGroup.p but the regrower needs the .oo (option order index) which, itself, could also be reverse-engineered... so this is a choice of more storage vs more places for code to break and reinventing an already invented wheel. And it remains an option if storage costs mount.
	return  {
		type = "group", 
		icon = function()				
			if self:getState_GroupEnabledForUser(self.userConfigDisplay, Genealogy) then 
				if self:getBehavior_isEnabled_OverrideOrDefault(self.userConfigDisplay, groupID) then
					return self.icons.used
				else
					return self.icons.notused
				end
			else
				return self.icons.disabledGroup
			end
		end,  
		name = function() 
			local s_groupName
			local H, cmT = "", ""

			if hGroup.hideFromDisplay then
				if ttStem.SM.hidden.useStyle then 
					if ttStem.SM.hidden.useText > 1 then
						H = ttStem.SM.hidden.useText_text
					else
						H = "(I)"
					end
					
					if ttStem.SM.hidden.useColor > 1 then
						H = H:cfc(self:tbl_pcColorToHex(ttStem.SM.hidden.color))
					else
						H = H:cfc("ff9966")
					end
				else
					H = ("(I)"):cfc("ff9966")
				end
			end

			if hGroup.cmdLineTarget then
				if ttStem.SM.cmdLineTarget.useStyle then 
					if ttStem.SM.cmdLineTarget.useText > 1 then
						cmT = ttStem.SM.cmdLineTarget.useText_text
					else
						cmT = "[T]"
					end
					
					if ttStem.SM.acctwide.useColor > 1 then
						cmT = cmT:cfc(self:tbl_pcColorToHex(ttStem.SM.cmdLineTarget.color))
					else
						cmT = cmT:cfc("ffff00")
					end
				else
					cmT = ("[T]"):cfc("ffff00")
				end
			end

			if hGroup.hideFromDisplay and ttStem.SM.hidden.useStyle and ttStem.SM.hidden.useColor == 3 then 
				s_groupName = hGroup.listName:cfc(self:tbl_pcColorToHex(ttStem.SM.hidden.color))
			elseif hGroup.cmdLineTarget and ttStem.SM.cmdLineTarget.useStyle and ttStem.SM.cmdLineTarget.useColor == 3 then 
				s_groupName = hGroup.listName:cfc(self:tbl_pcColorToHex(ttStem.SM.cmdLineTarget.color))
			else
				s_groupName = hGroup.listName:cfc(self:tbl_pcColorToHex(sdbg.Options.cfg_groupColor)) -- v0.9.9 regression fix (should not have been ttStem.color_Group)
			end

			return (H..cmT.." "..s_groupName)
		end,
	 	order = optOrder,
		args = self:loadTasks_toGroup_inOptionsTable( groupID, G, optOrder, gpGroup_optOrder )
	}	
end

function ExecAssist:TargetIsInLineage(hGroup)
	local agg, hpGroup = self.db.global.groupStem.agg, {}
	while hpGroup.id ~= "garden" do
		hpGroup = agg[ hGroup.p ] 
		if hpGroup.id == ExecAssist.reorgObjectID then return true
		else hGroup = hpGroup
		end	
	end	
end

function ExecAssist:loadTasks_toGroup_inOptionsTable(groupID, Genealogy)
	local sdbc, sdbg = self.db.char, self.db.global
	local hGroup = sdbg.groupStem.agg[groupID]

	-- Add Group Options
	local T = {
		whoami = {
			hidden=not ExecAssist.db.sv.debug,
			order=0,
			width="full",
			fontSize = "large",
			name="GroupID: "..hGroup.p.." / GroupID: "..hGroup.id,
			type="description",
		},	
		-- group 1
		hdr0 = {order=2, type="header", hidden = not ExecAssist.isReorging, name=L.reorg_ReorgTitle}, 
		ReorgNameDisplay = {
			order = 4,
			type = "description",
			hidden = not ExecAssist.reorgObjectName,
			fontSize = "medium",
			name = ("%s: %s"):cf("cream"):format( 
				(L.reorg_Moving):cf("grass", "cream"),
				(true and ExecAssist.reorgObjectName or ""):cf("grass", "cream")
			),
		},				  
		reorg_PickUpObject = {
			name = L.reorg_PickUp,
		  desc = L.reorg_PickUp_desc,
		  type = "execute",
		  hidden = not ExecAssist.isReorging,
		  disabled  = function() end,
		  order = 5,
		  width="half",
			func = function(info) self:reorg_PickUp(hGroup) end,
		},
		reorg_PutDownObject = {
			name = L.reorg_PutDown,
		  desc = L.reorg_PutDown_desc,
		  type = "execute",
			hidden = function () return (not ExecAssist.isReorging) or (not ExecAssist.reorgObjectID) end,
		  disabled = function() return ExecAssist.reorgObjectID==hGroup.id or self:TargetIsInLineage(hGroup) end,
		  order = 6,
		  width="normal",
			func = function() self:reorg_SetDown(hGroup) end,				
		},
		reorg_PutInRoot = {
			name = L.reorg_PutInRoot,
		  desc = L.reorg_PutInRoot_desc,
		  type = "execute",
			hidden = function(info) return (not ExecAssist.isReorging) or (not ExecAssist.reorgObjectID) or ( ExecAssist.reorgObjectID ~= info[#info-1])  end,
		  disabled  = function() if hGroup.p == "garden" then return true end end,
		  order = 6,
		  width="normal",
			func = function() self:reorg_SetDown(ExecAssist.db.global.groupStem.agg["garden"]); self:processIgnoredCharacters() end,				
		},		
		    	
		hdr1 = {order=9, type="header", hidden = ExecAssist.isReorging, name=L.groupactions}, 
		UP_moveGroup = {
			name = "^^^",
		  desc = L.UP_moveGroup,
		  type = "execute",
		  hidden = ExecAssist.isReorging,
		  disabled  = function() 
		  	local DO = self.db.global.groupStem.agg[hGroup.p].DO
				if DO[1] == groupID then return true end 
		  end,
		  order = 10,
		  width="half",
			func = function() 
				self:moveElement(hGroup, MOVE_UP)
		
				local p = simpleTcopy(Genealogy)
				if #p >= 2 then 
					table.remove(p, #p)
					self:semiSmart_regrow(p)			
				else -- When moving the Garden, we have to move everything anyway & 'garden' isn't a 'real' tree element
					-- ideally it'd just be swapping order= but, alas...						
					self:loadGroups_toOptionsTable()							
				end
			 end,
		},
		DOWN_moveGroup = {
			name = "vvv",
		  desc = L.DOWN_moveGroup,
		  type = "execute",
		  hidden = ExecAssist.isReorging,
		  disabled  = function() 
		  	local DO = self.db.global.groupStem.agg[hGroup.p].DO
			  if DO[#DO] == groupID then return true end 
		  end,
		  order = 11,
		  width="half",
			func = function() 
				self:moveElement(hGroup, MOVE_DOWN) 
			
				local p = simpleTcopy(Genealogy)
				if #p >= 2 then 
					table.remove(p, #p) 
					self:semiSmart_regrow(p)					
				else -- When moving the Garden, we have to move everything anyway & 'garden' isn't a 'real' tree element
					self:loadGroups_toOptionsTable()							
				end
		
			end,
		},
		deleteGroup = {
		  name = L.deleteGroup_name,
		  desc = L.deleteGroup_desc,
		  type = "execute",
		  hidden = ExecAssist.isReorging,
		  order = 100,
			func = function() 
				if IsShiftKeyDown() then
					self:DeleteGroup(hGroup, Genealogy) 
					
					local p = simpleTcopy(Genealogy)
					table.insert(p, 1, {["id"] = "TaskMaint"})
					p[#p] = nil
	
					self:fauxAceConfig_SelectGroup_tableAware(self.opts.f_reg, p)
				else
					self:alert(L.Delete_SafetyMeasureMessage)
				end						
			end,
		},
		
		addTask = {
			name = L.addTaskg_name,
		  desc = L.addTaskg_desc,
		  width="normal",
		  type = "execute",
		  hidden = ExecAssist.isReorging,
		  order= 120,
			func = function() 
				local hTask_NEW = ExecAssist:AddTask(hGroup); 					
				self:semiSmart_regrow(Genealogy)
				
				local p = simpleTcopy(Genealogy)
				table.insert(p, 1, {["id"] = "TaskMaint"})				
				table.insert(p, {["id"] = hTask_NEW.id})						
				self:fauxAceConfig_SelectGroup_tableAware(self.opts.f_reg, p)
			end,
		},
		addGroup = {
			name = L.addGroup_name,
		  desc = L.addGroup_desc,
		  width="normal",
		  type = "execute",
		  hidden = ExecAssist.isReorging,
		  order= 125,
			func = function() 
				local groupID = ExecAssist:AddGroup(nil, hGroup) 
		
				local p = simpleTcopy(Genealogy)
				table.insert(p, 1, {["id"] = "TaskMaint"})
				table.insert(p, {["id"] = groupID})
				
				self:fauxAceConfig_SelectGroup_tableAware(self.opts.f_reg, p)
			end,
		},
		-- group 2
		hdr2 = {order=204, type="header", name="Group Options"}, 
		byDefault_groupIs = {
			name = L.byDefault_groupIs_name,
			desc = L.byDefault_groupIs_desc,
			type="select",
			order = 205,
			values = self.optValues.EnableDisable,
			get = function() 
				if hGroup.defaultEnabled then 
					return 1 
				else 
					return 2 
				end 
			end,
			set = function(i, v) 
				if v==1 then 
					hGroup.defaultEnabled = true 
				else 
					hGroup.defaultEnabled = false
				end
				local charStem = self.db.global.charStem[self.userConfigDisplay]
		
				if self.db.global.tooltip.useCounts_onLDB then self:ldb_refreshCounts() end
				if sdbc.useTaskWindow then self:UpdateWindow() end		
			end,
		},
		byUser_groupIs = {
			name = L.byUser_groupIs, 
			desc = "",
			type = "select",
			order= 210,
			disabled = function()
				return self:isCharIgnored(self.userConfigDisplay, sdbg.charStem[self.userConfigDisplay]) -- this stops an 'ignored' user from having groups "enabled" (NB: This is an over-correction as it applies to ALL groups and not just those in the root.
			end,
			hidden = function() 
					local p = simpleTcopy(Genealogy)
					table.remove(p, #p)
					return not self:getState_GroupEnabledForUser(self.userConfigDisplay, p) 
			end,
			values = self.optValues.userOverrideEnableDisable,
			get = function()  
				local charStem = sdbg.charStem[self.userConfigDisplay]
				if charStem.agg[groupID] and charStem.agg[groupID].userOverride then
					return charStem.agg[groupID].userOverride
				else
					return 1
				end
			end,
			set = function(i, v)  
				local charStem = self.db.global.charStem[self.userConfigDisplay]
				if v==1 and charStem.agg[groupID] then charStem.agg[groupID].userOverride = nil -- 1:default / no override
				else
					if not charStem.agg[groupID] then charStem.agg[groupID] = {} end
					charStem.agg[groupID].userOverride = v
				end
				if sdbg.tooltip.useCounts_onLDB then self:ldb_refreshCounts() end  			
				if sdbc.useTaskWindow then self:UpdateWindow() end		
			end,
		},
		hideFromDisplay = { -- only applies to group-child-groups, not garden-child-groups
			hidden = function() return #Genealogy <= 1 end,
			name = L.hideFromDisplay_name,
			desc = L.hideFromDisplay_desc,
			type = "toggle",
			order = 212,
			get = function() return hGroup.hideFromDisplay end,
			set = function(i, v) hGroup.hideFromDisplay = v; if sdbc.useTaskWindow then self:UpdateWindow() end		 end,
		},	
		cmdLineTarget = {
		  name = L.cmdLineTarget_name,
		  desc = L.cmdLineTarget_desc,
		  type = "toggle",
		  order = 214,
			get = function() return hGroup.cmdLineTarget end,
			set = function(i, v)
				local groupStem = self.db.global.groupStem
				local old_groupID = groupStem.cmdLineTarget -- nix previous target if there
				if old_groupID then groupStem.agg[old_groupID].cmdLineTarget = nil; end
				
				if v then 
					groupStem.cmdLineTarget = groupID 
				else
					groupStem.cmdLineTarget = nil 
				end
				
				hGroup.cmdLineTarget = v;
				if sdbc.useTaskWindow then self:UpdateWindow() end		
			end,
		},		
		-- group 3
		spacer1 = {order = 219,type = "description", width="full", name = " "},			
		groupName = {
		 	name = L.groupName_rename_name,
		 	desc = L.groupName_rename_desc,
		 	type = "input",
		 	width="full",
		 	order = 220,
		 	get = function() return hGroup.listName:gsub("|", "//") end,
		 	set = function(i, v) hGroup.listName = v:gsub("//", "|"); if sdbc.useTaskWindow then self:UpdateWindow() end end,
		},
		-- group 5
		hideDays = {
			name = L.hideDays_group_name,
			desc = L.hideDays_group_desc,
			type = "multiselect",
			order = 240,
			values = self.optValues.DaysOfWeek,
			
			get = function(info, k) return hGroup.hideDays[k] end,
			set = function(info, k, v) hGroup.hideDays[k] = v ; if sdbc.useTaskWindow then self:UpdateWindow() end		end,				
			
		},
		-- group 6
		Export = {
			order = 250,
			inline = true,
			hidden = not IsAddOnLoaded(self.FC),
			name = "Export",
			desc = "Desc", 
			type = "group", 
			args = {
				groupName = {
				 	name = "Export Group: Name",
				 	desc = "Export Group: Name",
				 	type = "input",
				 	width="full",
				 	order = 10,
				 	get = function() return hGroup.exportName end,
				 	set = function(i, v) hGroup.exportName = v:trim() end,
				},
				reorg_PickUpObject = {
		    	name = "Export-o-potomus",
		      desc = "Export-o-potomus",
		      disabled = function() return hGroup.exportName==nil or hGroup.exportName:trim() == "" end,
		      type = "execute",
		      order = 20,
		      width="full",
					func = function()
						FileCabinet:ExportGroup(hGroup)
					end,				
		    },
			}
		}
	}

	local groupDO = self.db.global.groupStem.agg[groupID].DO -- group Handle	
	for i=1, #groupDO do 
		if groupDO[i]:isGroup() then -- send back to do the group thing
			T[groupDO[i]] = self:AddSingleGroup(groupDO[i], i, Genealogy)
		else -- do the task thing
			T[groupDO[i]] = self:AddSingleTask(groupDO[i], i, Genealogy) 
		end		
	end

	return T
end

function ExecAssist:primeDateBased_TaskTypes(hTask)
	if not hTask.resetDate_Next then 
		hTask.resetDate_Last = self:happyMidnight(time(), true)
		hTask.resetDate_Next = self:happyMidnight(time(), true) 
		hTask.offsetDays = 1
	end
	if hTask.resetType==L.CalendarAutomatic then
		-- If resetting to 'resettable calendar' it MIGHT be from Calendar so we have to reassert the _Next from the _Last reset date
		hTask.resetDate_Next = self:happyMidnight(hTask.resetDate_Last + (86400 * hTask.offsetDays), true)
	end
end

function ExecAssist:quickTaskEntry_SingleTask_Setup()
	-- NB: Scructure duplication from line2 of :AddSingleTask()
	
	self.quickTaskEntry_Opts = {
		type = "group",
		order = 10,
		name = self:mkLink(self.icons.enabled, 22).." "..L.appName.. "- Quick Task Entry",
		args = {	
		}
	}

	-- Register Options Table
 	local opts = self.quickTaskEntry_Opts
	local RegOpts = LibStub("AceConfigRegistry-3.0")
	
	RegOpts:RegisterOptionsTable( opts, opts ) -- ExecAssist Opts -
	self.Dialog:SetDefaultSize(   opts, 650, 400 ) -------------------
end
function ExecAssist:quickTaskEntry_SingleTask(hTask)
	local sdbc  = self.db.char	
	if not hTask then hTask = self:getFreshTaskStem() end

	self.quickTaskEntry_Opts.args = {
	    -- line 2
    	hdr2 = {order=80, type="header", name="Task Options"}, 
			byDefault_taskIs = {
				name = L.byDefault_taskIs_name,
				desc = L.byDefault_taskIs_desc,
				type="select",
				order = 90,
				values = self.optValues.EnableDisable,
				get = function() 
					if hTask.defaultEnabled then 
						return 1 
					else 
						return 2 
					end 
				end,
				set = function(i, v) 
					if v==1 then
						hTask.defaultEnabled = true
					else 
						hTask.defaultEnabled = false
					end
					local sdbc = self.db.global

					if sdbc.tooltip.useCounts_onLDB then self:ldb_refreshCounts() end
					if sdbc.useTaskWindow then self:UpdateWindow() end		
				end,
			},
			byUser_taskIs = {
				name = L.byUser_taskIs,
				desc = "",
				type = "select",
				order= 95,
--				hidden = function() return not self:getState_GroupEnabledForUser(self.userConfigDisplay, Genealogy) end,
				values = self.optValues.userOverrideEnableDisable,
				get = function()  
					local charStem = self.db.global.charStem[self.userConfigDisplay]
					if charStem.agg[taskID] and charStem.agg[taskID].userOverride then
						return charStem.agg[taskID].userOverride
					else
						return 1
					end
				end,
				set = function(i, v)  
					local charStem = self.db.global.charStem[self.userConfigDisplay]
					if v==1 and charStem.agg[taskID] then charStem.agg[taskID].userOverride = nil -- 1:default / no override
					else
						if not charStem.agg[taskID] then charStem.agg[taskID] = {} end
						charStem.agg[taskID].userOverride = v
					end
	  			if self.db.global.tooltip.useCounts_onLDB then self:ldb_refreshCounts() end  		
	  			if sdbc.useTaskWindow then self:UpdateWindow() end			
				end,
			},
			-- line 3
			taskName = {
		  	name = L.taskName,
		  	desc = "",
		  	type = "input",
		  	width="full",
		  	order = 100,
		  	get = function() return hTask.taskName:gsub("|", "//") end,
		  	set = function(i, v) hTask.taskName = v:gsub("//", "|"); if sdbc.useTaskWindow then self:UpdateWindow() end		end,
			},
			extCreate = {order=105, type="description", hidden = not hTask.extCreate,
				name = function() 
					if self.loadedModules[hTask.extCreate] then
						return ("%s: %s (%s)"):format(
											L.managedByModule_Prefix :cf("EAtan", "white"),
											tostring(hTask.extCreate):cf("cream"),
											(L.optsTable_base.EnableDisable[1]):cf("hard_green", "cream")
										)

					elseif hTask.extCreate and IsAddOnLoaded( hTask.extCreate ) then
						return ("%s: Addon %s (%s)"):format(
											L.managedByModule_Prefix :cf("EAtan", "white"),
											tostring(hTask.extCreate):cf("cream"),
											(L.optsTable_base.EnableDisable[1]):cf("hard_green", "cream")
										)

					else
						return ("%s: %s (%s)"):format(
											L.managedByModule_Prefix :cf("EAtan", "white"),
											tostring(hTask.extCreate):cf("cream"),
											(L.optsTable_base.EnableDisable[2]):cf("hard_red", "cream")
										)
					end
				end, 
			},
			resetType= {
				name = L.resetType_name,
				desc = L.resetType_desc,
				type="select",
				order = 110, 
				disabled = not self.isAvail_taskType[hTask.resetType],
				values = self.isAvail_taskType[hTask.resetType] and self.taskTypes_Index or L.optsTable_missingmodule_table,
				get = function() 
					local resetType = hTask.resetType
					local ResetTypes = self.taskTypes_Index

					if self.isAvail_taskType[resetType] then
						for i=1, #ResetTypes do 
							if ResetTypes[i] == resetType then 
								return i 
							end 
						end
					else
						return 1 --only one option in missingmodule_table:  L.optsTable_missingmodule_label
					end
				end,
				set = function(i, v) 
					hTask.resetType = self.taskTypes_Index[v]

 					hTask.extCreate = self.taskTypes[hTask.resetType].module -- should nil this if an internal is used, so DON'T FUCK WITH EXTERNALS!

					if hTask.resetType==L.Reminder or hTask.resetType==L.CalendarAutomatic then
						self:primeDateBased_TaskTypes(hTask)
					end
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
--					self:semiSmart_regrow(Genealogy) 
ExecAssist:quickTaskEntry_SingleTask(hTask)
				end, 
			},		
			
			AcctWide = {
			  name = L.task_AcctWide_name,
			  desc = L.task_AcctWide_desc,
			  type = "toggle",
			  order = 120,
				get = function() return hTask.isAcctWide end,
				set = function(i, v) hTask.isAcctWide = v ; if sdbc.useTaskWindow then self:UpdateWindow() end		end, -- NB: forgoing garbage collection atm...
			},
			-- Calendar and Date Management				
			CalHeader1 = {order=200, type="header", name=L.reminder_LastTrigger, hidden = hTask.resetType ~= L.CalendarAutomatic}, -- [7]
			day_last = {
				hidden = hTask.resetType ~= L.CalendarAutomatic,
				name = L.Day,
				type="select",
				width = "half",
				order = 210,
				values = self.optValues.Days,
				get = function() 
						return date("*t", hTask.resetDate_Last).day
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Last)
					d.day = v
					hTask.resetDate_Last = self:happyMidnight(time(d), true)
					hTask.resetDate_Next = self:happyMidnight(time(d) + (86400 * hTask.offsetDays), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
			month_last = {
				hidden = hTask.resetType ~= L.CalendarAutomatic,
				name = L.Month,
				type="select",
				width = "half",
				order = 220,
				values = self.optValues.Months,
				get = function() 
					return date("*t", hTask.resetDate_Last).month
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Last)
					d.month = v
					hTask.resetDate_Last = self:happyMidnight(time(d), true)
					hTask.resetDate_Next = self:happyMidnight(time(d) + (86400 * hTask.offsetDays), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
			year_last = {
				hidden = hTask.resetType ~= L.CalendarAutomatic,
				name = L.Year,
				type="select",
				width = "half",
				order = 230,
				values = self.optValues.Year,
				get = function()
					local y = tostring(date("*t", hTask.resetDate_Last).year)
					local Year = self.optValues.Year
					for i=1, #Year do if Year[i] == y then return i end end 
					return 
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Last)
					d.year = tonumber(self.optValues.Year[v])
					hTask.resetDate_Last = self:happyMidnight(time(d), true)
					hTask.resetDate_Next = self:happyMidnight(time(d) + (86400 * hTask.offsetDays) , true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},					
			offsetDays = {
				hidden = hTask.resetType ~= L.CalendarAutomatic,
				order=240,
				name = L.reminder_OffsetDays,
				desc = L.reminder_OffsetDays_desc,
				type="range",
				min=1,
				max=365,
				step=1,
				isPercent=false,
				get = function()
						return true and hTask.offsetDays or 1
				end,
				set = function(i, v) 							
					local d = date("*t", hTask.resetDate_Last)
					hTask.offsetDays = v
					hTask.resetDate_Next = self:happyMidnight(time(d) + (86400 * hTask.offsetDays) , true)
				end, 
			},

			CalHeader2 = {order=300, type="header", name=L.reminder_NextTrigger, hidden = (hTask.resetType ~= L.Reminder) and (hTask.resetType ~= L.CalendarAutomatic)}, --[6]
			ReminderIntro = {
				order = 305,
				type = "description",
				hidden = hTask.resetType ~= L.Reminder,						
				fontSize = "medium",
				name = ("'Reminder' Tasks will be hidden until the target date when they will reappear as a Purgable Task"),
			},
			day = {
				name = L.Day,
				type="select",
				hidden = (hTask.resetType ~= L.Reminder) and (hTask.resetType ~= L.CalendarAutomatic),
				disabled = hTask.resetType == L.CalendarAutomatic,
				width = "half",
				order = 310,
				values = self.optValues.Days,
				get = function() 
						return date("*t", hTask.resetDate_Next).day
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Next)
					d.day = v
					hTask.resetDate_Next = self:happyMidnight(time(d), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
			month = {
				name = L.Month,
				type="select",
				width = "half",
				hidden = (hTask.resetType ~= L.Reminder) and (hTask.resetType ~= L.CalendarAutomatic),
				disabled = hTask.resetType == L.CalendarAutomatic,
				order = 320,
				values = self.optValues.Months,
				get = function() 
					return date("*t", hTask.resetDate_Next).month
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Next)
					d.month = v
					hTask.resetDate_Next = self:happyMidnight(time(d), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
			year = {
				name = L.Year,
				type="select",
				hidden = (hTask.resetType ~= L.Reminder) and (hTask.resetType ~= L.CalendarAutomatic),
				disabled = hTask.resetType == L.CalendarAutomatic,
				width = "half",
				order = 330,
				values = self.optValues.Year,
				get = function()
					local y = tostring(date("*t", hTask.resetDate_Next).year)
					local Year = self.optValues.Year
					for i=1, #Year do if Year[i] == y then return i end end 
					return 
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Next)
					d.year = tonumber(self.optValues.Year[v])
					hTask.resetDate_Next = self:happyMidnight(time(d), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
					
			calGroup = {
				hidden = true,
				type = "group",
				name = "Calendar",
				inline=true,
				order = 500,				
				args = {}
			},
	
	}

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	self.Dialog:Open(self.quickTaskEntry_Opts)
	self.Dialog.OpenFrames[self.quickTaskEntry_Opts]:SetStatusText(
		(L.statusText):cf("cream"):format( 
				L.StatusField_appName:cf("EAtan", "cream"), 
				GetAddOnMetadata(AddonName, 'Version'):cf("grass", "cream"), 
				L.authorName:cf("EAtan"), 
				("Panel"):cf("cyan", "white"), 
				("Quick Task Entry"):cf("grass", "cream") 
		) 
	) 	
end

function ExecAssist:AddSingleTask(taskID, optOrder, Genealogy, pGroup_optOrder)
	local hTask = self.db.global.groupStem.agg[taskID]
	local sdbc  = self.db.char

	local task_optTable = {
		icon = function() 
			if self:getState_GroupEnabledForUser(self.userConfigDisplay, Genealogy) then 
				if self:getBehavior_isEnabled_OverrideOrDefault(self.userConfigDisplay, taskID) then
					if hTask.resetType == L.Reminder then return self.icons.used_R
					else return self.icons.used
					end					
				else
					if hTask.resetType == L.Reminder then return self.icons.notused_R
					else return self.icons.notused
					end					
				end
			else
				return self.icons.disabledGroup
			end
			
		end,
		type = "group", 
		name = function() 
			local ttStem = self.db.global.tooltip
			local s_taskName
			local aw, pur = "", ""

			if hTask.isAcctWide then
				if ttStem.SM.acctwide.useStyle then 
					if ttStem.SM.acctwide.useText > 1 then
						aw = ttStem.SM.acctwide.useText_text
					else
						aw = "[aw]"
					end
					
					if ttStem.SM.acctwide.useColor > 1 then
						aw = aw:cfc(self:tbl_pcColorToHex(ttStem.SM.acctwide.color))
					else
						aw = aw:cfc("00ffff")
					end
				else
					aw = ("[aw]"):cfc("00ffff")
				end
			end

			if hTask.resetType == L.Purgable then
				if ttStem.SM.purgable.useStyle then 
					if ttStem.SM.purgable.useText > 1 then
						pur = ttStem.SM.purgable.useText_text
					else
						pur = "[P]"
					end
					
					if ttStem.SM.purgable.useColor > 1 then
						pur = pur:cfc(self:tbl_pcColorToHex(ttStem.SM.purgable.color))
					else
						pur = pur:cfc("ff0088")
					end
				else
					pur = ("[P]"):cfc("ff0088")
				end
			end

			
			if hTask.isAcctWide and ttStem.SM.acctwide.useStyle and ttStem.SM.acctwide.useColor == 3 then 
				s_taskName = hTask.taskName:cfc(self:tbl_pcColorToHex(ttStem.SM.acctwide.color))
			elseif hTask.resetType == L.Purgable and ttStem.SM.purgable.useStyle and ttStem.SM.purgable.useColor == 3 then 
				s_taskName = hTask.taskName:cfc(self:tbl_pcColorToHex(ttStem.SM.purgable.color))
			else
				s_taskName = hTask.taskName:cfc(self:tbl_pcColorToHex(ttStem.color_TaskName))
			end

			return (aw..pur.." "..s_taskName)
		end, 
		order = optOrder,
		args = {
			whoami = {
				hidden=not ExecAssist.db.sv.debug,
				order=0,
				width="full",
				fontSize = "large",
				name="GroupID: "..hTask.p.." / TaskID: "..taskID,
				type="description",
			},	
						
			-- line 1
    	hdr0 = {order=33, type="header", hidden = not ExecAssist.isReorging, name=L.reorg_ReorgTitle}, 
			ReorgNameDisplay = {
				order = 34,
				type = "description",
				hidden = not ExecAssist.reorgObjectName,
				fontSize = "medium",
				name = ("%s: %s"):cf("cream"):format( 
					(L.reorg_Moving):cf("grass", "cream"),
					(true and ExecAssist.reorgObjectName or ""):cf("grass", "cream")							
				),
			},					  
	    
			reorg_PickUpObject = {
	    	name = L.reorg_PickUp,
	      desc = L.reorg_PickUp_desc,
	      type = "execute",
	      hidden = not ExecAssist.isReorging,
	      disabled  = function() end,
	      order = 35,
	      width="half",
				func = function() self:reorg_PickUp(hTask) end,				
	    },

    	hdr1 = {order=39, type="header", hidden = ExecAssist.isReorging, name=L.taskactions}, 
			UP_moveTask = {
	    	name = "^^^",
	      desc = L.UP_moveTask,
	      type = "execute",
	      hidden = ExecAssist.isReorging,
	      disabled  = function()
	      	local DO = self.db.global.groupStem.agg[hTask.p].DO
	      	if DO[1] == taskID then return true end
	      end,
	      order = 40,
	      width="half",
				func = function() self:moveElement(hTask, MOVE_UP); self:semiSmart_regrow(Genealogy)	end,				
	    },
			DOWN_moveTask = {
	    	name = "vvv",
	      desc = L.DOWN_moveTask,
	      type = "execute",
	      hidden = ExecAssist.isReorging,
	      disabled  = function() 
	      	local DO = self.db.global.groupStem.agg[hTask.p].DO
	      	if DO[#DO] == taskID then return true end
	      end,
	      order = 50,
	      width="half",
				func = function() self:moveElement(hTask, MOVE_DOWN); self:semiSmart_regrow(Genealogy)	end,
	    },
			addTask = {
	    	name = L.task_addTask_name,
	      desc = L.task_addTask_desc,
	      width="half",
	      type = "execute",
	      hidden = ExecAssist.isReorging,
	      order = 60,
				func = function() 
					local hTask_NEW = self:AddTask(hTask.p, taskID); -- hTask.id
					
					self:semiSmart_regrow(Genealogy)
	
					local p = simpleTcopy(Genealogy)
					table.insert(p, 1, {["id"] = "TaskMaint"})
					table.insert(p, {["id"] = hTask_NEW.id})
					self:fauxAceConfig_SelectGroup_tableAware(self.opts.f_reg, p)	
				end,
	    },
			deleteTask = {
	    	name = L.task_deleteTask_name,
	      desc = L.task_deleteTask_desc,
	      width="half",
	      type = "execute",
	      hidden = ExecAssist.isReorging,
	      order = 70,
				func = function()
					if IsShiftKeyDown() then
						self:DeleteTask(hTask, Genealogy) 
	
						local p = simpleTcopy(Genealogy)
						table.insert(p, 1, {["id"] = "TaskMaint"})						
						self:fauxAceConfig_SelectGroup_tableAware(self.opts.f_reg, p)
					else
						self:alert(L.Delete_SafetyMeasureMessage)
					end
				end,
	    },
	    -- line 2
    	hdr2 = {order=80, type="header", name="Task Options"}, 
			byDefault_taskIs = {
				name = L.byDefault_taskIs_name,
				desc = L.byDefault_taskIs_desc,
				type="select",
				order = 90,
				values = self.optValues.EnableDisable,
				get = function() 
					if hTask.defaultEnabled then 
						return 1 
					else 
						return 2 
					end 
				end,
				set = function(i, v) 
					if v==1 then
						hTask.defaultEnabled = true
					else 
						hTask.defaultEnabled = false
					end
					local sdbc = self.db.global

					if sdbc.tooltip.useCounts_onLDB then self:ldb_refreshCounts() end
					if sdbc.useTaskWindow then self:UpdateWindow() end		
				end,
			},
			byUser_taskIs = {
				name = L.byUser_taskIs,
				desc = "",
				type = "select",
				order= 95,
				hidden = function() return not self:getState_GroupEnabledForUser(self.userConfigDisplay, Genealogy) end,
				values = self.optValues.userOverrideEnableDisable,
				get = function()  
					local charStem = self.db.global.charStem[self.userConfigDisplay]
					if charStem.agg[taskID] and charStem.agg[taskID].userOverride then
						return charStem.agg[taskID].userOverride
					else
						return 1
					end
				end,
				set = function(i, v)  
					local charStem = self.db.global.charStem[self.userConfigDisplay]
					if v==1 and charStem.agg[taskID] then charStem.agg[taskID].userOverride = nil -- 1:default / no override
					else
						if not charStem.agg[taskID] then charStem.agg[taskID] = {} end
						charStem.agg[taskID].userOverride = v
					end
	  			if self.db.global.tooltip.useCounts_onLDB then self:ldb_refreshCounts() end  		
	  			if sdbc.useTaskWindow then self:UpdateWindow() end			
				end,
			},
			-- line 3
			taskName = {
		  	name = L.taskName,
		  	desc = "",
		  	type = "input",
		  	width="full",
		  	order = 100,
		  	get = function() return hTask.taskName:gsub("|", "//") end,
		  	set = function(i, v) hTask.taskName = v:gsub("//", "|"); if sdbc.useTaskWindow then self:UpdateWindow() end		end,
			},
			extCreate = {order=105, type="description", hidden = not hTask.extCreate,
				name = function() 
					if self.loadedModules[hTask.extCreate] then
						return ("%s: %s (%s)"):format(
											L.managedByModule_Prefix :cf("EAtan", "white"),
											tostring(hTask.extCreate):cf("cream"),
											(L.optsTable_base.EnableDisable[1]):cf("hard_green", "cream")
										)

					elseif hTask.extCreate and IsAddOnLoaded( hTask.extCreate ) then
						return ("%s: Addon %s (%s)"):format(
											L.managedByModule_Prefix :cf("EAtan", "white"),
											tostring(hTask.extCreate):cf("cream"),
											(L.optsTable_base.EnableDisable[1]):cf("hard_green", "cream")
										)

					else
						return ("%s: %s (%s)"):format(
											L.managedByModule_Prefix :cf("EAtan", "white"),
											tostring(hTask.extCreate):cf("cream"),
											(L.optsTable_base.EnableDisable[2]):cf("hard_red", "cream")
										)
					end
				end, 
			},
			resetType= {
				name = L.resetType_name,
				desc = L.resetType_desc,
				type="select",
				order = 110, 
				disabled = not self.isAvail_taskType[hTask.resetType],
				values = self.isAvail_taskType[hTask.resetType] and self.taskTypes_Index or L.optsTable_missingmodule_table,
				get = function() 
					local resetType = hTask.resetType
					local ResetTypes = self.taskTypes_Index

					if self.isAvail_taskType[resetType] then
						for i=1, #ResetTypes do 
							if ResetTypes[i] == resetType then 
								return i 
							end 
						end
					else
						return 1 --only one option in missingmodule_table:  L.optsTable_missingmodule_label
					end
				end,
				set = function(i, v) 
					hTask.resetType = self.taskTypes_Index[v]

 					hTask.extCreate = self.taskTypes[hTask.resetType].module -- should nil this if an internal is used, so DON'T FUCK WITH EXTERNALS!

					if hTask.resetType==L.Reminder or hTask.resetType==L.CalendarAutomatic then
						self:primeDateBased_TaskTypes(hTask)
					end
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
					self:semiSmart_regrow(Genealogy) 
				end, 
			},		
			
			AcctWide = {
			  name = L.task_AcctWide_name,
			  desc = L.task_AcctWide_desc,
			  type = "toggle",
			  order = 120,
				get = function() return hTask.isAcctWide end,
				set = function(i, v) hTask.isAcctWide = v ; if sdbc.useTaskWindow then self:UpdateWindow() end		end, -- NB: forgoing garbage collection atm...
			},
			-- Calendar and Date Management				
			CalHeader1 = {order=200, type="header", name=L.reminder_LastTrigger, hidden = hTask.resetType ~= L.CalendarAutomatic}, -- [7]
			day_last = {
				hidden = hTask.resetType ~= L.CalendarAutomatic,
				name = L.Day,
				type="select",
				width = "half",
				order = 210,
				values = self.optValues.Days,
				get = function() 
						return date("*t", hTask.resetDate_Last).day
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Last)
					d.day = v
					hTask.resetDate_Last = self:happyMidnight(time(d), true)
					hTask.resetDate_Next = self:happyMidnight(time(d) + (86400 * hTask.offsetDays), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
			month_last = {
				hidden = hTask.resetType ~= L.CalendarAutomatic,
				name = L.Month,
				type="select",
				width = "half",
				order = 220,
				values = self.optValues.Months,
				get = function() 
					return date("*t", hTask.resetDate_Last).month
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Last)
					d.month = v
					hTask.resetDate_Last = self:happyMidnight(time(d), true)
					hTask.resetDate_Next = self:happyMidnight(time(d) + (86400 * hTask.offsetDays), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
			year_last = {
				hidden = hTask.resetType ~= L.CalendarAutomatic,
				name = L.Year,
				type="select",
				width = "half",
				order = 230,
				values = self.optValues.Year,
				get = function()
					local y = tostring(date("*t", hTask.resetDate_Last).year)
					local Year = self.optValues.Year
					for i=1, #Year do if Year[i] == y then return i end end 
					return 
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Last)
					d.year = tonumber(self.optValues.Year[v])
					hTask.resetDate_Last = self:happyMidnight(time(d), true)
					hTask.resetDate_Next = self:happyMidnight(time(d) + (86400 * hTask.offsetDays) , true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},					
			offsetDays = {
				hidden = hTask.resetType ~= L.CalendarAutomatic,
				order=240,
				name = L.reminder_OffsetDays,
				desc = L.reminder_OffsetDays_desc,
				type="range",
				min=1,
				max=365,
				step=1,
				isPercent=false,
				get = function()
						return true and hTask.offsetDays or 1
				end,
				set = function(i, v) 							
					local d = date("*t", hTask.resetDate_Last)
					hTask.offsetDays = v
					hTask.resetDate_Next = self:happyMidnight(time(d) + (86400 * hTask.offsetDays) , true)
				end, 
			},

			CalHeader2 = {order=300, type="header", name=L.reminder_NextTrigger, hidden = (hTask.resetType ~= L.Reminder) and (hTask.resetType ~= L.CalendarAutomatic)}, --[6]
			ReminderIntro = {
				order = 305,
				type = "description",
				hidden = hTask.resetType ~= L.Reminder,						
				fontSize = "medium",
				name = ("'Reminder' Tasks will be hidden until the target date when they will reappear as a Purgable Task"),
			},
			day = {
				name = L.Day,
				type="select",
				hidden = (hTask.resetType ~= L.Reminder) and (hTask.resetType ~= L.CalendarAutomatic),
				disabled = hTask.resetType == L.CalendarAutomatic,
				width = "half",
				order = 310,
				values = self.optValues.Days,
				get = function() 
						return date("*t", hTask.resetDate_Next).day
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Next)
					d.day = v
					hTask.resetDate_Next = self:happyMidnight(time(d), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
			month = {
				name = L.Month,
				type="select",
				width = "half",
				hidden = (hTask.resetType ~= L.Reminder) and (hTask.resetType ~= L.CalendarAutomatic),
				disabled = hTask.resetType == L.CalendarAutomatic,
				order = 320,
				values = self.optValues.Months,
				get = function() 
					return date("*t", hTask.resetDate_Next).month
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Next)
					d.month = v
					hTask.resetDate_Next = self:happyMidnight(time(d), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
			year = {
				name = L.Year,
				type="select",
				hidden = (hTask.resetType ~= L.Reminder) and (hTask.resetType ~= L.CalendarAutomatic),
				disabled = hTask.resetType == L.CalendarAutomatic,
				width = "half",
				order = 330,
				values = self.optValues.Year,
				get = function()
					local y = tostring(date("*t", hTask.resetDate_Next).year)
					local Year = self.optValues.Year
					for i=1, #Year do if Year[i] == y then return i end end 
					return 
				end,
				set = function(i, v) 
					local d = date("*t", hTask.resetDate_Next)
					d.year = tonumber(self.optValues.Year[v])
					hTask.resetDate_Next = self:happyMidnight(time(d), true)
					
					if sdbc.useTaskWindow then self:UpdateWindow() end
				end, 
			},
					
			calGroup = {
				hidden = true,
				type = "group",
				name = "Calendar",
				inline=true,
				order = 500,				
				args = {}
			},
			-- line 4
			hideDays= {
				name = L.task_hideDays_name,
				desc = L.task_hideDays_desc,
				type = "multiselect",
				order = 600,
				values = self.optValues.DaysOfWeek,				
				get = function(info, k) return hTask.hideDays[k] end,
				set = function(info, k, v) hTask.hideDays[k] = v ; if sdbc.useTaskWindow then self:UpdateWindow() end		end,				
			},
		},
	}	

	-- Allow Module Injection
	if hTask.extCreate then -- hTask.extCreate contains MODULE module var
		if self.loadedModules[hTask.extCreate] then
			local module = self:GetModule(hTask.extCreate)
			if module then
				local injControls = module:intern_getInjectedControls(hTask)
				if injControls then for k, v in pairs(injControls) do task_optTable.args[k] = v end end
			end
		end
	end
	
	return task_optTable
end

function ExecAssist:fauxAceConfig_SelectGroup_tableAware(appKey, p)
	-- AceConfigDialog's :SelectGroup doesn't take a table but rather a string of parameters
	-- You can unpack (not table.unpack, not table.explode, just unpack) but you can't unpack and get just 1 sub-element (.id)
	local t = {}
	for n = 1, #p do table.insert(t, p[n].id) end
	self.Dialog:SelectGroup(appKey, unpack(t) )	
end

