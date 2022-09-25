
MegaMacroConfig = nil
MegaMacroGlobalData = {
	["Macros"] = {
		{
			["Scope"] = "gg",
			["StaticTexture"] = 4238932,
			["Code"] = "/target [@party2]\n",
			["Id"] = 7,
			["IsStaticTextureFallback"] = false,
			["ScopedIndex"] = 7,
			["DisplayName"] = "",
		}, -- [1]
		{
			["Scope"] = "gg",
			["Code"] = "#showtooltip\n/use 14\n",
			["Id"] = 9,
			["StaticTexture"] = 134400,
			["ScopedIndex"] = 9,
			["DisplayName"] = " ",
		}, -- [2]
		{
			["Scope"] = "gg",
			["StaticTexture"] = 4239318,
			["Code"] = "/target [@player]\n",
			["Id"] = 6,
			["IsStaticTextureFallback"] = false,
			["ScopedIndex"] = 6,
			["DisplayName"] = " ",
		}, -- [3]
		{
			["Scope"] = "gg",
			["Code"] = "#showtooltip\n/use 13\n",
			["Id"] = 8,
			["StaticTexture"] = 134400,
			["ScopedIndex"] = 8,
			["DisplayName"] = " ",
		}, -- [4]
		{
			["Scope"] = "gg",
			["StaticTexture"] = 4238928,
			["Code"] = "/target [@party1]\n",
			["Id"] = 5,
			["IsStaticTextureFallback"] = false,
			["ScopedIndex"] = 5,
			["DisplayName"] = " ",
		}, -- [5]
		{
			["Scope"] = "gg",
			["StaticTexture"] = 2399261,
			["Code"] = "/target arena2\n",
			["Id"] = 11,
			["IsStaticTextureFallback"] = false,
			["ScopedIndex"] = 11,
			["DisplayName"] = "  Target Arena2",
		}, -- [6]
		{
			["Scope"] = "gg",
			["StaticTexture"] = 2399247,
			["Code"] = "/target arena3\n",
			["Id"] = 12,
			["IsStaticTextureFallback"] = false,
			["ScopedIndex"] = 12,
			["DisplayName"] = "  Target Arena3",
		}, -- [7]
		{
			["Scope"] = "gg",
			["StaticTexture"] = 2399263,
			["Code"] = "/target arena1\n",
			["Id"] = 16,
			["IsStaticTextureFallback"] = false,
			["ScopedIndex"] = 16,
			["DisplayName"] = " Target Arena1",
		}, -- [8]
		{
			["Scope"] = "gg",
			["StaticTexture"] = 134400,
			["Code"] = "/cancelaura Kevin's oozeling\n/run local a,b,c,d=\"Conjured Mana Bun\",\"Ambroria Dew\",\"Drink\" d=GetMacroBody(c)EditMacro(c,c,nil,strsub(d,1,strfind(d,\";\\n\"))..\"\\n/use \"..(GetItemCount(a)>0 and a or b));\n/use Conjured Mana Bun\n",
			["Id"] = 17,
			["IsStaticTextureFallback"] = false,
			["ScopedIndex"] = 17,
			["DisplayName"] = "Drink",
		}, -- [9]
		{
			["Id"] = 1,
			["ScopedIndex"] = 13,
			["Code"] = "/way #1961 54.2, 41.2 IM 1\n/way #1961 56.8, 51.5 IM 1\n/way #1961 57.3, 39.4 IM 1\n/way #1961 58.2, 40.5 IM 1\n/way #1961 60.3, 41.6 IM 1\n/way #1961 60.7, 38.2 IM 1\n\n/way #1961 48.5, 41.2 IM 2\n/way #1961 49.4, 40.7 IM 2\n/way #1961 49.5, 31.7 IM 2\n/way #1961 49.9, 32.5 IM 2\n/way #1961 51.4, 46.8 IM 2\n/way #1961 53.7, 37.9 IM 2\n\n/way #1961 42.1, 35.8 IM 3\n/way #1961 42.3, 34.6 IM 3\n/way #1961 43.6, 36.6 IM 3\n/way #1961 45.6, 34.3 IM 3\n/way #1961 52.4, 25.0 IM 3\n/way #1961 55.1, 16.4 IM 3\n\n/way #1961 35.7, 31.1 IM 4\n/way #1961 37.4, 34.7 IM 4\n/way #1961 38.8, 33.8 IM 4\n/way #1961 39.5, 30.7 IM 4\n/way #1961 39.7, 34.8 IM 4\n/way #1961 42.0, 32.5 IM 4\n\n/way #1961 39.6, 30.0 IM 5\n/way #1961 41.2, 44.9 IM 5\n/way #1961 43.4, 56.3 IM 5\n/way #1961 45.2, 47.9 IM 5\n/way #1961 46.5, 48.5 IM 5\n/way #1961 54.8, 55.5 IM 5\n\n/way #1961 42.8, 32.7 Darkmaul",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = true,
			["StaticTexture"] = 237386,
			["DisplayName"] = "TomTom",
		}, -- [10]
	},
	["Activated"] = true,
	["Classes"] = {
		["Warrior"] = {
			["Macros"] = {
			},
			["Specializations"] = {
				["Arms"] = {
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
							["Id"] = 91,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 1,
						}, -- [1]
						{
							["Code"] = "#showtooltip\n/use [talent:3/2,@focus] Repentance; [talent:3/3] Blinding Light",
							["Scope"] = "gs",
							["Class"] = "Paladin",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["Id"] = 92,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 2,
							["StaticTexture"] = 134400,
						}, -- [2]
					},
				},
			},
		},
		["Shaman"] = {
			["Macros"] = {
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 1,
					["Class"] = "Shaman",
					["Code"] = "#showtooltip\n/stopcasting\n/cast Wind Shear\n",
					["Id"] = 61,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
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
							["Id"] = 91,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 1,
							["StaticTexture"] = 134400,
						}, -- [1]
						{
							["Code"] = "#showtooltip\n/cast [@mouseover,exists,help] Cleanse Spirit; Cleanse Spirit\n",
							["Scope"] = "gs",
							["Class"] = "Shaman",
							["DisplayName"] = " ",
							["Specialization"] = "Restoration",
							["Id"] = 92,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 2,
							["StaticTexture"] = 134400,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast [@arena1,exists] Purge; Purge\n",
							["Scope"] = "gs",
							["Class"] = "Shaman",
							["DisplayName"] = " ",
							["Specialization"] = "Restoration",
							["Id"] = 93,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 3,
							["StaticTexture"] = 134400,
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
				["Mistweaver"] = {
					["Macros"] = {
						{
							["Code"] = "#showtooltip\n/use 2",
							["Scope"] = "gs",
							["Class"] = "Monk",
							["DisplayName"] = "",
							["Specialization"] = "Mistweaver",
							["Id"] = 91,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 1,
							["StaticTexture"] = 134400,
						}, -- [1]
					},
				},
			},
		},
		["Rogue"] = {
			["Macros"] = {
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 1,
					["Class"] = "Rogue",
					["Code"] = "#showtooltip sap\n/cleartarget\n/targetenemyplayer\n/cast sap\n",
					["Id"] = 61,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [1]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 2,
					["Class"] = "Rogue",
					["Code"] = "#showtooltip\n/cast [@focus, exists] [] Blind\n",
					["Id"] = 62,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 3,
					["Class"] = "Rogue",
					["Code"] = "#showtooltip\n/cast [@focus, exists] [] Kick\n",
					["Id"] = 63,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 8,
					["Class"] = "Rogue",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Cheap Shot\n",
					["Id"] = 68,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [4]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 10,
					["Class"] = "Rogue",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Kidney Shot\n",
					["Id"] = 70,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [5]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 12,
					["Class"] = "Rogue",
					["Code"] = "#showtooltip\n/cast [@focus,exists] Sap; Sap",
					["Id"] = 72,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
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
							["ScopedIndex"] = 1,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 91,
						}, -- [1]
						{
							["Code"] = "#showtooltip Echoing Reprimand\n/stopmacro [noharm]\n/cast Shadow Dance\n/cast Symbols of Death\n/cast Echoing Reprimand\n/cast [@party1] Tricks of the Trade\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = "",
							["Specialization"] = "Subtlety",
							["ScopedIndex"] = 4,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 94,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast Shadow Blades\n/cast Ancestral Call(Racial)\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = "",
							["Specialization"] = "Subtlety",
							["ScopedIndex"] = 6,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 96,
						}, -- [3]
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Rupture\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = " ",
							["Specialization"] = "Subtlety",
							["ScopedIndex"] = 3,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 93,
						}, -- [4]
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Backstab\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = " ",
							["Specialization"] = "Subtlety",
							["ScopedIndex"] = 5,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 95,
						}, -- [5]
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Eviscerate\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = " ",
							["Specialization"] = "Subtlety",
							["ScopedIndex"] = 2,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 92,
						}, -- [6]
					},
				},
				[""] = {
					["Macros"] = {
					},
				},
			},
		},
		["Mage"] = {
			["Macros"] = {
				{
					["Id"] = 61,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip Counterspell\n/petpassive\n/cast [@focus, exists] [] Counterspell\n",
					["Scope"] = "gc",
					["Class"] = "Mage",
					["ScopedIndex"] = 1,
					["DisplayName"] = "",
				}, -- [1]
				{
					["Id"] = 62,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip Spellsteal\n/petpassive\n/cast [@focus, exists] [] Spellsteal",
					["Scope"] = "gc",
					["Class"] = "Mage",
					["ScopedIndex"] = 2,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 6,
					["Class"] = "Mage",
					["Code"] = "#showtooltip\n/cast Combustion\n/stopmacro [noequipped:tabard]\n/use 13",
					["Id"] = 65,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Id"] = 64,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast Mirror Image\n/stopmacro [equipped:tabard]\n/use 13",
					["Scope"] = "gc",
					["Class"] = "Mage",
					["ScopedIndex"] = 4,
					["DisplayName"] = " ",
				}, -- [4]
				{
					["Id"] = 66,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@mouseover, help, nodead] [] Remove Curse\n",
					["Scope"] = "gc",
					["Class"] = "Mage",
					["ScopedIndex"] = 6,
					["DisplayName"] = " ",
				}, -- [5]
				{
					["Id"] = 63,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip Polymorph\n/petpassive\n/cast [@focus, exists] [] Polymorph\n",
					["Scope"] = "gc",
					["Class"] = "Mage",
					["ScopedIndex"] = 3,
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
		["Druid"] = {
			["Macros"] = {
				{
					["Id"] = 61,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast Barkskin\n/stopmacro [equipped:tabard]\n/use 13",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 1,
					["DisplayName"] = "",
				}, -- [1]
				{
					["Id"] = 71,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Rip",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 11,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Id"] = 64,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@focus] Cyclone",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 4,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Id"] = 69,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Mangle",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 9,
					["DisplayName"] = "",
				}, -- [4]
				{
					["Id"] = 67,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Shred",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 7,
					["DisplayName"] = "",
				}, -- [5]
				{
					["Id"] = 66,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [nostealth] Shadowmeld\n/cast !Prowl",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 6,
					["DisplayName"] = "",
				}, -- [6]
				{
					["Id"] = 65,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@focus] Mighty Bash",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 5,
					["DisplayName"] = "",
				}, -- [7]
				{
					["Id"] = 70,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip Rake\n/cast Rake",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 10,
					["DisplayName"] = "",
				}, -- [8]
				{
					["Id"] = 62,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "/cast [flyable,outdoors] [combat,outdoors] [swimming,outdoors] [@party4,noexists,outdoors] Travel Form; [indoors] Cat Form; [outdoors] Thundering Ruby Cloud Serpent",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 2,
					["DisplayName"] = "",
				}, -- [9]
				{
					["Id"] = 63,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@focus] Entangling Roots",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 3,
					["DisplayName"] = "",
				}, -- [10]
				{
					["Id"] = 68,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Ferocious Bite",
					["Scope"] = "gc",
					["Class"] = "Druid",
					["ScopedIndex"] = 8,
					["DisplayName"] = " ",
				}, -- [11]
			},
			["Specializations"] = {
				["Feral"] = {
					["Macros"] = {
					},
				},
				["Balance"] = {
					["Macros"] = {
					},
				},
				["Restoration"] = {
					["Macros"] = {
						{
							["Code"] = "#showtooltip\n/cast [talent:3/1] Typhoon\n/cast [talent:3/2] Maim\n/cast [talent:3/3] Incapacitating Roar",
							["Scope"] = "gs",
							["Class"] = "Druid",
							["DisplayName"] = "",
							["Specialization"] = "Restoration",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 1,
							["Id"] = 91,
						}, -- [1]
						{
							["Code"] = "#showtooltip Nature's Swiftness\n/cancelaura Cat Form\n/cancelaura Bear Form\n/cast Nature's Swiftness\n/cast Regrowth",
							["Scope"] = "gs",
							["Class"] = "Druid",
							["DisplayName"] = "",
							["Specialization"] = "Restoration",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 2,
							["Id"] = 92,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast [@player] Innervate",
							["Scope"] = "gs",
							["Class"] = "Druid",
							["DisplayName"] = "",
							["Specialization"] = "Restoration",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 4,
							["Id"] = 94,
						}, -- [3]
					},
				},
			},
		},
		["Priest"] = {
			["Macros"] = {
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 1,
					["Class"] = "Priest",
					["Code"] = "#showtooltip\n/cast [@player] Angelic Feather\n/stopspelltarget\n/cast [@player] Body and Mind\n",
					["Id"] = 61,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [1]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 3,
					["Class"] = "Priest",
					["Code"] = "#showtooltip\n/stopcasting\n/cast Mind Control\n",
					["Id"] = 63,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 2,
					["Class"] = "Priest",
					["Code"] = "#showtooltip\n/cast [help] Purify; [harm] Dispel Magic; Purify\n",
					["Id"] = 62,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 4,
					["Class"] = "Priest",
					["Code"] = "#showtooltip\n/cleartarget [noharm]\n/targetenemy [noexists][dead]\n/cast Shadow Word: Death\n",
					["Id"] = 64,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
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
							["Id"] = 91,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 1,
							["StaticTexture"] = 134400,
						}, -- [1]
						{
							["Code"] = "#showtooltip\n/cast [@cursor] Holy Word: Sanctify\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["Id"] = 93,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 3,
							["StaticTexture"] = 134400,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast [@player] Holy Ward\n/cast [combat] Divine Ascension\n/cast [combat] Ray of Hope\n/run local G=GetSpellInfo SetMacroSpell(GetRunningMacro(), G\"Holy Ward\" or G\"Divine Ascension\" or G\"Ray of Hope\")\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["Id"] = 94,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 4,
							["StaticTexture"] = 134400,
						}, -- [3]
						{
							["Code"] = "#showtooltip\n/cast Desperate Prayer\n/stopmacro [equipped:tabard]\n/use 13\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["Id"] = 92,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 2,
							["StaticTexture"] = 134400,
						}, -- [4]
						{
							["Code"] = "#showtooltip\n/cast [@focus][] Holy Word: Chastise\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["Id"] = 95,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 5,
							["StaticTexture"] = 134400,
						}, -- [5]
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
