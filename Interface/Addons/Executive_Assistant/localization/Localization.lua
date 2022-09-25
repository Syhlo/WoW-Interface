-- ------------------------------------------------------------------------- --
-- Project: Executive Assistant - To-Do/Task List Manager
-- Author:  VincentSDSH				
-- Localization.Lua for English
-- ------------------------------------------------------------------------- --
local AddonName = ...
local L = LibStub('AceLocale-3.0'):NewLocale(AddonName, 'enUS', true)

L.appName = 'Executive Assistant'
L.StatusField_appName = 'Executive Assistant'
L.appName_short = 'EA'
L.authorName = 'VincentSDSH'
L.statusText = '%s (v%s) by %s  %s: %s'
-- ExecAssist version by VincentSDSH Page: / Module: 

L.optsTable_missingmodule_label = "Missing Module"
L.optsTable_missingmodule_table = {"Missing Module"}
L.optsTable_missingmodule = {
				name   = "Missing Module",
				letter = "-",
				color  = {
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
					["a"] = 1,
				}
			}


L.NPC_openTag = "NPC ["
L.NPC_closingTag_Created = "] Created"
L.NPC_closingTag_Exists = "] Already Exists"
L.NPC_NoNameEntered = "No NPC Name Entered"
L.NPC_StyleNPC_name = "Style NPC"
L.NPC_npcColor_name = "'Class' Color for NPC"
L.NPC_npcColor_desc = "Faux 'Class Color' for NPCs. See 'NPC' Help section for more information."
L.NPC_help_Label = "NPC Feature"
L.NPC_help_Label_hdr = "Non Player Characters (NPC)"
L.NPC_help_Body = "Executive Assistant is built around character-tasks; however, Power-Users sometimes find it advantageous to have tasks assigned to another 'character' for various reasons (categorization, decluttering, or tracking needs beyond that of a general user).\n\n"..
"NPC 'names' can be anything (e.g., 'Housekeeping', 'Non-WoW', 'MyNewChar - Wormrest Accord', etc) that you like. If they conform to a valid 'CharacterName - ServerName' format, a created matching character would use that configuration.\n\n"..
"NPC 'Class Color' can be found under 'LDB Tooltip Options' -> 'Style NPC' -> 'NPC Color'\n\n"..
"Command Line: '/ea npc anything you want as a label ' creates an entry labeled 'anything you want as a label'"

L.DailyAutomatic = "Daily Automatic"
L.WeeklyAutomatic = "Weekly Automatic"
L.Manual = "Manual"
L.CalendarAutomatic = "Calendar Automatic"
L.Purgable = "Purgable"
L.Reminder = "Reminder"
L.AtEachLogin = "At Each Login"

L.optsTable_base = { -- NOTE: DO NOT TRANSLATE THE KEYS ONLY THE TABLES
  	["DaysOfWeek"] 		 	 = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"},
		["TaskTypes_stublist"] = { "Daily Automatic", "Weekly Automatic", "Purgable", "Manual", "Reminder", "At Each Login", "Calendar Automatic" }, -- so there's some consistency in default types
		["TaskTypes"] = {
			["Daily Automatic"] = {
				name   = "Daily Automatic",
				letter = "D",
				color  = {
					["b"] = 0.529411764705882,
					["g"] = 0.72156862745098,
					["r"] = 0.870588235294118,
					["a"] = 1,
				}
			},		
			["Weekly Automatic"] = {
				name   = "Weekly Automatic",
				letter = "W",
				color  = {
					["b"] = 0.529411764705882,
					["g"] = 0.870588235294118,
					["r"] = 0.682352941176471,
					["a"] = 1,
				}
			},
			["Manual"] = {
				name   = "Manual",
				letter = "M",
				color  = {
					["b"] = 0.870588235294118,
					["g"] = 0.686274509803922,
					["r"] = 0.529411764705882,
					["a"] = 1,
				}
			},
			["Calendar Automatic"] = {
				name   = "Calendar Automatic",
				letter = "C",
				color  = {
					["b"] = 0.8,
					["g"] = 0.8,
					["r"] = 0.8,
					["a"] = 1,
				}
			},
			["Purgable"] = {
				name   = "Purgable",
				letter = "P",
				color  = {
					["b"] = 0.870588235294118,
					["g"] = 0.529411764705882,
					["r"] = 0.545098039215686,
					["a"] = 1,
				}
			},
			["Reminder"] = {
				name   = "Reminder",
				letter = "R",
				color  = {
					["b"] = 0,
					["g"] = 0.866666666666667,
					["r"] = 0.866666666666667,
					["a"] = 1,
				}
			},
			["At Each Login"] = {
				name   = "At Each Login",
				letter = "L",
				color  = {
					["b"] = 0,
					["g"] = 0,
					["r"] = 0.666666666666667,
					["a"] = 1,
				}
			},
		},

  	["relativePoints"] 	 = {"CENTER", "LEFT", "RIGHT", "TOP", "BOTTOM", "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT"},
  	["mouseclickTypes"]	 = {"-stop using-", "LeftMouse", "RightMouse"},
  	["ldbIcons_SET"]   	 = {"defaultLDBIcon", "enabled", "used"},
		["counts_DispTypes"] ={"Completed / Total", "Completed / Not Completed", "Not Completed", "Percent"},
		["tooltipButtonPos"] = {"Top", "Bottom"},
  	["EnableDisable"]    = {"Enabled", "Disabled"},
		["userOverrideEnableDisable"] = {"-Default-", "Enabled", "Disabled"},
		["SM_useText"] = {"Do Not Use", "Left", "Right", "Left and Right"},
		["SM_useColor"] = {"Do Not Use", "Only 'Use Text' Text", "Cell/Button Text", "Cell/Button Background", "Line/Button Background"},
		["Months"] = {"January", "Feburary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"},
		["Days"] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}, -- won't Feb 31 be just -awesome-? 2/31=3/3
		["Year"] = {"2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030"}, -- it's this or another ugly slider control...
  }

L.BrandNewUserTask_0 = "Click Me to Complete your First Task"
L.BrandNewUserTask_1 = "Left-Click on the DataBroker Object or Minimap Icon"
L.BrandNewUserTask_2 = "Enjoy the New User Message"
L.BrandNewUserTask_3 = "Scroll Down to the Automatic Resets control group"
L.BrandNewUserTask_4 = "Set Daily Reset Hour"
L.BrandNewUserTask_5 = "Set Weekly Reset Day"
L.BrandNewUserTask_6 = "Click on the Help and Information Tab"
L.BrandNewUserTask_7 = "Enter your own Group"
L.BrandNewUserTask_8 = "Enter your own Tasks"
L.BrandNewUserTask_9 = "Set the 'Task Window Grow-From/Anchor Point' ('Task Window Options' -> 'Window Positioning')"
L.BrandNewUserTask_10 = "Lock Task Window position to Remove the Border"
L.BrandNewUserTask_11 = "When Ready, Delete this Group"
L.NewUserTasks = "New User Tasks"

L.AutoHideDelay_name = "Tooltip AutoHide Delay"
L.AutoHideDelay_desc = "Time Delay (in seconds) for the tooltip display to hide when the mouse is not over it."..
											 "\n\nCollapsing sections with long task names can cause the tooltip to shrink such that the mouse is no longer over the tooltip and the tooltip will hide. This control lets you lengthen the time before the tooltip hides so that you can place your mouse over it again and prevent it autohiding."

L.optsTable_GroupDisplayModes_1 = "Show 'Visible' Groups"
L.optsTable_GroupDisplayModes_2 = "Show All Groups"
L.optsTable_GroupDisplayModes_3 = "Display Zoom Group"
L.optsTable_GroupDisplayModes_4 = "Hide Group Names"

L.optsTable_ldbIcons_GET_1 = "Green on Black Background"
L.optsTable_ldbIcons_GET_2 = "Green on Transparent Background"
L.optsTable_ldbIcons_GET_3 = "Yellow on Transparent Background"

L.optsTable_tooltipDisplay_1 = "Tasks categorized by Characters"
L.optsTable_tooltipDisplay_2 = "Characters categorized by Task"

L.alert_cannotToggleTask = "Task completion toggles only apply to the logged-in character. If you are certain you wish to toggle a Task for another character, hold the SHIFT key down while clicking."

L.widthMethod_name = "Width Constraint"
L.widthMethod_desc = "None: Window will resize to the width of the largest Group Name or Task Name\n\n"..
"Max Width: Sets a maximum width but the Task Window may resize smaller depending on the largest Group Name or Task Name\n\n"..
"Fixed Width: The Task Window will not resize.\n\n"..
"Task and Group Names that exceed the Max or Fixed Width will truncate with an ellipsis (...)"
L.widthMethod_values = {"None", "Max Width", "Fixed Width"}

L.twFixedWidth_name = "Task Window Size"
L.twFixedWidth_desc = "Specifies a size for the Task Window Group and Task Names with Width Constraint is not None."

L.mainOpts_intro = "%s is a flexible task tracker with manual and automatic task resets, multiple organization techniques and display platforms, and modular extensibility. For additional flexibility, a library (%s) is available for 3rd-party addons.\n\n"..
"Modules (known as %s) are able to bring additional features that are outside the scope of %s. The %s are able to inject Help, Configuration Panels, Click Map mappings, per-task Custom Controls, and click-handlers -- not all %s need each of these features but all will provide a Help Panel when enabled via the WoW Addons Panel.\n\nCommand Line Options: %s or %s"

L.versionData = "Addon version %s updated to WoW version %s by %s"
L.Interns_intro = "Interns"
L.Modules_intro = "modules"
L.libExecAssist = "LibExecAssist-1.0"

L.HelpAndInformation = "Help and Information"
L.FirstTimeUser = "First Time User, welcome to %s\n\nIt's recommended that you begin with the %s section of the %s. It will give you a brief intro into getting your first tasks ready for completion.\n\nWhile quite usable with the default settings, %s offers a number of options to help you use it efficiently but with many options comes the opportunity for confusion. The %s tab seeks to describe each icon and option in detail with occasional tips on best use.\n\nIf you're the intrepid adventurer type, you can shimmy on over to the %s to see what happens when you click on the %s icon and make any changes you may care to.\n\nAdditionally, a button has been provided (below) to remove this message when you're ready."


L.HideMapIcon = "Hide Minimap Icon"
L.ldbIcon_Name = "Select DataBroker / MiniMap Button Icon"
L.ldbIcon_desc = "Change the icon to one you prefer"

L.AutoReset_Name_1 = "Tasks flagged for Automatic Resets will be marked 'Not Completed' %s the specified time." 
L.AutoReset_Name_2 = "near but not precisely at"

L.LocalDailyResetTime = "Local Daily Reset Time"
L.WeeklyResetDay = "Weekly Reset Day"
L.LocalDailyResetDesc = "As experienced in your Local Time Zone (not the server's time zone)."

L.TooltipIntro = "See %s for for Fonts, Colors, and Special-Type Highlighting"

L.tooltipButtonLocation_name = "Place Tooltip Buttons at the..."
L.tooltipButtonLocation_desc = "Positions the Tooltip Type, Group Display, Zoom Group, and Character Display buttons. Position them as best suits your UI orientation or preference."

L.enableTooltipTips_name = "Enable Tooltip Button Tooltips"
L.enableTooltipTips_desc = "Displays information about the Tooltip Buttons"

L.defaultCollapse_name = "Collapse Tooltip Groups"
L.defaultCollapse_desc = "Forces Tooltip Group Categories closed of enabled; if disabled, Group Categories will default Expanded"

L.default_tooltipType_name = "Initial Display Type"
L.default_tooltipType_desc = "Denotes the initial tooltip type on load.\n\nTasks Categorized by Character: Character -> Groups -> Tasks (check-marks)\n\nCharacters Categorized by Task: Group -> Task -> Characters (check-marks)"

L.groupDisplayButton_intro = "The Group Display Modes Button will cycle through the selected Display Modes (Left-Mouse to go Foward, Right-Mouse to go Backward) in the order in which they appear below. Uncheck the ones you don't use; if all are unchecked, the Default will be the only available Mode.\n\nNote: the Default will be used even if not selected as part of the switching choices or if no switching selections are chosen.\n"

L.groupDisplayButton_name_TaskByChar = "Task Categorized by Character: Select Modes to Cycle Through"
L.groupDisplayButton_name_CharByTask = "Character Categorized by Task: Select Modes to Cycle Through"

L.groupDisplayButton_name_TaskByChar_h = "Task Categorized by Character"
L.groupDisplayButton_name_CharByTask_h = "Character Categorized by Task"
L.GroupDisplayModes = "Group Display Modes"
L.defaultGroupDisplay_name = "Default Display Mode when Game is Loaded"
L.defaultGroupDisplay_desc = "Sets the Default Display Mode used when Game is Loaded."

L.ShowGroupNames_Name = " Show 'Visible' Group Categorizations"
L.HideGroupNames = " Hide Group Categorizations"
L.ShowAllGroupNames_name = " Show All Groups Names (even Invisible)"
L.ShowAllGroupNames_desc = "Show ALL Group Categorization Names: Visible and Invisible."

