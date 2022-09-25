
ThreatPlatesDB = {
	["char"] = {
		["Gnomemounts - Tichondrius"] = {
			["spec"] = {
				[3] = false,
			},
			["welcome"] = true,
		},
		["Cyf - Tichondrius"] = {
			["spec"] = {
				nil, -- [1]
				nil, -- [2]
				true, -- [3]
				false, -- [4]
			},
			["welcome"] = true,
		},
		["Sýh - Thrall"] = {
			["spec"] = {
				[3] = true,
			},
			["welcome"] = true,
		},
		["Wthrename - Tichondrius"] = {
			["welcome"] = true,
			["spec"] = {
				[3] = false,
			},
		},
		["Gerold - Tichondrius"] = {
			["spec"] = {
				nil, -- [1]
				true, -- [2]
				false, -- [3]
			},
			["welcome"] = true,
		},
		["Dwarfmounts - Tichondrius"] = {
			["spec"] = {
				[3] = false,
			},
			["welcome"] = true,
		},
		["Syhlol - Thrall"] = {
			["spec"] = {
				[3] = false,
			},
			["welcome"] = true,
		},
		["Syhlol - Tichondrius"] = {
			["welcome"] = true,
			["spec"] = {
				true, -- [1]
				[3] = false,
			},
		},
		["Crylo - Tichondrius"] = {
			["welcome"] = true,
			["spec"] = {
				[3] = false,
			},
		},
		["Pandamounts - Tichondrius"] = {
			["spec"] = {
				true, -- [1]
				[3] = false,
			},
			["welcome"] = true,
		},
		["Regèn - Tichondrius"] = {
			["welcome"] = true,
			["spec"] = {
				[3] = false,
			},
		},
		["Syhlo - Thrall"] = {
			["welcome"] = true,
			["spec"] = {
				[3] = false,
			},
		},
		["Syh - Thrall"] = {
			["welcome"] = true,
			["spec"] = {
				[3] = false,
			},
		},
	},
	["profileKeys"] = {
		["Gnomemounts - Tichondrius"] = "Global",
		["Cyf - Tichondrius"] = "Global",
		["Sýh - Thrall"] = "Default",
		["Wthrename - Tichondrius"] = "Default",
		["Gerold - Tichondrius"] = "Global",
		["Dwarfmounts - Tichondrius"] = "Global",
		["Syhlol - Thrall"] = "Global",
		["Syhlol - Tichondrius"] = "Default",
		["Crylo - Tichondrius"] = "Default",
		["Pandamounts - Tichondrius"] = "Global",
		["Regèn - Tichondrius"] = "Default",
		["Syhlo - Thrall"] = "Global",
		["Syh - Thrall"] = "Default",
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
			["char"] = {
				["Cyf - Tichondrius"] = {
					["enabled"] = false,
				},
			},
		},
	},
	["global"] = {
		["version"] = "10.5.2",
	},
	["profiles"] = {
		["Default"] = {
			["nameplate"] = {
				["toggle"] = {
					["OccludedUnits"] = true,
					["TargetS"] = true,
					["TargetA"] = true,
				},
				["alpha"] = {
					["Target"] = 2,
					["OccludedUnits"] = 0.75,
					["NonTarget"] = 0.75,
				},
				["scale"] = {
					["Target"] = 0.25,
					["Pet"] = 0.6000000000000005,
					["FriendlyPlayer"] = 0.7000000000000002,
				},
			},
			["threat"] = {
				["ON"] = false,
			},
			["CVarsBackup"] = {
				["nameplateMinAlpha"] = "0.6",
				["nameplateMaxAlpha"] = "1.0",
			},
			["Scale"] = {
				["IgnoreUIScale"] = false,
				["PixelPerfectUI"] = true,
			},
			["HeadlineView"] = {
				["EnemySubtext"] = "NONE",
			},
			["settings"] = {
				["customtext"] = {
					["typeface"] = "Friz Quadrata TT",
					["SubtextColorUseSpecific"] = true,
					["size"] = 8,
				},
				["healthbar"] = {
					["height"] = 8,
					["width"] = 140,
					["TargetUnit"] = {
						["Font"] = {
							["flags"] = "NONE, MONOCHROME",
							["Typeface"] = "Arial Narrow",
						},
					},
				},
				["eliteicon"] = {
					["theme"] = "stddragon",
				},
				["threatborder"] = {
					["show"] = false,
				},
				["spellicon"] = {
					["y"] = -20,
				},
				["elitehealthborder"] = {
					["show"] = true,
				},
				["castbar"] = {
					["y"] = -20,
				},
				["frame"] = {
					["height"] = 50.525,
					["width"] = 182,
				},
				["level"] = {
					["typeface"] = "Arial Narrow",
					["x"] = 42,
					["show"] = false,
					["size"] = 8,
				},
				["name"] = {
					["typeface"] = "Arial Narrow",
					["y"] = 16,
					["size"] = 13,
				},
				["raidicon"] = {
					["y"] = 65,
					["x"] = -2,
					["scale"] = 44,
					["hpColor"] = false,
					["show"] = false,
				},
			},
			["AuraWidget"] = {
				["ON"] = false,
			},
			["uniqueSettings"] = {
				{
					["showIcon"] = false,
					["showNameplate"] = false,
					["ShowHeadlineView"] = true,
					["Trigger"] = {
						["Name"] = {
							["Input"] = "Army of the Dead, Wild Imp, Malicious Imp, Dreadstalker",
							["AsArray"] = {
								"Army of the Dead, Wild Imp, Malicious Imp, Dreadstalker", -- [1]
							},
						},
					},
					["Name"] = "Ignore Minions",
				}, -- [1]
			},
			["FocusWidget"] = {
				["a"] = 0.4900000095367432,
				["b"] = 0,
				["r"] = 1,
				["theme"] = "arrow_less_than",
				["g"] = 0.8274509803921568,
				["Size"] = 30,
			},
			["classWidget"] = {
				["ON"] = false,
			},
			["totemWidget"] = {
				["scale"] = 50,
			},
			["questWidget"] = {
				["scale"] = 32,
			},
			["Visibility"] = {
				["FriendlyMinus"] = {
					["Show"] = false,
				},
			},
			["targetWidget"] = {
				["a"] = 0.5722883641719818,
				["b"] = 0.984313725490196,
				["theme"] = "squarethin",
				["r"] = 0.984313725490196,
			},
		},
		["Global"] = {
			["nameplate"] = {
				["toggle"] = {
					["OccludedUnits"] = true,
					["TargetS"] = true,
					["TargetA"] = true,
				},
				["alpha"] = {
					["OccludedUnits"] = 0.6499999999999999,
					["Target"] = 2,
					["NonTarget"] = 0.75,
				},
				["scale"] = {
					["Target"] = 0.2999999999999998,
					["FriendlyPlayer"] = 0.7000000000000002,
				},
			},
			["uniqueSettings"] = {
				{
					["color"] = {
						["g"] = 0,
						["b"] = 0.4509803921568628,
					},
					["showIcon"] = false,
					["Trigger"] = {
						["Name"] = {
							["Input"] = "Fel Obelisk; Demonic Tyrant",
							["AsArray"] = {
								"Fel Obelisk", -- [1]
								"Demonic Tyrant", -- [2]
							},
						},
					},
					["Effects"] = {
						["Glow"] = {
							["Color"] = {
								0.9490196078431372, -- [1]
								0.8352941176470589, -- [2]
								0, -- [3]
								0.5120473504066467, -- [4]
							},
							["Frame"] = "Healthbar",
							["CustomColor"] = true,
						},
					},
					["Name"] = "Emphasized Minions",
					["scale"] = 1.4,
					["Enable"] = {
						["UnitReaction"] = {
							["FRIENDLY"] = false,
						},
					},
				}, -- [1]
				{
					["color"] = {
						["b"] = 0.5215686274509804,
						["g"] = 0.5215686274509804,
						["r"] = 0.5215686274509804,
					},
					["showIcon"] = false,
					["showNameplate"] = false,
					["ShowHeadlineView"] = true,
					["alpha"] = 0.7,
					["Name"] = "Ignored Minions",
					["Trigger"] = {
						["Name"] = {
							["Input"] = "Wild Imp; Malicious Imp; Army of the Dead; Dreadstalker",
							["AsArray"] = {
								"Wild Imp", -- [1]
								"Malicious Imp", -- [2]
								"Army of the Dead", -- [3]
								"Dreadstalker", -- [4]
							},
						},
					},
				}, -- [2]
			},
			["totemWidget"] = {
				["scale"] = 50,
			},
			["CVarsBackup"] = {
				["nameplateMinAlpha"] = "0.6",
				["nameplateMaxAlpha"] = "1.0",
			},
			["FocusWidget"] = {
				["a"] = 0.4900000095367432,
				["r"] = 1,
				["g"] = 0.8274509803921568,
				["b"] = 0,
				["theme"] = "arrow_less_than",
				["Size"] = 30,
			},
			["AuraWidget"] = {
				["Debuffs"] = {
					["ModeIcon"] = {
						["IconWidth"] = 26,
						["Style"] = "custom",
						["IconHeight"] = 26,
					},
					["HealthbarMode"] = {
						["VerticalOffset"] = 14,
					},
				},
				["CrowdControl"] = {
					["ShowEnemy"] = false,
					["ShowFriendly"] = false,
				},
				["FlashWhenExpiring"] = true,
				["ShowCooldownSpiral"] = true,
				["Buffs"] = {
					["HideUnlimitedDuration"] = true,
					["ShowEnemy"] = false,
					["ShowAllEnemy"] = true,
					["ShowOnEnemyNPCs"] = false,
					["ShowDispellable"] = false,
				},
			},
			["settings"] = {
				["customtext"] = {
					["typeface"] = "Friz Quadrata TT",
					["size"] = 8,
					["SubtextColorUseSpecific"] = true,
				},
				["eliteicon"] = {
					["theme"] = "stddragon",
				},
				["elitehealthborder"] = {
					["show"] = true,
				},
				["level"] = {
					["x"] = 42,
					["typeface"] = "Arial Narrow",
					["show"] = false,
					["size"] = 8,
				},
				["healthbar"] = {
					["TargetUnit"] = {
						["Font"] = {
							["flags"] = "NONE, MONOCHROME",
							["Typeface"] = "Arial Narrow",
						},
					},
					["width"] = 145,
					["height"] = 14,
				},
				["castbar"] = {
					["y"] = -20,
				},
				["threatborder"] = {
					["show"] = false,
				},
				["name"] = {
					["typeface"] = "Arial Narrow",
					["size"] = 13,
					["y"] = 16,
				},
				["frame"] = {
					["height"] = 57.575,
					["width"] = 189,
				},
				["raidicon"] = {
					["scale"] = 56,
					["hpColor"] = false,
					["y"] = 65,
					["x"] = -2,
					["show"] = false,
				},
			},
			["targetWidget"] = {
				["a"] = 0.5722883641719818,
				["b"] = 0.984313725490196,
				["r"] = 0.984313725490196,
				["theme"] = "squarethin",
			},
			["HeadlineView"] = {
				["EnemySubtext"] = "NONE",
			},
			["Scale"] = {
				["IgnoreUIScale"] = false,
				["PixelPerfectUI"] = true,
			},
			["classWidget"] = {
				["ON"] = false,
			},
			["threat"] = {
				["ON"] = false,
			},
			["Visibility"] = {
				["FriendlyMinus"] = {
					["Show"] = false,
				},
			},
		},
	},
}
