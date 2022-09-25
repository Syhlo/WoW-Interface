local _, S = ...

Sorted_defaultCategories = nil

if Sorted_IsClassic() then
    Sorted_defaultCategories = {
        {
            ["icon"] = "inv_sword_04",
            ["name"] = "Weapons",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [16] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        {
                            ["values"] = {
                                [2] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                },
                            },
                        }, -- [2]
                        {
                            ["values"] = {
                                [14] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    nil, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                    true, -- [12]
                                    true, -- [13]
                                    true, -- [14]
                                    true, -- [15]
                                },
                            },
                        }, -- [3]
                    },
                }, -- [1]
            },
        }, -- [1]
        {
            ["icon"] = "inv_chest_plate14",
            ["name"] = "Armor",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    true, -- [1]
                                }, -- [1]
                            },
                        }, -- [1]
                        {
                            ["values"] = {
                                {
                                    true, -- [1]
                                    [11] = true,
                                    [8] = true,
                                    [3] = true,
                                    [12] = true,
                                    [9] = true,
                                    [5] = true,
                                    [10] = true,
                                }, -- [1]
                            },
                        }, -- [2]
                        {
                            ["values"] = {
                                {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                }, -- [1]
                            },
                        }, -- [3]
                    },
                }, -- [1]
            },
        }, -- [2]
        {
            ["icon"] = "INV_Crown_02",
            ["name"] = "Accessories",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    true, -- [1]
                                }, -- [1]
                            },
                        }, -- [1]
                        {
                            ["values"] = {
                                {
                                    [6] = true,
                                    [2] = true,
                                    [15] = true,
                                    [7] = true,
                                    [14] = true,
                                    [4] = true,
                                    [16] = true,
                                    [13] = true,
                                }, -- [1]
                            },
                        }, -- [2]
                        {
                            ["values"] = {
                                {
                                    [6] = true,
                                    [7] = true,
                                    [8] = true,
                                    [10] = true,
                                    [9] = true,
                                    [11] = true,
                                }, -- [1]
                            },
                        }, -- [3]
                    },
                }, -- [1]
            },
        }, -- [3]
        {
            ["icon"] = "inv_misc_bag_06",
            ["name"] = "Containers",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [4] = true,
                                    [14] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [4] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    nil, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                },
                                [12] = {
                                    true, -- [1]
                                    true, -- [2]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
        }, -- [4]
        {
            ["icon"] = "Spell_Nature_MoonKey",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [8] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [8] = {
                                    true, -- [1]
                                    true, -- [2]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = "Keys",
        }, -- [5]
        {
            ["icon"] = "INV_Misc_ArmorKit_03",
            ["name"] = "Item Enhancements",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [7] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [7] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                    true, -- [12]
                                    true, -- [13]
                                    true, -- [14]
                                    true, -- [15]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
        }, -- [6]
        {
            ["icon"] = "inv_misc_food_38",
            ["name"] = "Consumables",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [3] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [3] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    nil, -- [7]
                                    true, -- [8]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
        }, -- [7]
        {
            ["icon"] = "trade_blacksmithing",
            ["name"] = "Trade Goods",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [15] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [13] = {
                                    true, -- [1]
                                    nil, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    nil, -- [10]
                                    true, -- [11]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
        }, -- [8]
        {
            ["icon"] = "inv_scroll_05",
            ["name"] = "Recipes",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [11] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [10] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
        }, -- [9]
        {
            ["icon"] = "INV_Misc_Note_06",
            ["name"] = "Quest Items",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [13] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                    },
                }, -- [1]
            },
        }, -- [10]
        {
            ["icon"] = "inv_misc_gear_08",
            ["name"] = "Miscellaneous",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [9] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [9] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
        }, -- [11]
    }
else
    Sorted_defaultCategories = {
        {
            ["icon"] = "achievement_legionpvptier1",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [16] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        {
                            ["values"] = {
                                [2] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                },
                            },
                        }, -- [2]
                        {
                            ["values"] = {
                                [14] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                    true, -- [12]
                                    nil, -- [13]
                                    true, -- [14]
                                    true, -- [15]
                                },
                            },
                        }, -- [3]
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_WEAPONS"),
        }, -- [1]
        {
            ["icon"] = "achievement_legionpvp2tier1",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    true, -- [1]
                                }, -- [1]
                            },
                        }, -- [1]
                        {
                            ["values"] = {
                                {
                                    true, -- [1]
                                    [11] = true,
                                    [8] = true,
                                    [3] = true,
                                    [12] = true,
                                    [10] = true,
                                    [9] = true,
                                    [5] = true,
                                }, -- [1]
                            },
                        }, -- [2]
                        {
                            ["values"] = {
                                {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                }, -- [1]
                            },
                        }, -- [3]
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_ARMOR"),
        }, -- [2]
        {
            ["icon"] = "achievement_legionpvp7tier2",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    true, -- [1]
                                }, -- [1]
                            },
                        }, -- [1]
                        {
                            ["values"] = {
                                {
                                    [6] = true,
                                    [2] = true,
                                    [15] = true,
                                    [13] = true,
                                    [14] = true,
                                    [4] = true,
                                    [7] = true,
                                }, -- [1]
                            },
                        }, -- [2]
                        {
                            ["values"] = {
                                {
                                    [6] = true,
                                    [7] = true,
                                }, -- [1]
                            },
                        }, -- [3]
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_ACCESSORIES"),
        }, -- [3]
        {
            ["icon"] = "inv_misc_bag_06",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [4] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [4] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_CONTAINERS"),
        }, -- [4]
        {
            ["icon"] = "achievement_legionpvp8tier2",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [5] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [5] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                    true, -- [12]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_GEMS"),
        }, -- [5]
        {
            ["icon"] = "garrison_bluearmorupgrade",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [7] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [7] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                    true, -- [12]
                                    true, -- [13]
                                    true, -- [14]
                                    true, -- [15]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_ITEM_ENHANCEMENTS"),
        }, -- [6]
        {
            ["icon"] = "inv_misc_food_38",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [3] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [3] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_CONSUMABLES"),
        }, -- [7]
        {
            ["icon"] = "inv_inscription_minorglyph01",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [6] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [6] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                    true, -- [12]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_GLYPHS"),
        }, -- [8]
        {
            ["icon"] = "trade_blacksmithing",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [15] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [13] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_TRADE_GOODS"),
        }, -- [9]
        {
            ["icon"] = "inv_misc_scrollunrolled04b",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [11] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [10] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                    true, -- [11]
                                    true, -- [12]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_RECIPES"),
        }, -- [10]
        {
            ["icon"] = "inv_box_petcarrier_01",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [2] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [2] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                    true, -- [8]
                                    true, -- [9]
                                    true, -- [10]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_BATTLE_PETS"),
        }, -- [11]
        {
            ["icon"] = "achievement_quests_completed_daily_04",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [13] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_QUEST_ITEMS"),
        }, -- [12]
        {
            ["icon"] = "inv_misc_gear_08",
            ["filterGroups"] = {
                {
                    ["filters"] = {
                        {
                            ["values"] = {
                                {
                                    [9] = true,
                                }, -- [1]
                            },
                        }, -- [1]
                        [3] = {
                            ["values"] = {
                                [9] = {
                                    true, -- [1]
                                    true, -- [2]
                                    true, -- [3]
                                    true, -- [4]
                                    true, -- [5]
                                    true, -- [6]
                                    true, -- [7]
                                },
                            },
                        },
                    },
                }, -- [1]
            },
            ["name"] = Sorted.Localize("CATEGORY_MISCELLANEOUS"),
        }, -- [13]
    }
end