L.ShowOnlySelectedGroup_Name = " Display Zoom Group"
L.ShowOnlySelectedGroup_desc = "This option allows you to select one Group to focus on (that group and any child groups it contains) \n\nFor Example: One may choose to Zoom In to a 'Darkmoon Faire' Group when at the Fair.\n\nNOTE: When no Zoom Group is selected, this mode acts like Show 'Visible' Groups"

L.PGT_name = "'Tasks by Character' Layout Specific"
L.OnlyCurrentChar = "Only Show Current Character"
L.HideCharHeader_OnlyCurrentChar_name = "Hide Name when Only Showing One Character"
L.defaultExpandSelf_name = "Initially Expand Current Character"
L.defaultExpandSelf_desc = "If selected, automatically expands the current character when multiple character categories are displayed. Note, this will be over-ridden if the user collapses the category."

L.HideChar_ifNoIncomplete_name = "Hide Character Category when all tasks complete (and 'Completed Tasks' are not being shown)"
L.HideChar_ifNoIncomplete_desc = "Prevents an 'empty' Character catetory by hiding the Character if: \n\n1) All Tasks are Completed\n2) 'Show Completed Tasks' is NOT ENABLED (see 'Complated Tasks...' section below)."


L.allChars_GroupCharNames_name = "When displaying All Characters: Sort by Char Name, then Server Name"
L.allChars_GroupCharNames_desc = "If checked, character name will be the primary sort. If unchecked, server name will be the primary sort. \n\n Examples \n\n If checked, all chars with the name 'soandso' will be grouped together. If unchecked chars named 'soandso' will not be grouped together but with their fellow server chars."

L.ShowServerNames_name = "Show Server Name with Character Name"
L.ShowServerNames_desc = "Displays the server name along with the character name (e.g., Character Name - Server Name)"
L.useMouseoverHighlight_name = "Use Mouseover Highlights"
L.useMouseoverHighlight_desc = "Mouseover highlight for tooltip"

L.useCounts_onHeaders_name = "On Headers"
L.useCounts_onHeaders_desc = "Displays Counts on any Collapsible Header"
L.displayType_onHeaders_name = "Display Type"
L.displayType_onHeaders_desc = "Type of display to use for Collapsible Headers"
L.useCounts_onLDB_name = "On DataBroker Object"
L.useCounts_onLDB_desc = "Displays Counts on the DataBroker Object"
L.displayType_onLDB_name = "Display Type"
L.displayType_onLDB_desc = "Type of display to use for DataBroker Object"

L.StyleManager_Name = "Style Manager for Tooltip and Task Window"
L.StyleManager_Intro = "The %s allows you to modify the Font and Font Size of the text used in the DataBroker/Minimap Button Tooltip. It also controls the styling of Special Group and Task types, their colors, markers, denotations, or enable/disable styling of a particular Special Type."
L.headerfont = "Header Font"
L.fontsize = "Font Size"
L.standardFont = "Standard Font"
L.selectedgpfont = "Zoom Group Font"

L.normalColors = "Normal, non-Highlight Colors"

L.GroupColor_name = "Normal Group Names"
L.GroupColor_desc = "Color for Normal Group Names"
L.TaskNameColor_name = "Normal Task Names"
L.TaskNameColor_desc = "Color for Normal Task Names"
L.countColor_group_ = "Task Counts (Group)"
L.countColor_group_ = "Task Count Color for Group Labels"
L.specialTypes_name = "Special-Type Highlights"

L.specialTypes_intro = "Special-Types can affect Groups or Tasks and denote specialized functions. Tasks may be %s or %s, Groups may be %s, %s, or %s (for single-group display). The controls below let you modify how these Special-Types are displayed. %s the %s configuration cannot display these options as they would appear in use, so bear with the developer's notation choices."
L.AcctWide = "Account-Wide"
L.PurgeWhenComplete = "Purgable when Completed"
L.CommandLineEntryTarget = "Command Line Entry Target"
L.HiddenFromDisplay = "Invisible"
L.quoteSelected = "'Selected'"
L.PleaseNote = "Please Note:"
L.InvisibleGroup = "Invisible Group"
L.task_AccountWide = "Account Wide Task"
L.PurgableTask = "Purgable Task"
L.ZoomGroup_SM = "Zoom Group"
L.CommandLineTarget_SM = "Command Line Target"

L.UseStyle = "Use Style"
L.resetDefault = "Reset Default"

L.useText_name = "Use Text"
L.useText_desc = "Allows prepending and/or appending text symbols (e.g., '<Name>' -> '* <Name> *')"
L.useColor_name = "Use Color"
L.useColor_desc = "Determines if and how the selected color is used"
L.color = "Color"
L.text = "Text"
L.ResetIntro = "The buttons will act on ALL Tasks of their type for ALL characters.\n\nDaily and Weekly resets shouldn't need to be used however they are provided should the user need them or the automatic reset day/time not be correct, this will reset it.  The purge of Completed Purgables Tasks can be done here but is best defined in the Click Map to be used on the DataBroker/Minimap Icon. The Manual button is an option available to the user should it prove useful"

L.resetManualOnly = "Reset Manual Only"
L.resetDailyAutomatic = "Reset Daily Automatic"
L.resetWeeklyAutomatic = "Reset Weekly Automatic"
L.resetAll = "Reset All Tasks"
L.PurgePurgables = "Purge Completed Purgable Tasks"

L.ClickMap_Name = "Click Map"
L.Clickmap_Label = "Click Map"
L.ClickMap_LabelExtended = " for DataBroker Display & Minimap Icon"
L.Clickmap_Bottom = ""
L.WhatIsAClickMap = "What's a Click Map?"
L.whatIsAClickMap = "A %s is a way for you to configure how %s responds to clicks on the DataBroker Object and Minimap Icon. (%s)\n\nWhat you need readily available is likely to change with your familiarity with how %s works or how you use it changes. In any event, it beats the hell out of the author deciding how you'd prefer to access the functions and information.\n\nBecause buttons generated in this panel don't respond to the Right-Mouse Button, a separate dialog is provided to allow you to configure the Click Map more intuitively. (For convenience, the %s window is also a separately bindable action in the Click Map)"
L.clickmap = "Click Map"
L.ImChg = "Changes take effect immediately"
L.CLickMap_Help = "A %s is a way for you to configure how %s responds to clicks on the DataBroker Object. The user may adapt the behavior to their current and changing needs and the developer is free to provide optional behaviors without fearing villagers with pitchforks.\n\n"..
"%s: The '%s' button will open the %s dialog. This dialog can also be directly assigned in the %s for more convenient access.\n\n"..
"Available Actions are listed in the left column and tooltips may provide more information.\n\n"..
"The large button accepts Left and Right Mouse clicks and any modifier keys (ctrl, alt, shift). If the key combination is accepted it will be immediately set and available for use.\n\nIf the Mouse and Key Combination is already used, you will be notified of what Action is bound to that Mouse and Key Combination.\n\n"..
"Clear will clear the Mouse and Key Combination from the Action.\n\n"..
"Notify and the Checked/Unchecked icon next to it will both toggle the Notify option for the Action. If Notify is enabled, a message will be printed in the chat window when the Action is used. This is helpful for Actions whose results may not be immediatley obvious (e.g., Toggle Tooltips, Reset Manual Tasks, etc.)\n\n"..
"%s: A quick map is displayed in the %s panel (it will update if closed/re-opened but not in real-time). The Actions are displayed as headers, the Mouse and Key Combination (if any) and either (Notify) or (silent) indicate its Notify state."

L.Configuration = "Configuration"
L.ClickMapConfiguration = "Click Map Configuration"
L.Display = "Display"


L.TACM_intro = "%s are %s while the %s apply only to the %s."
L.TACM_intro_TasksAndGroups = "Tasks & Task Groups"
L.TACM_intro_global = "global"
L.TACM_intro_checkmarks = "enable/disable checkmarks"
L.TACM_intro_selectedchar = "selected character"


L.charSelect_name = "Display Point-of-View for..."
L.charSelect_desc = "The Enablement icons displayed in the list of Groups and Tasks relate to the selected character. Enablement choices for the selected character may be Reset to Default or Deleted using the respective buttons to the right."
L.ColorizingNames_Help = "See Colorizing Names Help for More Information"

L.ignoreChar_name = "Ignore Character"
L.ignoreChar_desc = "Ignore Character will auto-force all root-Groups to be 'disabled for this character'\n\nUnchecking Ignore Character WILL NOT re-enable root-Groups, you will have to do that manually.\n\nNota Bene: you WILL be able to CREATE specific tasks for the character (e.g., /ea task +charname), they will simply be in a disabled group."


L.escapeCodes_Label = "Partial |cff00ccffHighlight|r Colorization"
L.escapeCodes_Intro = "%s accepts escape code colorization in a way to preserve furture editability. Use%srather than the usual escape char (Pipe%sor ascii code %s). (nb: you can use any escape sequence, but at your own risk)\n\n"..
"Example: 'Transmog Helm //cffffff00AND//r' Boots  or '//cffff0066Raid Signup Today//r'"

L.ColorCodes_Label = "|cff00ccffColorizing|r Names"
L.ColorCodes_header1 = "Colorizing Names"
L.cc__double_forward_slash = " // "
L.cc__pipe = " | "
L.cc__slash_124 = "\\124"
L.cc__char_124 = "char(124)"
L.cc__urgent = "[|cffffff00URGENT!|cffff0000]"

L.ColorCodes_help1 = "Group Names and Task Names allow for Escape Sequence Colorization in a slightly indirect manner to allow the user to edit the codes. Use a double-forward-slash (%s) for the pipe (%s or %s): in this way, you will be able to edit the color code rather than having it colorize text in the entry field. (Note: the configuration coloring scheme uses hex codes so you may create display oddities there however the buttons use baseline colorization and things -should- display ok there.)\n\n"..
"If the above seemed confusing, read on; otherwise, this is a rehash.\n\n"..
"Want to make a Group Name or Task Name stand out from the rest or makre sure '%s' stands out or make every letter a different color just 'because'? Now you can. It's done with a type of inline-coding called Escape Sequencing and you've seen it a billion times in-game. It's a powerful tool but we're only looking at one aspect of it below. (Feel free to skip boring sections, the explanations are redundant)\n"

L.ColorCodes_header2 = "Why Do It This Way"
L.highlightWord_display = "display"
L.cc_hexcode_pipe = "|cff<hexcode>"
L.cc_hexcode_slash = "//cff<hexcode>"

L.ColorCodes_help2 = "The Esacape Sequence Character (the pipe character '%s' or %s or %s) is not well received in 'input' fields because this is the type of field Blizzard uses for the Chatbox and they are quite careful about what codes are used b/c of how they can affect other people's chat windows, so entry text is sanitized of Escape Sequenceing; unfortunately, it's sanitized a the source, not the target so entered color-codes display as plain-text.\n\n"..
"That, however, is not the main problem: the 'input' field will also %s those Escape Sequences (which can be used for more than just colorization) which is pretty but it means you can't edit the codes. This is annoying.\n\n"..
"This is worked around by changing the character from the pipe char to a double-forward-slash when displaying the text for edit ( %s becomes %s ) then swapping the double-forward-slashes back to pipes ( %s becomes %s ). This also neatly works around the sanitization behavior.\n"

L.ColorCodes_header3 = "How Do We Do It"
L.cc_EscapeSequence = "[Escape Sequence]"
L.cc_Colorization = "[Sequence Code: Colorization]"
L.cc_Alpha = "[Alpha Transparency - Hex Code]"
L.cc_Red = "[Red - Hex Code]"
L.cc_Green = "[Green - Hex Code]"
L.cc_Blue = "[Blue - Hex Code]"
L.cc_Text = "[Text To Colorize]"
L.cc_ColorizationStop = "[Sequence Code: Stop Colorizing]"
L.highlightWord_Colorized = "Colorized"

L.ColorCodes_help3 = "An Escape Seqence for Colorization is made up of several parts as denoted below:\n\n"..
"%s %s %s %s %s %s %s %s %s \n\n"..
"%s: double-forward-slash (//). Blizzard uses the Pipe Character '|' (you may have seen it written in macros as \124) but (for reasons explained in 'Why Do It This Way' above) you'll input them in Executive Assistant with a //.\n\n"..
"%s: c. Just the letter c\n\n"..
"%s: WoW pretty much ignores this entirely, which is a good thing really. FF is the convention just in case it's implemented later (Techically FF=fully opague; 00=invisible)\n\n"..
"%s: 00 to FF: Amount of the color (from none to all) to contribute to the whole.\n\n"..
"%s: 00 to FF: Amount of the color (from none to all) to contribute to the whole.\n\n"..
"%s: 00 to FF: Amount of the color (from none to all) to contribute to the whole.\n\n"..
"These are the same color codes used in HTML and there's a world wide web full of 'em.\n\n"..
"%s: Anything between the color-code and the stop sequence.\n\n"..
"%s: r. Just thet letter r.\n\n"..
"Putting it all together:\n\n"..
"// c ff ff 66 99 Colorized // r \n\n"..
"=> //cffff6699Colorized//r \n\n"..
"Edit => Here is //cffff6699Colorized//r Text\n\n"..
"Display => Here is %s Text\n"

