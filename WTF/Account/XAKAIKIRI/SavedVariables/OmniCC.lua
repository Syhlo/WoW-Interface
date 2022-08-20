
OmniCCDB = {
	["profileKeys"] = {
		["Cyf - Tichondrius"] = "Default",
		["Sýh - Thrall"] = "Default",
		["Gerold - Tichondrius"] = "Default",
		["Dwarfmounts - Tichondrius"] = "Default",
		["Syhlol - Thrall"] = "Default",
		["Crylo - Tichondrius"] = "Default",
		["Pandamounts - Tichondrius"] = "Default",
		["Regèn - Tichondrius"] = "Default",
		["Syhlo - Thrall"] = "Default",
		["Syh - Thrall"] = "Default",
	},
	["global"] = {
		["dbVersion"] = 6,
		["addonVersion"] = "9.2.1",
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
						["soon"] = {
						},
						["seconds"] = {
						},
					},
					["minSize"] = 0.35,
				},
			},
		},
	},
}
OmniCC4Config = nil
