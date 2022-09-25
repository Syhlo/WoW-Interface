local function MyAddonCommands(msg, editbox)
  -- pattern matching that skips leading whitespace and whitespace between cmd and args
  -- any whitespace at end of args is retained
  local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
   
  if cmd == "on" then
    
    for i = 1,9999999
	do 
		MuteSoundFile(i)
	end
	UnmuteSoundFile(569807) -- sound/spells/tradeskills/fishcast.ogg
	UnmuteSoundFile(568970) -- sound/spells/fishingbobber_ver2_2.ogg
	UnmuteSoundFile(569044) -- sound/spells/fishingbobber_ver2_3.ogg
	UnmuteSoundFile(569285) -- sound/spells/fishingbobber_ver2_1.ogg
	UnmuteSoundFile(569816) -- sound/spells/tradeskills/fishbite.ogg
    print("All non-fishing sounds are now MUTED.")
    
  elseif cmd == "off" then
    
    for i = 1,9999999
	do 
		UnmuteSoundFile(i)
	end
    print("All sounds are now AUDIBLE")

  
  else

    print("Syntax: /fishinpeace (on|off)");
    print("Once running the ON command, if you are standing by the waterfall in Zereth Mortis (or hear other looping sounds that are already playing), you will need to run away until it is completely silent and then return. In addition, you will still hear other player's cast and bobber sounds. There is nothing that I know of that can be done to stop that as the sound files are the same as your own.")
  end
end

SLASH_FIP1, SLASH_FIP2 = '/fip', '/fishinpeace'
SlashCmdList["FIP"] = MyAddonCommands