L.ColorCodes_header4 = "Hang on, hang on, hang on...does that mean I can...??"
L.ColorCodes_help4 = "(Oh, what have I done?) Yes, it does. Have at it; knock yourselves out: \n\nYou can use all of the escape sequences, though some aren't all that helpful. The texture are fun (e.g, //TInterface\\Icons\\INV_Misc_Coin_01:16//t Shopping )\n\n"..
"Caveat: DO NOT USE \\\\, only use \\. The entry field will double the \\ for you. If you use \\ it'll save as \\\\ and it obviously can't figure that out."


L.resetChar_name = "Reset"
L.resetChar_desc = "Resets Group and Task Enablement Selections for Displayed Character"
L.removeChar_name = "Remove"
L.removeChar_desc = "Removes the the Displayed Character completely (useful for no-longer-played chars; cannot be used on the currently played character). "

L.newGroupName_name = "Add New Task Group: Group Name"
L.newGroupName_desc = "Enter the name of the new group and press the 'okay' button to create a new task group"
L.GroupColor_config_name = "Group Name Color"
L.GroupColor_config_desc = "Only applies to this config panel to make finding child-groups easier."

L.FontsAndColors = "Fonts and Colors"

L.Options = "Options"
L.useTaskWindow = "Use Task Window"
L.useDataBrokerTooltip = "Use DataBroker Tooltip Display"

L.perCharTaskPositionWindow_name = "Character Specific Window Settings"
L.perCharTaskPositionWindow_desc = "If checked, the task window controls will specific to this character. IF checked then UNchecked, character specific changes will be lost."
L.twButtonLocation_name = "Place Buttons at the..."
L.twButtonLocation_desc = "Positions the Group Display buttons. Position them as best suits your UI orientation or preference."
L.twenableTooltips_name = "Enable Button Tooltips"
L.twenableTooltips_desc = "Displays information about the Task Window Buttons"
L.twdefaultCollapse_name = "Collapse Task Window Groups"
L.twdefaultCollapse_desc = "Forces Task Window Group Categories closed of enabled; if disabled, Group Categories will default Expanded"
L.twuseMouseoverHighlight_name = "Use Mouseover Highlights"
L.twuseMouseoverHighlight_desc = "Mouseover Highlight"
L.twhideDuringCombat_name = "Hide During Combat"
L.twhideDuringCombat_desc = "Hides the Task Window during Combat"
L.twOpacity_Mouseover_name = "Mouse-Over Opacity"
L.twOpacity_Mouseover_desc = "Opacity when the mouse is over Task Window"
L.twOpacity_Normal_name = "Normal Opacity"
L.twOpacity_Normal_desc = "Opacity when the mouse is not over Task Window"
L.winPosition = "Window Positioning"
L.displayCounts = "Display Task Counts..."
L.relPos_name = "Task Window Grow-From/Anchor Point"
L.relPos_desc = "Sets the part of the Task Window that is 'anchored' and how the window will 'grow' (i.e., if set to BOTTOMRIGHT, the task window will grow upward and to the left)"
L.locked_name = "Locked"
L.locked_desc = "Enables/Disables moving the Task Window"
L.CompletedTasks = "Completed Tasks..."
L.twshowChecked_name = "Show Completed Tasks"
L.twshowChecked_desc = "Toggles the showing or hiding of Completed Tasks"
L.twrightMouseOnTask_togglesShowChecked_name = "Show Completed Tasks, Toggle with Right Mouse"
L.twrightMouseOnTask_togglesShowChecked_desc = "If enabled, right-clicking on a tooltip task will toggle 'Show Completed Tasks'"
L.twuseCounts_onHeaders_name = "Display On Headers"
L.twuseCounts_onHeaders_desc = "Displays Counts on any Collapsible Header"
L.twdisplayType_onHeaders_name = "Header Display Type"
L.twdisplayType_onHeaders_desc = "Type of display to use for Collapsible Headers"
L.background = "Background"
L.BackdropColor = "Backdrop color"
L.Border = "Border"
L.BorderColor = "Border Color"

L.StrataName = "Frame Strata"
L.strata_name = "Frame Stata"
L.strata_desc = "Select the display level within the frame hierarchy for best display"

L.GroupOptions = "Group Options"
L.groupactions = "Group Actions"
L.UP_moveGroup = "Moves Group Up in the Display Order\n\nHold SHIFT to move to the Top"
L.DOWN_moveGroup = "Moves Group Down in the Display Order\n\nHold SHIFT to move to the Bottom"
L.deleteGroup_name = "Delete Group"
L.deleteGroup_desc = "Removes the selected Group. SHIFT key must be pressed."
L.addTaskg_name = "Add Task"
L.addTaskg_desc = "Adds a New Task a the Bottom of the Group"
L.addGroup_name ="Add Group"
L.addGroup_desc ="Adds a New Group a the Bottom of the Group"
L.byDefault_groupIs_name = "Default for All Chars"
L.byDefault_groupIs_desc = "Default Enabled/Disabled behavior for all Chars. Avoids having to load each char and disable or enable certain contexts (e.g., Disabled for Char-Specific lists, etc)"

L.byUser_groupIs = "...for This Char..."

L.hideFromDisplay_name = "Invisible"
L.hideFromDisplay_desc = "An Invisible Group is, itself, not displayed on the Tooltip or Task Window and any child Groups or Tasks appear to be part of the Invisible Group's parent. This can help you keep Tasks organized in terms of configuration but reduce visual clutter playing. NB: The Group Display Mode 'Show ALL Groups' will show Invisible Groups."
L.cmdLineTarget_name = "Command Line Target"
L.cmdLineTarget_desc = "Command Line Target\n\nDefault Group for ad hoc Tasks added via Command Line"
L.groupName_rename_name = "Rename Group"
L.groupName_rename_desc = "Rename the group by entering a new one"
L.hideDays_group_name = "Hide Group on these Days"
L.hideDays_group_desc = "Hide Task on Selected Days"

L.taskactions = "Task Actions"
L.UP_moveTask = "Moves Task Up in the Display Order\n\nHold SHIFT to move to the Top"
L.DOWN_moveTask = "Moves Task Down in the Display Order\n\nHold SHIFT to move to the Bottom"

L.task_addTask_name = "+ Task"
L.task_addTask_desc = "Adds a New Task positioned below this Task (saves all that move up/down)"
L.task_deleteTask_name = "Delete"
L.task_deleteTask_desc = "Removes the selected Task. SHIFT key must be pressed."
L.byDefault_taskIs_name = "Default for All Chars"
L.byDefault_taskIs_desc = "Default Enabled/Disabled behavior for all Chars. Avoids having to load each char and disable or enable certain contexts (e.g., Disabled for Char-Specific lists, etc)"
L.byUser_taskIs = "...for This Char..."

L.resetType_name = "Task Type"
L.resetType_desc = "Select the Type of Task this is (see the Help for explanations)\n\nEnabled Modules and Interns may add Task Types; if a Task is marked as using one of these and the Module or Intern is disabled, the Task Type will be 'Missing Module'"

L.resetType_typeLogin = "At Each Login"
L.resetType_typeDaily = "Daily Automatic"
L.resetType_typeWeekly = "Weekly Automatic"
L.resetType_typeCalendar = "Calendar Automatic"
L.resetType_typePurgable = "Purgable"
L.resetType_typeReminder = "Reminder"
L.resetType_typeManual = "Manual"


L.task_AcctWide_name = "Account Wide Task"
L.task_AcctWide_desc = "Make the Task Account-Wide (e.g., Blingtron). When one char completes the Task, it will show completed for all characters."
L.task_hideDays_name = "Hide Days"
L.task_hideDays_desc = "Hide Task on Selected Days"

L.KeyCombinationSet = "Key Combination Set"

L.tw_taskwindowis = "Task Window is [%s]"
L.tw_movable = "Movable"
L.tw_locked = "Locked"

L.resetAlert_resetDaily = "Daily Tasks reset"
L.resetAlert_resetWeekly = "Weekly Tasks reset"
L.resetAlert_resetManual = "Manual Tasks reset"
L.resetAlert_purgePurgables = "Completed Purgables have been Purged"
L.resetAlert_resetAtLogins = "At Login Tasks reset"
L.resetAlert_resetReminder = "Reminder Tasks Checked"
L.resetAlert_resetCalendar = "Calendar Tasks reset"



L.cm_mouse_name = "Mouse"
L.cm_mouse_desc = "Mouse Button to use"
L.cm_shift_name = "Shift"
L.cm_shift_desc = "Shift key must be held down"
L.cm_alt_name = "Alt"
L.cm_alt_desc = "Alt key must be held down"
L.cm_ctrl_name = "Ctrl"
L.cm_ctrl_desc = "Ctrl key must be held down"
L.cm_notify_name = "Notify"
L.cm_notify_desc = "Prints a line to the chat window for the action you requested -- useful for actions that don't have immediate visual confirmation."
L.ClickMapAlert = "Click Map Alert: [%s] is in use by [%s]"
L.cm_running = "Running: "

L.cm_unableToFindGroup = "Unable to locate Command Line Target Group. Reset the Command Line Target Group via the Config panel or via /sa setgroup <groupname>"
L.cm_NoTagetSelected = "No Target Group has been selected. To use this feature, a group must be set as the Command Line Target via the Config panel or via /sa setgroup <groupname>"

L.personal = "Personal"
L.taskCreated = "Task [%s] created"
L.DefaultTaskName = "<Default New Task Name>"

L.cmdlinetargetsetto = "Command Line Target Group set to [%s]"
L.unabletofindgroup = "Unable to find Group [%s]"


L.saveCollapseMap_name = "Save Group Collapse/Expand"
L.saveCollapseMap_desc = "Save Group Collapse/Expand for each Character and reasserts them when the character logs in"


L.usefulTricks = "Useful Tricks"
L.gettingstarted = "Getting Started"
L.helpPanel_intro = "Don't let the size of the Help fool you, %s isn't complicated to use, it just has a lot of ways to tailor it to your needs. The Topic page will give a brief overview and how controls inter-relate while Named pages provide more detailed information."


L.gettingstarted_usefultricks = "* Right-Click on a Task and the display will toggle 'Hide/Show Completed'\n\n"..
"* Right-Click on a Group to mark it as the Zoom Group. When in Zoom Group mode, the display will 'Zoom-In' to that group. Since the Zoom Group mode will default to Show 'Visible' Groups, it can be used as an efficient 'toggle'\n\n"..
"* Ctrl Left-Click on a Group to set it as the Command Line Entry Target. You can also do this from the Command Line (/ea setgroup <groupname>), if that is more convenient (see Command Line)\n\n"..
"* Shift-Click on a Group to Expand / Collapse all its sibling Groups in that tier.\n\n"..
"* If you forget to mark something completed on an alt you can do it from the current character by holding the SHIFT key when left-clicking -- you don't need to remember that, %s will print that information to the chat window if you try to complete a non-Account-Wide task for a different character.\n\n"..
"* The Second Tooltip Button (Group Display Modes) cycles bi-directionally: left-click to cycle forward, right-click to cycle backward. Depending on the modes you assign to the Group Display Modes button, this can make for an efficient swapping.\n\n"..
"* Individual Groups can be marked Invisible, which hides them from display and makes its child Groups and Tasks will be appear as part of the Invisible Group's parent. See %s for more information.\n\n"..
"* If you want to re-use a Task but not have it automatically reset, set the Task's Type to 'Manual'\n\n"..
"* One-Time-Use Tasks (Task Type of Purgable) allow you to take notes or leave yourself reminders as well as one-time-use Tasks (e.g., transmog head-gear). Purging Completed Purgables can be done from the Reset/Auto-Reset Configuration Tab but it's much easier to use the Click Map to bind it to the DataBroker Object. See %s for more information."

L.ConfigureClickmap = "Configure Click Map"
L.configLabels_Help = "Help and Information"
L.configLabels_ClickMap = "Click Map"
L.configLabels_StyleMgr = "Style Manager"
L.configLabels_TaskMaint = "Task Management" -- "Task & Char Config"
L.configLabels_ToolTip = "LDB Tooltip Options"
L.configLabels_TaskWindow = "Task Window Options"
L.configLabels_CommandLine = "Command Line"
L.configLabels_ResetOpts = "Reset/Auto-Reset Options"
L.TooltipOptions = "DataBroker / Minimap Icon : Tooltip Options"
L.TACM_longLabel = "Task, Group, and Character Management"
L.ResetOpts_Label = "Reset / Automatic-Reset Options"
L.TaskWindow_Label = "Tasklist Window"

-- OptTable: cmdline
L.AddonConfiguration = "Addon Configuration"
L.cmdlineAddTask = "Add New Task"

-- OptTable: 
L.TACM = "Task Management" -- "Task & Char Config"



