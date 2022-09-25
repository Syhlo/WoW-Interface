-- http://www.silverdaggers.net/modFiles/ExecAssist_1.0.3_Alpha_25Aug16.zip

-- ------------------------------------------------------------------------- --
-- Project: Executive Assistant - File Cabinet
-- Author:  VincentSDSH				
-- Version: 1.0 - w7.0.0
-- ------------------------------------------------------------------------- --
local AddonName = ...

FileCabinet = LibStub("AceAddon-3.0"):NewAddon(AddonName, "AceEvent-3.0", "AceTimer-3.0")
FileCabinet.wowVer = "9.0"
FileCabinet.debug = function(data, booleanResponse, colorize) if ExecAssist.db.sv.debug then local r, b, g if not colorize then r=1; g=1; b=.8 elseif (booleanResponse and data) then r=0; g=1; b=0 else r=1; g=0; b=0 end; local eaColon = ("::"):cf("EAblue"); DEFAULT_CHAT_FRAME:AddMessage( eaColon..("EA_debug"):cf("EAtan")..eaColon .." ".. (booleanResponse and (booleanResponse.." is: ") or "").. tostring(data), r, g, b); end end
local debug = FileCabinet.debug
local L = LibStub("AceLocale-3.0"):GetLocale(AddonName)
local LSM     = LibStub("LibSharedMedia-3.0")
local LibQTip = LibStub("LibQTip-1.0moddedForExecAssist")
local FILECABINETTOOLTIP = "FileCabinet_Tooltip"

function FileCabinet:OnInitialize()
  -- Defaults -------------------------------------------------------------- --
  self.icons = {
    ["defaultLDBIcon"]  = ([[Interface\Addons\%s\icons\appIcon]]):format(AddonName),
  } 

  -- Setup AceDB
	self.DBDefaults = {
		["char"] = {
    	["DBIconTable"] = { ["hide"] = false },
		},
    ["global"] = {
				["cabinet"] = {
				},
				["tooltip"] = {
				["standard_font"] = "Friz Quadrata TT",
				["standard_size"] = 10,
				["header_font"] = "Friz Quadrata TT",
				["header_size"] = 12,
  
				["color_Group"]      = {["r"] = 0.78, ["g"] = 0.61, ["b"] = 0.43},
				["color_TaskName"]   = {["r"] = 1,    ["g"] = 1,    ["b"] = 1   },
				["color_taskCounts"] = {["r"] = 0.43, ["g"] = 0.61, ["b"] = 0.78},

			},
    },
  }
  self.db = LibStub("AceDB-3.0"):New("FileCabinetDB", self.DBDefaults, true)

	if FileCabinet_IMPORT and FileCabinet_IMPORT.name then
		local cab = self.db.global.cabinet
		local stamp = time()
		self.db.global.cabinet[stamp] = {
			["id"]   = FileCabinet_IMPORT.id,
			["name"] = FileCabinet_IMPORT.name,
			["stem"] = FileCabinet_IMPORT.groupStem,
		}
		FileCabinet_IMPORT = {}
		self:alert("Imported Settings for [".. self.db.global.cabinet[stamp].name .."]")
	end

	debug(("* %s Debugging Mode Active *"):format(AddonName)) -- dev sanity check

	-- config
	local sdbc = self.db.char
	local	mainOpts = {
		--hdr = {order=0, type="header", name="<header name>"}, 
		type = "group",
		name = L.appName,
		args = {
			intro = {
				order = 1,
				type = "description",
				fontSize = "medium",
				name = (L.mainOpts_intro):cf("cream"):format(L.appName:cf("EAtan", "cream"), L.appNameC:cf("EAtan", "cream")),
			},
			introspacer = { -- really needs to be a better way to do this...
				order = 2,
				type = "description",
				name = "  "
			},
			verionData = {
				order = 3,
				type = "description",
				fontSize = "medium",
				name = ((L.versionData):cf("cream")):format(
					GetAddOnMetadata(AddonName, 'Version'):cf("grass", "cream"),
					self.wowVer:cf("grass")
				 ),
			},
			spacer2 = { -- really needs to be a better way to do this...
				order = 4,
				type = "description",
				name = "  "
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
						
				},
			},
		},
	}	
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(AddonName, mainOpts)	
	self.opts = {["Grip"] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(AddonName, L.appName)}
	
  -- libDataBroker and DBIcon ---------------------------------------------- --
  self.meatPopcicle = self:ldb_ObjectCreate()
  LibStub("LibDBIcon-1.0"):Register(AddonName, self.meatPopcicle, self.db.char.DBIconTable) 
end

function FileCabinet:OnEnable()

end

	-- local libQtip funcs 