if (Sorted_IsClassic() and Sorted_WoWMajorVersionNumber() > 1) then
    table.insert(Sorted_defaultCategories, 5, {
        ["icon"] = "INV_Misc_Gem_02",
        ["filterGroups"] = {
            {
                ["filters"] = {
                    {
                        ["values"] = {
                            {
                                [5] = true,
                            }, -- [1]
                        },
                    }, -- [1]
                    [3] = {
                        ["values"] = {
                            [5] = {
                                true, -- [1]
                                true, -- [2]
                                true, -- [3]
                                true, -- [4]
                                true, -- [5]
                                true, -- [6]
                                true, -- [7]
                                true, -- [8]
                                true, -- [9]
                                true, -- [10]
                                true, -- [11]
                                true, -- [12]
                            },
                        },
                    },
                },
            }, -- [1]
        },
        ["name"] = Sorted.Localize("CATEGORY_GEMS"),
    })
end

Sorted_filters = {
    [1] = {
        ["name"] = Sorted.Localize("FILTER_TYPE"),
        ["func"] = function(itemData, optionGroupID, optionID)
            local class = Sorted_filters[1].optionGroups[optionGroupID].options[optionID].value
            return itemData.classID == class
        end,
        ["startChecked"] = false,
        ["operator"] = "OR",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_TYPE"),
                ["options"] = {
                    [1] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_ARMOR"),
                        ["value"] = LE_ITEM_CLASS_ARMOR
                    },
                    [2] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_BATTLE_PET"),
                        ["value"] = LE_ITEM_CLASS_BATTLEPET
                    },
                    [3] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_CONSUMABLE"),
                        ["value"] = LE_ITEM_CLASS_CONSUMABLE
                    },
                    [4] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_CONTAINER"),
                        ["value"] = LE_ITEM_CLASS_CONTAINER
                    },
                    [5] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_GEM"),
                        ["value"] = LE_ITEM_CLASS_GEM
                    },
                    [6] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_GLYPH"),
                        ["value"] = LE_ITEM_CLASS_GLYPH,
                        ["game"] = "RETAIL"
                    },
                    [7] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_ITEM_ENHANCEMENT"),
                        ["value"] = LE_ITEM_CLASS_ITEM_ENHANCEMENT
                    },
                    [8] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_KEY"),
                        ["value"] = LE_ITEM_CLASS_KEY,
                        ["game"] = "CLASSIC"
                    },
                    [9] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_MISCELLANEOUS"),
                        ["value"] = LE_ITEM_CLASS_MISCELLANEOUS
                    },
                    [10] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_REAGENT"),
                        ["value"] = LE_ITEM_CLASS_REAGENT,
                        ["game"] = "CLASSIC"
                    },
                    [11] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_RECIPE"),
                        ["value"] = LE_ITEM_CLASS_RECIPE
                    },
                    [12] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_PROJECTILE"),
                        ["value"] = LE_ITEM_CLASS_PROJECTILE,
                        ["game"] = "CLASSIC"
                    },
                    [13] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_QUEST"),
                        ["value"] = LE_ITEM_CLASS_QUESTITEM
                    },
                    [14] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_QUIVER"),
                        ["value"] = LE_ITEM_CLASS_QUIVER,
                        ["game"] = "CLASSIC"
                    },
                    [15] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_TRADE_GOODS"),
                        ["value"] = LE_ITEM_CLASS_TRADEGOODS
                    },
                    [16] = {
                        ["name"] = Sorted.Localize("SUBFILTER_TYPE_WEAPON"),
                        ["value"] = LE_ITEM_CLASS_WEAPON
                    }
                }
            }
        }
    },
    [2] = {
        ["name"] = Sorted.Localize("FILTER_EQUIP_LOCATION"),
        ["func"] = function(itemData, optionGroupID, optionID)
            for _, value in pairs(Sorted_filters[2].optionGroups[optionGroupID].options[optionID].value) do
                if itemData.equipLoc == value then
                    return true
                end
            end
            return false
        end,
        ["startChecked"] = false,
        ["operator"] = "OR",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_ARMOR"),
                ["required"] = {
                    ["filter"] = 1,
                    ["optionGroup"] = 1,
                    ["option"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_HEAD"),
                        ["value"] = {"INVTYPE_HEAD"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_NECK"),
                        ["value"] = {"INVTYPE_NECK"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_SHOULDER"),
                        ["value"] = {"INVTYPE_SHOULDER"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_BACK"),
                        ["value"] = {"INVTYPE_CLOAK"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_CHEST"),
                        ["value"] = {"INVTYPE_CHEST","INVTYPE_ROBE"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_SHIRT"),
                        ["value"] = {"INVTYPE_BODY"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_TABARD"),
                        ["value"] = {"INVTYPE_TABARD"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_WRIST"),
                        ["value"] = {"INVTYPE_WRIST"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_HANDS"),
                        ["value"] = {"INVTYPE_HAND"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_WAIST"),
                        ["value"] = {"INVTYPE_WAIST"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_LEGS"),
                        ["value"] = {"INVTYPE_LEGS"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_FEET"),
                        ["value"] = {"INVTYPE_FEET"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_FINGER"),
                        ["value"] = {"INVTYPE_FINGER"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_TRINKET"),
                        ["value"] = {"INVTYPE_TRINKET"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_OFF_HAND"),
                        ["value"] = {"INVTYPE_SHIELD","INVTYPE_HOLDABLE"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_RELIC"),
                        ["game"] = "CLASSIC",
                        ["value"] = {"INVTYPE_RELIC"}
                    },
                }
            },
            [2] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_WEAPON"),
                ["required"] = {
                    ["filter"] = 1,
                    ["optionGroup"] = 1,
                    ["option"] = 16,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_ONE_HAND"),
                        ["value"] = {"INVTYPE_WEAPON","INVTYPE_WEAPONMAINHAND","INVTYPE_WEAPONOFFHAND"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_TWO_HAND"),
                        ["value"] = {"INVTYPE_2HWEAPON"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_EQUIP_LOCATION_RANGED"),
                        ["value"] = {"INVTYPE_RANGED","INVTYPE_THROWN","INVTYPE_RANGEDRIGHT"}
                    }
                }
            },
        }
    },
    [3] = {
        ["name"] = Sorted.Localize("FILTER_SUBTYPE"),
        ["func"] = function(itemData, optionGroupID, optionID)
            local class = Sorted_filters[3].optionGroups[optionGroupID].value
            local subclass = Sorted_filters[3].optionGroups[optionGroupID].options[optionID].value

            -- Treat cloaks as generic
            if itemData.equipLoc == "INVTYPE_CLOAK" then
                return subclass == LE_ITEM_ARMOR_GENERIC
            end
            if type(subclass) == "table" then
                for _, value in pairs(subclass) do
                    if itemData.classID == class and itemData.subClassID == value then
                        return true
                    end
                end
                return false
            end
            return itemData.classID == class and itemData.subClassID == subclass
        end,
        ["startChecked"] = false,
        ["operator"] = "OR",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_ARMOR"),
                ["value"] = LE_ITEM_CLASS_ARMOR,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 1,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_PLATE"),
                        ["value"] = LE_ITEM_ARMOR_PLATE
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_MAIL"),
                        ["value"] = LE_ITEM_ARMOR_MAIL
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_LEATHER"),
                        ["value"] = LE_ITEM_ARMOR_LEATHER
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_CLOTH"),
                        ["value"] = LE_ITEM_ARMOR_CLOTH
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_COSMETIC"),
                        ["value"] = LE_ITEM_ARMOR_COSMETIC
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_GENERIC"),
                        ["value"] = LE_ITEM_ARMOR_GENERIC
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_SHIELDS"),
                        ["value"] = LE_ITEM_ARMOR_SHIELD
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_LIBRAMS"),
                        ["value"] = LE_ITEM_ARMOR_LIBRAM,
                        ["game"] = "CLASSIC"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_IDOLS"),
                        ["value"] = LE_ITEM_ARMOR_IDOL,
                        ["game"] = "CLASSIC"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_TOTEMS"),
                        ["value"] = LE_ITEM_ARMOR_TOTEM,
                        ["game"] = "CLASSIC"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ARMOR_SIGILS"),
                        ["value"] = LE_ITEM_ARMOR_SIGIL,
                        ["game"] = "CLASSIC"
                    },
                }
            },
            [2] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_BATTLE_PET"),
                ["value"] = LE_ITEM_CLASS_BATTLEPET,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 2,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_HUMANOID"),
                        ["value"] = 1
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_DRAGON"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_FLYING"),
                        ["value"] = 3
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_UNDEAD"),
                        ["value"] = 4
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_CRITTER"),
                        ["value"] = 5
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_MAGICAL"),
                        ["value"] = 6
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_ELEMENTAL"),
                        ["value"] = 7
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_BEAST"),
                        ["value"] = 8
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_WATER"),
                        ["value"] = 9
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_BATTLE_PET_MECHANICAL"),
                        ["value"] = 10
                    },
                }
            },
            [3] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_CONSUMABLE"),
                ["value"] = LE_ITEM_CLASS_CONSUMABLE,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 3,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_BOMBS_AND_DEVICES"),
                        ["value"] = 0
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_POTIONS"),
                        ["value"] = 1
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_ELIXIRS"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_FLASKS"),
                        ["value"] = 3
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_FOOD_AND_DRINK"),
                        ["value"] = 5
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_BANDAGES"),
                        ["value"] = 7
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_VANTUS_RUNES"),
                        ["value"] = 9
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_OTHER"),
                        ["value"] = {8, S.CONDUIT_SUBCLASSID}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONSUMABLE_CONDUIT"),
                        ["value"] = S.CONDUIT_SUBCLASSID
                    },
                }
            },
            [4] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_CONTAINER"),
                ["value"] = LE_ITEM_CLASS_CONTAINER,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 4,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_BAG"),
                        ["value"] = 8
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_SOUL"),
                        ["game"] = "CLASSIC",
                        ["value"] = 1
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_HERB"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_ENCHANTING"),
                        ["value"] = 3
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_ENGINEERING"),
                        ["value"] = 4
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_GEM"),
                        ["value"] = 5
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_MINING"),
                        ["value"] = 6
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_LEATHERWORKING"),
                        ["value"] = 7
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_INSCRIPTION"),
                        ["value"] = 8
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_TACKLE"),
                        ["value"] = 9
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_COOKING"),
                        ["value"] = 10
                    }
                }
            },
            [5] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_GEM"),
                ["value"] = LE_ITEM_CLASS_GEM,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 5,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_INTELLECT"),
                        ["value"] = LE_ITEM_GEM_INTELLECT
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_AGILITY"),
                        ["value"] = LE_ITEM_GEM_AGILITY
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_STRENGTH"),
                        ["value"] = LE_ITEM_GEM_STRENGTH
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_STAMINA"),
                        ["value"] = LE_ITEM_GEM_STAMINA
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_SPIRIT"),
                        ["value"] = LE_ITEM_GEM_SPIRIT
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_CRITICAL_STRIKE"),
                        ["value"] = LE_ITEM_GEM_CRITICALSTRIKE
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_MASTERY"),
                        ["value"] = LE_ITEM_GEM_MASTERY
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_HASTE"),
                        ["value"] = LE_ITEM_GEM_HASTE
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_VERSATILITY"),
                        ["value"] = LE_ITEM_GEM_VERSATILITY
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_OTHER"),
                        ["value"] = 9
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_MULTIPLE_STATS"),
                        ["value"] = LE_ITEM_GEM_MULTIPLESTATS
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GEM_ARTIFACT_RELIC"),
                        ["value"] = LE_ITEM_GEM_ARTIFACTRELIC
                    },
                }
            },
            [6] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_GLYPH"),
                ["value"] = LE_ITEM_CLASS_GLYPH,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 6,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_WARRIOR"),
                        ["value"] = 1
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_PALADIN"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_HUNTER"),
                        ["value"] = 3
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_ROGUE"),
                        ["value"] = 4
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_PRIEST"),
                        ["value"] = 5
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_DEATH_KNIGHT"),
                        ["value"] = 6
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_SHAMAN"),
                        ["value"] = 7
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_MAGE"),
                        ["value"] = 8
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_WARLOCK"),
                        ["value"] = 9
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_MONK"),
                        ["value"] = 10
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_DRUID"),
                        ["value"] = 11
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_GLYPH_DEMON_HUNTER"),
                        ["value"] = 12
                    },
                }
            },
            [7] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_ITEM_ENHANCEMENT"),
                ["value"] = LE_ITEM_CLASS_ITEM_ENHANCEMENT,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 7,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_HEAD"),
                        ["value"] = 0
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_NECK"),
                        ["value"] = 1
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_SHOULDER"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_CLOAK"),
                        ["value"] = 3
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_CHEST"),
                        ["value"] = 4
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_WRIST"),
                        ["value"] = 5
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_HANDS"),
                        ["value"] = 6
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_WAIST"),
                        ["value"] = 7
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_LEGS"),
                        ["value"] = 8
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_FEET"),
                        ["value"] = 9
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_FINGER"),
                        ["value"] = 10
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_ONE_HAND"),
                        ["value"] = 11
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_TWO_HAND"),
                        ["value"] = 12
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_SHIELD_OFF_HAND"),
                        ["value"] = 13
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_MISCELLANEOUS"),
                        ["value"] = 14
                    },
                }
            },
            [8] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_KEY"),
                ["value"] = LE_ITEM_CLASS_KEY,
                ["game"] = "CLASSIC",
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 8,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_KEY_KEY"),
                        ["value"] = 0
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_KEY_LOCKPICK"),
                        ["value"] = 1
                    },
                }
            },
            [9] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_MISCELLANEOUS"),
                ["value"] = LE_ITEM_CLASS_MISCELLANEOUS,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 9,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_MISCELLANEOUS_JUNK"),
                        ["value"] = 0
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_MISCELLANEOUS_REAGENTS"),
                        ["value"] = 1
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_MISCELLANEOUS_COMPANION_PETS"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_MISCELLANEOUS_HOLIDAY"),
                        ["value"] = 3
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_MISCELLANEOUS_OTHER"),
                        ["value"] = 4
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_MISCELLANEOUS_MOUNT"),
                        ["value"] = 5
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_MISCELLANEOUS_MOUNT_EQUIPMENT"),
                        ["value"] = 6
                    },
                }
            },
            [10] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_RECIPE"),
                ["value"] = LE_ITEM_CLASS_RECIPE,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 11,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_BOOK"),
                        ["value"] = 0
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_LEATHERWORKING"),
                        ["value"] = LE_ITEM_RECIPE_LEATHERWORKING
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_TAILORING"),
                        ["value"] = LE_ITEM_RECIPE_TAILORING
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_ENGINEERING"),
                        ["value"] = LE_ITEM_RECIPE_ENGINEERING
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_BLACKSMITHING"),
                        ["value"] = LE_ITEM_RECIPE_BLACKSMITHING
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_COOKING"),
                        ["value"] = LE_ITEM_RECIPE_COOKING
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_ALCHEMY"),
                        ["value"] = LE_ITEM_RECIPE_ALCHEMY
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_FIRST_AID"),
                        ["value"] = LE_ITEM_RECIPE_FIRST_AID
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_ENCHANTING"),
                        ["value"] = LE_ITEM_RECIPE_ENCHANTING
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_FISHING"),
                        ["value"] = LE_ITEM_RECIPE_FISHING
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_JEWELCRAFTING"),
                        ["value"] = LE_ITEM_RECIPE_JEWELCRAFTING
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_RECIPE_INSCRIPTION"),
                        ["value"] = LE_ITEM_RECIPE_INSCRIPTION
                    }
                }
            },
            [11] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_PROJECTILE"),
                ["value"] = LE_ITEM_CLASS_PROJECTILE,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 12,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_PROJECTILE_ARROW"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_PROJECTILE_BULLET"),
                        ["value"] = 3
                    },
                }
            },
            [12] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_QUIVER"),
                ["value"] = LE_ITEM_CLASS_QUIVER,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 14,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_QUIVER_QUIVER"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_QUIVER_AMMO_POUCH"),
                        ["value"] = 3
                    },
                }
            },
            [13] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_TRADE_GOODS"),
                ["value"] = LE_ITEM_CLASS_TRADEGOODS,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 15,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_PARTS"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_JEWELCRAFTING"),
                        ["value"] = 4
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_CLOTH"),
                        ["value"] = 5
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_LEATHER"),
                        ["value"] = 6
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_METAL_AND_STONE"),
                        ["value"] = 7
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_COOKING"),
                        ["value"] = 8
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_HERB"),
                        ["value"] = 9
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_ELEMENTAL"),
                        ["value"] = 10
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_ENCHANTING"),
                        ["value"] = 12
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_INSCRIPTION"),
                        ["value"] = 16
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_TRADE_GOODS_OTHER"),
                        ["value"] = 11
                    },
                }
            },
            [14] = {
                ["name"] = Sorted.Localize("SUBFILTER_TYPE_WEAPON"),
                ["value"] = LE_ITEM_CLASS_WEAPON,
                ["required"] = {
                    ["filter"] = 1,
                    ["option"] = 16,
                    ["optionGroup"] = 1,
                    ["value"] = true
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_AXES"),
                        ["value"] = { LE_ITEM_WEAPON_AXE1H, LE_ITEM_WEAPON_AXE2H }
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_MACES"),
                        ["value"] = { LE_ITEM_WEAPON_MACE1H, LE_ITEM_WEAPON_MACE2H }
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_SWORDS"),
                        ["value"] = { LE_ITEM_WEAPON_SWORD1H, LE_ITEM_WEAPON_SWORD2H }
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_DAGGERS"),
                        ["value"] = LE_ITEM_WEAPON_DAGGER
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_POLEARMS"),
                        ["value"] = LE_ITEM_WEAPON_POLEARM
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_FIST"),
                        ["value"] = LE_ITEM_WEAPON_UNARMED
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_GLAIVES"),
                        ["value"] = LE_ITEM_WEAPON_WARGLAIVE,
                        ["game"] = "RETAIL"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_WANDS"),
                        ["value"] = LE_ITEM_WEAPON_WAND
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_STAVES"),
                        ["value"] = LE_ITEM_WEAPON_STAFF
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_BOWS"),
                        ["value"] = LE_ITEM_WEAPON_BOWS
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_CROSSBOWS"),
                        ["value"] = LE_ITEM_WEAPON_CROSSBOW
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_GUNS"),
                        ["value"] = LE_ITEM_WEAPON_GUNS
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_THROWN"),
                        ["value"] = LE_ITEM_WEAPON_THROWN,
                        ["game"] = "CLASSIC"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_FISHING_POLES"),
                        ["value"] = LE_ITEM_WEAPON_FISHINGPOLE
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_SUBTYPE_WEAPON_MISCELLANEOUS"),
                        ["value"] = LE_ITEM_WEAPON_GENERIC
                    }
                }
            }
        }
    },
    [4] = {
        ["name"] = Sorted.Localize("FILTER_STATS"),
        ["func"] = function(itemData, optionGroupID, optionID, data)
            if not data then 
                return false 
            elseif type(data) == "boolean" then
                local statTable = GetItemStats(itemData.link)
                for _, stat in pairs(Sorted_filters[4].optionGroups[optionGroupID].options[optionID].value) do
                    if statTable and statTable[stat] then
                        return true
                    end
                end
                return false
            end
            local min = data.min
            local max = data.max
            local statTable = GetItemStats(itemData.link)
            if not statTable then return false end
            for _, stat in pairs(Sorted_filters[4].optionGroups[optionGroupID].options[optionID].value) do
                if statTable[stat] then
                    local value = statTable[stat]
                    if not min or min < 1 then 
                        return value <= max
                    elseif not max or max < 1 then 
                        return value >= min
                    else 
                        return value >= min and value <= max 
                    end
                end
            end
        end,
        ["startChecked"] = true,
        ["operator"] = "AND",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_STATS"),
                ["required"] = {
                    {
                        ["filter"] = 1,
                        ["option"] = "Weapon",
                        ["optionGroup"] = 1,
                        ["value"] = true
                    },
                    {
                        ["filter"] = 1,
                        ["option"] = "Armor",
                        ["optionGroup"] = 1,
                        ["value"] = true
                    }
                },
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_STAMINA"),
                        ["type"] = "RANGE",
                        ["value"] = {"ITEM_MOD_STAMINA", "ITEM_MOD_STAMINA_SHORT"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_STRENGTH"),
                        ["type"] = "RANGE",
                        ["value"] = {"ITEM_MOD_STRENGTH", "ITEM_MOD_STRENGTH_SHORT"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_AGILITY"),
                        ["type"] = "RANGE",
                        ["value"] = {"ITEM_MOD_AGILITY", "ITEM_MOD_AGILITY_SHORT"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_INTELLECT"),
                        ["type"] = "RANGE",
                        ["value"] = {"ITEM_MOD_INTELLECT", "ITEM_MOD_INTELLECT_SHORT"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_CRITICAL_STRIKE"),
                        ["type"] = "RANGE",
                        ["value"] = {
                            "ITEM_MOD_CRIT_MELEE_RATING",
                            "ITEM_MOD_CRIT_MELEE_RATING_SHORT",
                            "ITEM_MOD_CRIT_RANGED_RATING",
                            "ITEM_MOD_CRIT_RANGED_RATING_SHORT",
                            "ITEM_MOD_CRIT_RATING",
                            "ITEM_MOD_CRIT_RATING_SHORT",
                            "ITEM_MOD_CRIT_SPELL_RATING",
                            "ITEM_MOD_CRIT_SPELL_RATING_SHORT",
                        }
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_HASTE"),
                        ["type"] = "RANGE",
                        ["value"] = {
                            "ITEM_MOD_HASTE_MELEE_RATING",
                            "ITEM_MOD_HASTE_MELEE_RATING_SHORT",
                            "ITEM_MOD_HASTE_RANGED_RATING",
                            "ITEM_MOD_HASTE_RANGED_RATING_SHORT",
                            "ITEM_MOD_HASTE_RATING",
                            "ITEM_MOD_HASTE_RATING_SHORT",
                            "ITEM_MOD_HASTE_SPELL_RATING",
                            "ITEM_MOD_HASTE_SPELL_RATING_SHORT",
                        }
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_MASTERY"),
                        ["type"] = "RANGE",
                        ["value"] = {
                            "ITEM_MOD_MASTERY_RATING", 
                            "ITEM_MOD_MASTERY_RATING_SHORT",
                            "ITEM_MOD_MASTERY_RATING_SPELL",
                            "ITEM_MOD_MASTERY_RATING_TWO_SPELLS",
                        }
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_VERSATILITY"),
                        ["type"] = "RANGE",
                        ["value"] = {"ITEM_MOD_VERSATILITY"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_SPEED"),
                        ["type"] = "RANGE",
                        ["value"] = {"ITEM_MOD_CR_SPEED_SHORT"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_INDESTRUCTIBLE"),
                        ["value"] = {"ITEM_MOD_CR_STURDINESS_SHORT"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_LEECH"),
                        ["type"] = "RANGE",
                        ["value"] = {"ITEM_MOD_CR_LIFESTEAL_SHORT"}
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_STATS_AVOIDANCE"),
                        ["type"] = "RANGE",
                        ["value"] = {"ITEM_MOD_CR_AVOIDANCE_SHORT"}
                    },
                }
            }
        }
    },
    [5] = {
        ["name"] = Sorted.Localize("FILTER_QUALITY"),
        ["func"] = function(itemData, optionGroupID, optionID)
            local quality = Sorted_filters[5].optionGroups[optionGroupID].options[optionID].value
            if itemData.quality == 8 then return quality == 4 end
            return itemData.quality == quality
        end,
        ["startChecked"] = false,
        ["operator"] = "OR",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_QUALITY"),
                ["options"] = {
                    {
                        ["name"] = "|cff00ccff"..Sorted.Localize("SUBFILTER_QUALITY_HEIRLOOM"),
                        ["value"] = 7
                    },
                    {
                        ["name"] = "|cffe6cc80"..Sorted.Localize("SUBFILTER_QUALITY_ARTIFACT"),
                        ["value"] = 6
                    },
                    {
                        ["name"] = "|cffff8000"..Sorted.Localize("SUBFILTER_QUALITY_LEGENDARY"),
                        ["value"] = 5
                    },
                    {
                        ["name"] = "|cffa335ee"..Sorted.Localize("SUBFILTER_QUALITY_EPIC"),
                        ["value"] = 4
                    },
                    {
                        ["name"] = "|cff0070dd"..Sorted.Localize("SUBFILTER_QUALITY_RARE"),
                        ["value"] = 3
                    },
                    {
                        ["name"] = "|cff1eff00"..Sorted.Localize("SUBFILTER_QUALITY_UNCOMMON"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = "|cffffffff"..Sorted.Localize("SUBFILTER_QUALITY_COMMON"),
                        ["value"] = 1
                    },
                    {
                        ["name"] = "|cff9d9d9d"..Sorted.Localize("SUBFILTER_QUALITY_POOR"),
                        ["value"] = 0
                    }
                }
            }
        }
    },
    [6] = {
        ["name"] = Sorted.Localize("FILTER_TIME_ADDED"),
        ["func"] = function(itemData, optionGroupID, optionID, data)
            local timeAdded = itemData.timeAdded
            if not itemData.timeAdded then timeAdded = time() end
            local value = time() - timeAdded
            value = value / Sorted_filters[6].optionGroups[1].options[optionID].value
            if not data.min or data.min < 1 then 
                return value <= data.max
            elseif not data.max or data.max < 1 then 
                return value >= data.min
            else 
                return value >= data.min and value <= data.max 
            end
        end,
        ["startChecked"] = true,
        ["operator"] = "AND",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_TIME_ADDED"),
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_TIME_SECONDS"),
                        ["value"] = 1,
                        ["type"] = "RANGE"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_TIME_MINUTES"),
                        ["value"] = 60,
                        ["type"] = "RANGE"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_TIME_HOURS"),
                        ["value"] = 3600,
                        ["type"] = "RANGE"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_TIME_DAYS"),
                        ["value"] = 86400,
                        ["type"] = "RANGE"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_TIME_WEEKS"),
                        ["value"] = 604800,
                        ["type"] = "RANGE"
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_TIME_MONTHS"),
                        ["value"] = 2419200,
                        ["type"] = "RANGE"
                    }
                }
            }
        }
    },
    [7] = {
        ["name"] = Sorted.Localize("FILTER_BINDING"),
        ["func"] = function(itemData, optionGroupID, optionID)
            local bindType = Sorted_filters[7].optionGroups[optionGroupID].options[optionID].value
            if itemData.bound then
                return bindType == 5
            end
            return itemData.bindType == bindType
        end,
        ["startChecked"] = false,
        ["operator"] = "OR",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_BINDING"),
                ["options"] = {
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_BINDING_NONE"),
                        ["value"] = 0
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_BINDING_ON_EQUIP"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_BINDING_ON_PICKUP"),
                        ["value"] = 1
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_BINDING_ON_USE"),
                        ["value"] = 3
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_BINDING_SOULBOUND"),
                        ["value"] = 5
                    },
                }
            }
        }
    },
    [8] = {
        ["name"] = Sorted.Localize("FILTER_EXPANSION"),
        ["func"] = function(itemData, optionGroupID, optionID)
            local xpac = Sorted_filters[8].optionGroups[optionGroupID].options[optionID].value
            return itemData.expacID == xpac
        end,
        ["startChecked"] = false,
        ["operator"] = "OR",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_EXPANSION"),
                ["options"] = {
                    {
                        ["name"] = Sorted_FormatExpac(1), --Sorted_ExpacColor(1)..Sorted.Localize("SUBFILTER_EXPANSION_TBC"),
                        ["value"] = 1
                    },
                    {
                        ["name"] = Sorted_FormatExpac(2), --Sorted_ExpacColor(2)..Sorted.Localize("SUBFILTER_EXPANSION_WOTLK"),
                        ["value"] = 2
                    },
                    {
                        ["name"] = Sorted_FormatExpac(3), --Sorted_ExpacColor(3)..Sorted.Localize("SUBFILTER_EXPANSION_CATA"),
                        ["value"] = 3
                    },
                    {
                        ["name"] = Sorted_FormatExpac(4), --Sorted_ExpacColor(4)..Sorted.Localize("SUBFILTER_EXPANSION_MOP"),
                        ["value"] = 4
                    },
                    {
                        ["name"] = Sorted_FormatExpac(5), --Sorted_ExpacColor(5)..Sorted.Localize("SUBFILTER_EXPANSION_WOD"),
                        ["value"] = 5
                    },
                    {
                        ["name"] = Sorted_FormatExpac(6), --Sorted_ExpacColor(6)..Sorted.Localize("SUBFILTER_EXPANSION_LEGION"),
                        ["value"] = 6
                    },
                    {
                        ["name"] = Sorted_FormatExpac(7), --Sorted_ExpacColor(7)..Sorted.Localize("SUBFILTER_EXPANSION_BFA"),
                        ["value"] = 7
                    },
                    {
                        ["name"] = Sorted_FormatExpac(8), --Sorted_ExpacColor(8)..Sorted.Localize("SUBFILTER_EXPANSION_SHADOW"),
                        ["value"] = 8
                    }
                }
            }
        }
    },
    [9] = {
        ["name"] = Sorted.Localize("FILTER_LEVEL"),
        ["func"] = function(itemData, optionGroupID, optionID, data)
            local value
            if optionID == 1 then
                value = itemData.level
            else
                value = itemData.minLevel
            end
            if not data.min or data.min < 1 then 
                return value <= data.max
            elseif not data.max or data.max < 1 then 
                return value >= data.min
            else 
                return value >= data.min and value <= data.max 
            end
        end,
        ["startChecked"] = true,
        ["operator"] = "AND",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_LEVEL"),
                ["options"] = {
                    {
                        ["name"] = Sorted_ExpacColor(8)..Sorted.Localize("SUBFILTER_LEVEL_ITEM_LEVEL"),
                        ["type"] = "RANGE"
                    },
                    {
                        ["name"] = Sorted_ExpacColor(8)..Sorted.Localize("SUBFILTER_LEVEL_REQUIRED_LEVEL"),
                        ["type"] = "RANGE"
                    },
                }
            }
        }
    },
    [90] = {
        ["name"] = Sorted.Localize("FILTER_MARKER_ICON"),
        ["func"] = function(itemData, optionGroupID, optionID, data)
            local value = Sorted_filters[90].optionGroups[optionGroupID].options[optionID].value
            if value == 0 then
                return not Sorted_GetFavorited(itemData)
            else
                return Sorted_GetFavorited(itemData) == value
            end
        end,
        ["startChecked"] = false,
        ["operator"] = "OR",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_MARKER_ICON"),
                ["options"] = {
                    {
                        ["name"] = S.FormatMarkerIcon(1),
                        ["value"] = 1
                    },
                    {
                        ["name"] = S.FormatMarkerIcon(2),
                        ["value"] = 2
                    },
                    {
                        ["name"] = S.FormatMarkerIcon(3),
                        ["value"] = 3
                    },
                    {
                        ["name"] = S.FormatMarkerIcon(4),
                        ["value"] = 4
                    },
                    {
                        ["name"] = S.FormatMarkerIcon(5),
                        ["value"] = 5
                    },
                    {
                        ["name"] = S.FormatMarkerIcon(6),
                        ["value"] = 6
                    },
                    {
                        ["name"] = S.FormatMarkerIcon(7),
                        ["value"] = 7
                    },
                    {
                        ["name"] = S.FormatMarkerIcon(8),
                        ["value"] = 8
                    },
                    {
                        ["name"] = Sorted.Localize("SUBFILTER_MARKER_ICON_NONE"),
                        ["value"] = 0
                    },
                }
            }
        }
    },
    [100] = {
        ["name"] = SEARCH,
        ["func"] = function(itemData, optionGroupID, optionID, data)
            if optionGroupID == 1 then
                return Sorted_ItemSearchFilter(itemData, data, true)
            elseif optionGroupID == 2 then
                return Sorted_ItemSearchFilter(itemData, data, false, true)
            elseif optionGroupID == 3 then
                return Sorted_ItemSearchFilter(itemData, data, false, false, true)
            end
        end,
        ["startChecked"] = true,
        ["operator"] = "OR",
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_NAME_SEARCH"),
                ["type"] = "LIST",
            },
            [2] = {
                ["name"] = Sorted.Localize("FILTER_TOOLTIP_SEARCH"),
                ["type"] = "LIST",
            },
            [3] = {
                ["name"] = Sorted.Localize("FILTER_LIB_ITEM_SEARCH"),
                ["type"] = "LIST",
            }
        }
    },
    [101] = {
        ["name"] = Sorted.Localize("FILTER_SPECIFIC_ITEMS"),
        ["func"] = function(itemData, optionGroupID, optionID, data)
            if data.id then
                return tonumber(itemData.itemID) == tonumber(data.id)
            elseif data.name then
                return itemData.name == data.name
            end
            return false
        end,
        ["startChecked"] = true,
        ["operator"] = "OR",
        ["override"] = true,
        ["optionGroups"] = {
            [1] = {
                ["name"] = Sorted.Localize("FILTER_SPECIFIC_ITEMS"),
                ["type"] = "IDLIST",
            }
        }
    }
}