L.StyleManager_Label = "Style Manager"
L.SpecialTypeHighlights = "Special-Type Highlights"
L.ClickMap = "Click Map"


L.GettingStarted_CAPS = "GETTING STARTED"
L.FIRSTCONSIDERATIONS = "First Considerations"
L.GettingStarted_Title = "Getting Started..."
L.GettingStarted_Label = "--> Getting Started..."


L.ClickMapConfigDialog = "Click Map Config Dialog"

L.GettingStarted_Body = "The purpose of %s is to simplify your gameplay and become an almost invisible hand that gives you what you need to know and need to do without getting in the way. A to-do list is just a list of things to do, Executive Assistant tries to provide that information to you in a way that adapts to your gameplay needs and the needs of the character you are playing. It also provides you different ways to use the information you already have, not just which Tasks were completed by a Character but which Characters have completed a Task. For all that, it's still easy to use.\n\n"..
"%s is a simple 3-Step process and you may have done some of it already:\n\n"..
"1. Ensure the Local Daily Reset Time and Weekly Reset Day are set properly for your location. This is located on the main addon configuration page just below the 'Hide Minimap Button' toggle -- it's easily visible when the First Time User message is hidden.\n\n"..
"2. Visit the %s tab to see what actions are available and how they are configured. As your way through setting up %s to do your bidding, you may wish to reconfigure the %s but for now, just know that it's there and it's your friend. The Defaults are:\n      %s: Left-Mouse\n      %s: Right-Mouse\n      %s: Shift + Right-Mouse\n      %s: Shift + Ctrl + Right-Mouse\n\n"..
"3. Visit the %s panel, two tabs below the Help, and enter the name of your first Group -- you will likely do a lot of adjusting so a single group with three or four tasks will get you going.\n\n"..
"And that's it: you're ready to go.\n\n"..
"%s To get started, Yes; to adapt %s to your needs, probably not.\n\n"..
"One should keep in mind that the initial setup doesn't try to be 'optimized-for-the-average-user' but rather tries to expose you to a wide array of capabilities, to get a feel for them. The goal of the Help not just to explain individual settings but how they can be used in concert.\n\n"..
"%s, the Help panel immediately below this one, will guide you through some quick Use-Comfort items that may be among the first you will want to tweak.\n\n"..
"The 'best way to use %s' is the one that is supportive of your gameplay needs and invisible-but-dutifully-attentive the rest of the time. Powerful, keeping you on track and up to date, and otherwise staying out of your way just like a good Executive Assistant"
L.IsItReally = "Surely is not that easy..." 






L.MainConfigPanel = "Main Configuration Panel"
L.FirstConsiderations_didIdothat = "Did I so that Task on all my alts?"
L.PlaceTooltipButtons = "Place Tooltip Buttons at the..."
L.FirstConsiderations_Label = "First Considerations"
L.FirstConsiderations_Body = "%s: This is a companion addon for %s that is a small Backup/Restore facility for Groups and Tasks. For more information, see the Help section entitled %s.\n\n"..
"%s: While the Expand/Collapse position of each Group is remembered while a character is logged, you can decide if they are initially Expanded or Collapsed when the character logs in.\n\n"..
"Alternatively, %s can remember the user's Expand/Collapse state of each Group between sessions (both Tooltip and Task Window positions will be saved). See %s.\n\n"..
"%s (Tooltip and Task Window): The orientation of the buttons can be set to TOP or BOTTOM respectively in each (See %s and %s Panels respectively). The Tooltip Buttons were conceived to be near the DataBroker Object as switching between modes can pull the Tooltip away from the cursor and collapse it rather annoyingly. The Task Window buttons should be placed where they are most convenient.\n\n"..
"%s: The Task Window is optional and can be disabled in the Task Window Configuration Panel\n\n"..
"%s: Some will find the Tooltip's checklist redundant to the Task Window. The Task Window is optional and can be disabled in the Tooltip Configuration Panel.\n\nHowever, it is suggested that you first alter the default Tooltip to be the Characters by Task orientation (the reverse-index) to provide you easy access to that information.\n\n"..
"%s: If you find yourself mousing over the Tooltip at inopportune times and its size is a problem, 1) Use the Click Map to have the DataBroker Object display the Tooltip when clicked (%s) then 2) disable the Tooltip in the %s. Now it will only appear when you click the DataBroker Object.\n\n"..
"%s: Another area that may quickly interest you is the %s panel where you can set the Fonts and Font Sizes for the displays as well as the 'normal' colors. It is suggested that you read up on the %s options before you consider modifying them -- the one exception to this would be Account Wide, given its self-explanatory nature."
L.COLLAPSEEXPAND = "COLLAPSE/EXPAND"
L.BUTTONPOSITIONS = "BUTTON POSITIONS"
L.TASKWINDOWREDUNDANT = "TASK WINDOW REDUNDANT"
L.TOOLTIPISREDUNDANT = "DATABROKER TOOLTIP IS REDUNDANT"
L.TOOLTIPISDISTRACTING = "TOOLTIP IS DISTRACTING"
L.FONTSANDSIZES = "FONTS AND SIZES"

L.tw_tt_singleGroup = "Display Zoom Group. Select by the Right-Mouse Button. \nThe name of the Zoom Group appears to the left. If no group \nselected, 'All Visible Windows' is displayed."
L.tw_tt_hideGroups = "Hide Group Headers"
L.tw_tt_showGroups = "Show Visible Groups. Groups\n marked 'Hidden' will not \nhave their category header \ndisplayed, only their contents"
L.tw_tt_config = "%s: Right-Mouse to mark/unmark the 'Zoom Group'\n\n".."%s: Right-Mouse to toggle show/hide completed Tasks\n\n".."(%s)\n     %s: Open Task Window Config\n     %s: Toggle Locked / Movable\n     %s to Toggle Tooltips"
L.tw_tt_config_group = "Group"
L.tw_tt_config_task = "Task"
L.tw_tt_config_thisbutton = "This Button"
L.tw_tt_config_LeftClick = "Left-Click"
L.tw_tt_config_ShiftLeftCLick = "Shift Left-CLick"
L.tw_tt_config_RightClick = "Right-Click"

L.leftMouse = "Left-Mouse"

L.tt_tt_s1_g = "Groups"
L.rightMouse = "Right-Mouse"
L.ctrl_leftMouse = "Ctrl+Left-Mouse"
L.leftMouse_shift = "Shift+Left-Mouse"
L.tt_tt_s1_ts = "Tasks"
L.rightMouse = "Right-Mouse"
L.tt_tt_s1f = "This Field"
L.tt_tt_s1 = "%s\n".."%s Group to mark/unmark the 'Zoom Group'\n".."%s to mark/unmark the group as the Command Line Target\n".."%s to Expand/Collapse Groups of the same rank (siblings)\n\n".."%s\n".."%s:to toggle show/hide completed Tasks\n\n".."(%s) show Zoom Group Name (if any)"
L.tt_tt_ac = "Shows All Characters"
L.tt_tt_occ = "Shows Current Character"
L.tt_tt_4 = "Hide All Groups\n\n%s: Cycle Forward\n%s: Cycle Backward"
L.tt_tt_3 = "Display Zoom Group\n\n(if no group selected, shows 'Visible' Groups)\n\n%s: Cycle Forward\n%s: Cycle Backward"
L.tt_tt_2 = "Show ALL Groups\n\n%s: Cycle Forward\n%s: Cycle Backward"
L.tt_tt_1 = "Show 'Visible' Groups\n\n%s: Cycle Forward\n%s: Cycle Backward"
L.tt_tt_GTP = "Character by Task\n\nCharacters who have Completed a Task"
L.tt_tt_PGT = "Task by Character\n\nTasks a Character has Completed"

L.HideEmptyGroups_name = "Do Not Display Empty Groups"
L.HideEmptyGroups_desc = "An Empty Group has no Tasks available (they may be disabled for the character, hidden for that day, etc) Child groups that are themselves empty will not be considered an entry so a group whose only entries are two empty child groups will itself beconsidered empty."



L.clickmap_HELP_name = "Open |cffff9966%s|r Help"
L.clickmap_HELP_desc = "Opens the |cffff9966%s|r Help Panel"

L.clickmap_TACM_name = "|cffff9966Cfg|r: Open Task Management"
L.clickmap_TACM_desc = "Opens the Task Management configuration page"

L.clickmap_CONFIG_name = "|cffff9966Cfg|r: Open |cffff9966%s|r Main Config"
L.clickmap_CONFIG_desc = "Opens the main |cffff9966%s|r configuration panel (this page)"
L.clickmap_RESET_name = "|cffff9966Cfg|r: Open Reset Panel"
L.clickmap_RESET_desc = "Opens the Reset / Auto-Reset Options panel"
L.clickmap_reset_Manual_name = "Reset Manual Tasks"
L.clickmap_reset_Manual_desc = "Resets all Manual-Reset Tasks"
L.clickmap_purgePurgables_name = "Delete Completed Purgable Tasks"
L.clickmap_purgePurgables_desc = "Deletes Completed Purgable Tasks -- if you use %s as a general, on-the-fly to-do list, this may be for you."
L.clickmap_TOOLTIPCONFIG_name = "|cffff9966Cfg|r: Open DataBroker Tooltip Display Configuration"
L.clickmap_TOOLTIPCONFIG_desc = "Opens the DataBroker Tooltip Display Configuration page"
L.clickmap_CLICKMAP_name = "|cffff9966Cfg|r: Open Click Map"
L.clickmap_CLICKMAP_desc = "Opens Click Map page"

L.clickmap_CLICKMAPconfig_name = "|cffff9966Cfg|r: Open |cff87d8deClick Map Config Dialog|r"
L.clickmap_CLICKMAPconfig_desc = "Opens Click Map Configuration Dialog"

L.clickmap_STYLEMGR_name = "|cffff9966Cfg|r: Open Style Manger"
L.clickmap_STYLEMGR_desc = "Opens Style Manager configuration page"
L.clickmap_TASKWINCONFIG_name = "|cffff9966Cfg|r: Open Task Window Display Configuration"
L.clickmap_TASKWINCONFIG_desc = "Opens the Task Window Display Configuration configuration page"


L.clickmap_ToggleTaskWindow_name = "Toggle Task Window Display"
L.clickmap_ToggleTaskWindow_desc = "Toggle Task Window Display"

L.clickmap_ShowDataBrokerTT_name = "Show DataBroker Tooltip Display"
L.clickmap_ShowDataBrokerTT_desc = "Useful if showing the display on Mouseover is disabled but you still want to occasionally open it"

L.clickmap_config = "Click Map Configuration"
L.clickmap_config_close = "Finished"

L.hideTW_ifHideCompTaks_andNoUncompTasks_name = "Hide Task Window when 'Show Completed Tasks' is Disabled and All Tasks are Complete"
L.hideTW_ifHideCompTaks_andNoUncompTasks_desc = "\n!! EXPERIMENTAL FEATURE !!\n\n Hides Task Window if 'Show Completed Tasks' is disabled and all Tasks have been Completed. WARNING: this will effectively DISABLE the ClickMap 'Toggle Task Window' feature as the Task Window Toggle State is constantly reset by *this* feature. Use at your own risk."



L.clear = "clear"
L.notify = "Notify"

L.LEFTMOUSE = "Left Mouse"
L.RIGHTMOUSE = "Right Mouse"
L.SHIFT = "shift"
L.ALT = "alt"
L.CTRL = "ctrl"
L.silent = "silent"
L.notset = "not set"

L.clickmap_tooltip_keys = "Press the Mouse and Key Combination for the Action"
L.clickmap_tooltip_clear = "Clears the Mouse and Key Combination"
L.clickmap_tooltip_notify = "Toggles Notifications\n\nNotifications print a notice for the action to the chat window. \nVery useful for actions that do not have visible reactions \n(e.g., Purge Completed Purgable Tasks, etc)"

L.clickmap_ToggleTooltipTips_name = "Toggle Tooltip Tips"
L.clickmap_ToggleTooltipTips_desc = "Toggles Tooltips on DataBroker Tooltip Buttons"

L.clickmap_HideTaskWindowControlButtons_name = "Toggle Hide Task Window Control Buttons"
L.clickmap_HideTaskWindowControlButtons_desc = "Toggles Hide Task Window Control Buttons when Not Moving"


L.Enabled = "Enabled"
L.Disabled = "Disabled"
L.twTooltipsToggle = "Task Window Tooltips: "

L.MainOpts_Label = "Main Options"

L.MainOpts_Help = "%s: Toggles Hide/Show of the Minimap Icon. This item is per-character.\n\n"..
"%s: Lets you select the Executive Assistant icon.\n\n"..
"%s: Local Daily Reset Time and Local Reset Day lets Executive Assistant know when it's time to reset completed Tasks. Enter the Time and Day as you experience the resets in your Time Zone.\n\n"..
"%s: %s\n\n"..
"%s: When Group categories are expanded and collapsed, %s will retain these for the gaming session in normal course (i.e., if you open a Group on the tooltip it'll still be open when you open the tooltip again). \n\n"..
"This section chooses how they will be initially displayed for the logged-in character. (The Group categories of other characters displayed in the tooltip are automatically collapsed (see Technical Notes)).\n\n"..
"%s: This saves the character's state of the Groups for each login and overrides the two following controls. \n\n"..
"%s: If enabled, collapses all Tooltip Groups, otherwise expands all Tooltip Groups.\n\n"..
"%s: If enabled, collapses all Task Window Groups, otherwise expands all Task Window Groups.\n\n"..
"%s: Allow you to set the %s, %s, and %s of the configuration window for ease of use."
L.configConfig_name = "Config Dialog Options"

