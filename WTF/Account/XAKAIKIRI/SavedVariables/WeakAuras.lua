
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["editor_tab_spaces"] = 4,
	["displays"] = {
		["Ray of Hope Positive"] = {
			["sparkWidth"] = 10,
			["iconSource"] = 0,
			["xOffset"] = 0,
			["displayText"] = "%p",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/nC7HzcyPz/6",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["keepAspectRatio"] = false,
			["selfPoint"] = "BOTTOM",
			["barColor"] = {
				0, -- [1]
				1, -- [2]
				0.082352941176471, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_size"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["PRIEST"] = true,
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_spellknown"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["single"] = 18,
					["multi"] = {
						[18] = true,
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["ratedarena"] = true,
						["arena"] = true,
						["pvp"] = true,
						["none"] = true,
					},
				},
			},
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Solid",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 90200,
			["alpha"] = 1,
			["uid"] = "AX325iyi344",
			["displayIcon"] = 1445239,
			["outline"] = "OUTLINE",
			["sparkOffsetX"] = 0,
			["wagoID"] = "nC7HzcyPz",
			["parent"] = "Ray of Hope Dynamic Group",
			["customText"] = "function()\n    local net = aura_env.totalHealAbsorb * 1.5 - aura_env.totalDmgAbsorb;\n    -- Use player HP to gauge the limits of the progress bar. \n    -- Seems reasonable for now. Maybe want to stick some multipliers on. \n    local hp = UnitHealth(\"player\")    \n    \n    if WeakAuras.IsOptionsOpen() then\n        aura_env.region:SetDurationInfo(0.25*hp, hp, true)\n        return \"25K\"\n    end\n    \n    -- AbbreviateNumbers sucks for negative numbers so handle it\n    if (net < 0 ) then\n        net = -net\n        aura_env.region:SetDurationInfo(0, hp, true)\n        return \"-\" .. AbbreviateNumbers(net)\n    else\n        aura_env.region:SetDurationInfo(net, hp, true)\n        return AbbreviateNumbers(net)    \n    end\n    \nend\n\n\n",
			["cooldownSwipe"] = true,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["debuffType"] = "HELPFUL",
						["duration"] = "6",
						["event"] = "Chat Message",
						["unit"] = "player",
						["names"] = {
						},
						["spellIds"] = {
						},
						["custom"] = "function(event, timestamp, eventtype, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellID)\n    if (not aura_env.rayActive and eventtype == \"SPELL_AURA_APPLIED\") then  \n        if (spellID == 197268 and srcGUID == UnitGUID(\"player\")) then                \n            if (aura_env.debugPrint) then\n                print(\"Ray applied\")\n            end\n            \n            aura_env.rayActive = true;\n            \n            -- Reset values if new ray is cast\n            aura_env.totalHealAbsorb = 0;\n            aura_env.totalDmgAbsorb = 0;\n            \n            return true;\n        end\n    end    \nend",
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["custom"] = "function()\n    return true\nend\n\n\n\n\n\n\n\n",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["debuffType"] = "HELPFUL",
						["custom_type"] = "stateupdate",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "6",
						["event"] = "Chat Message",
						["unit"] = "player",
						["names"] = {
						},
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED",
						["custom"] = "function(allstates, event, timestamp, eventtype, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)\n    \n    if (aura_env.rayActive and (eventtype == \"SPELL_ABSORBED\" or eventtype == \"SPELL_HEAL_ABSORBED\")) then\n        local spellID, spellName, spellSchool, aSrcGUID, aSrcName, aSrcFlags, aSrcRaidFlags, aSpellID, aSpellName, aSpellSchool, aSpellAmountAbsorbed = ...\n        -- Ray absorbed heal\n        -- srcName = Player\n        -- dstName = RoH Target\n        -- spellID = RoH spellID\n        -- aSrcName = Absorbed Heal Caster\n        -- aSpellID = Absorbed Heal SpellID\n        -- aSpellAmountAbsorbed = duh;\n        if (eventtype == \"SPELL_HEAL_ABSORBED\") then\n            if (srcGUID == UnitGUID(\"player\") and spellID == 197268) then\n                if (aura_env.debugPrint) then\n                    local str = string.format(\"Ray of Hope absorbed %s's heal, %s, for %d.\", aSrcName, aSpellName, aSpellAmountAbsorbed);\n                    print(str);\n                end\n                \n                aura_env.totalHealAbsorb = aura_env.totalHealAbsorb + aSpellAmountAbsorbed;\n                return true;\n            end            \n        end\n        \n        -- Ray absorbed dmg\n        -- srcName = enemy\n        -- dstName = RoH Target\n        -- spellID = Spell Absorbed spellID\n        -- spellName = Spell Absorbed Name\n        -- aSrcName = Player\n        -- aSpellID = RoH spellID\n        if (eventtype == \"SPELL_ABSORBED\") then\n            if (aSrcGUID == UnitGUID(\"player\") and aSpellID == 197268) then \n                if (aura_env.debugPrint) then\n                    local str = string.format(\"Ray of Hope absorbed %s's damage, %s, for %d.\", srcName, spellName, aSpellAmountAbsorbed);\n                    print(str);\n                end\n                \n                aura_env.totalDmgAbsorb = aura_env.totalDmgAbsorb + aSpellAmountAbsorbed;\n                return true;  \n            end            \n        end\n        \n    end\n    \n    -- Ray expire\n    if (aura_env.rayActive and eventtype == \"SPELL_AURA_REMOVED\") then\n        local spellID = ...\n        if (spellID == 197268 and srcGUID == UnitGUID(\"player\")) then\n            if (aura_env.debugPrint) then\n                print\"Ray removed.\"\n                print(\"RoH heals taken: \", aura_env.totalHealAbsorb)\n                print(\"RoH dmg taken: \", aura_env.totalDmgAbsorb);\n                \n                -- 1.5 represents the 50% modifier to heals into ray\n                local net = aura_env.totalHealAbsorb * 1.5 - aura_env.totalDmgAbsorb;\n                \n                local colorString = \"\"\n                if net > 0 then\n                    colorString = string.format(\"|cff00ff00%d|r\",net)\n                else\n                    colorString = string.format(\"|cffff0000%d|r\",net)\n                end\n                print(\"Net: \", colorString)\n            end\n            \n            aura_env.rayActive = false;\n            \n        end\n    end\n    \nend",
						["spellIds"] = {
						},
						["check"] = "event",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["custom"] = "function()\n    return true\nend\n\n\n\n\n\n\n\n",
					},
				}, -- [2]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(t)\n    return t[1]\nend",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 6,
			["subRegions"] = {
				{
					["type"] = "subforeground",
				}, -- [1]
				{
					["type"] = "subbackground",
				}, -- [2]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%c",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Accidental Presidency",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowXOffset"] = 1,
					["text_visible"] = true,
					["text_fontSize"] = 20,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
				}, -- [3]
				{
					["tick_blend_mode"] = "ADD",
					["tick_rotation"] = 0,
					["tick_xOffset"] = 0,
					["tick_desaturate"] = false,
					["automatic_length"] = true,
					["tick_thickness"] = 2,
					["type"] = "subtick",
					["use_texture"] = false,
					["tick_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["tick_placement"] = "0",
					["tick_texture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
					["tick_yOffset"] = 0,
					["tick_visible"] = true,
					["tick_length"] = 30,
					["tick_mirror"] = false,
					["tick_placement_mode"] = "AtPercent",
				}, -- [4]
			},
			["height"] = 30,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["source"] = "import",
			["authorOptions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "LEFT",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
					["custom"] = "\n\n",
					["do_custom"] = false,
				},
				["init"] = {
					["custom"] = "aura_env.rayActive = false;\naura_env.debugPrint = false;\n\n-- Init values for display\naura_env.totalHealAbsorb = 0;\naura_env.totalDmgAbsorb = 0;",
					["do_custom"] = true,
				},
			},
			["icon"] = false,
			["sparkHeight"] = 30,
			["zoom"] = 0.3,
			["semver"] = "1.0.5",
			["anchorFrameType"] = "SCREEN",
			["justify"] = "LEFT",
			["sparkHidden"] = "NEVER",
			["id"] = "Ray of Hope Positive",
			["config"] = {
			},
			["frameStrata"] = 1,
			["width"] = 100,
			["desc"] = "By Xellis - Blackhand",
			["cooldownTextDisabled"] = false,
			["inverse"] = false,
			["customTextUpdate"] = "event",
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["cooldown"] = false,
			["preferToUpdate"] = false,
		},
		["Paladin - Equinox"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "120125",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "355567",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "SPELL",
						["sourceFlags"] = "NotInGroup",
						["duration"] = "3",
						["use_sourceFlags"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["spellName"] = 0,
						["use_sourceName"] = false,
						["type"] = "combatlog",
						["subeventSuffix"] = "_AURA_APPLIED",
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = false,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_sourceFlags3"] = false,
						["names"] = {
						},
						["use_track"] = true,
						["use_auraType"] = false,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["displayText_format_1.sourceUnit_format"] = "none",
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["xOffset"] = 1.8965454101563,
			["regionType"] = "text",
			["selfPoint"] = "BOTTOM",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["fixedWidth"] = 200,
			["displayText_format_p_time_precision"] = 1,
			["yOffset"] = -57.777770996094,
			["wordWrap"] = "WordWrap",
			["config"] = {
			},
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Paladin - Equinox",
			["justify"] = "LEFT",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["uid"] = "jtjPfaVEKAf",
			["color"] = {
				1, -- [1]
				0.49019607843137, -- [2]
				0.90196078431373, -- [3]
				1, -- [4]
			},
			["displayText"] = "%i Equinox",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Monk-Serenity/Images"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i SEF/Serenity",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "36209",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "137639",
						["duration"] = "2.5",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_AURA_APPLIED",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "combatlog",
						["spellId"] = "152173",
						["subeventSuffix"] = "_AURA_APPLIED",
						["duration"] = "2.5",
						["event"] = "Combat Log",
						["subeventPrefix"] = "SPELL",
						["use_spellId"] = true,
						["sourceFlags2"] = "Hostile",
						["use_sourceFlags2"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Monk-Serenity/Images",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "jltka7jPvN0",
			["color"] = {
				0.49803921568627, -- [1]
				1, -- [2]
				0.69411764705882, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["drinking "] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%1.unitName drinking!",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\hic3.ogg",
					["do_sound"] = true,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["auraspellids"] = {
							"314646", -- [1]
							"167152", -- [2]
							"232419", -- [3]
						},
						["spellIds"] = {
						},
						["specificUnit"] = "arena1",
						["unit"] = "member",
						["names"] = {
						},
						["useExactSpellId"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auraspellids"] = {
							"314646", -- [1]
							"167152", -- [2]
							"232419", -- [3]
						},
						["event"] = "Health",
						["unit"] = "member",
						["specificUnit"] = "arena2",
						["subeventSuffix"] = "_CAST_START",
						["useExactSpellId"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auraspellids"] = {
							"314646", -- [1]
							"167152", -- [2]
							"232419", -- [3]
						},
						["event"] = "Health",
						["unit"] = "member",
						["specificUnit"] = "arena3",
						["subeventSuffix"] = "_CAST_START",
						["useExactSpellId"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["wordWrap"] = "WordWrap",
			["displayText_format_1.unitName_format"] = "none",
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
				["use_size"] = false,
				["class_and_spec"] = {
				},
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_zoneIds"] = false,
				["zoneIds"] = "",
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["regionType"] = "text",
			["conditions"] = {
			},
			["selfPoint"] = "BOTTOM",
			["authorOptions"] = {
			},
			["automaticWidth"] = "Auto",
			["color"] = {
				1, -- [1]
				0.019607843137255, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "drinking ",
			["displayText_format_1.unitCaster_format"] = "none",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["justify"] = "LEFT",
			["uid"] = "h0vDuqX)hPt",
			["xOffset"] = -5.8560180664063,
			["yOffset"] = -70,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Shaman - Skyfury "] = {
			["iconSource"] = -1,
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["preferToUpdate"] = false,
			["yOffset"] = 16.266479492188,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "204330",
						["duration"] = "5",
						["unit"] = "member",
						["specificUnit"] = "arena3",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["auraspellids"] = {
							"208963", -- [1]
						},
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["subeventPrefix"] = "SPELL",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_SUCCESS",
						["use_sourceFlags2"] = true,
						["names"] = {
						},
						["useExactSpellId"] = true,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 0,
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glow"] = true,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 64,
			["load"] = {
				["use_size"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class_and_spec"] = {
				},
				["use_zoneIds"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldown"] = false,
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["config"] = {
			},
			["useCooldownModRate"] = true,
			["zoom"] = 0,
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Shaman - Skyfury ",
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["width"] = 64,
			["frameStrata"] = 1,
			["uid"] = "eEgZEjNMrJA",
			["inverse"] = false,
			["xOffset"] = -140.17797851563,
			["conditions"] = {
			},
			["information"] = {
			},
			["actions"] = {
				["start"] = {
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\sonar.ogg",
					["do_sound"] = true,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Warlock - Soul Rot"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Soul Rot casting",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "115332",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "325640",
						["duration"] = "2",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Warlock - Soul Rot",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "QBpv38)0r1a",
			["color"] = {
				0.57647058823529, -- [1]
				0, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Combustion Group"] = {
			["controlledChildren"] = {
				"COMBUSTION ACTIVE", -- [1]
				"COMBUSTION COOLDOWN", -- [2]
				"COMBUSTION READY", -- [3]
				"COMBUSTION POOL WARNING", -- [4]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 190.8356323242188,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/YygmpPoNL/1",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["unit"] = "player",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["scale"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 90005,
			["id"] = "Combustion Group",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["selfPoint"] = "CENTER",
			["borderInset"] = 1,
			["uid"] = "2YpyJKwdtMn",
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["xOffset"] = 0.83154296875,
		},
		["Monk-Bonedust"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i BONEDUST",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "26877",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "325216",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Monk-Bonedust",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "QXnK4LIgiOe",
			["color"] = {
				0.4, -- [1]
				1, -- [2]
				0.73333333333333, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Warlock - Decimating Warning"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 0,
			["yOffset"] = -57.777770996094,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "114212",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "356342",
						["duration"] = "2",
						["unit"] = "member",
						["specificUnit"] = "arena1",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["use_sourceName"] = false,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags3"] = false,
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["useExactSpellId"] = true,
						["auraspellids"] = {
							"356342", -- [1]
						},
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auraspellids"] = {
							"356342", -- [1]
						},
						["debuffType"] = "HELPFUL",
						["useExactSpellId"] = true,
						["specificUnit"] = "arena2",
						["unit"] = "member",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auraspellids"] = {
							"356342", -- [1]
						},
						["debuffType"] = "HELPFUL",
						["useExactSpellId"] = true,
						["specificUnit"] = "arena3",
						["unit"] = "member",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["wordWrap"] = "WordWrap",
			["displayText_format_1.totalStacks_format"] = "none",
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["displayText_format_s_format"] = "none",
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["displayText"] = "%i %s Decimating Bolts left %p",
			["xOffset"] = 1.8965454101563,
			["regionType"] = "text",
			["displayText_format_p_time_legacy_floor"] = true,
			["fixedWidth"] = 200,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["preferToUpdate"] = false,
			["displayText_format_p_time_precision"] = 1,
			["uid"] = "YwkaudI7Jcp",
			["automaticWidth"] = "Auto",
			["semver"] = "1.0.9",
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Warlock - Decimating Warning",
			["shadowYOffset"] = -1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				0.57647058823529, -- [1]
				0, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["selfPoint"] = "BOTTOM",
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["displayText_format_p_time_mod_rate"] = true,
		},
		["Ret - Seraphim "] = {
			["iconSource"] = -1,
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["preferToUpdate"] = false,
			["yOffset"] = 16.266479492188,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "152262",
						["duration"] = "15",
						["unit"] = "member",
						["specificUnit"] = "arena3",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["auraspellids"] = {
							"152262", -- [1]
						},
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["subeventPrefix"] = "SPELL",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_AURA_APPLIED",
						["use_sourceFlags2"] = true,
						["names"] = {
						},
						["useExactSpellId"] = true,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 0,
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glow"] = true,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 64,
			["load"] = {
				["use_size"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class_and_spec"] = {
				},
				["use_zoneIds"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldown"] = false,
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["config"] = {
			},
			["useCooldownModRate"] = true,
			["zoom"] = 0,
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Ret - Seraphim ",
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["width"] = 64,
			["frameStrata"] = 1,
			["uid"] = "cd5LZJU04Aq",
			["inverse"] = false,
			["xOffset"] = -209.17797851563,
			["conditions"] = {
			},
			["information"] = {
			},
			["actions"] = {
				["start"] = {
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\sonar.ogg",
					["do_sound"] = true,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Shaman-Echoing Shock"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Echoing Shock",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound"] = 568582,
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "320125",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Shaman-Echoing Shock",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "XDi7Yb4BI9q",
			["color"] = {
				0, -- [1]
				0.37647058823529, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Druid-Convoke"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i CONVOKE",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\panther1.ogg",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "323764",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Druid-Convoke",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "SFNrsi(3GRJ",
			["color"] = {
				1, -- [1]
				0.59607843137255, -- [2]
				0.27058823529412, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["COMBUSTION POOL WARNING"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 70,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["remaining_operator"] = "<=",
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "player",
						["remaining"] = "21",
						["debuffType"] = "HELPFUL",
						["type"] = "spell",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["spellName"] = 190319,
						["realSpellName"] = "Combustion",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_genericShowOn"] = true,
						["use_remaining"] = true,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = true,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "CENTER",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_mod_rate"] = true,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 22,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_p_time_precision"] = 1,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = false,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "SAVE",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_shadowYOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_anchorYOffset"] = 20,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_visible"] = true,
					["text_text_format_p_time_precision"] = 1,
					["text_fontSize"] = 23,
					["anchorXOffset"] = 0,
					["text_shadowXOffset"] = 0,
				}, -- [4]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "FIREBLAST",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_shadowYOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_anchorYOffset"] = -20,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_visible"] = true,
					["text_text_format_p_time_precision"] = 1,
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_shadowXOffset"] = 0,
				}, -- [5]
			},
			["height"] = 50,
			["load"] = {
				["use_class"] = true,
				["zoneIds"] = "",
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "8svMfWdGz7F",
			["zoom"] = 0,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["url"] = "https://wago.io/YygmpPoNL/1",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
			["parent"] = "Combustion Group",
			["semver"] = "1.0.0",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 90005,
			["id"] = "COMBUSTION POOL WARNING",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 50,
			["useCooldownModRate"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 0,
			["conditions"] = {
			},
			["cooldown"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
		},
		["Ray of Hope Negative"] = {
			["sparkWidth"] = 10,
			["iconSource"] = 0,
			["xOffset"] = 0,
			["displayText"] = "%p",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/nC7HzcyPz/6",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["keepAspectRatio"] = false,
			["selfPoint"] = "BOTTOM",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_size"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["PRIEST"] = true,
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_spellknown"] = false,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["single"] = 18,
					["multi"] = {
						[18] = true,
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["ratedarena"] = true,
						["arena"] = true,
						["pvp"] = true,
						["none"] = true,
					},
				},
			},
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Solid",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 90200,
			["alpha"] = 1,
			["uid"] = "cdqgZS6RrMU",
			["displayIcon"] = 1445239,
			["outline"] = "OUTLINE",
			["sparkOffsetX"] = 0,
			["wagoID"] = "nC7HzcyPz",
			["parent"] = "Ray of Hope Dynamic Group",
			["customText"] = "function()\n    local net = aura_env.totalHealAbsorb * 1.5 - aura_env.totalDmgAbsorb;\n    -- Use player HP to gauge the limits of the progress bar. \n    -- Seems reasonable for now. Maybe want to stick some multipliers on. \n    local hp = UnitHealth(\"player\")    \n    \n    if WeakAuras.IsOptionsOpen() then\n        aura_env.region:SetDurationInfo(0, hp, true)\n        return\n    end\n    \n    if (net < 0 ) then\n        aura_env.region:SetDurationInfo(-net, hp, true)\n        return\n    else\n        aura_env.region:SetDurationInfo(0, hp, true)   \n        return\n    end    \nend\n\n\n",
			["cooldownSwipe"] = true,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["debuffType"] = "HELPFUL",
						["duration"] = "6",
						["event"] = "Chat Message",
						["unit"] = "player",
						["names"] = {
						},
						["spellIds"] = {
						},
						["custom"] = "function(event, timestamp, eventtype, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellID)\n    if (not aura_env.rayActive and eventtype == \"SPELL_AURA_APPLIED\") then  \n        if (spellID == 197268 and srcGUID == UnitGUID(\"player\")) then                \n            if (aura_env.debugPrint) then\n                print(\"Ray applied\")\n            end\n            \n            aura_env.rayActive = true;\n            \n            -- Reset values if new ray is cast\n            aura_env.totalHealAbsorb = 0;\n            aura_env.totalDmgAbsorb = 0;\n            \n            return true;\n        end\n    end    \nend",
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["custom"] = "function()\n    return true\nend\n\n\n\n\n\n\n\n",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["debuffType"] = "HELPFUL",
						["custom_type"] = "stateupdate",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "6",
						["event"] = "Chat Message",
						["unit"] = "player",
						["names"] = {
						},
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED",
						["custom"] = "function(allstates, event, timestamp, eventtype, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)\n    \n    if (aura_env.rayActive and (eventtype == \"SPELL_ABSORBED\" or eventtype == \"SPELL_HEAL_ABSORBED\")) then\n        local spellID, spellName, spellSchool, aSrcGUID, aSrcName, aSrcFlags, aSrcRaidFlags, aSpellID, aSpellName, aSpellSchool, aSpellAmountAbsorbed = ...\n        -- Ray absorbed heal\n        -- srcName = Player\n        -- dstName = RoH Target\n        -- spellID = RoH spellID\n        -- aSrcName = Absorbed Heal Caster\n        -- aSpellID = Absorbed Heal SpellID\n        -- aSpellAmountAbsorbed = duh;\n        if (eventtype == \"SPELL_HEAL_ABSORBED\") then\n            if (srcGUID == UnitGUID(\"player\") and spellID == 197268) then\n                if (aura_env.debugPrint) then\n                    local str = string.format(\"Ray of Hope absorbed %s's heal, %s, for %d.\", aSrcName, aSpellName, aSpellAmountAbsorbed);\n                    print(str);\n                end\n                \n                aura_env.totalHealAbsorb = aura_env.totalHealAbsorb + aSpellAmountAbsorbed;\n                return true;\n            end            \n        end\n        \n        -- Ray absorbed dmg\n        -- srcName = enemy\n        -- dstName = RoH Target\n        -- spellID = Spell Absorbed spellID\n        -- spellName = Spell Absorbed Name\n        -- aSrcName = Player\n        -- aSpellID = RoH spellID\n        if (eventtype == \"SPELL_ABSORBED\") then\n            if (aSrcGUID == UnitGUID(\"player\") and aSpellID == 197268) then \n                if (aura_env.debugPrint) then\n                    local str = string.format(\"Ray of Hope absorbed %s's damage, %s, for %d.\", srcName, spellName, aSpellAmountAbsorbed);\n                    print(str);\n                end\n                \n                aura_env.totalDmgAbsorb = aura_env.totalDmgAbsorb + aSpellAmountAbsorbed;\n                return true;  \n            end            \n        end\n        \n    end\n    \n    -- Ray expire\n    if (aura_env.rayActive and eventtype == \"SPELL_AURA_REMOVED\") then\n        local spellID = ...\n        if (spellID == 197268 and srcGUID == UnitGUID(\"player\")) then\n            if (aura_env.debugPrint) then\n                print\"Ray removed.\"\n                print(\"RoH heals taken: \", aura_env.totalHealAbsorb)\n                print(\"RoH dmg taken: \", aura_env.totalDmgAbsorb);\n                \n                -- 1.5 represents the 50% modifier to heals into ray\n                local net = aura_env.totalHealAbsorb * 1.5 - aura_env.totalDmgAbsorb;\n                \n                local colorString = \"\"\n                if net > 0 then\n                    colorString = string.format(\"|cff00ff00%d|r\",net)\n                else\n                    colorString = string.format(\"|cffff0000%d|r\",net)\n                end\n                print(\"Net: \", colorString)\n            end\n            \n            aura_env.rayActive = false;\n            \n        end\n    end\n    \nend",
						["spellIds"] = {
						},
						["check"] = "event",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["custom"] = "function()\n    return true\nend\n\n\n\n\n\n\n\n",
					},
				}, -- [2]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(t)\n    return t[1]\nend",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 6,
			["subRegions"] = {
				{
					["type"] = "subforeground",
				}, -- [1]
				{
					["type"] = "subbackground",
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Accidental Presidency",
					["text_shadowXOffset"] = 1,
					["text_shadowYOffset"] = -1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_fontType"] = "OUTLINE",
					["text_text_format_n_format"] = "none",
					["text_fontSize"] = 20,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%c",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowXOffset"] = 1,
					["text_visible"] = false,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
				}, -- [4]
				{
					["tick_blend_mode"] = "ADD",
					["tick_rotation"] = 0,
					["tick_xOffset"] = 0,
					["tick_desaturate"] = false,
					["automatic_length"] = true,
					["tick_thickness"] = 2,
					["type"] = "subtick",
					["use_texture"] = false,
					["tick_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["tick_placement"] = "0",
					["tick_texture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
					["tick_yOffset"] = 0,
					["tick_visible"] = true,
					["tick_length"] = 30,
					["tick_mirror"] = false,
					["tick_placement_mode"] = "AtPercent",
				}, -- [5]
			},
			["height"] = 30,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["source"] = "import",
			["authorOptions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
					["custom"] = "\n\n",
					["do_custom"] = false,
				},
				["init"] = {
					["custom"] = "aura_env.rayActive = false;\naura_env.debugPrint = false;\n\n-- Init values for display\naura_env.totalHealAbsorb = 0;\naura_env.totalDmgAbsorb = 0;",
					["do_custom"] = true,
				},
			},
			["icon"] = false,
			["sparkHeight"] = 30,
			["zoom"] = 0.3,
			["semver"] = "1.0.5",
			["anchorFrameType"] = "SCREEN",
			["justify"] = "LEFT",
			["sparkHidden"] = "NEVER",
			["id"] = "Ray of Hope Negative",
			["config"] = {
			},
			["frameStrata"] = 1,
			["width"] = 100,
			["desc"] = "By Xellis - Blackhand",
			["cooldownTextDisabled"] = false,
			["inverse"] = false,
			["customTextUpdate"] = "event",
			["orientation"] = "HORIZONTAL_INVERSE",
			["conditions"] = {
			},
			["cooldown"] = false,
			["preferToUpdate"] = false,
		},
		["Rogue-Vendetta"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = -57.777770996094,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "22892",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "79140",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["color"] = {
				1, -- [1]
				0.94117647058824, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["automaticWidth"] = "Auto",
			["fixedWidth"] = 200,
			["selfPoint"] = "BOTTOM",
			["displayText_format_p_time_precision"] = 1,
			["shadowYOffset"] = -1,
			["config"] = {
			},
			["semver"] = "1.0.9",
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Rogue-Vendetta",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["displayText_format_1.destName_format"] = "none",
			["uid"] = "GcR160GRqPk",
			["xOffset"] = 1.8965454101563,
			["displayText"] = "%i Vendetta > %1.destName",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Mage-Combustion"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i COMBUSTION",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "6525",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "190319",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Mage-Combustion",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "UWSf6vtflnI",
			["color"] = {
				0, -- [1]
				0.88235294117647, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["DK-Chillstreak"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Chillstreak",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "13167",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "305392",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "DK-Chillstreak",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "NJFp01WQkNM",
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.32549019607843, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Shaman- Doomwinds"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i DOOMWINDS",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "20321",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["do_glow"] = false,
					["sound_kit_id"] = "20321",
					["sound"] = " KitID",
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "335903",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_AURA_APPLIED",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Shaman- Doomwinds",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "QzvpNKa(9ed",
			["color"] = {
				0, -- [1]
				0.32549019607843, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Monk - Dance Proc"] = {
			["iconSource"] = -1,
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["preferToUpdate"] = false,
			["yOffset"] = 16.266479492188,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "325202",
						["duration"] = "3",
						["unit"] = "member",
						["specificUnit"] = "arena3",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["auraspellids"] = {
							"152262", -- [1]
						},
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["subeventPrefix"] = "SPELL",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_AURA_APPLIED",
						["use_sourceFlags2"] = true,
						["names"] = {
						},
						["useExactSpellId"] = true,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 0,
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glow"] = true,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 64,
			["load"] = {
				["use_size"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class_and_spec"] = {
				},
				["use_zoneIds"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldown"] = false,
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["config"] = {
			},
			["useCooldownModRate"] = true,
			["zoom"] = 0,
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Monk - Dance Proc",
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["width"] = 64,
			["frameStrata"] = 1,
			["uid"] = "RxtOjID7l0X",
			["inverse"] = false,
			["xOffset"] = -190,
			["conditions"] = {
			},
			["information"] = {
			},
			["actions"] = {
				["start"] = {
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\sonar.ogg",
					["do_sound"] = true,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Warrior-Warbreaker"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Warbreaker",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["glow_frame_type"] = "FRAMESELECTOR",
					["glow_action"] = "show",
					["glow_color"] = {
						1, -- [1]
						0.050980392156863, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["do_glow"] = false,
					["do_custom"] = false,
					["use_glow_color"] = true,
					["glow_frame"] = "ActionButton3",
					["sound_kit_id"] = "71122",
					["glow_type"] = "buttonOverlay",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["glow_frame_type"] = "FRAMESELECTOR",
					["hide_all_glows"] = true,
					["do_glow"] = false,
					["glow_action"] = "show",
					["glow_frame"] = "ActionButton9",
					["glow_type"] = "Pixel",
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "262161",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = false,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "combatlog",
						["spellId"] = "167105",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["duration"] = "3",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["use_spellId"] = true,
						["subeventPrefix"] = "SPELL",
						["sourceFlags2"] = "Hostile",
						["use_sourceFlags"] = false,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Warrior-Warbreaker",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "nOzNeb0y5k4",
			["color"] = {
				1, -- [1]
				0.64705882352941, -- [2]
				0.54509803921569, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Mage-Radiant Spark on you"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Radiant Spark ON YOU %p",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "3333",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "307443",
						["duration"] = "3",
						["names"] = {
						},
						["use_sourceFlags3"] = false,
						["debuffType"] = "HARMFUL",
						["subeventPrefix"] = "SPELL",
						["type"] = "aura2",
						["use_debuffClass"] = false,
						["useExactSpellId"] = true,
						["use_sourceFlags"] = false,
						["auraspellids"] = {
							"307443", -- [1]
						},
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["unit"] = "player",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_sourceFlags2"] = true,
						["use_sourceName"] = false,
						["subeventSuffix"] = "_CAST_SUCCESS",
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_time_mod_rate"] = true,
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["color"] = {
				0, -- [1]
				0.88235294117647, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["displayText_format_p_time_legacy_floor"] = true,
			["conditions"] = {
			},
			["displayText_format_p_format"] = "timed",
			["selfPoint"] = "BOTTOM",
			["displayText_format_p_time_precision"] = 1,
			["config"] = {
			},
			["xOffset"] = 1.8965454101563,
			["justify"] = "LEFT",
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Mage-Radiant Spark on you",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "eDhsYSd2KGX",
			["yOffset"] = -57.777770996094,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Rogue-Shadowblades"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Shadowblades",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "57014",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "121471",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Rogue-Shadowblades",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "qsv(YPOhLFN",
			["color"] = {
				1, -- [1]
				0.9843137254902, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Hunter-Coordinated Assault"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Coordinated Assault",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "63764",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "266779",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Hunter-Coordinated Assault",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "8KqgNVhp3A2",
			["color"] = {
				0, -- [1]
				1, -- [2]
				0.14117647058824, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Trinket Shackle on YOU"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = -57.777770996094,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound"] = 568582,
					["do_sound"] = false,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_destFlags2"] = false,
						["spellId"] = "323673",
						["names"] = {
						},
						["unit"] = "player",
						["use_debuffClass"] = false,
						["use_sourceName"] = false,
						["destFlags"] = "Mine",
						["use_sourceUnit"] = false,
						["use_sourceFlags"] = true,
						["use_destFlags3"] = false,
						["debuffType"] = "HARMFUL",
						["auraspellids"] = {
							"358259", -- [1]
						},
						["useName"] = false,
						["use_destNpcId"] = false,
						["useExactSpellId"] = true,
						["type"] = "aura2",
						["use_sourceFlags2"] = true,
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["destFlags3"] = "Player",
						["use_destFlags"] = false,
						["use_sourceFlags3"] = false,
						["subeventPrefix"] = "SPELL",
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_time_mod_rate"] = true,
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["displayText_format_s_format"] = "none",
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["displayText"] = "%i %p Shackle on YOU %s",
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["displayText_format_p_time_legacy_floor"] = true,
			["fixedWidth"] = 200,
			["displayText_format_p_format"] = "timed",
			["preferToUpdate"] = false,
			["displayText_format_p_time_precision"] = 1,
			["uid"] = "tVESbcECob9",
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.12156862745098, -- [3]
				1, -- [4]
			},
			["justify"] = "LEFT",
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Trinket Shackle on YOU",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["wordWrap"] = "WordWrap",
			["automaticWidth"] = "Auto",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["shadowYOffset"] = -1,
		},
		["Mage - Deathborne UP"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Deathborne",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "3333",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "324220",
						["duration"] = "3",
						["names"] = {
						},
						["use_sourceFlags3"] = false,
						["debuffType"] = "HARMFUL",
						["type"] = "combatlog",
						["subeventPrefix"] = "SPELL",
						["useExactSpellId"] = true,
						["use_sourceFlags"] = false,
						["auraspellids"] = {
							"324220", -- [1]
						},
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["unit"] = "player",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_sourceFlags2"] = true,
						["use_sourceName"] = false,
						["subeventSuffix"] = "_CAST_SUCCESS",
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Mage - Deathborne UP",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "oJ)0hZkKZoL",
			["color"] = {
				0, -- [1]
				0.88235294117647, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["COMBUSTION ACTIVE"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 70,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["useExactSpellId"] = true,
						["event"] = "Health",
						["unit"] = "player",
						["auraspellids"] = {
							"190319", -- [1]
						},
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["remOperator"] = "==",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "CENTER",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_mod_rate"] = true,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 22,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_p_time_precision"] = 1,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 50,
			["load"] = {
				["use_class"] = true,
				["zoneIds"] = "",
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "Oru0TMJ1CFp",
			["zoom"] = 0,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["url"] = "https://wago.io/YygmpPoNL/1",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
			["parent"] = "Combustion Group",
			["semver"] = "1.0.0",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 90005,
			["id"] = "COMBUSTION ACTIVE",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 50,
			["useCooldownModRate"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 0,
			["conditions"] = {
			},
			["cooldown"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
		},
		["Soul of the forest"] = {
			["user_y"] = 0,
			["user_x"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 119.95745849609,
			["foregroundColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturateBackground"] = false,
			["sameTexture"] = true,
			["url"] = "https://wago.io/L_Skl6u1K/1",
			["desaturateForeground"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"Soul of the Forest", -- [1]
						},
						["event"] = "Health",
						["unit"] = "player",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["endAngle"] = 360,
			["internalVersion"] = 53,
			["alpha"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["slanted"] = false,
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 138.28469848633,
			["crop_x"] = 0.41,
			["crop_y"] = 0.41,
			["startAngle"] = 0,
			["useAdjustededMax"] = false,
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["source"] = "import",
			["foregroundTexture"] = "460831",
			["xOffset"] = -1.6062622070313,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["mirror"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "progresstexture",
			["uid"] = "TWOlLA2Emrl",
			["blendMode"] = "BLEND",
			["backgroundColor"] = {
				0.5, -- [1]
				0.5, -- [2]
				0.5, -- [3]
				0.5, -- [4]
			},
			["width"] = 192.84080505371,
			["slantMode"] = "INSIDE",
			["anchorPoint"] = "CENTER",
			["smoothProgress"] = true,
			["tocversion"] = 90002,
			["semver"] = "1.0.0",
			["compress"] = false,
			["id"] = "Soul of the forest",
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["backgroundTexture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["config"] = {
			},
			["inverse"] = false,
			["fontSize"] = 12,
			["orientation"] = "VERTICAL",
			["conditions"] = {
			},
			["information"] = {
			},
			["backgroundOffset"] = 2,
		},
		["Sepsis"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "gOdDlVEcr",
			["authorOptions"] = {
			},
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = 266.0225219726563,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["displayText_format_1.destName_format"] = "none",
			["url"] = "https://wago.io/gOdDlVEcr/2",
			["actions"] = {
				["start"] = {
					["glow_frame_type"] = "FRAMESELECTOR",
					["glow_frame"] = "CompactRaidFrame1",
					["sound"] = " KitID",
					["do_sound"] = true,
					["sound_kit_id"] = "22892",
					["do_glow"] = false,
					["do_custom"] = false,
					["glow_action"] = "show",
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "328305",
						["duration"] = "2.5",
						["unit"] = "player",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["use_sourceName"] = false,
						["subeventSuffix"] = "_CAST_SUCCESS",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["use_sourceFlags2"] = true,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_spellId"] = false,
						["use_sourceFlags3"] = false,
						["spellName"] = "Sepsis",
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["selfPoint"] = "BOTTOM",
			["font"] = "Friz Quadrata TT",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["pvp"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 43,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["customTextUpdate"] = "event",
			["regionType"] = "text",
			["preferToUpdate"] = false,
			["xOffset"] = 13.09674072265625,
			["fixedWidth"] = 200,
			["displayText_format_p_time_precision"] = 1,
			["displayText"] = "%i Sepsis > %1.destName",
			["color"] = {
				1, -- [1]
				0.94117647058824, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Sepsis",
			["shadowYOffset"] = -1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["wordWrap"] = "WordWrap",
			["uid"] = "uXuXswoV58G",
			["semver"] = "1.0.1",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["automaticWidth"] = "Auto",
		},
		["Hunter-Trap"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i TRAP",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "71316",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "187650",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Hunter-Trap",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "MdBEx6eJDv5",
			["color"] = {
				0, -- [1]
				1, -- [2]
				0.14117647058824, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Hunter-Trueshot"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Trueshot Aura",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "63764",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "288613",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Hunter-Trueshot",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "Zdp9ynFV4tQ",
			["color"] = {
				0, -- [1]
				1, -- [2]
				0.14117647058824, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Healer Drinking "] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["preferToUpdate"] = false,
			["yOffset"] = -60,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["do_loop"] = false,
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\hic3.ogg",
					["do_sound"] = true,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["auraspellids"] = {
							"314646", -- [1]
							"167152", -- [2]
							"232419", -- [3]
						},
						["spellIds"] = {
						},
						["specificUnit"] = "party1",
						["unit"] = "member",
						["names"] = {
						},
						["useExactSpellId"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auraspellids"] = {
							"314646", -- [1]
							"167152", -- [2]
							"232419", -- [3]
						},
						["debuffType"] = "HELPFUL",
						["useExactSpellId"] = true,
						["specificUnit"] = "party2",
						["unit"] = "member",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auraspellids"] = {
							"314646", -- [1]
							"167152", -- [2]
							"232419", -- [3]
						},
						["debuffType"] = "HELPFUL",
						["useExactSpellId"] = true,
						["specificUnit"] = "party3",
						["unit"] = "member",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 53,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.25882352941176, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["width"] = 158,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_fontType"] = "None",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [4]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "ACShine",
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glow"] = true,
					["glow_anchor"] = "bar",
					["glowLength"] = 10,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [5]
			},
			["height"] = 26,
			["load"] = {
				["use_size"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class_and_spec"] = {
				},
				["use_zoneIds"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["source"] = "import",
			["icon"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["xOffset"] = -5.4586791992188,
			["sparkOffsetX"] = 0,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["uid"] = "moNetwjGpqF",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["sparkHidden"] = "NEVER",
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["alpha"] = 1,
			["zoom"] = 0,
			["spark"] = false,
			["tocversion"] = 90200,
			["id"] = "Healer Drinking ",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["config"] = {
			},
			["inverse"] = true,
			["authorOptions"] = {
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
			},
			["sparkOffsetY"] = 0,
		},
		["Warlock - Decimating Cast Start"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Interrupt Decimating",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "114212",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "325289",
						["duration"] = "2",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Warlock - Decimating Cast Start",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "tfzb)N4CucM",
			["color"] = {
				0.57647058823529, -- [1]
				0, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["PVP Totem Nameplate Icon"] = {
			["iconSource"] = -1,
			["wagoID"] = "aQP1iMjEQ",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["customText"] = "function()\n    if aura_env.state and aura_env.state.unit then\n        local region = aura_env.region\n        local plate = C_NamePlate.GetNamePlateForUnit(aura_env.state.unit)\n        \n        if plate then \n            region:ClearAllPoints()\n            region:SetPoint(\"BOTTOM\", plate, \"TOP\", 0, -10)\n            region:SetScale(aura_env.state.scale)\n            region:SetAlpha(aura_env.state.alpha)\n            region:Show()\n        else\n            region:Hide()\n        end\n    end\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["customTextUpdate"] = "event",
			["cooldownEdge"] = true,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["custom_hide"] = "timed",
						["type"] = "custom",
						["customVariables"] = "{\n    expirationTime = true,\n}",
						["custom_type"] = "stateupdate",
						["unit"] = "player",
						["duration"] = "1",
						["event"] = "Chat Message",
						["subeventPrefix"] = "SPELL",
						["unevent"] = "timed",
						["custom"] = "function(allstates, event, unit)\n    if event == \"NAME_PLATE_UNIT_ADDED\" then\n        if UnitExists(unit) and string.match(unit, \"nameplate\") then\n            for _, state in pairs(allstates) do\n                if UnitIsUnit(state.unit, unit) then\n                    state.changed = true\n                    state.show = false\n                end\n            end\n            \n            -- for i = 0, 9 do\n            local tinfo = aura_env.totems[UnitName(unit)]\n            if tinfo and UnitCanAttack(unit, \"player\") then\n                \n                local icon, duration, expirationTime, scale = 0 \n                \n                icon = tinfo[1]\n                duration = tinfo[2]\n                expirationTime = GetTime() + duration\n                scale = tinfo[3]\n                \n                allstates[unit] = {\n                    changed = false,\n                    show = true,\n                    icon = icon,\n                    progressType = \"timed\",\n                    duration = duration,\n                    expirationTime = expirationTime,\n                    unit = unit,\n                    autoHide = true,\n                    scale = scale[1],\n                    alpha = scale[2],\n                }\n            end\n        end\n    end\n    \n    if event == \"NAME_PLATE_UNIT_REMOVED\" then\n        for _, state in pairs(allstates) do\n            if state.unit == unit then\n                state.show = false\n                state.changed = true\n            end\n        end\n    end\n    \n    return true\nend",
						["spellIds"] = {
						},
						["events"] = "NAME_PLATE_UNIT_ADDED, NAME_PLATE_UNIT_REMOVED",
						["check"] = "event",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["stickyDuration"] = false,
			["version"] = 6,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%c",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_c_format"] = "none",
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["anchorYOffset"] = 0,
					["text_fontSize"] = 18,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [2]
			},
			["height"] = 32,
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["width"] = 32,
			["desaturate"] = false,
			["selfPoint"] = "CENTER",
			["xOffset"] = -300,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["regionType"] = "icon",
			["displayIcon"] = 136039,
			["authorOptions"] = {
			},
			["actions"] = {
				["start"] = {
					["do_message"] = false,
					["do_sound"] = false,
				},
				["init"] = {
					["custom"] = "aura_env.totems = {\n    -- Shaman\n    [GetSpellInfo(204336)] = { 136039, 3,  { 1, 1 } },\n    [GetSpellInfo(8143)]   = { 136108, 10, { 1, 1 } },\n    [GetSpellInfo(192058)] = { 136013, 2, { 1, 1 } },\n    [GetSpellInfo(98008)] = { 237586, 6, { 1, 1 } },\n    [GetSpellInfo(204331)] = { 511726, 15, { 1, 1 } },\n    [GetSpellInfo(2484)] = { 136102, 20, { 1, 1 } },\n    [GetSpellInfo(204330)] = { 135829, 15, { 1, 1 } },\n    [GetSpellInfo(51485)] = { 136100, 20, { 1, 1 } },\n    [GetSpellInfo(355580)] = { 1020304, 6, { 1, 1 } },\n    [GetSpellInfo(108280)] = { 538569, 12, { 1, 1 } },\n    [GetSpellInfo(324386)] = { 3565451, 30, { 1, 1 } },\n    [GetSpellInfo(207399)] = { 136080, 30, { 1, 1 } },\n    \n    -- Warlock\n    [GetSpellInfo(353601)] = { 1718002, 15, { 1, 1 } },\n    \n}",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["config"] = {
			},
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 90205,
			["id"] = "PVP Totem Nameplate Icon",
			["semver"] = "1.0.5",
			["frameStrata"] = 2,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["uid"] = "oH0pxpktwhz",
			["inverse"] = false,
			["url"] = "https://wago.io/aQP1iMjEQ/6",
			["conditions"] = {
			},
			["cooldown"] = true,
			["desc"] = "Adds the totem icon above the enemy's totem nameplate. These totems are supported:\n\n- Grounding Totem\n- Tremor Totem\n- Capacitor Totem\n- Healing Tide Totem\n- Spirit Link Totem\n- Counterstrike Totem\n- Skyfury Totem\n- Static Field Totem\n- Earthbind Totem\n- Earthgrab Totem",
		},
		["Monk-Weapons of Ord"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Weapons of Order",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "26877",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "310454",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Monk-Weapons of Ord",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "(89zm(85ru)",
			["color"] = {
				0.56862745098039, -- [1]
				1, -- [2]
				0.66274509803922, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Warlock - Death Bolt"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i DEATH BOLT INCOMING",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "115332",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "264106",
						["duration"] = "1.5",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Warlock - Death Bolt",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "TR4zCwovylB",
			["color"] = {
				0.57647058823529, -- [1]
				0, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Hunt "] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["preferToUpdate"] = false,
			["yOffset"] = -96,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "50161",
					["do_loop"] = false,
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "323639",
						["subeventPrefix"] = "SPELL",
						["specificUnit"] = "arena1",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["auraspellids"] = {
							"320224", -- [1]
						},
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["unit"] = "member",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_sourceFlags2"] = true,
						["names"] = {
						},
						["useExactSpellId"] = true,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 53,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.027450980392157, -- [1]
				0, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["width"] = 303.34854125977,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_fontType"] = "None",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [4]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "ACShine",
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glow"] = true,
					["glow_anchor"] = "bar",
					["glowLength"] = 10,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [5]
			},
			["height"] = 51.029766082764,
			["load"] = {
				["use_size"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class_and_spec"] = {
				},
				["use_zoneIds"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["source"] = "import",
			["icon"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["xOffset"] = -2.4586791992188,
			["sparkOffsetX"] = 0,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["uid"] = "kEnWasvHABU",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["sparkHidden"] = "NEVER",
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["alpha"] = 1,
			["zoom"] = 0,
			["spark"] = false,
			["tocversion"] = 90200,
			["id"] = "Hunt ",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["config"] = {
			},
			["inverse"] = true,
			["authorOptions"] = {
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
			},
			["sparkOffsetY"] = 0,
		},
		["Trinket-Shackle"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["authorOptions"] = {
			},
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = -57.777770996094,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "75375",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "356567",
						["duration"] = "2",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["selfPoint"] = "BOTTOM",
			["displayText_format_1.destGUID_format"] = "none",
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["automaticWidth"] = "Auto",
			["regionType"] = "text",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["wordWrap"] = "WordWrap",
			["fixedWidth"] = 200,
			["displayText_format_p_time_precision"] = 1,
			["shadowYOffset"] = -1,
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.12156862745098, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Trinket-Shackle",
			["justify"] = "LEFT",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 1.8965454101563,
			["uid"] = "fraGO2Iq1am",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i INCOMING SHACKLE %1.destGUID",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Priest-Transfusion"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = -57.777770996094,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "84484",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_destFlags2"] = true,
						["spellId"] = "325203",
						["duration"] = "3",
						["names"] = {
						},
						["destFlags2"] = "Friendly",
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_AURA_APPLIED",
						["unit"] = "player",
						["use_sourceName"] = false,
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["use_sourceFlags2"] = false,
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_destFlags"] = false,
						["use_sourceFlags"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["color"] = {
				0.93333333333333, -- [1]
				0.97254901960784, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["automaticWidth"] = "Auto",
			["fixedWidth"] = 200,
			["selfPoint"] = "BOTTOM",
			["displayText_format_p_time_precision"] = 1,
			["shadowYOffset"] = -1,
			["config"] = {
			},
			["semver"] = "1.0.9",
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Priest-Transfusion",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["displayText_format_1.destName_format"] = "none",
			["uid"] = "IJvEt3RVASJ",
			["xOffset"] = 1.8965454101563,
			["displayText"] = "%i Unholy Transfusion on %1.destName",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Priest-Mind Games"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i %p Mind games on YOU",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound"] = 568582,
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_destFlags2"] = false,
						["spellId"] = "323673",
						["names"] = {
						},
						["unit"] = "player",
						["use_debuffClass"] = false,
						["use_sourceName"] = false,
						["destFlags"] = "Mine",
						["use_sourceUnit"] = false,
						["use_sourceFlags"] = true,
						["use_destFlags3"] = false,
						["debuffType"] = "HARMFUL",
						["auraspellids"] = {
							"323673", -- [1]
						},
						["useName"] = false,
						["use_destNpcId"] = false,
						["useExactSpellId"] = true,
						["type"] = "aura2",
						["use_sourceFlags2"] = true,
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["destFlags3"] = "Player",
						["use_destFlags"] = false,
						["use_sourceFlags3"] = false,
						["subeventPrefix"] = "SPELL",
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_time_mod_rate"] = true,
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["color"] = {
				0.96470588235294, -- [1]
				1, -- [2]
				0.98039215686275, -- [3]
				1, -- [4]
			},
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["displayText_format_p_time_legacy_floor"] = true,
			["conditions"] = {
			},
			["displayText_format_p_format"] = "timed",
			["selfPoint"] = "BOTTOM",
			["displayText_format_p_time_precision"] = 1,
			["config"] = {
			},
			["xOffset"] = 1.8965454101563,
			["justify"] = "LEFT",
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Priest-Mind Games",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "eEU7Zzq0oUd",
			["yOffset"] = -57.777770996094,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Phial of Serenity"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 128.9999389648438,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/KQsMfbEoA/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["itemName"] = 177278,
						["use_count"] = true,
						["use_absorbMode"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["unevent"] = "auto",
						["use_itemName"] = true,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["count"] = "1",
						["spellIds"] = {
						},
						["names"] = {
						},
						["duration"] = "1",
						["event"] = "Item Count",
						["use_unit"] = true,
						["count_operator"] = "<=",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						0.83921568627451, -- [1]
						0.88627450980392, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glowScale"] = 1,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "Yoo-hoo!",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Expressway",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_anchorYOffset"] = 40,
					["text_fontSize"] = 17,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 0,
				}, -- [4]
			},
			["height"] = 258,
			["load"] = {
				["covenant"] = {
					["single"] = 1,
				},
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["use_covenant"] = true,
			},
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "149428",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["init"] = {
				},
				["finish"] = {
					["sound_kit_id"] = "149422",
					["sound"] = " KitID",
					["do_message"] = false,
					["do_sound"] = true,
				},
			},
			["regionType"] = "icon",
			["xOffset"] = 0.57208251953125,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
			},
			["displayIcon"] = 3586266,
			["uid"] = "3NKBzqniIxO",
			["frameStrata"] = 1,
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Phial of Serenity",
			["width"] = 258,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["preset"] = "fade",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["preset"] = "pulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["preset"] = "fade",
					["duration_type"] = "seconds",
				},
			},
			["conditions"] = {
			},
			["cooldown"] = false,
			["cooldownEdge"] = false,
		},
		["Warlock - Dark Soul"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Dark Soul",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "114211",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "113858",
						["duration"] = "2.5",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_destFlags2"] = false,
						["spellId"] = "113860",
						["duration"] = "2.5",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["destFlags"] = "NotInGroup",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["use_destFlags"] = false,
						["unit"] = "player",
						["use_sourceFlags2"] = true,
						["destFlags2"] = "Hostile",
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Warlock - Dark Soul",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "OSn3YlcQmhv",
			["color"] = {
				0.57647058823529, -- [1]
				0, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Paladin - Summer"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "120125",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "328620",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "SPELL",
						["sourceFlags"] = "NotInGroup",
						["duration"] = "3",
						["use_sourceFlags"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["spellName"] = 0,
						["use_sourceName"] = false,
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = false,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_sourceFlags3"] = false,
						["names"] = {
						},
						["use_track"] = true,
						["use_auraType"] = false,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["displayText_format_1.sourceUnit_format"] = "none",
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["xOffset"] = 1.8965454101563,
			["regionType"] = "text",
			["selfPoint"] = "BOTTOM",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["fixedWidth"] = 200,
			["displayText_format_p_time_precision"] = 1,
			["yOffset"] = -57.777770996094,
			["wordWrap"] = "WordWrap",
			["config"] = {
			},
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Paladin - Summer",
			["justify"] = "LEFT",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["uid"] = "QIj7RAxIfb5",
			["color"] = {
				1, -- [1]
				0.49019607843137, -- [2]
				0.90196078431373, -- [3]
				1, -- [4]
			},
			["displayText"] = "%i Blessing of Summer",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["DK-Abom Limb"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Abomination Limb",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "15108",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "315443",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "DK-Abom Limb",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "3JAfpw7tYL)",
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.26274509803922, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["COMBUSTION COOLDOWN"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 70,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["remaining_operator"] = ">=",
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "player",
						["remaining"] = "21",
						["debuffType"] = "HELPFUL",
						["type"] = "spell",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["spellName"] = 190319,
						["realSpellName"] = "Combustion",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_genericShowOn"] = true,
						["use_remaining"] = true,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"Combustion", -- [1]
						},
						["unit"] = "player",
						["matchesShowOn"] = "showOnMissing",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = true,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "CENTER",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_mod_rate"] = true,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 22,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_p_time_precision"] = 1,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = false,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 50,
			["load"] = {
				["use_class"] = true,
				["zoneIds"] = "",
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "7mXh801nYCM",
			["zoom"] = 0,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["url"] = "https://wago.io/YygmpPoNL/1",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
			["parent"] = "Combustion Group",
			["semver"] = "1.0.0",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 90005,
			["id"] = "COMBUSTION COOLDOWN",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 50,
			["useCooldownModRate"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 0,
			["conditions"] = {
			},
			["cooldown"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
		},
		["Ephemeral Blossom"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = -233.9999084472656,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["auranames"] = {
							"Ephemeral Blossom", -- [1]
						},
						["unit"] = "player",
						["names"] = {
						},
						["useName"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 23,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glow"] = false,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 44,
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "icon",
			["information"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "fade",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "fade",
				},
			},
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["cooldownTextDisabled"] = false,
			["alpha"] = 1,
			["uid"] = ")U6NGmezkvP",
			["id"] = "Ephemeral Blossom",
			["frameStrata"] = 1,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["width"] = 44,
			["config"] = {
			},
			["inverse"] = false,
			["zoom"] = 0,
			["displayIcon"] = 1416160,
			["cooldown"] = false,
			["xOffset"] = -0.00018310546875,
		},
		["Mage-Ice Form"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Ice Form",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "12221",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "198144",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Mage-Ice Form",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "nD01ntXEYOG",
			["color"] = {
				0, -- [1]
				0.86666666666667, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Shaman-Earthern"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i STAND IN EARTHERN",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "102991",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "198838",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = false,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Friendly",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Shaman-Earthern",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "TbSf097DjWn",
			["color"] = {
				0, -- [1]
				1, -- [2]
				0.99607843137255, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Ret - Wings"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "10067",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "31884",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "SPELL",
						["sourceFlags"] = "NotInGroup",
						["duration"] = "3",
						["use_sourceFlags"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["spellName"] = 0,
						["use_sourceName"] = false,
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = false,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_sourceFlags3"] = false,
						["names"] = {
						},
						["use_track"] = true,
						["use_auraType"] = false,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["displayText_format_1.sourceUnit_format"] = "none",
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["xOffset"] = 1.8965454101563,
			["regionType"] = "text",
			["selfPoint"] = "BOTTOM",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["fixedWidth"] = 200,
			["displayText_format_p_time_precision"] = 1,
			["yOffset"] = -57.777770996094,
			["wordWrap"] = "WordWrap",
			["config"] = {
			},
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Ret - Wings",
			["justify"] = "LEFT",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["uid"] = "Il2pmz0dhz1",
			["color"] = {
				1, -- [1]
				0.49019607843137, -- [2]
				0.90196078431373, -- [3]
				1, -- [4]
			},
			["displayText"] = "%i Avenging Wrath",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Shaman-Vesper Totem"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i VESPER",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "2552",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "324386",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Shaman-Vesper Totem",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "45kj(MXKlN9",
			["color"] = {
				0, -- [1]
				0.4156862745098, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Rogue-Flagellation"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Flagellation",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "56209",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "323654",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Rogue-Flagellation",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "lbHfvb1S5Wr",
			["color"] = {
				1, -- [1]
				0.9843137254902, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Trinket Used"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = -57.777770996094,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "85866",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "336126",
						["duration"] = "2.5",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["wordWrap"] = "WordWrap",
			["displayText_format_1.sourceName_format"] = "none",
			["displayText_format_1.destGUID_format"] = "none",
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["automaticWidth"] = "Auto",
			["fixedWidth"] = 200,
			["displayText_format_p_time_precision"] = 1,
			["shadowYOffset"] = -1,
			["xOffset"] = 1.8965454101563,
			["uid"] = "XvQCjTp2W5)",
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Trinket Used",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.12156862745098, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["authorOptions"] = {
			},
			["displayText"] = "%i %1.sourceName trinket",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Warrior-Necro Banner"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Conqueror's Banner",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["glow_frame_type"] = "FRAMESELECTOR",
					["glow_action"] = "show",
					["glow_color"] = {
						1, -- [1]
						0.050980392156863, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["do_glow"] = false,
					["do_custom"] = false,
					["use_glow_color"] = true,
					["glow_frame"] = "ActionButton3",
					["sound_kit_id"] = "114049",
					["glow_type"] = "buttonOverlay",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["glow_frame_type"] = "FRAMESELECTOR",
					["hide_all_glows"] = true,
					["do_glow"] = false,
					["glow_action"] = "show",
					["glow_frame"] = "ActionButton9",
					["glow_type"] = "Pixel",
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "324143",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = false,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_AURA_APPLIED",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Warrior-Necro Banner",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "(hLA)t8ptPB",
			["color"] = {
				1, -- [1]
				0.64705882352941, -- [2]
				0.54509803921569, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Ret - Toll"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Divine Toll",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "34386",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "304971",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "SPELL",
						["sourceFlags"] = "NotInGroup",
						["duration"] = "3",
						["use_sourceFlags"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["spellName"] = 0,
						["use_sourceName"] = false,
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = false,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_sourceFlags3"] = false,
						["names"] = {
						},
						["use_track"] = true,
						["use_auraType"] = false,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Ret - Toll",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "Fe7RmCD1O8b",
			["color"] = {
				0.98823529411765, -- [1]
				0.47843137254902, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Shaman- Ascend"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i ASCENDANCE",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "61366",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "114051",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Shaman- Ascend",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "4NWXyu1xRdL",
			["color"] = {
				0, -- [1]
				0.34117647058824, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Priest-Psyfiend"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = -57.777770996094,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "84484",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "199845",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["color"] = {
				0.93333333333333, -- [1]
				0.97254901960784, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["automaticWidth"] = "Auto",
			["fixedWidth"] = 200,
			["selfPoint"] = "BOTTOM",
			["displayText_format_p_time_precision"] = 1,
			["shadowYOffset"] = -1,
			["config"] = {
			},
			["semver"] = "1.0.9",
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Priest-Psyfiend",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["displayText_format_1.destName_format"] = "none",
			["uid"] = "3BJNIQJdgVX",
			["xOffset"] = 1.8965454101563,
			["displayText"] = "%i Kill Psyfiend",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["COMBUSTION READY"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 70,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["remaining_operator"] = ">=",
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["remaining"] = "21",
						["debuffType"] = "HELPFUL",
						["type"] = "spell",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["spellName"] = 190319,
						["realSpellName"] = "Combustion",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_genericShowOn"] = true,
						["use_remaining"] = false,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "custom",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "CENTER",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_mod_rate"] = true,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 22,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_p_time_precision"] = 1,
				}, -- [2]
			},
			["height"] = 50,
			["load"] = {
				["use_class"] = true,
				["zoneIds"] = "",
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "Int8p64J47C",
			["zoom"] = 0,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["url"] = "https://wago.io/YygmpPoNL/1",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
			["parent"] = "Combustion Group",
			["semver"] = "1.0.0",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 90005,
			["id"] = "COMBUSTION READY",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 50,
			["useCooldownModRate"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 0,
			["conditions"] = {
			},
			["cooldown"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
		},
		["Arcanosphere"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["preferToUpdate"] = false,
			["yOffset"] = -96,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "50161",
					["do_loop"] = false,
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "353128",
						["subeventPrefix"] = "SPELL",
						["specificUnit"] = "arena1",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["auraspellids"] = {
							"320224", -- [1]
						},
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["unit"] = "member",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_sourceFlags2"] = true,
						["names"] = {
						},
						["useExactSpellId"] = true,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 53,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0.66666666666667, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["width"] = 303.34854125977,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_fontType"] = "None",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [4]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "ACShine",
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glow"] = true,
					["glow_anchor"] = "bar",
					["glowLength"] = 10,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [5]
			},
			["height"] = 51.029766082764,
			["load"] = {
				["use_size"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class_and_spec"] = {
				},
				["use_zoneIds"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["source"] = "import",
			["icon"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["xOffset"] = -2.4586791992188,
			["sparkOffsetX"] = 0,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["uid"] = "StZqbpPjVMW",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["sparkHidden"] = "NEVER",
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["alpha"] = 1,
			["zoom"] = 0,
			["spark"] = false,
			["tocversion"] = 90200,
			["id"] = "Arcanosphere",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["config"] = {
			},
			["inverse"] = true,
			["authorOptions"] = {
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
			},
			["sparkOffsetY"] = 0,
		},
		["Priest Res"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["preferToUpdate"] = false,
			["yOffset"] = -60,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["do_loop"] = false,
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\AirHorn.ogg",
					["do_sound"] = true,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["subeventPrefix"] = "SPELL",
						["type"] = "combatlog",
						["spellId"] = "211319",
						["subeventSuffix"] = "_AURA_APPLIED",
						["use_sourceFlags2"] = true,
						["duration"] = "15",
						["event"] = "Combat Log",
						["unit"] = "member",
						["names"] = {
						},
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["specificUnit"] = "arena3",
						["useExactSpellId"] = true,
						["auraspellids"] = {
							"320224", -- [1]
						},
						["sourceFlags2"] = "Hostile",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 53,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.91372549019608, -- [1]
				0.92156862745098, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["width"] = 303.34854125977,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_fontType"] = "None",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [4]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "ACShine",
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glow"] = true,
					["glow_anchor"] = "bar",
					["glowLength"] = 10,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [5]
			},
			["height"] = 51.029766082764,
			["load"] = {
				["use_size"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class_and_spec"] = {
				},
				["use_zoneIds"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["source"] = "import",
			["icon"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["xOffset"] = 17.541320800781,
			["sparkOffsetX"] = 0,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["uid"] = "mrqWdWfGZff",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["sparkHidden"] = "NEVER",
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["alpha"] = 1,
			["zoom"] = 0,
			["spark"] = false,
			["tocversion"] = 90200,
			["id"] = "Priest Res",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["config"] = {
			},
			["inverse"] = true,
			["authorOptions"] = {
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
			},
			["sparkOffsetY"] = 0,
		},
		["Shaman - Grounding Totem "] = {
			["iconSource"] = -1,
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["preferToUpdate"] = false,
			["yOffset"] = 16.266479492188,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "204336",
						["duration"] = "3",
						["unit"] = "member",
						["specificUnit"] = "arena3",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["auraspellids"] = {
							"255016", -- [1]
						},
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["use_spellName"] = false,
						["spellIds"] = {
						},
						["useExactSpellId"] = true,
						["names"] = {
						},
						["use_sourceFlags2"] = true,
						["subeventPrefix"] = "SPELL",
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 0,
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glow"] = true,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 64,
			["load"] = {
				["use_size"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class_and_spec"] = {
				},
				["use_zoneIds"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldown"] = false,
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["config"] = {
			},
			["useCooldownModRate"] = true,
			["zoom"] = 0,
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Shaman - Grounding Totem ",
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["width"] = 64,
			["frameStrata"] = 1,
			["uid"] = "1b482DzNgx7",
			["inverse"] = false,
			["xOffset"] = -140.17797851563,
			["conditions"] = {
			},
			["information"] = {
			},
			["actions"] = {
				["start"] = {
					["sound"] = "Interface\\AddOns\\BigWigs\\Media\\Sounds\\VictoryClassic.ogg",
					["do_sound"] = false,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Mage-Radiant Spark"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Radiant Spark",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "3333",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "307443",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = false,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Mage-Radiant Spark",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "PL)wxBFNPtH",
			["color"] = {
				0, -- [1]
				0.88235294117647, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Shaman-Healing Tide"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Kill Healing Tide",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "2552",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "108280",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Shaman-Healing Tide",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "snhZlazDTDi",
			["color"] = {
				0, -- [1]
				0.4156862745098, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Druid - Feral Frenzy"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = -57.777770996094,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "125220",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "338142",
						["duration"] = "3",
						["unit"] = "player",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["spellName"] = "Feral Frenzy",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["subeventPrefix"] = "SPELL",
						["use_sourceName"] = false,
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["use_sourceFlags2"] = true,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_spellId"] = false,
						["use_sourceFlags3"] = false,
						["names"] = {
						},
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["displayText_format_1.destUnit_format"] = "none",
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["color"] = {
				1, -- [1]
				0.68235294117647, -- [2]
				0.36862745098039, -- [3]
				1, -- [4]
			},
			["regionType"] = "text",
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["wordWrap"] = "WordWrap",
			["fixedWidth"] = 200,
			["selfPoint"] = "BOTTOM",
			["displayText_format_p_time_precision"] = 1,
			["shadowYOffset"] = -1,
			["config"] = {
			},
			["semver"] = "1.0.9",
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Druid - Feral Frenzy",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "DUU7kX2WfHJ",
			["xOffset"] = 1.8965454101563,
			["displayText"] = "%i Feral Frenzy",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Druid-Incarnation"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i INCARN",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "138401",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "102560",
						["duration"] = "2.5",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = false,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["spellId"] = "194223",
						["duration"] = "2.5",
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = false,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["sourceFlags2"] = "Hostile",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = false,
						["use_spellId"] = true,
						["spellName"] = 0,
						["use_genericShowOn"] = true,
						["unit"] = "player",
						["use_track"] = true,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["spellId"] = "106951",
						["duration"] = "2.5",
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "player",
						["use_cloneId"] = false,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["realSpellName"] = 0,
						["use_spellId"] = true,
						["use_spellName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags2"] = true,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["spellName"] = 0,
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["type"] = "combatlog",
						["spellId"] = "102543",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["duration"] = "2.5",
						["event"] = "Combat Log",
						["subeventPrefix"] = "SPELL",
						["use_spellId"] = true,
						["sourceFlags2"] = "Hostile",
						["use_sourceFlags2"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [4]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Druid-Incarnation",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "36pE3qpLhL7",
			["color"] = {
				1, -- [1]
				0.63137254901961, -- [2]
				0.31764705882353, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Warlock - Soul Rot on YOU"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i %p Soul Rot on YOU",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound"] = 568582,
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_destFlags2"] = false,
						["spellId"] = "323673",
						["names"] = {
						},
						["unit"] = "player",
						["use_debuffClass"] = false,
						["use_sourceName"] = false,
						["destFlags"] = "Mine",
						["use_sourceUnit"] = false,
						["use_sourceFlags"] = true,
						["use_destFlags3"] = false,
						["debuffType"] = "HARMFUL",
						["auraspellids"] = {
							"325640", -- [1]
						},
						["useName"] = false,
						["use_destNpcId"] = false,
						["useExactSpellId"] = true,
						["type"] = "aura2",
						["use_sourceFlags2"] = true,
						["event"] = "Combat Log",
						["sourceFlags2"] = "Hostile",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["destFlags3"] = "Player",
						["use_destFlags"] = false,
						["use_sourceFlags3"] = false,
						["subeventPrefix"] = "SPELL",
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_time_mod_rate"] = true,
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["color"] = {
				0.53333333333333, -- [1]
				0, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["displayText_format_p_time_legacy_floor"] = true,
			["conditions"] = {
			},
			["displayText_format_p_format"] = "timed",
			["selfPoint"] = "BOTTOM",
			["displayText_format_p_time_precision"] = 1,
			["config"] = {
			},
			["xOffset"] = 1.8965454101563,
			["justify"] = "LEFT",
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Warlock - Soul Rot on YOU",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "t4SC5Tff8qb",
			["yOffset"] = -57.777770996094,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Details! Boss Mods Group"] = {
			["grow"] = "DOWN",
			["controlledChildren"] = {
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["align"] = "CENTER",
			["stagger"] = 0,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rowSpace"] = 1,
			["animate"] = false,
			["sort"] = "none",
			["scale"] = 1,
			["selfPoint"] = "TOP",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["radius"] = 200,
			["arcLength"] = 360,
			["constantFactor"] = "RADIUS",
			["gridType"] = "RD",
			["borderOffset"] = 4,
			["config"] = {
			},
			["xOffset"] = 0,
			["id"] = "Details! Boss Mods Group",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "NzQBePQcziG",
			["borderInset"] = 1,
			["useLimit"] = false,
			["rotation"] = 0,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["fullCircle"] = true,
		},
		["Mes Arena CDs"] = {
			["arcLength"] = 360,
			["controlledChildren"] = {
				"Rogue-Flagellation", -- [1]
				"Rogue-Shadowblades", -- [2]
				"Rogue-Vendetta", -- [3]
				"Mage-Ice Form", -- [4]
				"Hunter-Double Tap", -- [5]
				"Hunter-Trap", -- [6]
				"Hunter-Coordinated Assault", -- [7]
				"Hunter-Bestial Wrath", -- [8]
				"Hunter-Trueshot", -- [9]
				"Priest-Psyfiend", -- [10]
				"Priest-Transfusion", -- [11]
				"Priest-Mind Games", -- [12]
				"Mage-Combustion", -- [13]
				"Mage-Radiant Spark", -- [14]
				"Mage-Radiant Spark on you", -- [15]
				"Mage - Deathborne UP", -- [16]
				"Druid-Lone Empowerment", -- [17]
				"Druid - Feral Frenzy", -- [18]
				"Druid-Incarnation", -- [19]
				"Druid-Convoke", -- [20]
				"Monk-Serenity/Images", -- [21]
				"Monk-Weapons of Ord", -- [22]
				"Monk-Bonedust", -- [23]
				"Monk - Dance Proc", -- [24]
				"Ret - Wings", -- [25]
				"Paladin - Summer", -- [26]
				"Paladin - Equinox", -- [27]
				"Ret - Toll", -- [28]
				"Ret - Seraphim ", -- [29]
				"Shaman-Echoing Shock", -- [30]
				"Shaman- Doomwinds", -- [31]
				"Shaman- Ascend", -- [32]
				"Shaman-Healing Tide", -- [33]
				"Shaman-Earthern", -- [34]
				"Shaman-Vesper Totem", -- [35]
				"Shaman - Skyfury ", -- [36]
				"Shaman - Grounding Totem ", -- [37]
				"Trinket-Shackle", -- [38]
				"Trinket Used", -- [39]
				"Trinket Shackle on YOU", -- [40]
				"DK-Chillstreak", -- [41]
				"DK-Abom Limb", -- [42]
				"Warrior-Warbreaker", -- [43]
				"Warrior-Necro Banner", -- [44]
				"Warlock - Dark Soul", -- [45]
				"Warlock - Decimating Cast Start", -- [46]
				"Warlock - Soul Rot", -- [47]
				"Warlock - Death Bolt", -- [48]
				"Warlock - Decimating Warning", -- [49]
				"Warlock - Soul Rot on YOU", -- [50]
				"Nightfae Pod ", -- [51]
				"Priest Res", -- [52]
				"Hunt ", -- [53]
				"Arcanosphere", -- [54]
				"Healer Drinking ", -- [55]
				"drinking ", -- [56]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "4bSCZMHz4",
			["xOffset"] = 40.5330810546875,
			["preferToUpdate"] = false,
			["yOffset"] = 464.1409912109375,
			["gridType"] = "RD",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["align"] = "CENTER",
			["stagger"] = 0,
			["borderInset"] = 1,
			["version"] = 10,
			["subRegions"] = {
			},
			["sortHybridTable"] = {
				["Druid-Lone Empowerment"] = false,
				["Paladin - Equinox"] = false,
				["Monk-Weapons of Ord"] = false,
				["Monk-Serenity/Images"] = false,
				["Mage-Radiant Spark"] = false,
				["Shaman-Healing Tide"] = false,
				["Hunt "] = false,
				["Warlock - Soul Rot"] = false,
				["Trinket-Shackle"] = false,
				["Monk-Bonedust"] = false,
				["Priest-Mind Games"] = false,
				["Ret - Seraphim "] = false,
				["Shaman-Echoing Shock"] = false,
				["Warlock - Dark Soul"] = false,
				["drinking "] = false,
				["Druid-Convoke"] = false,
				["Shaman - Skyfury "] = false,
				["Paladin - Summer"] = false,
				["Rogue-Vendetta"] = false,
				["Priest Res"] = false,
				["Warlock - Decimating Warning"] = false,
				["Mage-Combustion"] = false,
				["Shaman-Earthern"] = false,
				["Hunter-Bestial Wrath"] = false,
				["Ret - Wings"] = false,
				["Shaman-Vesper Totem"] = false,
				["Shaman- Doomwinds"] = false,
				["Trinket Used"] = false,
				["Arcanosphere"] = false,
				["Druid - Feral Frenzy"] = false,
				["Monk - Dance Proc"] = false,
				["Warrior-Warbreaker"] = false,
				["Warlock - Soul Rot on YOU"] = false,
				["Mage-Radiant Spark on you"] = false,
				["Rogue-Shadowblades"] = false,
				["Ret - Toll"] = false,
				["Hunter-Coordinated Assault"] = false,
				["Priest-Psyfiend"] = false,
				["Trinket Shackle on YOU"] = false,
				["Mage - Deathborne UP"] = false,
				["Warlock - Death Bolt"] = false,
				["Shaman - Grounding Totem "] = false,
				["Warlock - Decimating Cast Start"] = false,
				["Warrior-Necro Banner"] = false,
				["DK-Abom Limb"] = false,
				["Druid-Incarnation"] = false,
				["DK-Chillstreak"] = false,
				["Hunter-Trap"] = false,
				["Hunter-Trueshot"] = false,
				["Hunter-Double Tap"] = false,
				["Healer Drinking "] = false,
				["Shaman- Ascend"] = false,
				["Rogue-Flagellation"] = false,
				["Nightfae Pod "] = false,
				["Mage-Ice Form"] = false,
				["Priest-Transfusion"] = false,
			},
			["fullCircle"] = true,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["selfPoint"] = "TOP",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["anchorPoint"] = "CENTER",
			["source"] = "import",
			["animate"] = false,
			["scale"] = 1,
			["rotation"] = 0,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["radius"] = 200,
			["config"] = {
			},
			["constantFactor"] = "RADIUS",
			["gridWidth"] = 5,
			["borderOffset"] = 4,
			["semver"] = "1.0.9",
			["tocversion"] = 90200,
			["id"] = "Mes Arena CDs",
			["grow"] = "DOWN",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["uid"] = "oXggSxujXKU",
			["limit"] = 5,
			["rowSpace"] = 1,
			["conditions"] = {
			},
			["information"] = {
			},
			["useLimit"] = false,
		},
		["Hunter-Double Tap"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Double Tap",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "15245",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "260402",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Hunter-Double Tap",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "PPEiy3ajqrn",
			["color"] = {
				0, -- [1]
				1, -- [2]
				0.2078431372549, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Details! Aura Group"] = {
			["grow"] = "DOWN",
			["controlledChildren"] = {
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["align"] = "CENTER",
			["stagger"] = 0,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rowSpace"] = 1,
			["animate"] = false,
			["sort"] = "none",
			["scale"] = 1,
			["selfPoint"] = "TOP",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["radius"] = 200,
			["arcLength"] = 360,
			["constantFactor"] = "RADIUS",
			["gridType"] = "RD",
			["borderOffset"] = 4,
			["config"] = {
			},
			["xOffset"] = 0,
			["id"] = "Details! Aura Group",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "I7Y0mTf5KSP",
			["borderInset"] = 1,
			["useLimit"] = false,
			["rotation"] = 0,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["fullCircle"] = true,
		},
		["Guardian Spirit"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 377.000732421875,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "cooldown",
						["use_sourceRaidFlags"] = false,
						["duration"] = "4",
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "player",
						["remaining_operator"] = ">",
						["remaining"] = "170",
						["use_genericShowOn"] = true,
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["use_destName"] = false,
						["spellName"] = "Guardian Spirit",
						["use_destFlags3"] = false,
						["use_remaining"] = true,
						["destFlags"] = "InGroup",
						["subeventSuffix"] = "_HEAL",
						["type"] = "combatlog",
						["debuffType"] = "HELPFUL",
						["event"] = "Combat Log",
						["use_exact_spellName"] = true,
						["realSpellName"] = 47788,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["use_destFlags"] = false,
						["use_destUnit"] = false,
						["use_track"] = true,
						["sourceFlags"] = "Mine",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glow"] = true,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 64,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "icon",
			["cooldown"] = false,
			["xOffset"] = -0.0001220703125,
			["authorOptions"] = {
			},
			["displayIcon"] = 237542,
			["zoom"] = 0,
			["cooldownTextDisabled"] = false,
			["frameStrata"] = 1,
			["config"] = {
			},
			["id"] = "Guardian Spirit",
			["width"] = 64,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["uid"] = "8A9Zan514XL",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
					["do_loop"] = false,
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Protected.ogg",
					["do_message"] = false,
					["do_sound"] = true,
				},
				["init"] = {
					["do_custom"] = false,
				},
				["finish"] = {
					["do_glow"] = false,
					["do_sound"] = false,
					["stop_sound"] = false,
					["do_custom"] = false,
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Protected.ogg",
					["sound_channel"] = "Master",
				},
			},
			["conditions"] = {
			},
			["information"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "fade",
					["easeStrength"] = 3,
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "fade",
					["easeStrength"] = 3,
				},
			},
		},
		["Druid-Lone Empowerment"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Kyrian",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "125220",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "338142",
						["duration"] = "2.5",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "combatlog",
						["subeventSuffix"] = "_AURA_APPLIED",
						["duration"] = "2.5",
						["event"] = "Combat Log",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = "Kindred Empowerment",
						["unit"] = "player",
						["destFlags2"] = "Hostile",
						["use_destFlags2"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Druid-Lone Empowerment",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "jU)3AGSgvFl",
			["color"] = {
				1, -- [1]
				0.68235294117647, -- [2]
				0.36862745098039, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Nightfae Pod "] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["preferToUpdate"] = false,
			["yOffset"] = -60,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["actions"] = {
				["start"] = {
					["do_loop"] = false,
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\AirHorn.ogg",
					["do_sound"] = true,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["auraspellids"] = {
							"320224", -- [1]
						},
						["spellIds"] = {
						},
						["specificUnit"] = "arena1",
						["unit"] = "member",
						["names"] = {
						},
						["useExactSpellId"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auraspellids"] = {
							"320224", -- [1]
						},
						["debuffType"] = "HELPFUL",
						["useExactSpellId"] = true,
						["specificUnit"] = "arena2",
						["unit"] = "member",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auraspellids"] = {
							"320224", -- [1]
						},
						["debuffType"] = "HELPFUL",
						["useExactSpellId"] = true,
						["specificUnit"] = "arena3",
						["unit"] = "member",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 53,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.027450980392157, -- [1]
				0, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["width"] = 303.34854125977,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_fontType"] = "None",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [4]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "ACShine",
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowScale"] = 1,
					["glow"] = true,
					["glow_anchor"] = "bar",
					["glowLength"] = 10,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [5]
			},
			["height"] = 51.029766082764,
			["load"] = {
				["use_size"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class_and_spec"] = {
				},
				["use_zoneIds"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["source"] = "import",
			["icon"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["xOffset"] = 17.541320800781,
			["sparkOffsetX"] = 0,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["uid"] = "RauhDGIclD2",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["sparkHidden"] = "NEVER",
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["alpha"] = 1,
			["zoom"] = 0,
			["spark"] = false,
			["tocversion"] = 90200,
			["id"] = "Nightfae Pod ",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["config"] = {
			},
			["inverse"] = true,
			["authorOptions"] = {
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
			},
			["sparkOffsetY"] = 0,
		},
		["Hunter-Bestial Wrath"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "4bSCZMHz4",
			["parent"] = "Mes Arena CDs",
			["displayText"] = "%i Bestial Wrath",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
					["sound_kit_id"] = "63764",
					["sound"] = " KitID",
					["do_sound"] = true,
				},
				["finish"] = {
					["sound"] = 568975,
					["do_sound"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "19574",
						["duration"] = "3",
						["subeventPrefix"] = "SPELL",
						["use_sourceFlags"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["unit"] = "player",
						["event"] = "Combat Log",
						["use_sourceFlags2"] = true,
						["sourceFlags2"] = "Hostile",
						["use_spellId"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = false,
						["names"] = {
						},
						["use_sourceName"] = false,
						["use_sourceFlags3"] = false,
						["sourceFlags"] = "NotInGroup",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = false,
				["use_zoneIds"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "arena",
					["multi"] = {
						["ratedpvp"] = true,
						["arena"] = true,
						["ratedarena"] = true,
					},
				},
			},
			["fontSize"] = 28,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["yOffset"] = -57.777770996094,
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["xOffset"] = 1.8965454101563,
			["config"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 90200,
			["id"] = "Hunter-Bestial Wrath",
			["semver"] = "1.0.9",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/4bSCZMHz4/10",
			["uid"] = "UUB(uwnMBYU",
			["color"] = {
				0, -- [1]
				1, -- [2]
				0.14117647058824, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["preferToUpdate"] = false,
		},
		["Ray of Hope Dynamic Group"] = {
			["grow"] = "HORIZONTAL",
			["controlledChildren"] = {
				"Ray of Hope Negative", -- [1]
				"Ray of Hope Positive", -- [2]
			},
			["borderBackdrop"] = "Solid",
			["wagoID"] = "nC7HzcyPz",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -200.9997863769531,
			["anchorPoint"] = "CENTER",
			["fullCircle"] = true,
			["space"] = 0,
			["url"] = "https://wago.io/nC7HzcyPz/6",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 53,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["align"] = "CENTER",
			["stagger"] = 0,
			["borderInset"] = 1,
			["version"] = 6,
			["subRegions"] = {
			},
			["rotation"] = 0,
			["selfPoint"] = "CENTER",
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["rowSpace"] = 1,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["sortHybridTable"] = {
				["Ray of Hope Positive"] = false,
				["Ray of Hope Negative"] = false,
			},
			["source"] = "import",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["scale"] = 1,
			["animate"] = false,
			["border"] = true,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["gridType"] = "RD",
			["config"] = {
			},
			["constantFactor"] = "RADIUS",
			["gridWidth"] = 5,
			["borderOffset"] = 2,
			["semver"] = "1.0.5",
			["tocversion"] = 90200,
			["id"] = "Ray of Hope Dynamic Group",
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["sort"] = "none",
			["uid"] = "SmCzEdfhN2y",
			["radius"] = 200,
			["useLimit"] = false,
			["conditions"] = {
			},
			["information"] = {
			},
			["arcLength"] = 360,
		},
	},
	["lastArchiveClear"] = 1609033022,
	["minimap"] = {
		["hide"] = true,
	},
	["lastUpgrade"] = 1654553709,
	["dbVersion"] = 53,
	["login_squelch_time"] = 10,
	["registered"] = {
	},
	["frame"] = {
		["xOffset"] = -27.00048828125,
		["yOffset"] = -201.4961547851563,
		["height"] = 665.0001220703125,
		["width"] = 830.0001831054688,
	},
	["editor_theme"] = "Monokai",
}
