
ThreatPlatesDB = {
	["char"] = {
		["Cyf - Tichondrius"] = {
			["welcome"] = true,
			["spec"] = {
				nil, -- [1]
				nil, -- [2]
				true, -- [3]
				false, -- [4]
			},
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
		["Syhlo - Thrall"] = {
			["welcome"] = true,
			["spec"] = {
				[3] = false,
			},
		},
		["Gerold - Tichondrius"] = {
			["welcome"] = true,
			["spec"] = {
				nil, -- [1]
				true, -- [2]
				false, -- [3]
			},
		},
		["Syhlol - Thrall"] = {
			["spec"] = {
				[3] = false,
			},
			["welcome"] = true,
		},
		["Crylo - Tichondrius"] = {
			["welcome"] = true,
			["spec"] = {
				[3] = false,
			},
		},
	},
	["profileKeys"] = {
		["Cyf - Tichondrius"] = "Global",
		["Sýh - Thrall"] = "Default",
		["Wthrename - Tichondrius"] = "Default",
		["Syhlo - Thrall"] = "Default",
		["Gerold - Tichondrius"] = "Default",
		["Syhlol - Thrall"] = "Global",
		["Crylo - Tichondrius"] = "Default",
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
		["version"] = "10.4.1",
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
				["r"] = 1,
				["b"] = 0,
				["theme"] = "arrow_less_than",
				["g"] = 0.8274509803921568,
				["Size"] = 30,
			},
			["classWidget"] = {
				["ON"] = false,
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
					["show"] = false,
					["x"] = -2,
					["scale"] = 44,
					["hpColor"] = false,
					["y"] = 65,
				},
			},
			["totemWidget"] = {
				["scale"] = 50,
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
					["Pet"] = 0.6000000000000005,
					["FriendlyPlayer"] = 0.7000000000000002,
				},
			},
			["uniqueSettings"] = {
				{
					["showIcon"] = false,
					["showNameplate"] = false,
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
					["alpha"] = 0.7,
					["Name"] = "Ignored Minions",
					["color"] = {
						["b"] = 0.5215686274509804,
						["g"] = 0.5215686274509804,
						["r"] = 0.5215686274509804,
					},
					["ShowHeadlineView"] = true,
				}, -- [1]
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
						["VerticalOffset"] = 42,
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