L.scale_name = "Scale"
L.scale_desc = "DO NOT USE THE SLIDER unless you want to see a very confused dialog."
L.width_name = "Width"
L.height_name = "Height"


L.HideMinimapIcon = "Hide Minimap Icon"
L.SelectDataBroker = "Select Data-Broker / MiniMap Button Icon"
L.AutomaticResets = "Automatic Resets"
L.ExpandCollapse = "Expand / Collapse"
L.SaveGroupCollapseExpand = "Save Group Collapse/Expand"
L.CollapseTooltipGroups = "Collapse Tooltip Groups at Login"
L.CollapseTaskWindowGroups = "Collapse Task Window Groups at Login"


L.TACM_help = "%s lets you configure Character Point-Of-View alongside the Groups and Tasks themselves. While it may sound odd, it provides immediate feedback on the Group and Task configuration and if tweaks are needed while setting up Character Point-of-View you are right where you need to be.\n\n"..
"%s is the logic behind how Groups and Tasks are utilized. Every character on the account has access to the Group and Task configuration so it only needs to be entered once. From there, how each character experiences those Groups and Tasks can be configured, a process speeded up by being able to set a default of Enabled or Disabled for both Groups and Tasks and Tasks allowed to follow the Default for the Group.\n\n"..

"This approach allows keep track of your Group and Task configuration in one place while being able to swap between Character Points-Of-View with a mouse-click; use Account-Wide Tasks (e.g., Blingtron, Housekeeping-among-alts, etc); keep and manage Special Events (e.g., Brewfest, Darkmoon Faire, etc) with ease and simplicity.\n\n".."Two Examples:\n\n"..

"%s, a Group for 'Darkmoon Faire' may contain all possible Tasks to perform (daily and per-event) but not all of your alts particiapte. For those alts, the 'Darkmoon Faire' can be set Disabled on that Character. If some Characters do not do some Tasks, those Tasks can be set Disabled on this Character for those Characters. When Darkmoon Faire is over, the Group can have its Default state set to Disabled and reset to Enabled when the event begins again: this makes the tasks 'disappear' and 'reappear' for Characters who accept the Group's Default setting.\n\n"..

"%s, a Group for 'Garrison Tasks' can have all of the different Garrison tasks but each Character would only have applicable Tasks Enabled and the Group itself be Disabled for Characters who don't yet have a Garrison -- and when they do, it can simply be enabled and Tasks enabled as the Character progresses, etc."


L.AddOnce_UseMany = "Add Once, Use Many"

L.forExample_1 = "For one example"
L.forExample_2 = "For another example"


L.BasicConfigurationLabel = "Basic Configuration Controls"
L.DisplayPOVChar = "Display Point-of-View for..."
L.button_Reset = "Reset Button"
L.button_Remove = "Remove Button"
L.EntryField = "Add New Task Group: Group Name"
L.gpcolor = "Group Name Color"
L.BasicConfiguration_Help = "Groups and Tasks are available to every Character and are thus 'global' but a Character's ability to use a Group or Task is dependant on their Point of View, which is unique to them. (This will be described in more detail in Group and Task help panels dealing with 'Default for All' and '...for this Char' controls)\n\n"..
"%s: Allows you to select the Character who's Point of View you want to configure. The initial Character displayed will always be the currently logged in character. The graphics displayed are the output of the displayed Character's Point of View.\n\n"..
"%s: Resets the Character to a base-state. Any special Enables/Disables are removed and they adopt a 'default' outlook. (This will also reset the Character's completed Task count)\n\n"..
"%s: Removes the Character from %s completely. Should only be used on Characters that will no longer use the Addon and cannot be used on the currently logged in character.\n\n"..
"%s: Automatically sets all root-Groups (new and moved to root) to 'Disabled' for that character. Useful for inactive characters (e.g., bank characters, etc.) It is suggested to be used with %s (see %s Help Tab).\n\n"..
"%s: Base Groups are named before creation (unlike Child Groups). Enter a Group name and press Enter or the 'Okay' button. A Base Group of that name will be created and a default Task assigned. (Base Groups have special handling conditions because they are first-children of the hidden common parent)\n\n"..
"%s: Group Name Color is a convenience control that applies ONLY to the configuration panel. Due to how the nested Groups display (over which I have little control) it's terribly easy for them to get lost or hard to spot. Group Name Color makes them easier to see in complex configurations.\n\n"..
"%s: Places the Groups and Tasks into %s mode (see %s tab)"


L.GroupOptions_help = "  --- Group Options ---" -- afternoon
L.GroupOptionsLabel = "Group Configuration"
L.GroupOptions_Help = "%s: Moves the Group Up within its parent. Shift-Click to move to the Top.\n\n"..
"%s: Moves the Group Down within its parent. Shift-Click to move to the Bottom.\n\n"..
"%s: Deletes the Group and all Child Groups and Child Tasks (SHIFT key must be pressed).\n\n"..
"%s: Adds a Task to the Bottom of the Group Display Order (NB: see the +Task button in Tasks for an easier way to position New Tasks) \n\n"..
"%s: Adds a Child Group to the bottom of the Group Display Order\n\n"..
"%s\n\n"..
"The next two controls determine how a Character perceives the Group (and all its children).\n\n"..
"%s: Enabled or Disabled. Sets the Default State for the Group. If Disabled, all Child Groups and Tasks will also be Disabled.\n\n"..
"%s: Enabled, Disabled, or Default. Allows you to Force a behavior for the Group, not just Override. If Default, the Character will experience the Group's Default for All Characters State, if Enabled or Disabled, it will Force that state regardless.\n\n"..
"For example, a Darkmoon Faire Group could be Enabled or Disabled as the event comes and goes and Characters with Default will find the Group is available or not but if the value is Disabled, they will never see the group; Enabled, they will always see the group.\n\n"..
"%s If any parent Group is Disabled, it will supersede this setting.\n\n"..
"%s: The Group will not show up on the Tooltip or Task Window but its Child Groups and Tasks will appear within the Group's parent Group. This control is not available on Base Groups. (See 'Invisible Groups' for more information on their use)\n\n"..
"%s: Makes the Group the target for Tasks entered from the Command Line. Note that this can also be set on-the-fly from the command line and from the Mouse and Key Combination CTRL+Left-Click in both the Tooltip and Task Window. (You must hit Enter or press the 'Okay' button for the new name to be recognized) \n\n"..
"%s: Allows a Group to be Renamed. Renames should take place in real-time, even in the configuration panel.\n\n"..
"%s: Allows you to hide the Group on the selected days. Selections will affect all Child Groups and Tasks.\n\n"

L.DefaultForAllChars = "Default for All Characters"
L.ForThisChar = "For This Char..."
L.CaveatuponGroups = "Caveat upon Groups"
L.GroupActions = "  --- Group Actions ---" -- afternoon
L.DeleteGroup = "Delete Group"
L.AddTask = "Add Task"
L.AddGroup = "Add Group"
L.Invisible = "Invisible"
L.CmdLineTarget = "Command Line Target"
L.RenameGroup = "Rename Group"

L.NB = "Note:"


L.TaskOption_HelpLabel = "Task Configuration"
L.TaskOptions_Help = "%s: \n\n"..
"%s: Moves the Task Up within its parent. Shift-Click to move to the Top.\n\n"..
"%s: Moves the Task Down within its parent. Shift-Click to move to the Bottom.\n\n"..
"%s: Adds a New Task just below the selected one -- more convenient than a lot of move up/move down\n\n"..
"%s: Deletes the Task (SHIFT key must be pressed)\n\n"..
"%s: \n\n"..
"The next two controls determine how a Character perceives the Task.\n\n"..
"%s: Enabled or Disabled. Sets the Default State for the Task.\n\n"..
"%s: Enabled, Disabled, or Default. Allows you to Force a behavior for the Task, not just Override. If Default, the Character will experience the Task's Default for All Characters State, if Enabled or Disabled, it will Force that state regardless.\n\n"..
"For Example: if a Task is set to Disabled, it will remain Disabled on that Character regardless of the Default state.\n\n"..
"%s If any parent Group is Disabled, it will supersede this setting.\n\n"..
"%s: Allows a Task to be Renamed. (You must hit Enter or press the 'Okay' button for the new name to be recognized) \n\n"..
"%s: Determines how or if a Task will be automatically Reset. See '%s' page under this heading for a more in-depth explanation.\n\n"..
"%s: These Tasks can be completed by Any Character and will show completed for All Characters on the Account. One Example would be the Daily Reset, Account Wide Quest for Blingtron. When combined with the Purgable Task Type, Account Wide Tasks are a powerful tool in managing transfers. (See Purgable Tasks)\n\n"..
"%s: Allows you to hide the Task on the selected days.\n\n"

L.AccountWideTask_HelpLabel = "Account Wide Task"
L.AccountWideTask_Help = "Tasks with this property were designed to address Account Wide quests and actions such as Blingtron 4000/5000 where only one Character on the account may do them in a given time period.\n\nWhen one Character completes the Task it will show Completed for All Characters.\n\nThis property may be used with any Task Type. See '%s' for ways to use the Account Wide property to help you manage cross-character Tasks."

L.TaskOptions_TaskActions = " --- Task Actions ---"
L.MoveUp = "^^^"
L.MoveDown = "vvv"
L.plusTask = "+ Task"
L.DeleteTask = "Delete"
L.TaskOptions_TaskOptions = " --- Task Options ---"
L.DefaultForAllChars = "Default for All Characters"
L.ForThisChar = "For This Char..."
L.NB = "Note:"
L.taskName = "Rename Task"
L.ResetType_HelpLabel = "Task Type"
L.awTask_Help = "Account Wide Task"
L.HideDays_help = "Hide Days"


L.ResetType_HelpHeader = "Task Types"
L.ResetType_Help = "%s has 7 task types, 4 Automatically Reset and the remaing 3 have their own special handling characteristics.\n\n"..
"Time of Day and Weekday are configured on the Main Panel under %s under %s and %s respectively. The Time and Weekday should be set to how your computer experiences the server resets. Tasks using these controls will reset within ~5 minutes or at Login if past.\n"


L.ResetType_Help_Automatic = "%s: will reset Each Login or UI Reload. Useful for intra-day tasks (e.g., check Garrison Missions Table, etc)\n\n"..
"%s: will be automatically reset at the Daily Reset Time or at Login if this time has past.\n\n"..
"%s: will be automatically reset at the Daily Reset Time on the Weekly Reset Day or at Login if this time has past on that day.\n\n"..
"%s: will be automatically at Midnight on the Specified Day shown under the heading '%s'.\n\n"..
"%s %s: Day, Month, and Year will show the last relative date the reset was Triggered. You may set this as you like, along with the %s so if wishes to configure a bi-weekly reset one can 'back-date' so that the 14 %s show the proper %s.\n\n"..
"%s %s, in this context, is disabled and used to show the next Trigger date for this Task to reset."

L.ResetType_Help_Other = "%s: Are intended for One-Time-Use (e.g., shopping list, which quest to continue, make sure to do X when at Y, etc). When Completed, these 'purgable' Tasks can be deleted (purged) en masse either from a button in the Reset/AutoReset configuration panel or, much more conveniently, from the DataBroker Object (see %s to configure)\n\n"..
"%s: Hide until your Specified Date then return as a %s. This reduces clutter in your Task List AND prevents you from getting so used to see it that you overlook it when the time comes.\n\n"..
"%s Under %s select the Day, Month, and Year and ~5 minutes of midnight on the selected day, the Task will reappear as a %s.\n\n"..
"%s: These Tasks are persistent. They can be reset individually (by toggling the completed state) or en masse with the Reset Button in the Reset/AutoReset configuration panel."

							
L.AtLoginReset = "At Login"
L.autoReset = "Automatic Resets"
L.ResetCategory_Automatic = "Automatically Reset"
L.ResetCategory_Other = "Other Task Types"
L.resetTypeHelp_Daily = "Daily"
L.resetTypeHelp_Weekly = "Weekly"

L.manReset = "Manual Resets"
L.resetTypeHelp_Manual = "Manual"
L.resetTypeHelp_Purgable = "Purgable"

L.slashEA    = "/ea"
L.paraTask   = "task"
L.paraMytask = "mytask"
L.paraAW     = "+aw"
L.paraVector = ">"

L.TaskWindowNotEnabled = "The Task Window cannot be Shown because it is Disabled"

