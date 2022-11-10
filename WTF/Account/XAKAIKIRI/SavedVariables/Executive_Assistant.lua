
ExecAssistDB = {
	["char"] = {
		["Syhlol - Tichondrius"] = {
			["map"] = {
				["GTP"] = {
				},
			},
			["DBIconTable"] = {
				["minimapPos"] = 170.2723875833033,
			},
		},
		["Cyf - Tichondrius"] = {
			["CharSpecificTaskWindow"] = false,
			["map"] = {
				["TW"] = {
					["p"] = "player",
					["isCollapsed"] = false,
					["PGT"] = {
						["g399737"] = {
							["p"] = "__garden",
							["sibMap"] = {
							},
							["isCollapsed"] = true,
						},
						["__garden"] = {
							["sibMap"] = {
								"g100606", -- [1]
								"g399737", -- [2]
							},
						},
						["g100606"] = {
							["p"] = "__garden",
							["sibMap"] = {
							},
							["isCollapsed"] = false,
						},
					},
				},
				["GTP"] = {
					["g399737"] = {
						["p"] = "__garden",
						["sibMap"] = {
							"t725772", -- [1]
							"t727139", -- [2]
							"t136110", -- [3]
							"t332563", -- [4]
							"t696589", -- [5]
							"t309613", -- [6]
							"t583041", -- [7]
							"t643095", -- [8]
							"t20733", -- [9]
							"t624695", -- [10]
							"t239444", -- [11]
						},
						["isCollapsed"] = true,
					},
					["t583041"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t748111"] = {
						["isCollapsed"] = true,
						["p"] = "g100606",
					},
					["t278720"] = {
						["isCollapsed"] = true,
						["p"] = "g100606",
					},
					["t624695"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t338332"] = {
						["isCollapsed"] = true,
						["p"] = "g100606",
					},
					["t239444"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t727139"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t775627"] = {
						["isCollapsed"] = true,
						["p"] = "g100606",
					},
					["g100606"] = {
						["p"] = "__garden",
						["sibMap"] = {
							"t644883", -- [1]
							"t288802", -- [2]
							"t112573", -- [3]
							"t718497", -- [4]
							"t775627", -- [5]
							"t807135", -- [6]
							"t271126", -- [7]
							"t278720", -- [8]
							"t748111", -- [9]
							"t338332", -- [10]
							"t203809", -- [11]
						},
						["isCollapsed"] = false,
					},
					["t20733"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t807135"] = {
						["isCollapsed"] = true,
						["p"] = "g100606",
					},
					["t725772"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t309613"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t643095"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t332563"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t288802"] = {
						["isCollapsed"] = true,
						["p"] = "g100606",
					},
					["__garden"] = {
						["sibMap"] = {
							"g100606", -- [1]
							"g399737", -- [2]
						},
					},
					["t136110"] = {
						["isCollapsed"] = true,
						["p"] = "g399737",
					},
					["t644883"] = {
						["isCollapsed"] = true,
						["p"] = "g100606",
					},
					["t203809"] = {
						["isCollapsed"] = true,
						["p"] = "g100606",
					},
				},
			},
		},
		["Syhlo - Tichondrius"] = {
			["map"] = {
				["GTP"] = {
				},
			},
		},
	},
	["global"] = {
		["clickmap"] = {
			["ToggleShowTWControlButtons"] = {
				["a"] = false,
				["s"] = true,
				["m"] = "RightButton",
				["c"] = false,
				["code"] = "Rm",
			},
			["TACM"] = {
				["a"] = false,
				["s"] = false,
				["notify"] = false,
				["m"] = "LeftButton",
				["c"] = false,
				["code"] = "Rm",
			},
			["ToggleTaskWindow"] = {
				["a"] = false,
				["s"] = false,
				["m"] = "RightButton",
				["c"] = false,
				["code"] = "Rm",
			},
		},
		["groupStem"] = {
			["agg"] = {
				["g399737"] = {
					["cmdLineTarget"] = false,
					["p"] = "garden",
					["isGroup"] = true,
					["id"] = "g399737",
					["G"] = {
						{
							["id"] = "g399737",
							["oo"] = 20,
						}, -- [1]
					},
					["defaultEnabled"] = false,
					["hideDays"] = {
					},
					["DO"] = {
						"t725772", -- [1]
						"t727139", -- [2]
						"t136110", -- [3]
						"t332563", -- [4]
						"t309613", -- [5]
						"t583041", -- [6]
						"t643095", -- [7]
						"t20733", -- [8]
						"t624695", -- [9]
						"t239444", -- [10]
						"t536129", -- [11]
					},
					["listName"] = "Weekly Tasks",
				},
				["t583041"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t583041",
					["p"] = "g399737",
					["taskName"] = "Tempest Keep",
					["isTask"] = true,
				},
				["t136110"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t136110",
					["p"] = "g399737",
					["taskName"] = "ICC",
					["isTask"] = true,
				},
				["t332563"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t332563",
					["p"] = "g399737",
					["taskName"] = "Ulduar",
					["isTask"] = true,
				},
				["t624695"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t624695",
					["p"] = "g399737",
					["taskName"] = "Galleon",
					["isTask"] = true,
				},
				["t727139"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t727139",
					["p"] = "g399737",
					["taskName"] = "Onyxia",
					["isTask"] = true,
				},
				["garden"] = {
					["DO"] = {
						"g100606", -- [1]
						"g399737", -- [2]
					},
				},
				["t725772"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t725772",
					["p"] = "g399737",
					["taskName"] = "Throne of the Four WInds",
					["isTask"] = true,
				},
				["t20733"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t20733",
					["p"] = "g399737",
					["taskName"] = "Nalak",
					["isTask"] = true,
				},
				["t775627"] = {
					["hideDays"] = {
					},
					["resetType"] = "Daily Automatic",
					["defaultEnabled"] = true,
					["id"] = "t775627",
					["p"] = "g100606",
					["taskName"] = "Kill Nerissa Heartless",
					["isTask"] = true,
				},
				["g100606"] = {
					["hideDays"] = {
					},
					["p"] = "garden",
					["DO"] = {
						"t644883", -- [1]
						"t288802", -- [2]
						"t775627", -- [3]
						"t807135", -- [4]
						"t278720", -- [5]
						"t748111", -- [6]
						"t338332", -- [7]
						"t203809", -- [8]
					},
					["isGroup"] = true,
					["id"] = "g100606",
					["listName"] = "Daily Tasks",
					["G"] = {
						{
							["id"] = "g100606",
							["oo"] = 10,
						}, -- [1]
					},
					["defaultEnabled"] = false,
				},
				["t309613"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t309613",
					["p"] = "g399737",
					["taskName"] = "Firelands",
					["isTask"] = true,
				},
				["t807135"] = {
					["hideDays"] = {
					},
					["resetType"] = "Daily Automatic",
					["defaultEnabled"] = true,
					["id"] = "t807135",
					["p"] = "g100606",
					["taskName"] = "Kill Warbringer Mal'Korak",
					["isTask"] = true,
				},
				["t239444"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t239444",
					["p"] = "g399737",
					["taskName"] = "Oondasta",
					["isTask"] = true,
				},
				["t748111"] = {
					["hideDays"] = {
					},
					["resetType"] = "Daily Automatic",
					["defaultEnabled"] = true,
					["id"] = "t748111",
					["p"] = "g100606",
					["taskName"] = "Kill Famu",
					["isTask"] = true,
				},
				["t643095"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t643095",
					["p"] = "g399737",
					["taskName"] = "Sha of Anger",
					["isTask"] = true,
				},
				["t536129"] = {
					["hideDays"] = {
					},
					["resetType"] = "Weekly Automatic",
					["defaultEnabled"] = true,
					["id"] = "t536129",
					["p"] = "g399737",
					["taskName"] = "Vault of Archavon",
					["isTask"] = true,
				},
				["t288802"] = {
					["hideDays"] = {
					},
					["resetType"] = "Daily Automatic",
					["defaultEnabled"] = false,
					["id"] = "t288802",
					["p"] = "g100606",
					["taskName"] = "Fish for Strange Goop x100",
					["isTask"] = true,
				},
				["t203809"] = {
					["hideDays"] = {
					},
					["resetType"] = "Daily Automatic",
					["defaultEnabled"] = true,
					["id"] = "t203809",
					["p"] = "g100606",
					["taskName"] = "Finish Calling(s)",
					["isTask"] = true,
				},
				["t338332"] = {
					["hideDays"] = {
					},
					["resetType"] = "Daily Automatic",
					["defaultEnabled"] = true,
					["id"] = "t338332",
					["p"] = "g100606",
					["taskName"] = "Kill MoP Warbringers",
					["isTask"] = true,
				},
				["t644883"] = {
					["hideDays"] = {
					},
					["resetType"] = "Daily Automatic",
					["defaultEnabled"] = true,
					["id"] = "t644883",
					["p"] = "g100606",
					["taskName"] = "Kill Fleshwing",
					["isTask"] = true,
				},
				["t278720"] = {
					["hideDays"] = {
					},
					["resetType"] = "Daily Automatic",
					["defaultEnabled"] = true,
					["id"] = "t278720",
					["p"] = "g100606",
					["taskName"] = "Kill Theater of Pain elites x5",
					["isTask"] = true,
				},
			},
		},
		["Options"] = {
			["DailyResetTime"] = 12,
		},
		["nextMidnightReset"] = 1668056400,
		["IsOldHat"] = true,
		["nextWeeklyReset"] = 1668528000,
		["nextDailyReset"] = 1668096000,
		["taskWindow"] = {
			["locked"] = true,
			["toggleState_ToggledOff"] = false,
			["widthMethod"] = 3,
			["FixedWidth_FontString"] = 198,
			["hidebuttons"] = true,
			["useDragFrame"] = false,
			["showChecked"] = false,
			["hideTW_ifHideCompTaks_andNoUncompTasks"] = false,
			["style"] = {
				["bgcolor"] = {
					["a"] = 0.3799999952316284,
					["b"] = 0.01176470588235294,
					["g"] = 0.01176470588235294,
					["r"] = 0.01176470588235294,
				},
				["border"] = "Square Clean",
				["bdrcolor"] = {
					["a"] = 0,
					["b"] = 0.01176470588235294,
					["g"] = 0.01176470588235294,
					["r"] = 0.01176470588235294,
				},
			},
			["pos"] = {
				["yOff"] = -185.0006256103516,
				["xOff"] = 67.9998779296875,
				["posW_rel"] = "LEFT",
				["idx"] = 5,
				["posW_relP"] = "LEFT",
				["relTW"] = "BOTTOM",
			},
		},
		["charStem"] = {
			["Syhlol - Tichondrius"] = {
				["agg"] = {
					["g100606"] = {
						["userOverride"] = 3,
					},
				},
				["charClass"] = "MONK",
			},
			["Cyf - Tichondrius"] = {
				["agg"] = {
					["g399737"] = {
						["userOverride"] = 2,
					},
					["t583041"] = {
					},
					["t136110"] = {
					},
					["t332563"] = {
					},
					["t727139"] = {
					},
					["t338332"] = {
					},
					["t309613"] = {
					},
					["t624695"] = {
					},
					["t203809"] = {
					},
					["g100606"] = {
						["userOverride"] = 2,
					},
					["t20733"] = {
					},
					["t807135"] = {
					},
					["t775627"] = {
					},
					["t748111"] = {
					},
					["t536129"] = {
					},
					["t239444"] = {
					},
					["t643095"] = {
					},
					["t288802"] = {
						["userOverride"] = 2,
					},
					["t725772"] = {
					},
					["t644883"] = {
					},
					["t278720"] = {
					},
				},
				["charClass"] = "DRUID",
			},
			["Sýh - Thrall"] = {
				["agg"] = {
				},
				["charClass"] = "WARRIOR",
			},
			["Gerold - Tichondrius"] = {
				["agg"] = {
				},
				["charClass"] = "PALADIN",
			},
			["Syhlo - Tichondrius"] = {
				["agg"] = {
				},
				["charClass"] = "PALADIN",
			},
			["Dwarfmounts - Tichondrius"] = {
				["agg"] = {
				},
				["charClass"] = "HUNTER",
			},
			["Syhlol - Thrall"] = {
				["agg"] = {
				},
				["charClass"] = "ROGUE",
			},
			["Syhdk - Thrall"] = {
				["agg"] = {
				},
				["charClass"] = "DEATHKNIGHT",
			},
			["Syhlo - Thrall"] = {
				["agg"] = {
				},
				["charClass"] = "PRIEST",
			},
			["Syh - Thrall"] = {
				["agg"] = {
				},
				["charClass"] = "MAGE",
			},
		},
		["hideHelp"] = true,
	},
	["profileKeys"] = {
		["Syhlol - Tichondrius"] = "Default",
		["Cyf - Tichondrius"] = "Default",
		["Sýh - Thrall"] = "Default",
		["Gerold - Tichondrius"] = "Default",
		["Syhlo - Tichondrius"] = "Default",
		["Dwarfmounts - Tichondrius"] = "Default",
		["Syhlol - Thrall"] = "Default",
		["Syhdk - Thrall"] = "Default",
		["Syhlo - Thrall"] = "Default",
		["Syh - Thrall"] = "Default",
	},
}