local function addSeparator(tooltip)    return tooltip:AddSeparator(2, .1, .9, .9, .9) end
local function addHSeparator(tooltip)   return tooltip:AddSeparator(2,  1,  1,  0, .9) end
local function rct(O)
	-- Recursive table copy, handles metatables and avoids __pairs metamethod
	local O_type = type(O)
	local C
	if O_type == 'table' then
	    C = {}
	    for O_key, O_value in next, O, nil do C[rct(O_key)] = rct(O_value) end
	    setmetatable(C, rct(getmetatable(O)))
	else  -- numbers, strings, small dancing frogs named Hector, booleans, etc, etc
	    C = O
	end
	return C
end

function FileCabinet:ExportGroup(hGroup)	
	local agg = ExecAssist.db.global.groupStem.agg
	local function exportSream(hItem)
		local stem = FileCabinet_EXPORT.groupStem
		stem[hItem.id] = {}
		for k, v in pairs(hItem) do
			stem[hItem.id][k] = v
		end
		
		if hItem.DO then -- isGroup w/ chillens
			for n=1,#hItem.DO do
				local _hItem = agg[hItem.DO[n]]
				if _hItem then exportSream(_hItem) end
			end
		end		
	end

	FileCabinet_EXPORT = {
		["name"] = hGroup.exportName,	
		["id"] = hGroup.id, 
		["groupStem"] = {}
	}
	hGroup.exportName = nil -- no need to retain it
	exportSream(hGroup)

-- TESTING
	FileCabinet_IMPORT = {}
	for k, v in pairs(FileCabinet_EXPORT) do FileCabinet_IMPORT[k] = v end
-- TESTING	

	ReloadUI()
end


function FileCabinet:ExportGroup_SAFECOPY(hGroup)	
	local agg = ExecAssist.db.global.groupStem.agg
	local function exportSream(hItem)
		local stem = self.export.global.groupStem
		stem[hItem.id] = {}
		for k, v in pairs(hItem) do
			stem[hItem.id][k] = v
		end
		
		if hItem.DO then -- isGroup w/ chillens
			for n=1,#hItem.DO do
				local _hItem = agg[hItem.DO[n]]
				if _hItem then exportSream(_hItem) end
			end
		end		
	end

FileCabinet_EXPORT = { ["global"] = {["name"] = nil,	["id"] = nil, ["groupStem"] = {} }}


	self.export.global.name = hGroup.exportName
	hGroup.exportName = nil -- no need to retain it
	self.export.global.id = hGroup.id
	self.export.global.groupStem = {}
	exportSream(hGroup)



-- TESTING	
	for k, v in pairs(self.export.global) do self.import.global[k] = v end
-- TESTING	

	ReloadUI()
end

	-- tooltip driver