L.rememberToggleState_name = "Remember Toggle State Between Sessions"
L.rememberToggleState_desc = "Remembers and restores the Toggle State at login/UI reload\n\nIf Unchecked, the Task Window will ALWAYS be shown at login/refresh.\n\n(See Key Bindings to bind a key or See Click Map to setup Toggling from the DataBroker / Minimap Button)"


L.PurgableTask_cmdilne_HelpLabel = "Command Line Examples"
L.PurgableTask_cmdilne_Help = "A logical growth of Manually reset Tasks, Purgables have many utilitarian uses that a persistent Task would not. Designed to be easily entered, they are the default Task Type for Command Line entered Tasks. The examples below show some uses, certainly not all.\n\n"..
"Below are a few (anonymized) samples of Purgable Tasks the author entered during a session to give you a general idea. (See Command Line all the Command Line parameters)\n\n"..
"%s %s transmog headgear\n"..
"%s %s resume quest at 23,53\n"..
"%s %s %s Send 1000g to AltNameHere\n"..
"%s %s %sAltNameHere upgrade the last garrison building to level 2\n"..
"%s %s %s See if AH has [glyph] at a fair price then send to AltNameHere\n"..
"%s %s %sOtherAltName Free up a pet slot and head over to [zonename] for [creaturename]\n"..
"%s %s enterance for [questname] is at 39,55 despite what the map says\n"..
"%s %s %s Lookup the location for [somepet] for next time\n"..
"%s %s %sThirdAltName send stack of [resource] to [currently logged in char]\n\n"..
"Tasks are by-default 'enabled for all' so they will show for each character who is using the Group they are created in. This is good for some special event items you want all characters to do.\n\n"..
"The first parameter you see is %s or %s. The %s parameter is an easy of saying 'only for me' (default Disabled, Enabled for logged in Character).  To do that for a character not logged in, the vector '%s' symbol is used. So the 'Free up a pet slot...' Task will only be visible for OtherAltName.\n\n"..
"However, that's not necessarily the best organizational method -- it really depends on what works best for you.\n\n"..
"If you have a 'Notes and Tasks' group that you dump them into, you really want to make sure they are only Enabled for the alts they apply to but you can also make Child Groups, one for each alt, that is Disabled for a Default but Enabled for the alt.\n\n"..
"Group: 'While In Town' Child Groups: AltNameHere, OtherAltName. The Target Group can be set for either Character and Tasks entered without regard to the Tasks's own visibility to other Characters because the Groups are only Enabled for their respective Characters. (The Command Line Target Group can be set from the Command Line or by a Ctrl-Left-Click on the Group name, so swapping the target is easy) (See Invisible Groups to enhance how this organization method works)\n\n"..
"This simplifies the parameters needed when entering from the Command Line and makes it very easy to know which Task applies to which Character.  In addition, the parent group 'While In Town' is the idea receptacle for Account-Wide Any-Character-Can-Do Tasks.\n\n"..
"The %s parameter denotes the Task is Account-Wide. While not all Characters may be able to do it, only one needs to (such as sending AltNameHere 1000g).\n\n"..
"One could easily have a Group called 'things that need doing' using the aforementioned structure but the author makes extensive use of the Zoom Group feature. Zoom into 'When in Town' when in town, 'Darkmoon Faire' when at the Fair,  'Zone: <name>' when in the <name> Zone, etc and pre-filterers the Tasks for that reason.\n\n"..
"How you organize them should fit how many Tasks you have and how you organize your game-time."

L.PurgableTask_HelpLabel = "Purgable when Completed"
L.PurgableTask_Help = "%s is a special Task Type. It is designed to be One-Time-Use with an easy way to delete completed Tasks (%s) which can be run from the DataBroker Object / Minimap Icon (see %s to configure) or from the %s configuration tab.\n\n"..
"In General, a Purgable Task will disappear when Purging Purgables and the feel is intuitive in use, however they have some important considerations regarding Task Management when not made Account Wide.\n\n"..
"-- Easier Version\n\n"..
"When Purgables are Purged, characters see completed Purgables disappear. Purgable Tasks are deleted from Task Management when all characters using the Task have completed it.\n\n"..
"-- More Complicated Version\n\n"..
"When Purgables are Purged, the Tasks completed on a particular character are 'disabled' thus making the task 'disappear' from the character's point-of-view but it will still show for all other characters using it. When Purgables are Purged after the last character has completed the Task, it is finally considered 'fully complete' and deleted.\n\n"..
"-- AN IMPORTANT CAVEAT -- is that if you create a Purgable Task and do not have at least one character using it, it will be deleted when Purgables are Purged. Sorry about that but the sleight-of-hand noted above is how %s handles the unique meta-complete-state and it creates this very-rare-but-still-possible condition."

L.ReminderTask_HelpLabel = "Reminder Task Type"
L.Reminder_shortName = "Reminders"
L.ReminderTask_Help = "%s are Tasks that Hide until your Specified Date then return as a %s. This reduces clutter in your Task List AND prevents you from getting so used to see it that you overlook it when the time comes.\n\n"..
"When selected, a new section will appear called '%s' and it is here you will set the date.\n\n"..
"Select the Day, Month, and Year and ~5 minutes of midnight on the selected day, the Task will reappear as a %s.\n\n"..
"For Recurring Date-Based Tasks, see '%s' under '%s -> %s'"

L.reminder_NextTrigger = "Next Trigger"
L.reminder_LastTrigger = "Last Trigger"
L.reminder_OffsetDays = "Offset Days"
L.reminder_OffsetDays_desc = "Number of Days to push the Next Trigger Date ahead of the Last Trigger Date"
L.Day = "Day"
L.Month = "Month"
L.Year = "Year"

L.InvisibleGroup_HelpLabel = "Invisible Groups"
L.indentS     = "    "
L.indentL     = "         "
L.ig_AW = "[aw]"
L.ig_purg = "[p]"

L.showLoginAlerts_name = "Show Reset-At-Login Information"
L.showLoginAlerts_desc = "Shows what Task Types were reset when the UI is loaded. This feature is disabled by default as many echew 'load spam'."

L.G1="GROUP When In Town"
L.G2="GROUP ThirdAltName"
L.G3="GROUP AltNameHere"
L.G4="GROUP OtherAltName"

L.task_1 = "transmog legs, weapons"
L.task_2 = "check/replace/update auctions"


L.InvisibleGroup_Help = "%s are a Clutter-Management device, allowing you the ability to have a complex system of management but a simpler form of display. This is not intended to obviate the 'Hide Groups' Group Display mode but rather when there is a disparity-of-need between Task Entry or Configuration and the Display and Completion of the Tasks.\n\n"..
"An Invisible Group tells the the Display to pretend it isn't there and that its Child Groups and Tasks are really part of the Invisible Group's parent.\n\n"..
"In the 'When In Town' example, the Character ThirdAltName will have a Child Group to open with their actions in it. If you like this arrangement (and some do) that's great; however, this really doesn't help you because other Characters' Groups are not visible to ThirdAltName.\n\n"..
"%s\n"..
"    Drop Useful Items (if any) in Guild Bank\n"..
"    %s %s get stack of [item] from AH for AltNameHere\n"..
"    %s %s get 3 [item] for AltNameHere\n"..
"    %s %s get [Glyph] from AH and send to OtherAltName\n"..
"    %s\n"..
"        %s %s\n"..
"        %s\n"..
"    %s\n"..
"        %s Dump Transmog Items in Void Storage\n"..
"    %s\n"..
"        %s Free up a pet slot and head over to [zonename]\n"..
"    %s %s Send 1000g to AltNameHere\n\n"..
"If each Character-Specific Group is made invisible, then the list of Tasks each character sees is both tailored to them AND seamless. Thus ThirdAltName sees the following: \n\n"..
"%s\n"..
"    Drop Useful Items (if any) in Guild Bank\n"..
"    %s %s get stack of [item] from AH for AltNameHere\n"..
"    %s %s get 3 [item] for AltNameHere\n"..
"    %s %s get [Glyph] from AH and send to OtherAltName\n"..
"    %s %s\n"..
"    %s\n"..
"    %s %s Send 1000g to AltNameHere\n\n"..
"Do note that Base Groups cannot be made %s as their parent is inaccessible to the user, only Child Groups."


L.ifUsed_isHidden_name = "Task Window Hidden"
L.ifUsed_isHidden_desc = "This option is a Quick Reference to display the Task Window Show/Hide state, instead of wondering why it's enabled but you can't find it.\n\nClicking will change the toggle Show/Hide."

L.UseThisChar_Label = "%s Will be Used"
L.UseThisChar_H = "Will be Used"
L.UseThisChar_header = "Will be Used on This Character"
L.UseThisChar_help = "%s\n\nThis icon means that the Group or Task %s by the Point of View Character selected.\n\n"
L.UseThisChar_help_R = "%s\n\nThis icon means that the Task is a %s Task Type (see %s) and %s by the Point of View Character selected.\n\n"

L.DoNotUseThisChar_Label = "%s Will Not be Used"
L.DoNotUseThisChar_H = "Will Not be Used"
L.DoNotUseThisChar_header = "Will Not be Used on This Character"
L.DoNotUseThisChar_help = "%s\n\nThis icon means that the Group or Task %s by the Point of View Character selected.\n\n"
L.DoNotUseThisChar_help_R = "%s\n\nThis icon means that the Task is a %s Task Type (see %s) and %s by the Point of View Character selected.\n\n"

L.GroupDisabled_Label = "%s Cannot be Used"
L.GroupDisabled_H = "Cannot be Used"
L.GroupDisabled_header = "Cannot be Used on This Character"
L.GroupDisabled_help = "%s\n\nThis icon means that the Group or Task %s by the Point of View Character selected because a parent Group has been Disabled by Default or has been set to Default for this Character.\n\n"

L.Delete_SafetyMeasureMessage = "Press Shift to Delete. This is a safety precaution against accidental deletion."

L.FontsAndColors = "Fonts and Colors"
L.Fonts_hdr = "Fonts"
L.Colors_hdr = "Colors"
L.Fonts_help = "Fonts and Font Sizes are used in both Tooltip and Task Window displays.\n\n"..
"%s: This is the font used for Collapsible Headers\n\n"..
"%s: This is the font used for Items that can be checked/completed\n\n"..
"%s: This is the font used for the Zoom Group display beside the buttons on the respective displays."
L.Font_1 = "Header Font"
L.Font_2 = "Standard Font"
L.Font_3 = "Zoom Group Font"


L.Colors_help = "Colors are used in both Tooltip and Task Window displays.\n\n"..
"%s: Sets the normal text color for Group Headers\n\n"..
"%s: Sets the normal text color for Tasks\n\n"..
"%s: Sets the text color for Task Completion Counts displayed on Group headers\n\n"
L.color_1 = "Normal Group Color"
L.color_2 = "Normal Task Color"
L.color_3 = "Count Color (group)"


L.SpecialTypes = "Special Types"
L.SpecialTypes_help = "There are six Special Types, three for Tasks and three for Groups.\n\n"..
"%s %s: Any Character on the Account may complete and will show complete for Characters. \n\n"..
"%s %s: Purgable when Complete, a One-Time-Use type Task. \n\n"..
"%s %s: Hides until a Date you specify, then reappears as a %s\n\n"..
"%s %s: Group categorization does not display but its child Groups and Tasks show under its parent.\n\n"..
"%s %s: Tasks entered from the Command Line will display under this group.\n\n"..
"%s %s: Will 'zoom in' to this group (displaying only it and its child Groups and Tasks) when the display is set to the Zoom Mode"
L.spctype_TASK = "TASK"
L.spctype_aw = "Account Wide"
L.spctype_pwc = "Purgable Task"
L.spctype_reminder = "Reminder Task"
L.spctype_GROUP = "GROUP"
L.spctype_i = "Invisible"
L.spctype_cmt = "Command Line Target"
L.spctype_zg = "Zoom Group"


L.resetAll_desc = "Runs the Task Reset for all Tasks; Tasks will reset based on their individual criteria."
L.ZoomIsLoggedInCharOnly = "Zoom Group must belong to [%s], the logged in character."


L.CommandLineHelp_Introduction = "The Command Line options are designed for quick access to functions and not necessarily comprehensive. Specialized characters (e.g., >, +, etc) should NOT include a space after them ('> MyAltChar' is bad, '>MyAltChar' is good)\n\n"..
"To Access them, use %s or %s, depending on your preference."
L.cmdline_ea = "/ea"
L.cmdline_exa = "/exa"
L.CommandLineHelp_config = "Open Addon Configuration"
L.CommandLineHelp_manage = "Manages Groups, Tasks, and Characters (config)"
L.CommandLineHelp_task = "Add Task enabled for all (purgable=default)\n : +aw=Account Wide\n : [>MyAltChar] enables the task for that alt and disables for all others)\n [|cffff9966usage: /ea task [+daily|+weekly|+manual|+login|+reminder|+calendar] [+aw] [>AltCharName] <task name>|cffdeb887]\n\nTask Redirection (>MyAltChar) obeys unique partial matches and accepts server names, for same name, different server situations. In this way 'Mychar-th' selects 'Mychar - Thorium Brotherhood' not 'MyChar - Silver Hand'. NOTE: redirector names should be a single, contiguous string with no spaces (e.g., >mychar-thoriumbrotherhood). "
L.CommandLineHelp_mytask = "Add Task only enabled on this character (purgable=default) : +aw=Account Wide) [|cffff9966usage: /ea mytask [+daily|+weekly|+manual|+login|+reminder|+calendar] [+aw] <task name>|cffdeb887]|r"
L.CommandLineHelp_setgroup = "Resets the command-line-entered Task Target to the specified group. [|cffff9966usage: /ea setgroup <case-insensitive group name>|cffdeb887]|r"
L.CommandLineHelp_npc = "Adds a 'character' of the name provided. [|cffff9966usage: /ea npc <case-insensitive label>|cffdeb887]|r]  |cff00ffff(see Help section 'NPC Feature' for more information about this feature)"


