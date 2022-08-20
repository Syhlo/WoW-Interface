
MegaMacroConfig = nil
MegaMacroGlobalData = {
	["Macros"] = {
		{
			["Id"] = 7,
			["ScopedIndex"] = 7,
			["Code"] = "/target [@party2]\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 4238932,
			["DisplayName"] = "",
		}, -- [1]
		{
			["Id"] = 8,
			["Code"] = "#showtooltip\n/use 13\n",
			["Scope"] = "gg",
			["ScopedIndex"] = 8,
			["StaticTexture"] = 134400,
			["DisplayName"] = " ",
		}, -- [2]
		{
			["Id"] = 9,
			["Code"] = "#showtooltip\n/use 14\n",
			["Scope"] = "gg",
			["ScopedIndex"] = 9,
			["StaticTexture"] = 134400,
			["DisplayName"] = " ",
		}, -- [3]
		{
			["Id"] = 6,
			["ScopedIndex"] = 6,
			["Code"] = "/target [@player]\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 4239318,
			["DisplayName"] = " ",
		}, -- [4]
		{
			["Id"] = 5,
			["ScopedIndex"] = 5,
			["Code"] = "/target [@party1]\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 4238928,
			["DisplayName"] = " ",
		}, -- [5]
		{
			["Id"] = 4,
			["Code"] = "#showtooltip\n/petpassive\n/cast Polymorph\n",
			["Scope"] = "gg",
			["ScopedIndex"] = 4,
			["StaticTexture"] = 134400,
			["DisplayName"] = " ",
		}, -- [6]
		{
			["Id"] = 11,
			["ScopedIndex"] = 11,
			["Code"] = "/target arena2\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 2399261,
			["DisplayName"] = "  Target Arena2",
		}, -- [7]
		{
			["Id"] = 12,
			["ScopedIndex"] = 12,
			["Code"] = "/target arena3\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 2399247,
			["DisplayName"] = "  Target Arena3",
		}, -- [8]
		{
			["Id"] = 13,
			["ScopedIndex"] = 13,
			["Code"] = "/click StaticPopup1Button1\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 3565717,
			["DisplayName"] = " Annoying Prompt",
		}, -- [9]
		{
			["Id"] = 16,
			["ScopedIndex"] = 16,
			["Code"] = "/target arena1\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 2399263,
			["DisplayName"] = " Target Arena1",
		}, -- [10]
		{
			["Id"] = 17,
			["ScopedIndex"] = 17,
			["Code"] = "/cancelaura Kevin's oozeling\n/run local a,b,c,d=\"Conjured Mana Bun\",\"Ambroria Dew\",\"Drink\" d=GetMacroBody(c)EditMacro(c,c,nil,strsub(d,1,strfind(d,\";\\n\"))..\"\\n/use \"..(GetItemCount(a)>0 and a or b));\n/use Conjured Mana Bun\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 134400,
			["DisplayName"] = "Drink",
		}, -- [11]
		{
			["Scope"] = "gg",
			["StaticTexture"] = 237386,
			["Code"] = "/way 55.14 27.42 Oats (Day 1)\n/way 56.26 30.17 Oats (Day 1)\n/way 52.16 33.56 Oats (Day 1)\n/way 51.02 39.08 Oats (Day 1)\n/way 46.57 37.79 Oats (Day 1)",
			["Id"] = 1,
			["IsStaticTextureFallback"] = true,
			["ScopedIndex"] = 13,
			["DisplayName"] = "TomTom",
		}, -- [12]
	},
	["Activated"] = true,
	["Classes"] = {
		["Rogue"] = {
			["Macros"] = {
				{
					["Id"] = 61,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip sap\n/cleartarget\n/targetenemyplayer\n/cast sap\n",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 1,
					["DisplayName"] = "",
				}, -- [1]
				{
					["Id"] = 62,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@focus, exists] [] Blind\n",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 2,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Id"] = 63,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@focus, exists] [] Kick\n",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 3,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Id"] = 68,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Cheap Shot\n",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 8,
					["DisplayName"] = "",
				}, -- [4]
				{
					["Id"] = 70,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Kidney Shot\n",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 10,
					["DisplayName"] = "",
				}, -- [5]
				{
					["Id"] = 72,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@focus,exists] Sap; Sap",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 12,
					["DisplayName"] = "",
				}, -- [6]
			},
			["Specializations"] = {
				["Subtlety"] = {
					["Macros"] = {
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Shadowstrike\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = "",
							["Specialization"] = "Subtlety",
							["Id"] = 91,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 1,
						}, -- [1]
						{
							["Code"] = "#showtooltip Echoing Reprimand\n/stopmacro [noharm]\n/cast Shadow Dance\n/cast Symbols of Death\n/cast Echoing Reprimand\n/cast [@party1] Tricks of the Trade\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = "",
							["Specialization"] = "Subtlety",
							["Id"] = 94,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 4,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast Shadow Blades\n/cast Ancestral Call(Racial)\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = "",
							["Specialization"] = "Subtlety",
							["Id"] = 96,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 6,
						}, -- [3]
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Rupture\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = " ",
							["Specialization"] = "Subtlety",
							["Id"] = 93,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 3,
						}, -- [4]
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Backstab\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = " ",
							["Specialization"] = "Subtlety",
							["Id"] = 95,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 5,
						}, -- [5]
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Eviscerate\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = " ",
							["Specialization"] = "Subtlety",
							["Id"] = 92,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 2,
						}, -- [6]
					},
				},
			},
		},
		["Druid"] = {
			["Macros"] = {
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 1,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/cast Barkskin\n/stopmacro [equipped:tabard]\n/use 13",
					["Id"] = 61,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [1]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 9,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Mangle",
					["Id"] = 69,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 7,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Shred",
					["Id"] = 67,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 11,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Rip",
					["Id"] = 71,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [4]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 4,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/cast [@focus] Cyclone",
					["Id"] = 64,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [5]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 6,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/cast [nostealth] Shadowmeld\n/cast !Prowl",
					["Id"] = 66,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [6]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 2,
					["Class"] = "Druid",
					["Code"] = "/cast [flyable,outdoors] [combat,outdoors] [swimming,outdoors] [@party4,noexists,outdoors] Travel Form; [indoors] Cat Form; [outdoors] Thundering Ruby Cloud Serpent",
					["Id"] = 62,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [7]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 3,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/cast [@focus] Entangling Roots",
					["Id"] = 63,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [8]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 5,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/cast [@focus] Mighty Bash",
					["Id"] = 65,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [9]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 10,
					["Class"] = "Druid",
					["Code"] = "#showtooltip Rake\n/cast Rake",
					["Id"] = 70,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [10]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 8,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Ferocious Bite",
					["Id"] = 68,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = " ",
				}, -- [11]
			},
			["Specializations"] = {
				["Restoration"] = {
					["Macros"] = {
						{
							["Code"] = "#showtooltip\n/cast [talent:3/1] Typhoon\n/cast [talent:3/2] Maim\n/cast [talent:3/3] Incapacitating Roar",
							["Scope"] = "gs",
							["Class"] = "Druid",
							["DisplayName"] = "",
							["Specialization"] = "Restoration",
							["Id"] = 91,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 1,
							["StaticTexture"] = 134400,
						}, -- [1]
						{
							["Code"] = "#showtooltip Nature's Swiftness\n/cancelaura Cat Form\n/cancelaura Bear Form\n/cast Nature's Swiftness\n/cast Regrowth",
							["Scope"] = "gs",
							["Class"] = "Druid",
							["DisplayName"] = "",
							["Specialization"] = "Restoration",
							["Id"] = 92,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 2,
							["StaticTexture"] = 134400,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast [@player] Innervate",
							["Scope"] = "gs",
							["Class"] = "Druid",
							["DisplayName"] = "",
							["Specialization"] = "Restoration",
							["Id"] = 94,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 4,
							["StaticTexture"] = 134400,
						}, -- [3]
					},
				},
				["Balance"] = {
					["Macros"] = {
					},
				},
			},
		},
		["Shaman"] = {
			["Macros"] = {
				{
					["Id"] = 61,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopcasting\n/cast Wind Shear\n",
					["Scope"] = "gc",
					["Class"] = "Shaman",
					["ScopedIndex"] = 1,
					["DisplayName"] = "",
				}, -- [1]
			},
			["Specializations"] = {
				["Restoration"] = {
					["Macros"] = {
						{
							["Code"] = "#showtooltip Spiritwalker's Grace\n/cast Spiritwalker's Grace\n/stopcasting\n",
							["Scope"] = "gs",
							["Class"] = "Shaman",
							["DisplayName"] = "",
							["Specialization"] = "Restoration",
							["ScopedIndex"] = 1,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 91,
						}, -- [1]
						{
							["Code"] = "#showtooltip\n/cast [@mouseover,exists,help] Cleanse Spirit; Cleanse Spirit\n",
							["Scope"] = "gs",
							["Class"] = "Shaman",
							["DisplayName"] = " ",
							["Specialization"] = "Restoration",
							["ScopedIndex"] = 2,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 92,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast [@arena1,exists] Purge; Purge\n",
							["Scope"] = "gs",
							["Class"] = "Shaman",
							["DisplayName"] = " ",
							["Specialization"] = "Restoration",
							["ScopedIndex"] = 3,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 93,
						}, -- [3]
					},
				},
			},
		},
		["Monk"] = {
			["Macros"] = {
			},
			["Specializations"] = {
				[""] = {
					["Macros"] = {
					},
				},
				["Brewmaster"] = {
					["Macros"] = {
					},
				},
			},
		},
		["Priest"] = {
			["Macros"] = {
				{
					["Id"] = 61,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@player] Angelic Feather\n/stopspelltarget\n/cast [@player] Body and Mind\n",
					["Scope"] = "gc",
					["Class"] = "Priest",
					["ScopedIndex"] = 1,
					["DisplayName"] = "",
				}, -- [1]
				{
					["Id"] = 63,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopcasting\n/cast Mind Control\n",
					["Scope"] = "gc",
					["Class"] = "Priest",
					["ScopedIndex"] = 3,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Id"] = 62,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [help] Purify; [harm] Dispel Magic; Purify\n",
					["Scope"] = "gc",
					["Class"] = "Priest",
					["ScopedIndex"] = 2,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Id"] = 64,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cleartarget [noharm]\n/targetenemy [noexists][dead]\n/cast Shadow Word: Death\n",
					["Scope"] = "gc",
					["Class"] = "Priest",
					["ScopedIndex"] = 4,
					["DisplayName"] = "",
				}, -- [4]
			},
			["Specializations"] = {
				["Holy"] = {
					["Macros"] = {
						{
							["Code"] = "#showtooltip Fade\n/cancelaura Spirit of Redemption\n/cast Fade\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["ScopedIndex"] = 1,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 91,
						}, -- [1]
						{
							["Code"] = "#showtooltip\n/cast [@cursor] Holy Word: Sanctify\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["ScopedIndex"] = 3,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 93,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast [@player] Holy Ward\n/cast [combat] Divine Ascension\n/cast [combat] Ray of Hope\n/run local G=GetSpellInfo SetMacroSpell(GetRunningMacro(), G\"Holy Ward\" or G\"Divine Ascension\" or G\"Ray of Hope\")\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["ScopedIndex"] = 4,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 94,
						}, -- [3]
						{
							["Code"] = "#showtooltip\n/cast Desperate Prayer\n/stopmacro [equipped:tabard]\n/use 13\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["ScopedIndex"] = 2,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 92,
						}, -- [4]
						{
							["Code"] = "#showtooltip\n/cast [@focus][] Holy Word: Chastise\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["ScopedIndex"] = 5,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 95,
						}, -- [5]
					},
				},
			},
		},
		["Mage"] = {
			["Macros"] = {
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 1,
					["Class"] = "Mage",
					["Code"] = "#showtooltip Counterspell\n/petpassive\n/cast [@focus, exists] [] Counterspell\n",
					["Id"] = 61,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [1]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 2,
					["Class"] = "Mage",
					["Code"] = "#showtooltip Spellsteal\n/petpassive\n/cast [@focus, exists] [] Spellsteal",
					["Id"] = 62,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Id"] = 65,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast Combustion\n/stopmacro [noequipped:tabard]\n/use 13",
					["Scope"] = "gc",
					["Class"] = "Mage",
					["ScopedIndex"] = 6,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 4,
					["Class"] = "Mage",
					["Code"] = "#showtooltip\n/cast Mirror Image\n/stopmacro [equipped:tabard]\n/use 13",
					["Id"] = 64,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = " ",
				}, -- [4]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 6,
					["Class"] = "Mage",
					["Code"] = "#showtooltip\n/cast [@mouseover, help, nodead] [] Remove Curse\n",
					["Id"] = 66,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = " ",
				}, -- [5]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 3,
					["Class"] = "Mage",
					["Code"] = "#showtooltip Polymorph\n/petpassive\n/cast [@focus, exists] [] Polymorph\n",
					["Id"] = 63,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = " ",
				}, -- [6]
			},
			["Specializations"] = {
				["Fire"] = {
					["Macros"] = {
					},
				},
			},
		},
		["Paladin"] = {
			["Macros"] = {
			},
			["Specializations"] = {
				["Holy"] = {
					["Macros"] = {
						{
							["Code"] = "#showtooltip\n/use [talent:3/2] Repentance; [talent:3/3] Blinding Light",
							["Scope"] = "gs",
							["Class"] = "Paladin",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 1,
							["Id"] = 91,
						}, -- [1]
					},
				},
			},
		},
		["Hunter"] = {
			["Macros"] = {
			},
			["Specializations"] = {
				[""] = {
					["Macros"] = {
					},
				},
				["Beast Mastery"] = {
					["Macros"] = {
					},
				},
			},
		},
	},
}