function FileCabinet:displayTooltip(anchorFrame)
	local groupStem, charStem, tooltipStem = ExecAssist.db.global.groupStem, ExecAssist.db.global.charStem, ExecAssist.db.global.tooltip
	local tooltip = FileCabinet.tooltip
	local row
	if not LibQTip:IsAcquired(FILECABINETTOOLTIP) or not tooltip then -- Build Tooltip Base --
		FileCabinet.tooltip  = LibQTip:Acquire(FILECABINETTOOLTIP)
		FileCabinet.tooltip.OnRelease = function() FileCabinet.tooltip = nil; FileCabinet.h_meatPopcicle = nil end  -- bit of cleanup
		tooltip = FileCabinet.tooltip			
	
		tooltip:Clear()
		tooltip:SetCellMarginH(0)
		tooltip:SetCellMarginV(0)
		tooltip:EnableMouse(true)
			
		local hf, sf = CreateFont("headerFont"), CreateFont("standardFont")  		
		hf:SetFont(LSM:Fetch("font", tooltipStem.header_font), tooltipStem.header_size, "")     --			hf:SetFont(LSM:Fetch("font", "Friz Quadrata TT"), 12, "") 
		sf:SetFont(LSM:Fetch("font", tooltipStem.standard_font), tooltipStem.standard_size, "") --			sf:SetFont(LSM:Fetch("font", "Friz Quadrata TT"), 10, "") 
		tooltip:SetHeaderFont(hf)
		tooltip:SetFont(sf)
		
		tooltip.specialSnowflake_font = CreateFont("specialSnowflake_font")
		tooltip.specialSnowflake_font:SetFont(LSM:Fetch("font", tooltipStem.snowflake_font), tooltipStem.snowflake_size, "")
		
		tooltip:SetScale(1)
		if not tooltipStem.useMouseoverHighlight then tooltip:SetHighlightTexture(nil) end
	 	ExecAssist:mixinCheck_GameTooltipBackdrop()
	 	tooltip:SetBackdropColor(0, 0, 0, 1) 
		tooltip:SetAutoHideDelay(.25, anchorFrame	)	
	end
	tooltip:Clear()

	-- -------------------------------------------------------------------------------------------------------------- --
	local maxCols = 4
	tooltip:SetColumnLayout(maxCols)

	local function tooltiptip_OnLeave()	FileCabinet.tooltipQ:Release("FileCabinet_Tooltip"); FileCabinet.tooltipQ=nil end
	local function tooltiptip_OnEnter(tbl) -- Proof of Concept...may need to be refactored
		local args = tbl._OnEnter_arg
		if not FileCabinet.tooltipQ then 
			FileCabinet.tooltipQ = LibQTip:Acquire("FileCabinetTooltip_Tooltip")
		end
		tooltip = FileCabinet.tooltipQ			
		tooltip:Clear()
		tooltip:SetCellMarginH(0); tooltip:SetCellMarginV(0)		
		local tf = CreateFont("tiptipFont"); tf:SetFont(LSM:Fetch("font", tooltipStem.header_font), tooltipStem.header_size, ""); tooltip:SetFont(tf)
	
		tooltip:SetScale(1)
		ExecAssist:mixinCheck_GameTooltipBackdrop()
		tooltip:SetBackdropColor(0, 0, 0, 1) 
		tooltip:SetAutoHideDelay(.25, FileCabinet.tooltip	)	
		tooltip:SmartAnchorTo(FileCabinet.tooltip)   
	
		tooltip:SetColumnLayout(1)
		tooltip:AddLine()
		
		local p = { 
			["Backup"]  = L.eafc_tooltipTip_Backup:format( L.appNameC:cf("EAtan")),
			["Restore"] = L.eafc_tooltipTip_Restore:format( L.appNameC:cf("EAtan")),
			["Update"]  = L.eafc_tooltipTip_Update:format( L.appNameC:cf("EAtan")),
			["Delete"]  = L.eafc_tooltipTip_Delete,
		}
	
		tooltip:SetCell(1, 1,p[args.b])
	 	tooltip:UpdateScrolling()	
		tooltip:Show()
				
	end

	local function displayTooltipButtons() -- Tooltip Button local func
		--==[ Last Row ]==-- -------------------------------------------------------------------------------------------- --
		row = tooltip:AddHeader()
		-- List Display Type	
		local function ClonousGroupStemousandCharStemous(tbl) 
			local cab = self.db.global.cabinet
			local stamp = time()

			cab[stamp] = {
				["groupStem"] = rct(groupStem),
				["charStem"]  = rct(charStem),
			}		
			PlaySound(SOUNDKIT.IG_QUEST_LIST_OPEN); self:displayTooltip(tbl._OnMouseUp_arg.anchorFrame) 
		end
		
		tooltip:SetCell(row, 1, L.MakeNewBackup:cf("cream"):format( ExecAssist:mkLink(self.icons.defaultLDBIcon, 16), L.appNameC:cf("EAtan", "cream")), nil, "CENTER", maxCols)
		tooltip:SetLineScript(row, "OnMouseUp", ClonousGroupStemousandCharStemous, {["anchorFrame"] = anchorFrame}) 	
		tooltip:SetLineScript(row, "OnEnter", tooltiptip_OnEnter, {["b"] = "Backup"})
		tooltip:SetLineScript(row, "OnLeave", tooltiptip_OnLeave)	
	end

	if tooltipStem.tooltipButtonPos == 1 then displayTooltipButtons(); addHSeparator(tooltip) end	

	local cab = self.db.global.cabinet -- [ cabinet loop ] -----------------------------------------------------
	for timeStamp, archive in pairs(cab) do
		row = tooltip:AddHeader()
		
		local function nukeemtilltheyglow(tbl)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) 
			local args = tbl._OnMouseUp_arg
			local sdbg = ExecAssist.db.global
			local cab = self.db.global.cabinet
			local groupStem = self.db.global.groupStem
			
			if cab[args.stem].name then -- Importing
				local agg = sdbg.groupStem.agg
				local stub = cab[args.stem]
				local hGroup, hTask, hItem
					
				local function buildTree(hItem, hParent)
					if hItem.isTask then
						hTask = ExecAssist:AddTask(hParent, nil, true)
						hTask.hideDays = hItem.hideDays
						hTask.resetType = hItem.resetType
						hTask.isAcctWide = hItem.isAcctWide
						hTask.defaultEnabled = hItem.defaultEnabled
						hTask.taskName = hItem.taskName			
debug("item")				
					elseif hItem.isGroup then