function Sorted_GetSubfilterValue(category, filterGroup, filter, optionGroup, option)
    local data = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)[category]
    if data.filterGroups then
        data = data.filterGroups[filterGroup]
        if data and data.filters and data.filters[filter] and data.filters[filter].values and data.filters[filter].values[optionGroup] then
            return data.filters[filter].values[optionGroup][option]
        end
    end
end

function Sorted_GetSubfilterGroupModified(category, filterGroup, filter, optionGroup)
    local data = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)[category]
    if data.filterGroups then
        data = data.filterGroups[filterGroup]
        if data and data.filters and data.filters[filter] and data.filters[filter].values and data.filters[filter].values[optionGroup] then
            return true
        end
    end
    return false
end

function Sorted_GetSubfilterGroupEnabled(category, filterGroup, filter, optionGroup)
    local req = Sorted_filters[filter].optionGroups[optionGroup].required
    if (not req) or (not Sorted_GetSubfilterGroupModified(category, filterGroup, req.filter, req.optionGroup)) or Sorted_GetSubfilterValue(category, filterGroup, req.filter, req.optionGroup, req.option) == req.value then
        return true
    end
end

function Sorted_GetFilterModified(category, filterGroup, filter)
    local data = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)[category]
    if data.filterGroups then 
        data = data.filterGroups[filterGroup] 
        if data and data.filters and data.filters[filter] and data.filters[filter].values then
            for optionGroupID, optionGroup in pairs(data.filters[filter].values) do
                if Sorted_GetSubfilterGroupEnabled(category, filterGroup, filter, optionGroupID) then
                    return true
                end
            end
        end
    end
    return false
