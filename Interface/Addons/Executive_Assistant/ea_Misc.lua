-- ------------------------------------------------------------------------- --
-- Project: Executive Assistant - To-Do/Task List Manager
-- Author:  VincentSDSH				
-- ------------------------------------------------------------------------- --
local AddonName = ...
local debug = ExecAssist.debug
local L = LibStub('AceLocale-3.0'):GetLocale(AddonName)

	-- makes text hyperlinks for graphics to be used inline
function ExecAssist:mkLink(path, size) return ("\124T"..path..":%d:%d:1:0\124t"):format(size, size) end

	-- alert
function ExecAssist:alert(msg, r, g, b)
	DEFAULT_CHAT_FRAME:AddMessage( (L.appName):cf("EAtan")..(": "):cf("EAblue")..tostring(msg), r or 1, g or 1, b or .8);
end
	-- crayons (defined colors)
local Crayons = {
	["stop"] = "|r",
	["white"] = "FFFFFF",
	["black"] = "000000",
	["EAtan"] = "ff9966",  -- orange
	["EAblue"] = "6699ff", -- unoraange
	["sunshine"] = "ffff00",
	["afternoon"] = "dddd00",   
	["lightgray"] = "cccccc",
	["fuglyYellow"] = "FEDF0B",
	["dullRed"] = "aa0000",
	
	["hard_red"] = "ff0000",
	["hard_blue"] = "0000ff",
	["hard_green"] = "00ff00",
	
	["defaultStyleMgr_acctwide"] 			= "00efef", --  0,    0.94, 0.94),
	["defaultStyleMgr_purgable"] 			= "ff007f", --  1,    0,    0.5),
	["defaultStyleMgr_hidden"]   			= "ba9bc6", --  0.73, 0.61, 0.78),
	["defaultStyleMgr_cmdLineTarget"] = "548984", --  0.33, 0.54, 0.52),
	["defaultStyleMgr_snowflake"] 		= "ff7c66", --  1,    0.49, 0.4),
	
  -- whites
	["cream"] = "deb887",
  -- purples
 	["lilac"]  = "d1c4e7",
 	["purple"] = "8b87de",
  -- greens
 	["grass"] = "aede87",
	-- blues
 	["sky"]  = "87afde",
 	["cyan"] = "87d8de",
 	["attn"] = "ff0088",
 	["acyan"] = "00dddd",
 	["bcyan"] = "dd00dd",
 	["colorizeExample"] = "ff6699",
}
	-- converts 
local function dec2hex(dec) return string.format("%02x", dec) end
function ExecAssist:pcColorToHex(r, g, b) return dec2hex(r*255)..dec2hex(g*255)..dec2hex(b*255) end
function ExecAssist:tbl_pcColorToHex(tbl) return dec2hex(tbl.r*255)..dec2hex(tbl.g*255)..dec2hex(tbl.b*255) end
local function hex2pc(crayon)
	local rx, gx, bx = crayon:sub(1,2), crayon:sub(3,4), crayon:sub(5, 6)
	return tonumber(rx, 16) / tonumber("ff", 16), tonumber(gx, 16) / tonumber("ff", 16), tonumber(bx, 16) / tonumber("ff", 16)
end
function ExecAssist:Marker(crayon) -- :tbl_hex2pc(crayon)
	local r, g, b = hex2pc(Crayons[crayon])
	return {["r"] = r, ["g"] = g, ["b"] = b}
end 

	-- safeFunctions
function ExecAssist:mixinCheck_GameTooltipBackdrop()
	-- Since the backdrop was removed from GTT, do a check for the GetBackdrop() function to see if the mixin is needed before returning the GTT
	if not GameTooltip.GetBackdrop then 
		debug("mixin-ed GTT")
		Mixin(GameTooltip, BackdropTemplateMixin) 
	end
end

	-- plumbing functions
function ExecAssist:rCopyTable(O)
	-- Recursive table copy, handles metatables and avoids __pairs metamethod
    local O_type = type(O)
    local C
    if O_type == 'table' then
        C = {}
        for O_key, O_value in next, O, nil do
            C[ExecAssist:rCopyTable(O_key)] = ExecAssist:rCopyTable(O_value)
        end
        setmetatable(C, ExecAssist:rCopyTable(getmetatable(O)))
    else  -- numbers, strings, small dancing frogs named Hector, booleans, etc, etc
        C = O
    end
    return C
end

function ExecAssist:extendStringFunc()
	-- Extending the string class in this way (adding functions to the string metatable)... Lua 5.2 Reference Manual: 
	-- "You can replace the metatable of tables using the setmetatable function. You cannot change the metatable of other types from Lua"
	-- One may make a table of the string metatable and extend /that/ but not replace the metatable on a string itself; it'd be safer in
	-- this implementation but it is what it is and the data aren't in tables. :trim() should be universal and :rpad() might maaaybe
	-- have a conflict but the others (isTask, isGroup, cf (color formatter), cfc (color formatter constrained) ) should be unique
	-- enough to avoid conflict. *wince*

--	string.trim = function(str) return (str:gsub("^%s*(.-)%s*$", "%1")) end 
	string.isGroup = function(data) if data and #data>0 then return (data:sub(1,1) == "g") and true or false else return false end end
	string.isTask  = function(data) if data and #data>0 then return (data:sub(1,1) == "t") and true or false else return false end end

	-- color formatter
	string.cf = function(data, startColor, endColor) return ("%s%s%s"):format("|cff"..Crayons[startColor], tostring(data), endcolor==false and "|r" or ((endColor and ("|cff"..Crayons[endColor])) or "|r")) end
	-- color formatter curtailed
	string.cfc = function(data, Color) return ("%s%s%s"):format("|cff"..Color, tostring(data), "|r") end -- only used for start/stop not start-continue colors

	string.rpad = function(str, len, chr) if not chr then chr = " " end return str..string.rep(chr, len-#str) end
	--[[ Removing Unused Extenders -------------------- --
	-- string.lpad = function(str, len, chr) if not chr then chr = " " end return string.rep(chr, len-#str)..str end
	-- string.whatIs = function(data) 	if data and #data>0 then return data:sub(1,1) else return false end end
	--]] -------------------- Removing Unused Extenders --
end

	-- event handling
function ExecAssist:Register(E, F)
	if (not self.EventsRegistered[E]) then
		self.EventsRegistered[E] = true
		self:RegisterEvent(E, F)
	end
end
function ExecAssist:Unregister(E)
	if (self.EventsRegistered[E]) then
  	self.EventsRegistered[E] = false
    self:UnregisterEvent(E)
  end
end