L.CommandLine_Label = "Command Line"
L.CommandLineTarget = "Command Line Target"
L.CommandLineTarget_Help = "Makes the Group the target for Tasks entered from the Command Line. (See Also 'Command Line')\n\n This property may be set from the %s panel; on-the-fly from the command line (%s); from both Tooltip Display and Task Window with the Mouse and Key Combination %s."
L.eaSetGroup = "/ea setgroup"
L.CLC = "CTRL+Left-Click"

L.ZoomGroup_Label = "Zoom Group"
L.ZoomGroup_Help = "A Group marked as the Zoom Group will, in the appropriate Group Display Mode (see '%s') show only that group and any child Groups and Tasks.\n\n"..
"The Group may be subsequently expanded or collapsed in other Group Display modes but still 'zoom in' when in the appropriate Group Display Mode.\n\n"..
"A Zoom Group is selected by Right-Clicking on a Group Header. When no Zoom Group is selected, the Display will react similarly to Show Visible Groups so the user may wish to use it as a zoom-toggle. "


L.SpecialTypeControls = "Special Type Controls"
L.SpecialTypeControls_help = "Styling %s allows you to easily identify them when looking at a Display.\n\n(Not all Styles can be applied in all circumstances (e.g., Tooltip can be styled by Cell or by Line but the Task Window interprets either to style the entire Button) but close approximations are made. Only the configuration panels differ widely and some design choices had to be made due to constraints of that framework.)\n\nEach Type has the same controls and some choices will enable others based on their logical need.\n\n"..
"%s: If Enabled, the Special Type will be Styled as described, otherwise it will be Unstyled.\n\n" ..
"%s: Resets the Style to its default state.\n\n"..
"%s: Determines If and How a Text-based style will be used. Options include %s, %s, %s, & %s. These position the %s text as described.\n\n"..
"%s: You can use whatever text you wish to use but it is suggested to keep the length under 4 chars, especially if Styling both sides (either for the same Type or different Types\n\n"..
"%s: Determines If and How color is applied to the Style. Options include %s, %s, %s, %s, & %s.\n\n"..
"%s: Label kinda speaks for itself."

L.st_us_1 = "Do Not Use"
L.st_us_2 = "Left"
L.st_us_3 = "Right"
L.st_us_4 = "Left and Right"

L.st_uc_2 = "Only 'Use Text' Text"
L.st_uc_3 = "Cell Text"
L.st_uc_4 = "Cell Background"
L.st_uc_5 = "Line Background"


L.StyleTooltip = "Style Tooltip"

L.Background = "Background"
L.BackgroundColor = "Background Color"

L.Border = "Border"
L.BorderColor = "Border Color"

L.BorderEdgeSize = "Border Edge Size"

L.CompletedTasks = "Completed Tasks..."
L.styleTooltip_name = "Style LDB Tooltip"

L.BorderInset = "Border Inset"

L.TextShadow = "Text Shadow"

L.FontShadowColor = "Font Shadow Color"
L.FontShadowXOffset = "Font Shadow X-Offset"
L.FontShadowYOffset = "Font Shadow Y-Offset"


L.showChecked_name = "Show Completed Tasks"
L.showChecked_desc = "Toggles the showing or hiding of Completed Tasks"

L.rightMouseOnTask_name = "Show Completed Tasks, Toggle with Right Mouse"
L.rightMouseOnTask_desc = "If enabled, right-clicking on a tooltip task will toggle 'Show Completed Tasks'"


L.STcontrols_us = "Use Style"
L.STcontrols_rd = "Reset Default"
L.STcontrols_tg = "Text Group"
L.STcontrols_ut = "Use Text"
L.STcontrols_ttu = "Text to Use"
L.STcontrols_uc = "Use Color"
L.STcontrols_ctbu = "Color to be Used"
L.DisplayInterface = "Display Interface"

L.di_GettingStarted = "--> Getting Started..."
L.di_GettingStarted_L = "Getting Started"
L.Similar = "What's the Same"
L.Different = "What's Different"

L.you = "you"
L.DT = "Do Things"
L.AQ = "Answer Questions"
L.DisplayInterface_Intro = "This information is provided by way of answering questions about disparity in functionality between the DataBroker Tooltip and the Task Window. The 'proper way to use' %s is the way that works best for %s.\n\n"..
"%s strives to provide you unobtrusive reminders, easy answers to questions, and an avoidance of waking up in the middle of the night wondering 'Did I...?' To balance those objectives -- the minimum approach to maximum predigested information -- the Task Window and DataBroker Tooltip are designed to serve different purposes.\n\n"..
"%s may be used perfectly well without the Task Window, and quite well without the DataBroker Tooltip (though with a loss of some functionality) -- technically, you can use it without either but it's hard to get anything done that way.\n\n"..
"The purpose of the Task Window is to '%s' and the purpose of the DataBroker Tooltip is to '%s'. What Tasks need to be performed is an Always-Up bit of information whereas 'Did I remember to check off [SomeImportantTask] on [SomeOtherCharacter]?' or 'Who hasn't done [CritiallyImportantTask] yet?' are questions whose answers you don't need all the time.\n\n"..
"This is the reason behind the Task Window being restricted to showing only the character currently logged in rather than being expanded to the display functionality of the DataBroker Tooltip and why it lacks the 'Show All' Group Display Mode. (There are some minor technical concerns too but the overarching reason is as stated).\n\n"..
"The DataBroker Tooltip mirrors the Task Window functionality both because to do so was an intuitive non sequitur and because in certain circumstances the author found turning off the Task Window and just using the Tooltip to be a advantageous (e.g., characters with few Tasks assigned; important addon already in the spot most convenient for %s)"

L.di_Group = "Group"
L.di_Task = "Task"
L.DisplayInterface_SimilarIntro = "All Click-Functions for Group Headers and Tasks:\n\n"..
"%s:\n"..
"Zoom Group (Mark/Reset/Unmark) :: Right-Mouse\n"..
"Command Line Target (Mark/Reset/Unmark) :: Ctrl+Left-Mouse\n"..
"Expand/Collapse Group :: Left-Mouse\n"..
"Expand/Collapse Group and Siblings :: Shift+Left-Mouse\n\n"..
"%s:\n"..
"Complete/Not Complete: Left-Mouse\n"..
"Show/Hide Completed Toggle: Right-Mouse\n\n"..
"Zoom Group Name is displayed next to the Group Display Mode buttons\n\n"..
"%s  Show 'Visible' Groups %s  Hide Group Headers\n%s  Display Zoom Group"

L.Diff_TaskWindow = "Task Window"
L.Diff_Tooltip = "DataBroker Tooltip"
L.DisplayInterface_DifferentIntro = "Vive la difference\n\n"..
"%s: The %s handles them in a side-by-side display while the %s handles them in a 'ring' from the Second-From-Left Button (Note: the user may select which modes are used in the %s configuration). The handling difference is due to function, usage patterns, and configurability tempered with display considerations and feedback.\n\n"..
"%s:\n"..
"%s This icon serves a couple features, some designed for folks who don't wish to use a DataBroker Object.\n"..
"      Open Config Panel: Left-Mouse\n"..
"      Lock/Unlock Window Position: Shift+Left-Mouse\n"..
"      Show/Hide Task Window Tooltips: Right-Mouse\n\n"..
"%s:\n"..
"%s Show ALL Groups -- this is an extra Group Display Mode that will display Invisible Groups w/o having to go into the %s panel.\n\n"..
"%s and %s Toggle between Showing the Current Character and All Characters\n"..
"%s and %s Toggle between Tasks by Character and Character by Task (reverse index) modes."

L.Tooltip_label = "Tooltip (DataBroker)"

L.GroupDisplayModes_1 = "Show 'Visible' Groups"
L.GroupDisplayModes_2 = "Show ALL Groups"
L.GroupDisplayModes_3 = "Show Zoom Group"
L.GroupDisplayModes_4 = "Hide Group Names"
L.InvisAsNorm = "Invisible Groups will be treated as Normal Groups"
L.Ifyoudonotuse = "If you do not use Invisible Groups, this mode should be disabled from the DataBroker Tooltip"

L.GroupDisplayModes = "Group Display Modes"
L.DisplayInterface_GroupDisplayModes = "\n\n"..
"How Groups are used or how they need to be displayed may change depending Character, play-style, how you use %s, or what you're trying to accomplish at a particular moment. The %s offers three of the modes in a side-by-side display while the %s offers them in a 'ring' from the Second-From-Left button.\n\n"..
"%s %s\n"..
"Group Headers will be shown and Invisible Groups will follow their normal behavior. (See 'Invisible Groups' under %s for more information)\n\n"..
"%s %s\n"..
"Same as %s except that %s. This Display Mode is intended to help the user debug their use of Invisible Groups and reference the origin of a Task or Child Group. %s as it will provide no net benefit over %s\n\n"..
"%s %s\n"..
"Displays the Zoom Group if selected, %s if not. The Zoom Group can be set/reset/unset on the fly (Right-Click on the Group Header). (See 'Zoom Groups' under %s)\n\n"..
"%s %s\n"..
"No Group Names will be displayed and all Tasks will consider their parents to be Expanded: no Group with All Tasks. This is a convenient display for Characters with simpler configurations or when you just don't need Group Headers.\n\nTask indentation is intentionally retained in part as a readability issue (avoids wall-of-text effect) and in part to help you quickly locate the Task you're looking for (familiarity with their position in the list and indentation)"

L.DisplayInterface_GroupDisplayModes_short = "\n\n"..
"How Groups are used or how they need to be displayed may change depending Character, play-style, how you use %s, or what you're trying to accomplish at a particular moment. The %s offers three of the modes in a side-by-side display while the %s offers them in a 'ring' from the Second-From-Left button.\n\n"..
"%s %s\n"..
"Group Headers will be shown and Invisible Groups will follow their normal behavior. (See 'Invisible Groups' under %s for more information)\n\n"..
"%s %s\n"..
"Displays the Zoom Group if selected, %s if not. The Zoom Group can be set/reset/unset on the fly (Right-Click on the Group Header). (See 'Zoom Groups' under %s)\n\n"..
"%s %s\n"..
"No Group Names will be displayed and all Tasks will consider their parents to be Expanded: no Group with All Tasks. This is a convenient display for Characters with simpler configurations or when you just don't need Group Headers.\n\nTask indentation is intentionally retained in part as a readability issue (avoids wall-of-text effect) and in part to help you quickly locate the Task you're looking for (familiarity with their position in the list and indentation)"


L.LayoutType = "Layout Type"
L.LayoutType_help = "\n\n"..
"We're all familiar with a Character having a list of Tasks to do. %s provides its reverse: a Task having multiple Characters that need to do it. It is available from the %s.\n\n"..
"%s %s\n"..
"This is the normal orientation for a 'to-do' list: Characters are the main Category, followed by the Groups Enabled for the Character then the Tasks in those Groups.\n\n"..
"%s %s\n"..
"This reverses the normal index. Groups and their Tasks are both categories, when a Task is Expanded, the Characters for which it is Enabled are displayed. This provides a fast answer to which Characters have/have not done a Task or Group of Tasks."

L.TaskByChar = "Tasks by Character"
L.CharByTask = "Characters by Task"

L.CurrentChar = "Currently Logged In Character"
L.AllChars = "All Characters"
L.DispChars = "Displayed Characters"
L.DispChars_help = "\n\n"..
"In the same vein as the Characters by Task Layout Type, %s provides you access to all the Characters (you may even complete a Task for another Character if you forgot to do so when they were logged in). This display is available from the %s.\n\n"..
"%s %s\n"..
"Single Character Display, which will be the Currently Logged In Character. Useful if you're not using the Task Window. \n\n"..
"%s %s\n"..
"All Characters are displayed. Default will be Collapsed Headers and Groups for all but the Currently Logged In Character (which will follow the preferences you've selected) but Collapse/Expand will be remembered for the session.\n\nTo Complete (or mark Not Complete) a Task for another Character, the Shift-key must be held.\n\nAs a Technical Note, due to how LibQTip works, refresh performance suffers with the number of lines displayed so it is not advised to exceed 140 lines (which itself requires a good deal of scrolling) as performance degradation from its re-size bottle-neck becomes noticeable." 