end



Sorted.LIS = LibStub("LibItemSearch-1.2")

function Sorted_ItemSearchFilter(itemData, searchText, onlyName, onlyTooltip, onlyLIS)
    if itemData.classID == LE_ITEM_CLASS_BATTLEPET then
        onlyName = true
    end
    local s1
    if onlyName then
        s1 = itemData.name
    elseif onlyTooltip then
        if Sorted.LIS and Sorted.LIS:Tooltip(itemData.link, searchText) then
            return true
        end
        s1 = S.GetItemTooltipString(itemData.bag, itemData.slot, true)
    elseif onlyLIS then
        return Sorted.LIS:Matches(itemData.link, searchText)
    else
        if Sorted.LIS and Sorted.LIS:Matches(itemData.link, searchText) then
            return true
        end
        s1 = itemData.name..S.GetItemTooltipString(itemData.bag, itemData.slot, true)
    end
    if s1 then
        s1 = s1:lower():gsub("%s+", ""):gsub("%p+", "")
        local s2 = searchText:lower():gsub("%s+", ""):gsub("%p+", "")
        -- Search for whole string, ignoring whitespace, punctuation, and case
        if s1:find(s2) then return true end
        -- Search stats
        if not onlyName and Sorted_SearchStatTable(GetItemStats(itemData.link), searchText) then
            return true
        end
        -- Search for each word separated by spaces
        for s2 in searchText:gmatch("%S+") do
            s2 = string.lower(s2)
            if not s1:find(s2) then return false end
        end
        return true
    end
