
Gladius2DB = {
	["profileKeys"] = {
		["Cyf - Tichondrius"] = "Syh - Thrall",
		["Sýh - Thrall"] = "Syh - Thrall",
		["Wthrename - Tichondrius"] = "Wthrename - Tichondrius",
		["Gerold - Tichondrius"] = "Syh - Thrall",
		["Syhlo - Thrall"] = "Syh - Thrall",
		["Crylo - Tichondrius"] = "Crylo - Tichondrius",
		["Syhdk - Thrall"] = "Syh - Thrall",
		["Syh - Thrall"] = "Syh - Thrall",
		["Syhlol - Thrall"] = "Global",
		["Sydh - Thrall"] = "Sydh - Thrall",
	},
	["profiles"] = {
		["Cyf - Tichondrius"] = {
			["auraVersion"] = 1,
			["tagsVersion"] = 4,
			["y"] = {
				["arena1"] = 545.4223222348446,
			},
			["x"] = {
				["arena1"] = 954.3111342191696,
			},
		},
		["Global"] = {
			["targetBarWidth"] = 100,
			["modules"] = {
				["TargetBar"] = true,
				["Racial"] = false,
			},
			["castBarInverse"] = true,
			["dispellGlossColor"] = {
				["a"] = 0,
			},
			["castBarHeight"] = 44,
			["timerMinutesFontSize"] = 20,
			["tags"] = {
				["maxhealth"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitHealthMax(unit) or Gladius.testing[unit].maxHealth\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
				["class:short"] = {
					["preparation"] = true,
					["func"] = "function(unit)\nreturn not Gladius.test and Gladius.L[LOCALIZED_CLASS_NAMES_MALE[Gladius.buttons[unit].class]..\":short\"] or Gladius.L[LOCALIZED_CLASS_NAMES_MALE[Gladius.testing[unit].unitClass]..\":short\"]\nend",
					["events"] = "UNIT_NAME_UPDATE",
				},
				["health:short"] = {
					["func"] = "function(unit)\nlocal health = not Gladius.test and UnitHealth(unit) or Gladius.testing[unit].health\nif (health > 999) then\nreturn strformat(\"%.1fk\", (health / 1000))\nelse\nreturn health\nend\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
				["class"] = {
					["preparation"] = true,
					["func"] = "function(unit)\nreturn not Gladius.test and LOCALIZED_CLASS_NAMES_MALE[Gladius.buttons[unit].class] or LOCALIZED_CLASS_NAMES_MALE[Gladius.testing[unit].unitClass]\nend",
					["events"] = "UNIT_NAME_UPDATE",
				},
				["power:short"] = {
					["func"] = "function(unit)\nlocal power = not Gladius.test and UnitPower(unit) or Gladius.testing[unit].power\nif (power > 999) then\nreturn strformat(\"%.1fk\", (power / 1000))\nelse\nreturn power\nend\nend",
					["events"] = "UNIT_POWER_UPDATE UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["race"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitRace(unit) or Gladius.testing[unit].unitRace\nend",
					["events"] = "UNIT_NAME_UPDATE",
				},
				["maxpower:short"] = {
					["func"] = "function(unit)\nlocal power = not Gladius.test and UnitPowerMax(unit) or Gladius.testing[unit].maxPower\nif (power > 999) then\nreturn strformat(\"%.1fk\", (power / 1000))\nelse\nreturn power\nend\nend",
					["events"] = "UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["power"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitPower(unit) or Gladius.testing[unit].power\nend",
					["events"] = "UNIT_POWER_UPDATE UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["name:status"] = {
					["func"] = "function(unit)\nreturn UnitIsDeadOrGhost(unit) and Gladius.L[\"DEAD\"] or (UnitName(unit) or unit)\nend",
					["events"] = "UNIT_NAME_UPDATE UNIT_HEALTH",
				},
				["spec"] = {
					["preparation"] = true,
					["func"] = "function(unit)\nreturn Gladius.test and Gladius.testing[unit].unitSpec or Gladius.buttons[unit].spec\nend",
					["events"] = "UNIT_NAME_UPDATE GLADIUS_SPEC_UPDATE",
				},
				["power:percentage"] = {
					["func"] = "function(unit)\nlocal power = not Gladius.test and UnitPower(unit) or Gladius.testing[unit].power\nlocal maxPower = not Gladius.test and UnitPowerMax(unit) or Gladius.testing[unit].maxPower\nreturn strformat(\"%.1f%%\", (power / maxPower * 100))\nend",
					["events"] = "UNIT_POWER_UPDATE UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["name"] = {
					["func"] = "function(unit)\nreturn UnitName(unit) or unit\nend",
					["events"] = "UNIT_NAME_UPDATE",
				},
				["spec:short"] = {
					["preparation"] = true,
					["func"] = "function(unit)\nlocal spec = Gladius.test and Gladius.testing[unit].unitSpec or Gladius.buttons[unit].spec\nif (spec == nil or spec == \"\") then\nreturn \"\"\nend\nreturn Gladius.L[spec..\":short\"]\nend",
					["events"] = "UNIT_NAME_UPDATE GLADIUS_SPEC_UPDATE",
				},
				["health:percentage"] = {
					["func"] = "function(unit)\nlocal health = not Gladius.test and UnitHealth(unit) or Gladius.testing[unit].health\nlocal maxHealth = not Gladius.test and UnitHealthMax(unit) or Gladius.testing[unit].maxHealth\nreturn strformat(\"%.1f%%\", (health / maxHealth * 100))\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
				["maxpower"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitPowerMax(unit) or Gladius.testing[unit].maxPower\nend",
					["events"] = "UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["maxhealth:short"] = {
					["func"] = "function(unit)\nlocal health = not Gladius.test and UnitHealthMax(unit) or Gladius.testing[unit].maxHealth\nif (health > 999) then\nreturn strformat(\"%.1fk\", (health / 1000))\nelse\nreturn health\nend\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
				["health"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitHealth(unit) or Gladius.testing[unit].health\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
			},
			["highlightFocus"] = false,
			["dispellAdjustSize"] = false,
			["drTrackerGlossColor"] = {
				["a"] = 0,
			},
			["powerBarHeight"] = 25,
			["targetBarAttachTo"] = "Dispel",
			["targetBarOffsetX"] = 15,
			["tagsVersion"] = 4,
			["drTrackerCooldownReverse"] = true,
			["locked"] = true,
			["trinketSize"] = 58,
			["x"] = {
				["arena1"] = 901.5125218295725,
			},
			["classIconCooldown"] = true,
			["castBarColor"] = {
				["g"] = 0,
				["b"] = 0.4941176470588236,
			},
			["trinketAdjustSize"] = false,
			["targetBarAdjustWidth"] = false,
			["healthBarHeight"] = 26,
			["targetBarHeight"] = 32,
			["globalFont"] = "Arial Narrow",
			["dispellCooldownReverse"] = true,
			["timerSoonFontSize"] = 20,
			["backgroundColor"] = {
				["a"] = 0,
			},
			["castTextSize"] = 14,
			["trinketGloss"] = false,
			["timerSecondsFontSize"] = 20,
			["dispellIconCrop"] = true,
			["globalFontSize"] = 16,
			["drTrackerMargin"] = 7,
			["direction"] = 2,
			["targetBarOffsetY"] = -13,
			["announcements"] = {
				["trinket"] = false,
				["health"] = false,
				["spec"] = false,
				["enemies"] = false,
			},
			["frameScale"] = 0.8,
			["targetBarIcon"] = false,
			["dispellSize"] = 56,
			["tagsTexts"] = {
				["TargetBar Left Text"] = {
					["offsetX"] = 8,
				},
				["HealthBar Right Text"] = {
					["text"] = "[maxhealth:short]",
				},
				["PowerBar Right Text"] = {
					["text"] = "[power:short]/ [maxpower:short]",
				},
				["TargetBar Right Text"] = {
					["text"] = "",
				},
			},
			["drFontSize"] = 20,
			["highlightHover"] = false,
			["trinketIconCrop"] = true,
			["classIconCooldownReverse"] = true,
			["classIconGlossColor"] = {
				["a"] = 0,
			},
			["classIconSize"] = 63,
			["drTrackerSize"] = 54,
			["drTrackerCooldown"] = true,
			["castBarBackgroundColor"] = {
				["a"] = 0.1816238760948181,
				["r"] = 0.0392156862745098,
				["g"] = 0.0392156862745098,
				["b"] = 0.0392156862745098,
			},
			["drTrackerAdjustSize"] = false,
			["auraVersion"] = 1,
			["barWidth"] = 180,
			["backgroundPadding"] = 0,
			["y"] = {
				["arena1"] = 536.6411241055466,
			},
		},
		["Wthrename - Tichondrius"] = {
			["auraVersion"] = 1,
			["tagsVersion"] = 4,
			["y"] = {
				["arena1"] = 485.6890308578841,
			},
			["x"] = {
				["arena1"] = 904.5337024582841,
			},
		},
		["Syh - Thrall"] = {
			["direction"] = 2,
			["targetBarWidth"] = 100,
			["tagsTexts"] = {
				["TargetBar Left Text"] = {
					["offsetX"] = 8,
				},
				["PowerBar Right Text"] = {
					["text"] = "[power:short]/ [maxpower:short]",
				},
				["HealthBar Right Text"] = {
					["text"] = "[maxhealth:short]",
				},
				["TargetBar Right Text"] = {
					["text"] = "",
				},
			},
			["drTrackerCooldownReverse"] = true,
			["modules"] = {
				["Racial"] = false,
			},
			["classIconSize"] = 63,
			["highlightFocus"] = false,
			["castBarColor"] = {
				["g"] = 0,
				["b"] = 0.4941176470588236,
			},
			["castBarInverse"] = true,
			["trinketAdjustSize"] = false,
			["backgroundColor"] = {
				["a"] = 0,
			},
			["castBarHeight"] = 44,
			["powerBarHeight"] = 25,
			["trinketSize"] = 58,
			["targetBarAdjustWidth"] = false,
			["announcements"] = {
				["spec"] = false,
				["trinket"] = false,
				["health"] = false,
				["enemies"] = false,
			},
			["x"] = {
				["arena1"] = 901.5125218295725,
			},
			["drTrackerSize"] = 54,
			["healthBarHeight"] = 26,
			["frameScale"] = 0.8,
			["y"] = {
				["arena1"] = 536.6411241055466,
			},
			["highlightHover"] = false,
			["backgroundPadding"] = 0,
			["trinketIconCrop"] = true,
			["dispellAdjustSize"] = false,
			["trinketGloss"] = false,
			["locked"] = true,
			["drTrackerAdjustSize"] = false,
			["timerMinutesFontSize"] = 20,
			["castBarBackgroundColor"] = {
				["a"] = 0.1816238760948181,
				["b"] = 0.0392156862745098,
				["g"] = 0.0392156862745098,
				["r"] = 0.0392156862745098,
			},
			["drTrackerCooldown"] = true,
			["dispellGlossColor"] = {
				["a"] = 0,
			},
			["castTextSize"] = 14,
			["targetBarIcon"] = false,
			["classIconCooldownReverse"] = true,
			["drFontSize"] = 20,
			["targetBarOffsetX"] = 15,
			["dispellSize"] = 56,
			["targetBarHeight"] = 32,
			["targetBarOffsetY"] = -13,
			["timerSecondsFontSize"] = 20,
			["tags"] = {
				["maxhealth"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitHealthMax(unit) or Gladius.testing[unit].maxHealth\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
				["class:short"] = {
					["preparation"] = true,
					["func"] = "function(unit)\nreturn not Gladius.test and Gladius.L[LOCALIZED_CLASS_NAMES_MALE[Gladius.buttons[unit].class]..\":short\"] or Gladius.L[LOCALIZED_CLASS_NAMES_MALE[Gladius.testing[unit].unitClass]..\":short\"]\nend",
					["events"] = "UNIT_NAME_UPDATE",
				},
				["health:short"] = {
					["func"] = "function(unit)\nlocal health = not Gladius.test and UnitHealth(unit) or Gladius.testing[unit].health\nif (health > 999) then\nreturn strformat(\"%.1fk\", (health / 1000))\nelse\nreturn health\nend\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
				["class"] = {
					["preparation"] = true,
					["func"] = "function(unit)\nreturn not Gladius.test and LOCALIZED_CLASS_NAMES_MALE[Gladius.buttons[unit].class] or LOCALIZED_CLASS_NAMES_MALE[Gladius.testing[unit].unitClass]\nend",
					["events"] = "UNIT_NAME_UPDATE",
				},
				["power:short"] = {
					["func"] = "function(unit)\nlocal power = not Gladius.test and UnitPower(unit) or Gladius.testing[unit].power\nif (power > 999) then\nreturn strformat(\"%.1fk\", (power / 1000))\nelse\nreturn power\nend\nend",
					["events"] = "UNIT_POWER_UPDATE UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["race"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitRace(unit) or Gladius.testing[unit].unitRace\nend",
					["events"] = "UNIT_NAME_UPDATE",
				},
				["maxpower:short"] = {
					["func"] = "function(unit)\nlocal power = not Gladius.test and UnitPowerMax(unit) or Gladius.testing[unit].maxPower\nif (power > 999) then\nreturn strformat(\"%.1fk\", (power / 1000))\nelse\nreturn power\nend\nend",
					["events"] = "UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["power"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitPower(unit) or Gladius.testing[unit].power\nend",
					["events"] = "UNIT_POWER_UPDATE UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["name:status"] = {
					["func"] = "function(unit)\nreturn UnitIsDeadOrGhost(unit) and Gladius.L[\"DEAD\"] or (UnitName(unit) or unit)\nend",
					["events"] = "UNIT_NAME_UPDATE UNIT_HEALTH",
				},
				["spec"] = {
					["preparation"] = true,
					["func"] = "function(unit)\nreturn Gladius.test and Gladius.testing[unit].unitSpec or Gladius.buttons[unit].spec\nend",
					["events"] = "UNIT_NAME_UPDATE GLADIUS_SPEC_UPDATE",
				},
				["power:percentage"] = {
					["func"] = "function(unit)\nlocal power = not Gladius.test and UnitPower(unit) or Gladius.testing[unit].power\nlocal maxPower = not Gladius.test and UnitPowerMax(unit) or Gladius.testing[unit].maxPower\nreturn strformat(\"%.1f%%\", (power / maxPower * 100))\nend",
					["events"] = "UNIT_POWER_UPDATE UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["name"] = {
					["func"] = "function(unit)\nreturn UnitName(unit) or unit\nend",
					["events"] = "UNIT_NAME_UPDATE",
				},
				["spec:short"] = {
					["preparation"] = true,
					["func"] = "function(unit)\nlocal spec = Gladius.test and Gladius.testing[unit].unitSpec or Gladius.buttons[unit].spec\nif (spec == nil or spec == \"\") then\nreturn \"\"\nend\nreturn Gladius.L[spec..\":short\"]\nend",
					["events"] = "UNIT_NAME_UPDATE GLADIUS_SPEC_UPDATE",
				},
				["health:percentage"] = {
					["func"] = "function(unit)\nlocal health = not Gladius.test and UnitHealth(unit) or Gladius.testing[unit].health\nlocal maxHealth = not Gladius.test and UnitHealthMax(unit) or Gladius.testing[unit].maxHealth\nreturn strformat(\"%.1f%%\", (health / maxHealth * 100))\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
				["maxpower"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitPowerMax(unit) or Gladius.testing[unit].maxPower\nend",
					["events"] = "UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_NAME_UPDATE",
				},
				["maxhealth:short"] = {
					["func"] = "function(unit)\nlocal health = not Gladius.test and UnitHealthMax(unit) or Gladius.testing[unit].maxHealth\nif (health > 999) then\nreturn strformat(\"%.1fk\", (health / 1000))\nelse\nreturn health\nend\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
				["health"] = {
					["func"] = "function(unit)\nreturn not Gladius.test and UnitHealth(unit) or Gladius.testing[unit].health\nend",
					["events"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_NAME_UPDATE",
				},
			},
			["auraVersion"] = 1,
			["globalFontSize"] = 16,
			["dispellIconCrop"] = true,
			["classIconGlossColor"] = {
				["a"] = 0,
			},
			["timerSoonFontSize"] = 20,
			["dispellCooldownReverse"] = true,
			["classIconCooldown"] = true,
			["globalFont"] = "Arial Narrow",
			["drTrackerMargin"] = 7,
			["tagsVersion"] = 4,
			["drTrackerGlossColor"] = {
				["a"] = 0,
			},
			["barWidth"] = 180,
		},
		["Crylo - Tichondrius"] = {
			["auraVersion"] = 1,
			["tagsVersion"] = 4,
		},
		["Sydh - Thrall"] = {
			["auraVersion"] = 1,
			["tagsVersion"] = 4,
		},
	},
}
