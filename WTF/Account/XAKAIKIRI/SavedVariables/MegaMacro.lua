
MegaMacroConfig = nil
MegaMacroGlobalData = {
	["Macros"] = {
		{
			["Id"] = 8,
			["ScopedIndex"] = 8,
			["Code"] = "#showtooltip\n/use 13\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 134400,
			["DisplayName"] = " T1",
		}, -- [1]
		{
			["Id"] = 9,
			["ScopedIndex"] = 9,
			["Code"] = "#showtooltip\n/use 14\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 134400,
			["DisplayName"] = " T2",
		}, -- [2]
		{
			["Id"] = 16,
			["ScopedIndex"] = 16,
			["Code"] = "/target arena1\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 2399263,
			["DisplayName"] = "A1",
		}, -- [3]
		{
			["Id"] = 11,
			["ScopedIndex"] = 11,
			["Code"] = "/target arena2\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 2399261,
			["DisplayName"] = "A2",
		}, -- [4]
		{
			["Id"] = 12,
			["ScopedIndex"] = 12,
			["Code"] = "/target arena3\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 2399247,
			["DisplayName"] = "A3",
		}, -- [5]
		{
			["Scope"] = "gg",
			["StaticTexture"] = 2909707,
			["Code"] = "/bartender bars 1 visibility always\n/bartender bars 2 visibility always\n/bartender bars 3 visibility always\n/bartender bars 4 visibility always\n/bartender bars 5 visibility always\n/bartender bars 6 visibility always\n/bartender bars 9 visibility always\n/bartender bars 10 visibility always",
			["Id"] = 2,
			["IsStaticTextureFallback"] = true,
			["ScopedIndex"] = 11,
			["DisplayName"] = "AB",
		}, -- [6]
		{
			["Id"] = 17,
			["ScopedIndex"] = 17,
			["Code"] = "/cancelaura Kevin's oozeling\n/run local a,b,c,d=\"Conjured Mana Bun\",\"Ambroria Dew\",\"Drink\" d=GetMacroBody(c)EditMacro(c,c,nil,strsub(d,1,strfind(d,\";\\n\"))..\"\\n/use \"..(GetItemCount(a)>0 and a or b));\n/use Conjured Mana Bun\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 134400,
			["DisplayName"] = "D",
		}, -- [7]
		{
			["Id"] = 6,
			["ScopedIndex"] = 6,
			["Code"] = "/target [@player]\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 4239318,
			["DisplayName"] = "P0",
		}, -- [8]
		{
			["Id"] = 5,
			["ScopedIndex"] = 5,
			["Code"] = "/target [@party1]\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 4238928,
			["DisplayName"] = "P1",
		}, -- [9]
		{
			["Id"] = 7,
			["ScopedIndex"] = 7,
			["Code"] = "/target [@party2]\n",
			["Scope"] = "gg",
			["IsStaticTextureFallback"] = false,
			["StaticTexture"] = 4238932,
			["DisplayName"] = "P2",
		}, -- [10]
		{
			["Scope"] = "gg",
			["StaticTexture"] = 237386,
			["Code"] = "/way 35 46 on chain\n/way 50 22 on cliff\n/way 41 39 on cliff\n/way 39 34 under tree roots\n/way 43 50 under tree roots",
			["Id"] = 1,
			["IsStaticTextureFallback"] = true,
			["ScopedIndex"] = 13,
			["DisplayName"] = "TT",
		}, -- [11]
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
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 1,
					["Code"] = "#showtooltip\n/cast [@focus,exists][] Hammer of Justice\n",
					["Id"] = 61,
					["Class"] = "Paladin",
					["StaticTexture"] = 134400,
					["DisplayName"] = " ",
				}, -- [1]
			},
			["Specializations"] = {
				["Retribution"] = {
					["Macros"] = {
					},
				},
				["Holy"] = {
					["Macros"] = {
						{
							["Code"] = "#showtooltip\n/use [talent:3/2] Repentance; [talent:3/3] Blinding Light",
							["Scope"] = "gs",
							["Class"] = "Paladin",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["ScopedIndex"] = 1,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 91,
						}, -- [1]
						{
							["Code"] = "#showtooltip\n/use [talent:3/2,@focus] Repentance; [talent:3/3] Blinding Light",
							["Scope"] = "gs",
							["Class"] = "Paladin",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 2,
							["Id"] = 92,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast Divine Protection\n/use 13\n",
							["Scope"] = "gs",
							["Class"] = "Paladin",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["Id"] = 93,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 3,
							["StaticTexture"] = 134400,
						}, -- [3]
						{
							["Id"] = 94,
							["ScopedIndex"] = 4,
							["Specialization"] = "Holy",
							["Code"] = "#showtooltip\n/cleartarget [noharm]\n/targetenemy [noexists][dead]\n/cast Vanquisher's Hammer\n",
							["Scope"] = "gs",
							["Class"] = "Paladin",
							["StaticTexture"] = 134400,
							["DisplayName"] = " ",
						}, -- [4]
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
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 1,
							["Id"] = 91,
						}, -- [1]
						{
							["Code"] = "#showtooltip\n/cast [@mouseover,exists,help] Cleanse Spirit; Cleanse Spirit\n",
							["Scope"] = "gs",
							["Class"] = "Shaman",
							["DisplayName"] = " ",
							["Specialization"] = "Restoration",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 2,
							["Id"] = 92,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast [@arena1,exists] Purge; Purge\n",
							["Scope"] = "gs",
							["Class"] = "Shaman",
							["DisplayName"] = " ",
							["Specialization"] = "Restoration",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 3,
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
				["Windwalker"] = {
					["Macros"] = {
					},
				},
				["Mistweaver"] = {
					["Macros"] = {
					},
				},
			},
		},
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
					["Id"] = 70,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Kidney Shot\n",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 10,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Id"] = 68,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Cheap Shot\n",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 8,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Id"] = 72,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@focus,exists] Sap; Sap",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 12,
					["DisplayName"] = "",
				}, -- [4]
				{
					["Id"] = 63,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@focus, exists] [] Kick\n",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 3,
					["DisplayName"] = "",
				}, -- [5]
				{
					["Id"] = 62,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "#showtooltip\n/cast [@focus, exists] [] Blind\n",
					["Scope"] = "gc",
					["Class"] = "Rogue",
					["ScopedIndex"] = 2,
					["DisplayName"] = "",
				}, -- [6]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 8,
					["Class"] = "Rogue",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast [@focus] Cheap Shot\n",
					["Id"] = 65,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = " ",
				}, -- [7]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 7,
					["Class"] = "Rogue",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast [@focus] Kidney Shot\n",
					["Id"] = 64,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = " ",
				}, -- [8]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 9,
					["Class"] = "Rogue",
					["Code"] = "#showtooltip\n/cast [@focus] Dismantle",
					["Id"] = 66,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = " ",
				}, -- [9]
			},
			["Specializations"] = {
				[""] = {
					["Macros"] = {
					},
				},
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
							["ScopedIndex"] = 1,
							["StaticTexture"] = 134400,
						}, -- [1]
						{
							["Code"] = "#showtooltip Echoing Reprimand\n/stopmacro [noharm]\n/cast Shadow Dance\n/cast Symbols of Death\n/cast Echoing Reprimand\n/cast [@party1] Tricks of the Trade\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = "",
							["Specialization"] = "Subtlety",
							["Id"] = 94,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 4,
							["StaticTexture"] = 134400,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast Shadow Blades\n/cast Ancestral Call(Racial)\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = "",
							["Specialization"] = "Subtlety",
							["Id"] = 96,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 6,
							["StaticTexture"] = 134400,
						}, -- [3]
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Rupture\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = " ",
							["Specialization"] = "Subtlety",
							["Id"] = 93,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 3,
							["StaticTexture"] = 134400,
						}, -- [4]
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Backstab\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = " ",
							["Specialization"] = "Subtlety",
							["Id"] = 95,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 5,
							["StaticTexture"] = 134400,
						}, -- [5]
						{
							["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Eviscerate\n",
							["Scope"] = "gs",
							["Class"] = "Rogue",
							["DisplayName"] = " ",
							["Specialization"] = "Subtlety",
							["Id"] = 92,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 2,
							["StaticTexture"] = 134400,
						}, -- [6]
					},
				},
				["Assassination"] = {
					["Macros"] = {
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
					["ScopedIndex"] = 11,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Rip",
					["Id"] = 71,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 4,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/cast [@focus] Cyclone",
					["Id"] = 64,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [3]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 9,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Mangle",
					["Id"] = 69,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [4]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 7,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/stopmacro [noharm]\n/cast Shred",
					["Id"] = 67,
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
					["ScopedIndex"] = 5,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/cast [@focus] Mighty Bash",
					["Id"] = 65,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [7]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 10,
					["Class"] = "Druid",
					["Code"] = "#showtooltip Rake\n/cast Rake",
					["Id"] = 70,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [8]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 2,
					["Class"] = "Druid",
					["Code"] = "/cast [flyable,outdoors] [combat,outdoors] [swimming,outdoors] [@party4,noexists,outdoors] Travel Form; [indoors] Cat Form; [outdoors] Thundering Ruby Cloud Serpent",
					["Id"] = 62,
					["IsStaticTextureFallback"] = true,
					["StaticTexture"] = 134400,
					["DisplayName"] = "",
				}, -- [9]
				{
					["Scope"] = "gc",
					["ScopedIndex"] = 3,
					["Class"] = "Druid",
					["Code"] = "#showtooltip\n/cast [@focus] Entangling Roots",
					["Id"] = 63,
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
				["Feral"] = {
					["Macros"] = {
					},
				},
				["Balance"] = {
					["Macros"] = {
						{
							["Code"] = "/cast Celestial Alignment\n/cast Convoke the Spirits",
							["Scope"] = "gs",
							["Class"] = "Druid",
							["DisplayName"] = "",
							["Specialization"] = "Balance",
							["Id"] = 91,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 1,
						}, -- [1]
					},
				},
				["Restoration"] = {
					["Macros"] = {
						{
							["Code"] = "#showtooltip Nature's Swiftness\n/cancelaura Cat Form\n/cancelaura Bear Form\n/cast Nature's Swiftness\n/cast Regrowth",
							["Scope"] = "gs",
							["Class"] = "Druid",
							["DisplayName"] = "",
							["Specialization"] = "Restoration",
							["Id"] = 92,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 2,
						}, -- [1]
						{
							["Code"] = "#showtooltip Skull Bash\n/cast Skull Bash\n/stopmacro [form:1]\n/cast Bear Form",
							["Scope"] = "gs",
							["Class"] = "Druid",
							["DisplayName"] = "",
							["Specialization"] = "Restoration",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 3,
							["Id"] = 91,
						}, -- [2]
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
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 1,
							["Id"] = 91,
						}, -- [1]
						{
							["Code"] = "#showtooltip\n/cast [@cursor] Holy Word: Sanctify\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 3,
							["Id"] = 93,
						}, -- [2]
						{
							["Code"] = "#showtooltip\n/cast [@player] Holy Ward\n/cast [combat] Divine Ascension\n/cast [combat] Ray of Hope\n/run local G=GetSpellInfo SetMacroSpell(GetRunningMacro(), G\"Holy Ward\" or G\"Divine Ascension\" or G\"Ray of Hope\")\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 4,
							["Id"] = 94,
						}, -- [3]
						{
							["Code"] = "#showtooltip\n/cast Desperate Prayer\n/stopmacro [equipped:tabard]\n/use 13\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 2,
							["Id"] = 92,
						}, -- [4]
						{
							["Code"] = "#showtooltip\n/cast [@focus][] Holy Word: Chastise\n",
							["Scope"] = "gs",
							["Class"] = "Priest",
							["DisplayName"] = "",
							["Specialization"] = "Holy",
							["StaticTexture"] = 134400,
							["IsStaticTextureFallback"] = true,
							["ScopedIndex"] = 5,
							["Id"] = 95,
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
		["Death Knight"] = {
			["Macros"] = {
				{
					["Id"] = 64,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "/cast [@focus] Asphyxiate",
					["Scope"] = "gc",
					["Class"] = "Death Knight",
					["ScopedIndex"] = 5,
					["DisplayName"] = "",
				}, -- [1]
				{
					["Id"] = 65,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "/cast [@focus] Strangulate",
					["Scope"] = "gc",
					["Class"] = "Death Knight",
					["ScopedIndex"] = 6,
					["DisplayName"] = "",
				}, -- [2]
				{
					["Id"] = 62,
					["StaticTexture"] = 134400,
					["IsStaticTextureFallback"] = true,
					["Code"] = "/cast [@player] Death Coil",
					["Scope"] = "gc",
					["Class"] = "Death Knight",
					["ScopedIndex"] = 2,
					["DisplayName"] = "HS",
				}, -- [3]
			},
			["Specializations"] = {
				["Unholy"] = {
					["Macros"] = {
						{
							["Id"] = 97,
							["ScopedIndex"] = 7,
							["Specialization"] = "Unholy",
							["Code"] = "/cast Huddle",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["StaticTexture"] = 134400,
							["DisplayName"] = "",
						}, -- [1]
						{
							["Id"] = 93,
							["ScopedIndex"] = 3,
							["Specialization"] = "Unholy",
							["Code"] = "/cast Leap",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["StaticTexture"] = 134400,
							["DisplayName"] = "",
						}, -- [2]
						{
							["Id"] = 94,
							["ScopedIndex"] = 4,
							["Specialization"] = "Unholy",
							["Code"] = "#showtooltip Dark Transformation\n/cast [nopet] Raise Dead\n/cast Dark Transformation\n/cast Unholy Blight",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["StaticTexture"] = 134400,
							["DisplayName"] = "",
						}, -- [3]
						{
							["Id"] = 100,
							["ScopedIndex"] = 10,
							["Specialization"] = "Unholy",
							["Code"] = "/cast Abomination Limb\n/cast Empower Rune Weapon\n/cast Blood Fury\n/use 13",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["StaticTexture"] = 134400,
							["DisplayName"] = "",
						}, -- [4]
						{
							["Code"] = "/petmoveto",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["DisplayName"] = "",
							["Specialization"] = "Unholy",
							["Id"] = 98,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 8,
						}, -- [5]
						{
							["Id"] = 95,
							["ScopedIndex"] = 5,
							["Specialization"] = "Unholy",
							["Code"] = "/cast Gnaw",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["StaticTexture"] = 134400,
							["DisplayName"] = "",
						}, -- [6]
						{
							["Code"] = "Necklace --- mastery\nShoulders -- haste\nChest -------  mastery\nLegs --------  mastery",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["DisplayName"] = "",
							["Specialization"] = "Unholy",
							["ScopedIndex"] = 11,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["Id"] = 101,
						}, -- [7]
						{
							["Code"] = "/petfollow",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["DisplayName"] = "",
							["Specialization"] = "Unholy",
							["Id"] = 99,
							["IsStaticTextureFallback"] = true,
							["StaticTexture"] = 134400,
							["ScopedIndex"] = 9,
						}, -- [8]
						{
							["Id"] = 92,
							["ScopedIndex"] = 2,
							["Specialization"] = "Unholy",
							["Code"] = "/cast [@focus,exists][] Leap",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["StaticTexture"] = 134400,
							["DisplayName"] = " F",
						}, -- [9]
						{
							["Id"] = 91,
							["ScopedIndex"] = 1,
							["Specialization"] = "Unholy",
							["Code"] = "/cast [@pet] Death Coil",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["StaticTexture"] = 134400,
							["DisplayName"] = "HP",
						}, -- [10]
						{
							["Id"] = 96,
							["ScopedIndex"] = 6,
							["Specialization"] = "Unholy",
							["Code"] = "/cast [@focus,exists][] Gnaw",
							["Scope"] = "gs",
							["Class"] = "Death Knight",
							["StaticTexture"] = 134400,
							["DisplayName"] = "f",
						}, -- [11]
					},
				},
				["Frost"] = {
					["Macros"] = {
					},
				},
			},
		},
		["DRUID"] = {
			["Macros"] = {
			},
			["Specializations"] = {
				["Restoration"] = {
					["Macros"] = {
					},
				},
			},
		},
	},
}