end

function Sorted_CategoryFilter(categoryID, itemData, ignoreAllOptions)
    local filterGroups = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)[categoryID].filterGroups
    local filteredOut = false
    local filteredIn = false
    if filterGroups then
        for filterGroupID, fg in pairs(filterGroups) do

            if fg.filters then
                for filterID, filter in pairs(fg.filters) do
                    local options
                    local ignoreOptions = true
                    if not ignoreAllOptions then
                        options = SortedSubcategoryFrame_GetOptions()[filterGroupID][filterID]
                        if Sorted_filters[filterID].override then
                            ignoreOptions = false
                        else
                            for optionGroupID, optionGroup in pairs(options) do
                                for optionID, option in pairs(optionGroup) do
                                    if option then
                                        ignoreOptions = false
                                    end
                                end
                            end
                        end
                    end

                    local filtered
                    if Sorted_filters[filterID].operator == "AND" then
                        filtered = true
                        if not ignoreOptions and not ignoreAllOptions then
                            for optionGroupID, optionGroup in pairs(options) do
                                for optionID, option in pairs(optionGroup) do
                                    if (options[optionGroupID][optionID]) then
                                        if not Sorted_filters[filterID].func(itemData, optionGroupID, optionID, Sorted_GetSubfilterValue(categoryID, filterGroupID, filterID, optionGroupID, optionID)) then
                                            filtered = false
                                        else
                                            filteredIn = true
                                        end
                                    end
                                end
                            end
                        end
                    elseif Sorted_filters[filterID].operator == "OR" then
                        filtered = false
                        for optionGroupID, optionGroup in pairs(filter.values) do
                            for optionID, option in pairs(optionGroup) do
                                if ignoreOptions or ignoreAllOptions or (options[optionGroupID][optionID]) then
                                    if Sorted_filters[filterID].func(itemData, optionGroupID, optionID, Sorted_GetSubfilterValue(categoryID, filterGroupID, filterID, optionGroupID, optionID)) then
                                        filtered = true
                                        filteredIn = true
                                    end
                                end
                            end
                        end
                    end
                    if Sorted_filters[filterID].override then
                        if filtered then
                            return true
                        end
                    elseif not filtered then
                        filteredOut = true
                    end
                end
            end
        end
    end
    return (not filteredOut) and filteredIn