debug("group")
						hGroup = agg[ ExecAssist:AddGroup(hItem.listName, hParent, true) ]
						hGroup.hideDays = hItem.hideDays
						hGroup.defaultEnabled = hItem.defaultEnabled

						if hItem.DO then
							for n=1,#hItem.DO do
								buildTree(stub.stem[ hItem.DO[n] ], hGroup)
							end
						end

					else 
						return
					end
				
				end


				
				hGroup = stub.stem[ stub.id ]

				buildTree(hGroup, nil) -- form in Garden











				self:alert( (L.ImportComplete):format( stub.name:cf("EAtan") , date("%Y-%m-%d %H:%M:%S", args.stem):cf("cream") ) )
			else -- Full Restore
				sdbg.groupStem = nil
				sdbg.charStem = nil
				sdbg["groupStem"] = rct(cab[args.stem].groupStem)
				sdbg["charStem"]  = rct(cab[args.stem].charStem) 

				self:alert( (L.RestoreComplete):format( date("%Y-%m-%d %H:%M:%S", args.stem):cf("EAtan") ) )
			end
			
			-- If the loaded profile does not contain the current user then establish agglomeration	for them (or all hell breaks loose)
			if not ExecAssist.db.global.charStem[ExecAssist.userCurrent] then 
				ExecAssist.db.global.charStem[ExecAssist.userCurrent] = {["agg"] = {}} 
				ExecAssist.db.global.charStem[ExecAssist.userCurrent].charClass = select(2, UnitClass("player"))
			end
			
			ExecAssist:loadGroups_toOptionsTable()
			if ExecAssist.db.char.useTaskWindow then ExecAssist:UpdateWindow() end
		end
		tooltip:SetCell(				 row, 1, archive.name and L.eafc_Import or L.eafc_Restore, nil, "CENTER")
		tooltip:SetCellScript(	 row, 1, "OnMouseUp", nukeemtilltheyglow, {["stem"] = timeStamp, ["anchorFrame"] = anchorFrame}) 	
		tooltip:SetCellScript(	 row, 1, "OnEnter", tooltiptip_OnEnter, {["b"] = "Restore"})
		tooltip:SetCellScript(	 row, 1, "OnLeave", tooltiptip_OnLeave)	
		tooltip:SetCellTextColor(row, 1, tooltipStem.color_Group.r, tooltipStem.color_Group.g, tooltipStem.color_Group.b, 1)
		
		local function deadpuppiesarentmuchfun(tbl)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			self.db.global.cabinet[tbl._OnMouseUp_arg.stem] = nil
			self:alert( (L.Deleted):format( date("%Y-%m-%d %H:%M:%S", tbl._OnMouseUp_arg.stem):cf("EAtan") ) )			
			self:displayTooltip(tbl._OnMouseUp_arg.anchorFrame)
		end		
		tooltip:SetCell(				 row, 2, L.eafc_Delete, nil, "CENTER")
		tooltip:SetCellScript(	 row, 2, "OnMouseUp", deadpuppiesarentmuchfun, {["stem"] = timeStamp, ["anchorFrame"] = anchorFrame}) 	
		tooltip:SetCellScript(	 row, 2, "OnEnter", tooltiptip_OnEnter, {["b"] = "Delete"})
		tooltip:SetCellScript(	 row, 2, "OnLeave", tooltiptip_OnLeave)	
		tooltip:SetCellTextColor(row, 2, tooltipStem.color_Group.b, tooltipStem.color_Group.g, tooltipStem.color_Group.r, 1)

		tooltip:SetCell(row, 3, archive.name and (archive.name.." - "..date("%Y-%m-%d %H:%M:%S", timeStamp)) or "Backup - "..date("%Y-%m-%d %H:%M:%S", timeStamp), nil, "CENTER", 2)
		tooltip:SetCellTextColor(row, 3, tooltipStem.color_TaskName.r, tooltipStem.color_TaskName.g, tooltipStem.color_TaskName.b, 1)

	
	end -- -----------------------------------------------------------------------------------------------------

	if tooltipStem.tooltipButtonPos == 2 then addHSeparator(tooltip); displayTooltipButtons() end

	tooltip:SmartAnchorTo(anchorFrame)   -- Use smart anchoring code to anchor the tooltip to our frame   
 	tooltip:UpdateScrolling()
 	tooltip:Show()
end


 -- libDataBroker create func
function FileCabinet:ldb_ObjectCreate()
	return LibStub("LibDataBroker-1.1"):NewDataObject(AddonName, {
		type = 'data source',
		label = L.appName, 
		text = L.appNameC, 	
		icon = self.icons.defaultLDBIcon,
			-- can have EITHER OnTooltipShow OR OnEnter, not both --> OnTooltipShow = function(tooltip) end				

		OnEnter = function(self) FileCabinet:displayTooltip(self) end, -- self in this context is the ldbObject		
    -- OnLeave = function(self) end,
				
		OnClick = function(self, button) InterfaceOptionsFrame_OpenToCategory(FileCabinet.opts.Grip)  end,
	})
end

function FileCabinet:alert(msg, r, g, b)
	DEFAULT_CHAT_FRAME:AddMessage( (L.appName):cf("EAtan")..(": "):cf("EAblue")..tostring(msg), r or 1, g or 1, b or .8);
end