L.Complete = "Complete"
L.Complete_full = "Task is Complete"
L.NotComplete = "Not Complete"
L.NotComplete_full = "Task has Not Been Completed"

L.Complete_help = "\n\nTask has been Completed by the associated Character."
L.NotComplete_help = "\n\nTask has Not been Completed by the associated Character."


L.ToolTip_GettingStarted="Help with the Configuration Options is available in the next panel: %s\n\n%s Icon Help sections are duplicated for convenience but for more detailed information on the DataBroker Tooltip Display itself, See %s."

L.TooltipConfig = "Tooltip Configuration"

L.CharSpecificI = "["
L.CharSpecific = "Character Specific"
L.CharSpecificO = "]"
L.TooltipConfig_Help = "%s: %s%s%s Toggles use of the DataBroker Display on Mouseover. The Tooltip can still be accessed via Click on the DataBroker Object if desired (see %s configuration)\n\n"..
"%s: Time Delay (in seconds) for the tooltip display to hide when the mouse is not over it.\n\n"..
"%s: Places the Tooltip Buttons at the Top or Bottom of the Tooltip. It is strongly suggested that you set these to be near the DataBroker Object to avoid inadvertent collapsing of the Tooltip.\n\n"..
"%s: Toggles Display of Tooltips for the Buttons and areas on the DataBroker Tooltip. This action can also be bound to the DataBroker Object (see %s configuration)\n\n"..
"%s: Determines the default %s for the Tooltip. Users who rely on the %s for Completing Tasks may wish to set the Default to '%s'  (See %s for for a more in-depth description of the organization of each Type)\n\n"..
"%s & %s: The Group Display Modes Button will cycle through the selected Display Modes. Few people will use all Display Modes, even those who eschew the %s. It is suggested that you review the %s panel (under this Help section or under %s) for deeper explanations. Then deselect the modes you don't find useful -- if all are unchecked, the Default selection will be the only available Display Mode\n\n"..
"%s: If Unchecked, All Characters will be Displayed on the Tooltip. This setting can be toggled from the Tooltip itself (see %s under this Help section or under %s) \n\n"..
"%s: Purely aesthetic -- some users prefer the Currently Logged In Character's name always in the Tooltip Display, others only when warranted.\n\n"..
"%s: If Enabled, the Currently Logged In Character's Header will be automatically Expanded. This is advantageous if you have All Characters displayed in the Tooltip as it saves you a step reaching the Current Character.\n\n"..
"%s: This setting helps with clutter management. An Empty Group has no Tasks available and may come about for a number of reasons (they may be disabled for the character, hidden for that day, etc). If Enabled, Child Groups that are themselves empty will not be considered an entry so a Group whose only entries are two empty Child Groups will itself be considered empty.\n\n"..
"%s: Prevents an 'empty' Character catetory by hiding the Character when All Tasks are Completed and '%s' (see below for explanation) is NOT enabled.\n\n"..
"%s: If Enabled [CharacterName - ServerName]; if Disabled [CharacterName]. This only affects the Display, %s will still be able to tell same-name-but-different-server Alts apart.\n\n"..
"%s: If checked, character name will be the primary sort. If unchecked, server name will be the primary sort. Examples: If checked, all chars with the name 'soandso' will be grouped together. If unchecked chars named 'soandso' will not be grouped together but with their fellow server chars.\n\n"..



"%s: Controls the use of a Mouseover texture for the Tooltip cells. Most users prefer them enabled so they are certain which cell/button the mouse is over but others are crazy-brave and certain of themselves.\n\n"..
"%s: Counts refer to the Complete/Not Complete counts of Tasks. Four type of display are available: 'Completed / Total', 'Completed / Not Completed', 'Not Completed', 'Percent Completed'. %s will display them on Group Headers while %s will display them in the Text element of the DataBroker feed.\n\n"..
"%s: Shows/Hides Completed Tasks from the Tooltip.\n\n"..
"%s: Enables/Disables the ability to use a Right-Mouse click on a Task to toggle the Show/Hide mode. It is suggested to leave this enabled but a few users may find it problematic for various reasons."


L.WindowStyle = "Window Style"
L.TaskWindowConfig = "Task Window Configuration"
L.TaskWindow_GettingStarted = "Help with the Configuration Options is available in the next panel: %s\n\n%s Icon Help sections are duplicated for convenience but for more detailed information on the Task Window Display itself, See %s."

L.TaskWindowConfig_Help = "%s: %s Toggles use of the %s. This can also be toggled from the DataBroker Object if desired (see %s configuration)\n\n"..
"%s: Remembers and restores the Toggle State at login/UI reload (See Key Bindings to bind a key or Click Map to setup Toggling from the DataBroker / Minimap Button)\n\n"..
"%s: %s If Enabled, the Current Character will be able to set the %s position specifically for them; otherwise, it will use the global position.\n\n"..
"%s: Places the Task Window Buttons at the Top or Bottom of the %s.\n\n"..
"%s: Toggles Display of Tooltips for the Buttons and areas on the %s. This can be toggled from the %s itself (Right-Mouse on the Gear Icon)\n\n"..
"%s: Controls the use of a Mouseover texture for the Task Window Buttons. Most users prefer them enabled so they are certain which button the mouse is over but others are crazy-brave and certain of themselves.\n\n"..
"%s: If Enabled, the %s will be hidden during combat.\n\n"..
"%s and %s: These settings determine the Opacity (or Transparency, if you prefer) of the %s. Opacity of 0%% to 100%% are permissible. NOTE: These controls are independent so one may set the Mouseover Opacity lower than the Normal Opacity, if that's your sort of thing.\n\n"..
"%s: concerns window growth and movability.\n\n"..
"%s: Sets the point of the %s that doesn't move when the %s Grows/Shrinks to accommodate size of the Group and Task Names. It is highly recommended you set this point to the part of the Screen that %s nearest (e.g., if the %s is placed in the lower-right of the screen, set the point to be BOTTOMRIGHT). The default is CENTER. \n\n"..
"%s: Whether or not the %s is movable. (It can be toggled with Shift+Left-Click on the Gear icon)\n\n"..
"%s: Displays a 'drag-handle' Border around the %s when it is movable. Move the Task Window using the area Left of the Task Window Buttons if you prefer to Disable the Border. \n\n"..
"%s: This setting helps with clutter management. An Empty Group has no Tasks available and may come about for a number of reasons (they may be disabled for the character, hidden for that day, etc). If Enabled, Child Groups that are themselves empty will not be considered an entry so a Group who's only entries are two empty Child Groups will itself be considered empty.\n\n"..
"%s: %s\n\n"..
"%s: %s\n\n"..
"%s: Counts refer to the Complete/Not Complete counts of Tasks. Four type of display are available: 'Completed / Total', 'Completed / Not Completed', 'Not Completed', 'Percent Completed'. %s will display them on Group Headers.\n\n"..
"%s: Shows/Hides Completed Tasks from the Tooltip.\n\n"..
"%s: Enables/Disables the ability to use a Right-Mouse click on a Task to toggle the Show/Hide mode. It is suggested to leave this enabled but a few users may find it problematic for various reasons.\n\n"..
"%s: \n!! Experimental Feature !!\n\n Hides Task Window if '%s' is disabled and all Tasks have been Completed. WARNING: this will effectively DISABLE the ClickMap 'Toggle Task Window' feature as the Task Window Toggle State is constantly reset by *this* feature. Use at your own risk.\n\n"..
"%s: Sets the Frame Strata, allowing you to raise or lower where the Task Window is in the frame hierarchy.\n\n"..
"%s: Set the Type and Color for the %s Background and Border."

L.ResetAutoreset = "Reset/Autoreset"
L.ResetAutoreset_help = "The button on the %s panel are provided for completeness, problem recovery, or after a File Cabinet restore.\n\nThe available actions are %s; %s and %s; %s; and finally %s, which is available from the %s to be bound to the DataBroker Object."

L.StyleMgr_DefaultSpecialFlags_HelpHeader = "Default Special Flags"
L.StyleMgr_DefaultSpecialFlags_Help = "Special Flags are set by the %s and can be changed whenever you like. This section describes their DEFAULT appearance.\n\n"..
"Default Group Special Flags\n\n"..
"%s -- comand line target\n"..
"%s -- Invisible\n"..
"%s -- Zoom Group\n\n"..
"Default Task Special Flags\n\n"..
"%s -- Account Wide\n"..
"%s -- Purgable\n\n"

L.StyleMgr_cmdline = "(c)"
L.StyleMgr_Invisible = "(I)"
L.StyleMgr_Zoom = "[Z]"
L.StyleMgr_AcctWide = "*"
L.StyleMgr_Purgeable = "{p}"


L.reorg_Moving = "Moving "
L.reorg_group = "Group: "
L.reorg_task = "Task: "
L.reorg_ReorgTitle = "Reorganize Groups and Tasks"
L.reorg_PickUp = "Pick Up"
L.reorg_PickUp_desc = "Pick Up this object to move to another group"
L.reorg_PutDown = "Put Down"
L.reorg_PutDown_desc = "Put Down the moving object into this group"
L.reorg_PutInRoot = "Put In Root"
L.reorg_PutInRoot_desc = "Move the Group to the Root"

L.Reorganization_desc = "Reorganization Mode: Allows moving of Tasks and Groups"
L.Reorganization_HelpLabel = "Reorganization"
L.Reorganization_ControlName = "Reorganize"
L.Reorg_ReorgMode = "Reorganization Mode"
L.Reorg_GroupTaskConfigMode = "Group and Task Configuration Mode"
L.Reorg_GA = "Group Actions"
L.Rerog_TA = "Task Actions"
L.Reorganization_Help = "Reorganizing Groups and Tasks takes on two forms.\n\n"..
"The first is a simple Move Up / Move Down and these controls are available as part of the normal %s and %s.\n\n"..
"The second is moving a Group or Task from one Group to another and for this a Pick-Up/Put-Down method is used. The %s checkbox (see %s) will switch between %s and %s.\n\n"..
"In %s, the normal %s and %s sections are replaced by %s\n\n"..
"%s: Stores a Group or Task to be moved. This may be done multiple times and only the last to be Picked Up will be remembered.\n\n"..
"%s: Puts Down the Group or Task into the desired Group.\n\n"..
"%s: Places the Group in the Root the way 'Add New Task Group' does. Nota Bene: This is considered an intim workaround as it is somewhat less intuitive that it might otherwise be."


L.useDragFrame_Name = "Border"
L.useDragFrame_Desc = "Creates a 'drag-handle' Border around the Task Window when not Locked.\n\nMove the Task Window using the area Left of the Task Window Buttons if you prefer to Disable the Border."

L.dragFrameTooltip = "Moving/Positioning Border. This border will disappear when the Task Window is Locked.\n\n(Shift-Left-Click the Gear icon to quickly toggle Task Window Locking)"

L.UseResizableConfig_name = "Use Resizable Configuration Dialog"
L.UseResizableConfig_desc = "Resizable Configuration Dialog will be used when the config is opened from Command Line, DataBroker Object / Minimap, or Task Window. Nota Bene: Checking this option WILL NOT REMOVE configuration from Blizzard Options panel."


L.blizzyOpts_blurb = "%s Configuration Dialogs can be reached with the '%s' button below. They can alternatively be reached from the DataBroker / Minimap Button, Task Window, or Command Line (/ea config).\n\n'%s' is self-explanatory and Easy Access buttons for Help and '%s' will open the Click Map Configuration panel.\n"
L.blizzyOpts_buttonName_config = "Open Configuration"
L.blizzyOpts_buttonName_help = "Open Help"
L.blizzyOpts_buttonName_clickmap = "Open Click Map"

L.paranoia_Alert = "Unable to Set Proper Date on Task: "


L.FileCabinet = "File Cabinet"
L.FileCabinet_NB = "must be Enabled in the Addons list."
L.FileCabinet_intro = "%s is a backup and restore utility for %s.\n\n%s %s\n\nThe backups and restores from this utility are real-time which gives the user some flexibility in its use.\n\nFor users who don't run regular backups of their addons and saved variables directories (seriously back up these directories regularly!) this can serve as a backstop against loss of Group, Task, and Character configuration.\n\nThe real-time nature also allows the user to backup a configuration, try something new, and revert if it doesn't work out as planned.\n\nTaking that a bit further, one may work on a new layout bits and pieces at at time. Backup the Working configuration then begin work on the New. Backup unfinished New and restore Working. Then restore the New when you want to work on it some more, back it up and restore the Working copy, etc, until complete. (NB: Character Task Completion is stored but not Account Wide. Completion data was originally intended to be purged however it was requested that the error be retained to facilitate this process...The developer is still deciding if this is a 'bug' or a 'feature')" 

L.managedByModule_Prefix = "Managed by" -- "Managed by Module"
L.AssociatedToModule_Prefix = "Associated to Module"

L.HideTaskWindowControlButtons_name = "Hide Task Window Control Buttons"
L.HideTaskWindowControlButtons_desc = "Hide Task Window Control Buttons when Not Moving\n\nWhen No Groups or Tasks are displayed, only the window frame will be displayed."