end

local function Sorted_FilterItemButton(itemButton)
    if itemButton.empty then 
        return false
    end

    -- Equipment sets
    if Sorted_selectedEquipSet ~= nil then
        if Sorted_selectedEquipSet < 0 then
            local found = false
            for _, equipSet in pairs(Sorted_GetData().equipSets) do
                for k,v in pairs(equipSet.locations) do
                    if v.bag == itemButton.bag and v.slot == itemButton.slot then
                        found = true
                    end
                end
            end
            if found then return false end
        else
            local found = false
            for k,v in pairs(Sorted_GetData().equipSets[Sorted_selectedEquipSet].locations) do
                if v.bag == itemButton.bag and v.slot == itemButton.slot then
                    found = true
                end
            end
            if not found then return false end
        end
    end

    
    local itemData = itemButton:GetData()

    local doSearch = (#SortedFrameSearchBox:GetText() > 0 )
    if doSearch and (not Sorted_ItemSearchFilter(itemData, SortedFrameSearchBox:GetText())) then
        return false
    elseif Sorted_SelectedCategory == 0 then
        return true
    else
        -- Filter by category
        return Sorted_CategoryFilter(Sorted_SelectedCategory, itemData)
    end
end

function SortedItemList_FilterItems(self, itemID)
    for k, v in pairs(self.itemButtons) do
        if not itemID or itemID == v.itemID then
            if Sorted_FilterItemButton(v) then
                v.filtered = false
            else
                v.filtered = true
            end
        end
    end
end




function Sorted_SelectCategoryButton(id, dontToggle)
    if Sorted_SelectedCategory == id and not dontToggle then
        Sorted_CategoryButtons[Sorted_SelectedCategory].selectedTexture:Hide()
        Sorted_CategoryButtons[Sorted_SelectedCategory].miniButton.selectedTexture:Hide()
        Sorted_CategoryButtons[Sorted_SelectedCategory].miniButton:SetPoint("LEFT", SortedFrame, "RIGHT", -2, 0)
        Sorted_CategoryButtons[Sorted_SelectedCategory].miniButton:SetFrameLevel(540)
        Sorted_CategoryButtons[Sorted_SelectedCategory].miniButton:Deselect()
        if Sorted.IsSkinned() then
            Sorted_CategoryButtons[Sorted_SelectedCategory].text:SetFontObject(SortedButtonFont)
        end
        Sorted_SelectedCategory = 0
    else
        local data = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)
        local foundCategory = false

        for i,v in ipairs(Sorted_CategoryButtons) do
            if i == id and data[id] then
                foundCategory = true
                v.selectedTexture:Show()
                if Sorted.IsSkinned() then
                    v.text:SetFontObject(SortedButtonSelectedFont)
                end
                v.miniButton:SetPoint("LEFT", 4, 0)
                v.miniButton:SetFrameLevel(550)
                v.miniButton:Select()
            else
                v.selectedTexture:Hide()
                if Sorted.IsSkinned() then
                    v.text:SetFontObject(SortedButtonFont)
                end
                v.miniButton:SetPoint("LEFT", -2, 0)
                v.miniButton:SetFrameLevel(540)
                v.miniButton:Deselect()
            end
        end
        if not id or not foundCategory then
            Sorted_SelectedCategory = 0
        else
            Sorted_SelectedCategory = id
        end
    end
    Sorted_SetSetting("lastCategory", Sorted_SelectedCategory)
    if Sorted_GetSetting("categoriesUseIcons") == 2 and not Sorted_GetData(playerGUID).minimized then
        if Sorted_SelectedCategory > 0 then
            SortedFrame_MaximizeRightPanel(true)
        else
            SortedFrame_MinimizeRightPanel(true)
        end
    end
