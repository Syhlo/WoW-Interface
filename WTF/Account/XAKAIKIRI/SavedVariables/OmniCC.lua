
OmniCCDB = {
	["global"] = {
		["dbVersion"] = 6,
		["addonVersion"] = "10.0.1",
	},
	["profileKeys"] = {
		["Gnomemounts - Tichondrius"] = "Default",
		["Cyf - Tichondrius"] = "Default",
		["Sýh - Thrall"] = "Default",
		["Gerold - Tichondrius"] = "Default",
		["Syhlo - Tichondrius"] = "Default",
		["Dwarfmounts - Tichondrius"] = "Default",
		["Syhlol - Tichondrius"] = "Default",
		["Syhlol - Thrall"] = "Default",
		["Syhdk - Thrall"] = "Default",
		["Crylo - Tichondrius"] = "Default",
		["Pandamounts - Tichondrius"] = "Default",
		["Regèn - Tichondrius"] = "Default",
		["Syhlo - Thrall"] = "Default",
		["Syh - Thrall"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["rules"] = {
				{
					["enabled"] = false,
					["patterns"] = {
						"Aura", -- [1]
						"Buff", -- [2]
						"Debuff", -- [3]
					},
					["name"] = "Auras",
					["id"] = "auras",
				}, -- [1]
				{
					["enabled"] = false,
					["patterns"] = {
						"Plate", -- [1]
					},
					["name"] = "Unit Nameplates",
					["id"] = "plates",
				}, -- [2]
				{
					["enabled"] = false,
					["patterns"] = {
						"ActionButton", -- [1]
					},
					["name"] = "ActionBars",
					["id"] = "actions",
				}, -- [3]
			},
			["themes"] = {
				["Default"] = {
					["textStyles"] = {
						["minutes"] = {
						},
						["seconds"] = {
						},
						["soon"] = {
						},
					},
					["minSize"] = 0.35,
				},
			},
		},
	},
}
OmniCC4Config = nil
