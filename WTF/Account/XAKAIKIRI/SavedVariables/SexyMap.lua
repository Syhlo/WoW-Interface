
SexyMap2DB = {
	["Syhlol-Illidan"] = {
		["core"] = {
			["clamp"] = true,
			["lock"] = false,
			["rightClickToConfig"] = true,
			["autoZoom"] = 5,
			["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
			["northTag"] = true,
		},
		["coordinates"] = {
			["enabled"] = true,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["moveBuffs"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
				{
					["name"] = "Rune 1",
					["r"] = 0.3098039215686275,
					["scale"] = 1.4,
					["rotSpeed"] = -30,
					["g"] = 0.4784313725490196,
					["texture"] = 165630,
				}, -- [1]
				{
					["a"] = 0.3799999952316284,
					["rotSpeed"] = 60,
					["r"] = 0.196078431372549,
					["scale"] = 2.1,
					["name"] = "Rune 2",
					["g"] = 0.2901960784313725,
					["texture"] = 165638,
				}, -- [2]
				{
					["a"] = 0.3,
					["name"] = "Fade",
					["r"] = 0,
					["scale"] = 1.6,
					["g"] = 0.2235294117647059,
					["texture"] = 167062,
				}, -- [3]
			},
			["backdrop"] = {
				["show"] = false,
				["textureColor"] = {
				},
				["settings"] = {
					["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
					["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
					["tile"] = false,
					["edgeSize"] = 16,
					["insets"] = {
						["top"] = 4,
						["right"] = 4,
						["left"] = 4,
						["bottom"] = 4,
					},
				},
				["borderColor"] = {
				},
				["scale"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "never",
				["MiniMapMailFrame"] = "always",
				["TimeManagerClockButton"] = "always",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "always",
				["MinimapZoomOut"] = "never",
				["SexyMapZoneTextButton"] = "always",
				["MiniMapWorldMapButton"] = "never",
			},
			["dragPositions"] = {
			},
			["controlVisibility"] = true,
		},
	},
	["Syhlol-Tichondrius"] = {
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
		["coordinates"] = {
			["enabled"] = false,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["core"] = {
			["clamp"] = true,
			["point"] = "TOPRIGHT",
			["relpoint"] = "TOPRIGHT",
			["autoZoom"] = 5,
			["northTag"] = false,
			["y"] = -28.66643905639648,
			["x"] = -57.66691970825195,
			["lock"] = true,
			["shape"] = 130871,
			["rightClickToConfig"] = true,
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "hover",
				["MiniMapMailFrame"] = "always",
				["GameTimeFrame"] = "hover",
				["TimeManagerClockButton"] = "always",
				["MinimapZoomOut"] = "hover",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "hover",
				["SexyMapZoneTextButton"] = "hover",
				["MiniMapWorldMapButton"] = "never",
				["LibDBIcon10_RareScannerMinimapIcon"] = "hover",
			},
			["dragPositions"] = {
				["MinimapZoomIn"] = 15.58729202115153,
				["MiniMapMailFrame"] = 28.26205225057081,
				["LibDBIcon10_RareScannerMinimapIcon"] = 173.6839504555741,
				["LibDBIcon10_ActionBarProfiles"] = 195.0863589922001,
				["GameTimeFrame"] = 39.37613929948467,
				["LibDBIcon10_LookingForGroup"] = 240.538678265827,
				["QueueStatusMinimapButton"] = 220.5664533431682,
				["MinimapZoomOut"] = -4.203750656999082,
				["LibDBIcon10_Executive_Assistant"] = 195.354673073557,
				["LibDBIcon10_REFlex"] = -42.87890238074035,
				["LibDBIcon10_Rarity"] = -5.259397079567432,
				["MiniMapTracking"] = 155.6005796710525,
				["LibDBIcon10_LootAppraiser"] = 198.3700681202371,
				["GarrisonLandingPageMinimapButton"] = -45.67716852958172,
				["LibDBIcon10_Details"] = 246.3707364671078,
			},
			["controlVisibility"] = true,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 0,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 0,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["fontsize"] = 10,
			["yOffset"] = -2,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
			},
			["backdrop"] = {
				["show"] = true,
				["textureColor"] = {
					["a"] = 1,
					["b"] = 0.1058823529411765,
					["g"] = 0.08235294117647059,
					["r"] = 0.08235294117647059,
				},
				["settings"] = {
					["insets"] = {
						["top"] = 5,
						["right"] = 5,
						["left"] = 5,
						["bottom"] = 5,
					},
					["edgeSize"] = 17,
					["bgFile"] = "Interface\\Buttons\\WHITE8X8",
					["tile"] = false,
				},
				["borderColor"] = {
					["a"] = 0,
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["scale"] = 1.1,
				["alpha"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 0,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
				["a"] = 1,
				["b"] = 1,
				["g"] = 1,
				["r"] = 1,
			},
			["borderColor"] = {
				["a"] = 0,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 2,
			["fontsize"] = 10,
			["width"] = 154,
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["lockTopWidget"] = false,
			["moveBuffs"] = false,
			["moveTopWidget"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
	},
	["Gnomemounts-Tichondrius"] = "global",
	["Syhl-Thrall"] = "global",
	["Sydh-Thrall"] = {
		["core"] = {
			["clamp"] = true,
			["lock"] = false,
			["rightClickToConfig"] = true,
			["autoZoom"] = 5,
			["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
			["northTag"] = true,
		},
		["coordinates"] = {
			["enabled"] = true,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "never",
				["MiniMapMailFrame"] = "always",
				["MiniMapWorldMapButton"] = "never",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "always",
				["MinimapZoomOut"] = "never",
				["SexyMapZoneTextButton"] = "always",
				["TimeManagerClockButton"] = "always",
			},
			["dragPositions"] = {
			},
			["controlVisibility"] = true,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
				{
					["name"] = "Rune 1",
					["r"] = 0.3098039215686275,
					["scale"] = 1.4,
					["rotSpeed"] = -30,
					["g"] = 0.4784313725490196,
					["texture"] = 165630,
				}, -- [1]
				{
					["a"] = 0.3799999952316284,
					["rotSpeed"] = 60,
					["r"] = 0.196078431372549,
					["scale"] = 2.1,
					["name"] = "Rune 2",
					["g"] = 0.2901960784313725,
					["texture"] = 165638,
				}, -- [2]
				{
					["a"] = 0.3,
					["name"] = "Fade",
					["r"] = 0,
					["scale"] = 1.6,
					["g"] = 0.2235294117647059,
					["texture"] = 167062,
				}, -- [3]
			},
			["backdrop"] = {
				["show"] = false,
				["textureColor"] = {
				},
				["settings"] = {
					["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
					["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
					["tile"] = false,
					["edgeSize"] = 16,
					["insets"] = {
						["top"] = 4,
						["right"] = 4,
						["left"] = 4,
						["bottom"] = 4,
					},
				},
				["borderColor"] = {
				},
				["scale"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["lockTopWidget"] = false,
			["moveBuffs"] = false,
			["moveTopWidget"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
	},
	["Isellpropane-Proudmoore"] = {
		["core"] = {
			["clamp"] = true,
			["point"] = "TOPRIGHT",
			["relpoint"] = "TOPRIGHT",
			["autoZoom"] = 5,
			["northTag"] = true,
			["y"] = -33.66658782958984,
			["x"] = -33.66667938232422,
			["lock"] = true,
			["shape"] = 130871,
			["rightClickToConfig"] = true,
		},
		["coordinates"] = {
			["enabled"] = true,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "hover",
				["MiniMapMailFrame"] = "always",
				["MiniMapWorldMapButton"] = "never",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "hover",
				["MinimapZoomOut"] = "hover",
				["SexyMapZoneTextButton"] = "always",
				["TimeManagerClockButton"] = "always",
			},
			["dragPositions"] = {
				["MinimapZoomIn"] = 14.312148919284,
				["MiniMapMailFrame"] = 194.78123078913,
				["QueueStatusMinimapButton"] = 210.8959954348665,
				["MiniMapTracking"] = 147.7507478894727,
				["GarrisonLandingPageMinimapButton"] = -24.6496137745433,
				["MinimapZoomOut"] = -4.203750656999082,
			},
			["controlVisibility"] = true,
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["lockTopWidget"] = false,
			["moveBuffs"] = false,
			["moveTopWidget"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["xOffset"] = 0,
			["fontsize"] = 10,
			["yOffset"] = -2,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
			},
			["backdrop"] = {
				["show"] = true,
				["textureColor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["settings"] = {
					["edgeSize"] = 17,
					["edgeFile"] = "Interface\\DialogFrame\\UI-DialogBox-Border",
					["bgFile"] = "Interface\\Buttons\\WHITE8X8",
					["tile"] = false,
					["insets"] = {
						["top"] = 4,
						["right"] = 4,
						["left"] = 4,
						["bottom"] = 4,
					},
				},
				["borderColor"] = {
					["a"] = 0.352563202381134,
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["scale"] = 1.07,
				["alpha"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 0.4380334615707398,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["xOffset"] = 0,
			["width"] = 154,
			["yOffset"] = 2,
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
	},
	["Syh-Thrall"] = "global",
	["Crylo-Tichondrius"] = {
		["core"] = {
			["clamp"] = true,
			["lock"] = false,
			["rightClickToConfig"] = true,
			["autoZoom"] = 5,
			["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
			["northTag"] = true,
		},
		["coordinates"] = {
			["enabled"] = true,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["lockTopWidget"] = false,
			["moveBuffs"] = false,
			["moveTopWidget"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
				{
					["name"] = "Rune 1",
					["r"] = 0.3098039215686275,
					["scale"] = 1.4,
					["rotSpeed"] = -30,
					["g"] = 0.4784313725490196,
					["texture"] = 165630,
				}, -- [1]
				{
					["a"] = 0.3799999952316284,
					["rotSpeed"] = 60,
					["r"] = 0.196078431372549,
					["scale"] = 2.1,
					["name"] = "Rune 2",
					["g"] = 0.2901960784313725,
					["texture"] = 165638,
				}, -- [2]
				{
					["a"] = 0.3,
					["name"] = "Fade",
					["r"] = 0,
					["scale"] = 1.6,
					["g"] = 0.2235294117647059,
					["texture"] = 167062,
				}, -- [3]
			},
			["backdrop"] = {
				["show"] = false,
				["textureColor"] = {
				},
				["settings"] = {
					["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
					["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
					["tile"] = false,
					["edgeSize"] = 16,
					["insets"] = {
						["top"] = 4,
						["right"] = 4,
						["left"] = 4,
						["bottom"] = 4,
					},
				},
				["borderColor"] = {
				},
				["scale"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "never",
				["MiniMapMailFrame"] = "always",
				["MiniMapWorldMapButton"] = "never",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "always",
				["MinimapZoomOut"] = "never",
				["SexyMapZoneTextButton"] = "always",
				["TimeManagerClockButton"] = "always",
			},
			["dragPositions"] = {
			},
			["controlVisibility"] = true,
		},
	},
	["Syhlo-Thrall"] = "global",
	["Youreterribl-Burning Legion"] = {
		["core"] = {
			["clamp"] = true,
			["lock"] = false,
			["rightClickToConfig"] = true,
			["autoZoom"] = 5,
			["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
			["northTag"] = true,
		},
		["coordinates"] = {
			["enabled"] = true,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["lockTopWidget"] = false,
			["moveBuffs"] = false,
			["moveTopWidget"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
				{
					["name"] = "Rune 1",
					["r"] = 0.3098039215686275,
					["scale"] = 1.4,
					["rotSpeed"] = -30,
					["g"] = 0.4784313725490196,
					["texture"] = 165630,
				}, -- [1]
				{
					["a"] = 0.3799999952316284,
					["rotSpeed"] = 60,
					["r"] = 0.196078431372549,
					["scale"] = 2.1,
					["name"] = "Rune 2",
					["g"] = 0.2901960784313725,
					["texture"] = 165638,
				}, -- [2]
				{
					["a"] = 0.3,
					["name"] = "Fade",
					["r"] = 0,
					["scale"] = 1.6,
					["g"] = 0.2235294117647059,
					["texture"] = 167062,
				}, -- [3]
			},
			["backdrop"] = {
				["show"] = false,
				["textureColor"] = {
				},
				["settings"] = {
					["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
					["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
					["tile"] = false,
					["edgeSize"] = 16,
					["insets"] = {
						["top"] = 4,
						["right"] = 4,
						["left"] = 4,
						["bottom"] = 4,
					},
				},
				["borderColor"] = {
				},
				["scale"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "never",
				["MiniMapMailFrame"] = "always",
				["MiniMapWorldMapButton"] = "never",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "always",
				["MinimapZoomOut"] = "never",
				["SexyMapZoneTextButton"] = "always",
				["TimeManagerClockButton"] = "always",
			},
			["dragPositions"] = {
			},
			["controlVisibility"] = true,
		},
	},
	["Syhloc-Thrall"] = "global",
	["presets"] = {
	},
	["Scatterffs-Ragnaros"] = {
		["core"] = {
			["clamp"] = true,
			["lock"] = false,
			["northTag"] = true,
			["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
			["autoZoom"] = 5,
			["rightClickToConfig"] = true,
		},
		["coordinates"] = {
			["enabled"] = true,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "never",
				["MiniMapMailFrame"] = "always",
				["TimeManagerClockButton"] = "always",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "always",
				["SexyMapZoneTextButton"] = "always",
				["MinimapZoomOut"] = "never",
				["MiniMapWorldMapButton"] = "never",
			},
			["dragPositions"] = {
			},
			["controlVisibility"] = true,
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["moveBuffs"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 1,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
				{
					["name"] = "Rune 1",
					["r"] = 0.3098039215686275,
					["scale"] = 1.4,
					["rotSpeed"] = -30,
					["g"] = 0.4784313725490196,
					["texture"] = 165630,
				}, -- [1]
				{
					["a"] = 0.3799999952316284,
					["rotSpeed"] = 60,
					["r"] = 0.196078431372549,
					["scale"] = 2.1,
					["name"] = "Rune 2",
					["g"] = 0.2901960784313725,
					["texture"] = 165638,
				}, -- [2]
				{
					["a"] = 0.3,
					["name"] = "Fade",
					["r"] = 0,
					["scale"] = 1.6,
					["g"] = 0.2235294117647059,
					["texture"] = 167062,
				}, -- [3]
			},
			["backdrop"] = {
				["show"] = false,
				["textureColor"] = {
				},
				["settings"] = {
					["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
					["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
					["tile"] = false,
					["edgeSize"] = 16,
					["insets"] = {
						["top"] = 4,
						["right"] = 4,
						["left"] = 4,
						["bottom"] = 4,
					},
				},
				["borderColor"] = {
				},
				["scale"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 1,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
	},
	["Dwarfmounts-Tichondrius"] = "global",
	["Gerold-Tichondrius"] = "global",
	["Regèn-Tichondrius"] = "global",
	["Wthrename-Tichondrius"] = {
		["core"] = {
			["clamp"] = true,
			["lock"] = false,
			["rightClickToConfig"] = true,
			["autoZoom"] = 5,
			["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
			["northTag"] = true,
		},
		["coordinates"] = {
			["enabled"] = true,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["moveBuffs"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
				{
					["name"] = "Rune 1",
					["r"] = 0.3098039215686275,
					["scale"] = 1.4,
					["rotSpeed"] = -30,
					["g"] = 0.4784313725490196,
					["texture"] = 165630,
				}, -- [1]
				{
					["a"] = 0.3799999952316284,
					["rotSpeed"] = 60,
					["r"] = 0.196078431372549,
					["scale"] = 2.1,
					["name"] = "Rune 2",
					["g"] = 0.2901960784313725,
					["texture"] = 165638,
				}, -- [2]
				{
					["a"] = 0.3,
					["name"] = "Fade",
					["r"] = 0,
					["scale"] = 1.6,
					["g"] = 0.2235294117647059,
					["texture"] = 167062,
				}, -- [3]
			},
			["backdrop"] = {
				["show"] = false,
				["textureColor"] = {
				},
				["settings"] = {
					["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
					["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
					["tile"] = false,
					["edgeSize"] = 16,
					["insets"] = {
						["top"] = 4,
						["right"] = 4,
						["left"] = 4,
						["bottom"] = 4,
					},
				},
				["borderColor"] = {
				},
				["scale"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "never",
				["MiniMapMailFrame"] = "always",
				["MiniMapWorldMapButton"] = "never",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "always",
				["MinimapZoomOut"] = "never",
				["SexyMapZoneTextButton"] = "always",
				["TimeManagerClockButton"] = "always",
			},
			["dragPositions"] = {
			},
			["controlVisibility"] = true,
		},
	},
	["global"] = {
		["core"] = {
			["clamp"] = true,
			["point"] = "TOPRIGHT",
			["relpoint"] = "TOPRIGHT",
			["autoZoom"] = 0,
			["northTag"] = false,
			["y"] = -29.99982643127441,
			["x"] = -30.66671943664551,
			["lock"] = true,
			["scale"] = 1,
			["shape"] = 130871,
			["rightClickToConfig"] = true,
		},
		["coordinates"] = {
			["enabled"] = false,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "hover",
				["MiniMapMailFrame"] = "always",
				["TimeManagerClockButton"] = "always",
				["SexyMapZoneTextButton"] = "always",
				["LibDBIcon10_DBM"] = "never",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "hover",
				["LibDBIcon10_Leatrix_Plus"] = "never",
				["MiniMapWorldMapButton"] = "never",
				["MinimapZoomOut"] = "hover",
			},
			["dragPositions"] = {
				["LibDBIcon10_RareScannerMinimapIcon"] = 207.294023400319,
				["LibDBIcon10_ActionBarProfiles"] = -18.92471175282654,
				["LibDBIcon10_DBM"] = 199.5668172360448,
				["LibDBIcon10_REFlex"] = 233.188030727947,
				["LibDBIcon10_Executive_Assistant"] = 192.2979533068692,
				["LibDBIcon10_Details"] = 192.5504909563713,
				["MiniMapMailFrame"] = 171.0661065819078,
				["LibDBIcon10_Rarity"] = 261.3305764525171,
				["LibDBIcon10_TradeSkillMaster"] = -59.01946740452686,
				["MinimapZoomIn"] = 14.312148919284,
				["MinimapZoomOut"] = -4.203750656999082,
				["LibDBIcon10_XarMods"] = 195.0076098171514,
				["GarrisonLandingPageMinimapButton"] = -40.89600639434675,
				["LibDBIcon10_DetailsStreamer"] = 163.8107505440486,
				["MiniMapTracking"] = 155.9245019162651,
				["LibDBIcon10_LootAppraiser"] = 192.2448210065599,
				["LibDBIcon10_WeakAuras"] = 237.6298335737002,
				["QueueStatusMinimapButton"] = 224.8943663995693,
			},
			["controlVisibility"] = true,
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = true,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
				["objectives"] = {
					"BOTTOMRIGHT", -- [1]
					"BOTTOMRIGHT", -- [2]
					-21.16672515869141, -- [3]
					25.33331680297852, -- [4]
				},
			},
			["moveCaptureBar"] = false,
			["moveObjectives"] = true,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["xOffset"] = 0,
			["fontsize"] = 10,
			["yOffset"] = -2,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
			},
			["backdrop"] = {
				["show"] = true,
				["textureColor"] = {
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["settings"] = {
					["edgeSize"] = 17,
					["edgeFile"] = "Interface\\DialogFrame\\UI-DialogBox-Border",
					["bgFile"] = "Interface\\Buttons\\WHITE8X8",
					["tile"] = false,
					["insets"] = {
						["top"] = 4,
						["right"] = 4,
						["left"] = 4,
						["bottom"] = 4,
					},
				},
				["borderColor"] = {
					["a"] = 0.352563202381134,
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["scale"] = 1.07,
				["alpha"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 0.4380334615707398,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["xOffset"] = 0,
			["width"] = 154,
			["yOffset"] = 2,
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
	},
	["Pandamounts-Tichondrius"] = "global",
	["Syhdk-Thrall"] = "global",
	["Cyf-Tichondrius"] = {
		["core"] = {
			["clamp"] = true,
			["point"] = "TOPRIGHT",
			["relpoint"] = "TOPRIGHT",
			["autoZoom"] = 5,
			["northTag"] = false,
			["y"] = -28.66643714904785,
			["x"] = -57.66691970825195,
			["lock"] = true,
			["shape"] = 130871,
			["rightClickToConfig"] = true,
		},
		["coordinates"] = {
			["enabled"] = false,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "hover",
				["MiniMapMailFrame"] = "always",
				["GameTimeFrame"] = "hover",
				["TimeManagerClockButton"] = "always",
				["MinimapZoomOut"] = "hover",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "hover",
				["LibDBIcon10_RareScannerMinimapIcon"] = "hover",
				["MiniMapWorldMapButton"] = "never",
				["SexyMapZoneTextButton"] = "hover",
			},
			["dragPositions"] = {
				["MinimapZoomIn"] = 14.312148919284,
				["MiniMapMailFrame"] = 28.26205225057081,
				["LibDBIcon10_Details"] = 246.3707364671078,
				["MiniMapTracking"] = 158.8522730997002,
				["GameTimeFrame"] = 45.3967319465316,
				["LibDBIcon10_LookingForGroup"] = 240.538678265827,
				["LibDBIcon10_Rarity"] = -5.259397079567432,
				["MinimapZoomOut"] = -4.203750656999082,
				["GarrisonLandingPageMinimapButton"] = -28.05944573164052,
				["QueueStatusMinimapButton"] = 220.5664533431682,
				["LibDBIcon10_REFlex"] = -75.65052868370628,
				["LibDBIcon10_Executive_Assistant"] = 178.749319498429,
				["LibDBIcon10_LootAppraiser"] = 198.3700681202371,
				["LibDBIcon10_ActionBarProfiles"] = 195.0863589922001,
				["LibDBIcon10_RareScannerMinimapIcon"] = 195.497431376618,
			},
			["controlVisibility"] = true,
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["lockTopWidget"] = false,
			["moveBuffs"] = false,
			["moveTopWidget"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["xOffset"] = 0,
			["fontsize"] = 10,
			["yOffset"] = -2,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
			},
			["backdrop"] = {
				["show"] = true,
				["textureColor"] = {
					["a"] = 1,
					["r"] = 0.08235294117647059,
					["g"] = 0.08235294117647059,
					["b"] = 0.1058823529411765,
				},
				["settings"] = {
					["tile"] = false,
					["edgeSize"] = 17,
					["bgFile"] = "Interface\\Buttons\\WHITE8X8",
					["insets"] = {
						["top"] = 5,
						["right"] = 5,
						["left"] = 5,
						["bottom"] = 5,
					},
				},
				["borderColor"] = {
					["a"] = 0,
					["b"] = 0,
					["g"] = 0,
					["r"] = 0,
				},
				["scale"] = 1.1,
				["alpha"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
				["a"] = 1,
				["r"] = 1,
				["g"] = 1,
				["b"] = 1,
			},
			["borderColor"] = {
				["a"] = 0,
				["b"] = 0,
				["g"] = 0,
				["r"] = 0,
			},
			["xOffset"] = 0,
			["width"] = 154,
			["fontsize"] = 10,
			["yOffset"] = 2,
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
	},
	["Sýh-Thrall"] = "global",
	["Syhlol-Thrall"] = {
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
		["coordinates"] = {
			["enabled"] = false,
			["fontColor"] = {
			},
			["xOffset"] = 0,
			["updateRate"] = 1,
			["yOffset"] = 10,
			["font"] = "Friz Quadrata TT",
			["borderColor"] = {
			},
			["coordPrecision"] = "%d,%d",
			["backgroundColor"] = {
			},
		},
		["core"] = {
			["clamp"] = true,
			["point"] = "TOPRIGHT",
			["relpoint"] = "TOPRIGHT",
			["autoZoom"] = 5,
			["northTag"] = false,
			["y"] = -28.66643905639648,
			["x"] = -57.66691970825195,
			["lock"] = true,
			["shape"] = 130871,
			["rightClickToConfig"] = true,
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "hover",
				["MiniMapMailFrame"] = "always",
				["GameTimeFrame"] = "hover",
				["TimeManagerClockButton"] = "always",
				["MinimapZoomOut"] = "hover",
				["QueueStatusMinimapButton"] = "always",
				["GarrisonLandingPageMinimapButton"] = "hover",
				["SexyMapZoneTextButton"] = "hover",
				["MiniMapWorldMapButton"] = "never",
				["LibDBIcon10_RareScannerMinimapIcon"] = "hover",
			},
			["dragPositions"] = {
				["MinimapZoomIn"] = 14.312148919284,
				["MiniMapMailFrame"] = 28.26205225057081,
				["LibDBIcon10_RareScannerMinimapIcon"] = 201.440754701509,
				["LibDBIcon10_ActionBarProfiles"] = 195.0863589922001,
				["GameTimeFrame"] = 45.3967319465316,
				["LibDBIcon10_LookingForGroup"] = 240.538678265827,
				["QueueStatusMinimapButton"] = 220.5664533431682,
				["MinimapZoomOut"] = -4.203750656999082,
				["LibDBIcon10_Executive_Assistant"] = 187.565452104568,
				["LibDBIcon10_REFlex"] = -75.65052868370628,
				["LibDBIcon10_Rarity"] = -5.259397079567432,
				["MiniMapTracking"] = 158.8522730997002,
				["LibDBIcon10_LootAppraiser"] = 198.3700681202371,
				["GarrisonLandingPageMinimapButton"] = -45.67716852958172,
				["LibDBIcon10_Details"] = 246.3707364671078,
			},
			["controlVisibility"] = true,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 0,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 0,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["fontsize"] = 10,
			["yOffset"] = -2,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
			},
			["backdrop"] = {
				["show"] = true,
				["textureColor"] = {
					["a"] = 1,
					["b"] = 0.1058823529411765,
					["g"] = 0.08235294117647059,
					["r"] = 0.08235294117647059,
				},
				["settings"] = {
					["insets"] = {
						["top"] = 5,
						["right"] = 5,
						["left"] = 5,
						["bottom"] = 5,
					},
					["edgeSize"] = 17,
					["bgFile"] = "Interface\\Buttons\\WHITE8X8",
					["tile"] = false,
				},
				["borderColor"] = {
					["a"] = 0,
					["r"] = 0,
					["g"] = 0,
					["b"] = 0,
				},
				["scale"] = 1.1,
				["alpha"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 0,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "Friz Quadrata TT",
			["fontColor"] = {
				["a"] = 1,
				["b"] = 1,
				["g"] = 1,
				["r"] = 1,
			},
			["borderColor"] = {
				["a"] = 0,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 2,
			["fontsize"] = 10,
			["width"] = 154,
		},
		["movers"] = {
			["lockDurability"] = false,
			["lockObjectives"] = false,
			["moveDurability"] = false,
			["lockCaptureBar"] = false,
			["moveVehicle"] = false,
			["lockVehicle"] = false,
			["moverPositions"] = {
			},
			["lockTopWidget"] = false,
			["moveBuffs"] = false,
			["moveTopWidget"] = false,
			["lockBuffs"] = false,
			["moveCaptureBar"] = false,
			["moveObjectives"] = false,
		},
	},
}