end

local function SortedCategoryButton_OnReceiveDrag(self)
    local type, itemID = GetCursorInfo()
    if type == "item" then
        local name = select(1, GetItemInfo(itemID))
        local data = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)[self:GetID()]
        if not data.filterGroups then data.filterGroups = {} end
        if not data.filterGroups[1] then data.filterGroups[1] = {} end
        if not data.filterGroups[1].filters then data.filterGroups[1].filters = {} end
        if not data.filterGroups[1].filters[101] then data.filterGroups[1].filters[101] = {} end
        if not data.filterGroups[1].filters[101].values then data.filterGroups[1].filters[101].values = {} end
        if not data.filterGroups[1].filters[101].values[1] then data.filterGroups[1].filters[101].values[1] = {} end
        local itemFound = false
        for _, item in pairs(data.filterGroups[1].filters[101].values[1]) do
            if item.id == itemID then
                itemFound = true
            end
        end
        if not itemFound then
            table.insert(data.filterGroups[1].filters[101].values[1], {
                ["id"] = itemID,
                ["name"] = name
            })
        end
        ClearCursor()
        SortedConfigCategoryFilters:Update()
        SortedConfigCategorySubfilters:Update()
        SortedSubcategoryFrame_Update()
        Sorted_FilterItems()
    end
end

local function SortedCategoryButton_OnClick(self, button)
    PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON )
    if button == "LeftButton" then
        Sorted_SelectCategoryButton(self:GetID())
    else
        Sorted_SelectCategoryButton(nil)
    end
    SortedSubcategoryFrame_Update()
    Sorted_FilterItems(nil, true, true)
    Sorted_ScrollToTop()
end

function SortedCategoryButtons_OnLoad(self)
    Sorted.RegisterBackdrop(self.backdrop)
    Sorted_SelectedCategory = 0
    Sorted_CategoryButtons = {}
    local miniButtonsFrame = CreateFrame("Frame", "SortedFrameMiniFilterButtons", SortedFrame)
    miniButtonsFrame:SetPoint("TOPLEFT", SortedFrame, "TOPRIGHT")
    miniButtonsFrame:SetPoint("RIGHT", 40, 0)
    for i = 1, 22 do
        local b = CreateFrame("Button", "SortedFilterButton"..i, self, "SortedButtonTemplate")
        b:SetPoint("TOPLEFT", 6, 14 - i * 21)
        b:SetPoint("BOTTOMRIGHT", b:GetParent(), "TOPRIGHT", -6, 14 - i * 21 - 21)
        b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
        b:SetID(i)
        b:HookScript("OnClick", SortedCategoryButton_OnClick)
        b:HookScript("OnReceiveDrag", SortedCategoryButton_OnReceiveDrag)
        Sorted_CategoryButtons[i] = b

        b = CreateFrame("Button", "SortedFilterButton"..i.."Mini", miniButtonsFrame, "SortedIconButtonTemplate")
        b:SetPoint("TOP", 0, -i * 32 + 16)
        b:SetPoint("LEFT", -2)
        b:RegisterForClicks("LeftButtonDown", "RightButtonDown")
        b:SetID(i)
        b:HookScript("OnClick", SortedCategoryButton_OnClick)
        b:HookScript("OnReceiveDrag", SortedCategoryButton_OnReceiveDrag)
        b:Show()
        Sorted_CategoryButtons[i].miniButton = b
    end
    miniButtonsFrame:Hide()
end

function SortedFilterButtons_Update(self)
    local data = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)
    for i, v in ipairs(Sorted_CategoryButtons) do
        if data[i] then
            v:Show()
            v.text:SetText(data[i].name)
            v.miniButton:Show()
            v.miniButton.tooltip = data[i].name
            if data[i].icon then
                v.miniButton:SetNormalTexture("Interface\\Icons\\"..data[i].icon)
                if S.DoSkinning() then
                    S.AS:SkinTexture(v.miniButton:GetNormalTexture(), true)
                end
            else
                v.miniButton:SetNormalTexture("Interface\\Icons\\inv_misc_questionmark")
                if S.DoSkinning() then
                    S.AS:SkinTexture(v.miniButton:GetNormalTexture(), true)
                end
            end
        else
            v:Hide()
            v.miniButton:Hide()
        end
    end
    if S.DoSkinning() then
        self:SetHeight(#data * 21 + 12)
    else
        self:SetHeight(#data * 21 + 14)
    end
    SortedFrameMiniFilterButtons:SetHeight(#data * 32 + 32)
    SortedFrame_UpdateMinSize()
    Sorted_UpdateBagContents()
    Sorted_SortItems()
end



-- SUBCATEGORY FRAME
function SortedSubcategoryFrame_OnLoad(self)
    local spaces = 0
    local y = 4
    self.checkButtons = {}
    self.fontStrings = {}
    self.noneSelected = true
    self:Hide()
    self.Update = SortedSubcategoryFrame_Update

    local scrollParent = self:GetParent()

    scrollParent.scrollBar = CreateFrame("Slider", scrollParent:GetName().."ScrollBar", scrollParent, "MinimalScrollBarTemplate")
    scrollParent.scrollBar.trackBG:Hide()
    scrollParent.scrollBar:SetPoint("TOPRIGHT", 1, -18)
    scrollParent.scrollBar:SetPoint("BOTTOM", 0, 16)
    scrollParent.scrollBar:SetMinMaxValues(1, 1)
    scrollParent.scrollBar:SetValueStep(1)
    scrollParent.scrollBar.scrollStep = 16
    scrollParent.scrollBar:SetValue(0)
    scrollParent:SetScrollChild(_G["SortedSubcategoryFrameScrollChild"])

    scrollParent:EnableMouseWheel(1)
    scrollParent:SetScript("OnMouseWheel", function(self, delta)
        self.scrollBar:SetValue(self.scrollBar:GetValue() - delta * 30)
    end)
end

function SortedSubcategoryFrame_GetOptions()
    return SortedSubcategoryFrameScrollChild.options
end

local function CheckBoxOnClick(self)
    local options = SortedSubcategoryFrameScrollChild.options
    options[self.filterGroup][self.filter][self.optionGroup][self.option] = self:GetChecked()
    Sorted_FilterItems()
end
function SortedSubcategoryFrame_GetItem(self, row, type)
    local y = -13 - (row - 1) * 22

    if type == "CheckButton" then
        if not self.checkButtons[row] then
            local cb = CreateFrame("CheckButton", self:GetName().."CheckButton"..row, self, "SortedCheckButtonTemplate")
            cb:SetPoint("TOPLEFT", 4, y + 11)
            cb.clickable:SetPoint("RIGHT", self)
            cb.clickable:RegisterForClicks("LeftButtonUp")
            self.checkButtons[row] = cb

            cb.onShowAnim = cb:CreateAnimationGroup()
            local anim = cb.onShowAnim:CreateAnimation("Translation")
            anim:SetDuration(0)
            anim:SetOffset(0, 11 + row * 3)
            anim:SetOrder(1)
            anim = cb.onShowAnim:CreateAnimation("Alpha")
            anim:SetDuration(0.2 + row / 75)
            anim:SetFromAlpha(0)
            anim:SetToAlpha(1)
            anim:SetOrder(2)
            anim = cb.onShowAnim:CreateAnimation("Translation")
            anim:SetDuration(0.2 + row / 75)
            anim:SetOffset(0, -11 - row * 3)
            anim:SetSmoothing("OUT")
            anim:SetOrder(2)
            cb.onShowAnim:HookScript("OnFinished", function(self)
                if S.DoSkinning() then
                    _G[cb:GetName().."HighlightTexture"]:SetAlpha(0.5)
                end
                _G[cb:GetName().."PushedTexture"]:SetAlpha(0.5)
            end)
            cb:HookScript("OnShow", function(self) 
                if Sorted_GetSetting("animations") == 2 then
                    self.onShowAnim:Stop() 
                    self.onShowAnim:Play() 
                end
            end)
            if Sorted_GetSetting("animations") == 2 then
                cb.onShowAnim:Play() 
            end

            cb:HookScript("OnClick", CheckBoxOnClick)

            if S.DoSkinning() then
                S:SkinCheckBox(cb)
            end
        end
        return self.checkButtons[row]

    elseif type == "Header" then
        if not self.fontStrings[row] then
            local f = CreateFrame("Frame", nil, self)
            f:SetPoint("TOPLEFT", self, "TOPLEFT", 6, y + 11)
            f:SetPoint("BOTTOMRIGHT", self, "TOPLEFT", 6, y - 11)
            local fs = f:CreateFontString(self:GetName().."FontString"..row, "OVERLAY", "SortedButtonFont")
            fs:SetPoint("LEFT")

            f.onShowAnim = f:CreateAnimationGroup()
            local anim = f.onShowAnim:CreateAnimation("Translation")
            anim:SetDuration(0)
            anim:SetOffset(0, 11 + row * 3)
            anim:SetOrder(1)
            anim = f.onShowAnim:CreateAnimation("Alpha")
            anim:SetDuration(0.2 + row / 75)
            anim:SetFromAlpha(0)
            anim:SetToAlpha(1)
            anim:SetSmoothing("OUT")
            anim:SetOrder(2)
            anim = f.onShowAnim:CreateAnimation("Translation")
            anim:SetDuration(0.2 + row / 75)
            anim:SetOffset(0, -11 - row * 3)
            anim:SetSmoothing("OUT")
            anim:SetOrder(2)
            f:HookScript("OnShow", function(self) 
                if Sorted_GetSetting("animations") == 2 then
                    self.onShowAnim:Stop() 
                    self.onShowAnim:Play() 
                end
            end)
            if Sorted_GetSetting("animations") == 2 then
                f.onShowAnim:Play() 
            end

            self.fontStrings[row] = f
            f.text = fs
        end
        return self.fontStrings[row]
    end
end

function SortedSubcategoryFrame_Update()
    local self = SortedSubcategoryFrameScrollChild
    self.options = {}
    for _, cb in pairs(self.checkButtons) do 
        cb:Hide() 
        cb:SetChecked(false)
    end
    for _, fs in pairs(self.fontStrings) do fs:Hide() end

    if Sorted_SelectedCategory > 0 then
        self:Show()
        local data = Sorted_GetSetting("categories", Sorted_SelectedPlayerGUID)[Sorted_SelectedCategory]
        local i = 1
        if data and data.filterGroups then
            data = data.filterGroups
            for filterGroupID, filterGroup in pairs(data) do
                if filterGroup.filters then
                    self.options[filterGroupID] = {}

                    for filterID, filter in pairs(filterGroup.filters) do
                        self.options[filterGroupID][filterID] = {}

                        local optionCount = 0
                        if Sorted_filters[filterID].operator == "AND" or Sorted_filters[filterID].override then
                            optionCount = 2
                        end
                        for optionGroupID, optionGroup in pairs(filter.values) do
                            for _, option in pairs(optionGroup) do
                                optionCount = optionCount + 1
                            end
                        end

                        if optionCount > 1 then
                            local head = SortedSubcategoryFrame_GetItem(self, i, "Header")
                            head.text:SetText(Sorted_filters[filterID].name)
                            head:Show()
                            i = i + 1
                        end

                        for optionGroupID, optionGroup in pairs(filter.values) do
                            self.options[filterGroupID][filterID][optionGroupID] = {}

                            for optionID, option in pairs(optionGroup) do
                                if Sorted_filters[filterID].startChecked then
                                    self.options[filterGroupID][filterID][optionGroupID][optionID] = true
                                else
                                    self.options[filterGroupID][filterID][optionGroupID][optionID] = false
                                end
                                
                                if optionCount > 1 then
                                    local cb = SortedSubcategoryFrame_GetItem(self, i, "CheckButton")
                                    if Sorted_filters[filterID].optionGroups[optionGroupID].type == "LIST" then
                                        cb.text:SetText(option)
                                    elseif Sorted_filters[filterID].optionGroups[optionGroupID].type == "IDLIST" then
                                        if option.name then
                                            cb.text:SetText(option.name)
                                        else
                                            cb.text:SetText("#"..option.id)
                                        end
                                    elseif Sorted_filters[filterID].optionGroups[optionGroupID].options[optionID].type == "RANGE" then
                                        local min = option.min
                                        local max = option.max
                                        local name = Sorted_filters[filterID].optionGroups[optionGroupID].options[optionID].name
                                        if not min then
                                            cb.text:SetText(name.." (<"..max..")")
                                        elseif not max then
                                            cb.text:SetText(name.." (>"..min..")")
                                        else
                                            cb.text:SetText(name.." ("..min.."-"..max..")")
                                        end
                                    else
                                        cb.text:SetText(Sorted_filters[filterID].optionGroups[optionGroupID].options[optionID].name)
                                    end
                                    cb.filterGroup = filterGroupID
                                    cb.filter = filterID
                                    cb.optionGroup = optionGroupID
                                    cb.option = optionID
                                    cb:Show()
                                    if Sorted_filters[filterID].startChecked then
                                        cb:SetChecked(true)
                                    end
                                    i = i + 1
                                end
                            end
                        end
                    end
                end
            end
            self:SetHeight(i * 22 - 12)
        end
    end
end