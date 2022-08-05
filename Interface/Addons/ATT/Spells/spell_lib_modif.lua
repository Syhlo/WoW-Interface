local addon, ATTdbs = ...

ATTdbs.cooldownResetters = {
   [235219] = { -- Cold Snap
      [120] = 1, 		-- Cone of Cold
      [45438] = 1,  	-- Ice Block
      [122] = 1, 		-- Frost Nova
      [11426] = 1,
   },
   [200183] = { -- 2
      [88625] = 1,
      [34861] = 1,
      [2050] = 1,
   },
   [327193] = { -- 3
      [31935] = 1,
   },
   [310454] = { -- 4
      [121253] = 1,
   },
}


ATTdbs.dbModif = {
   [2050] = {["mod"]= 235587, ["cooldown"] = 6 }, -- 15 hpriest
   [62618] = {["mod"]= 197590, ["cooldown"] = 90 }, -- 90
   [275699] = {["mod"]= 288848, ["cooldown"] = 45 }, -- 45
   [47568] = {["mod"]= 233394, ["x"] = true , ["cooldown"] = .50 }, --50%
   [49028] = {["mod"]= 233412, ["x"] = true , ["cooldown"] = .75 }, --50%
   [48707] = {["mod"]= 205727, ["cooldown"] = 20 },-- 20
   [108199] = {["mod"]= 206970, ["cooldown"] = 30 }, -- 30
   [200166] = {["mod"]= 235893, ["cooldown"] = 120 }, -- 120 dh old
   [179057] = {["mod"]= 206477, ["cooldown"] = 20 }, -- 20
   [207684] = {["mod"]= 209281, ["x"] = true , ["cooldown"] = .80 }, -- 20% 1
   [202137] = {["mod"]= 209281, ["x"] = true , ["cooldown"] = .80 }, -- 20% 2
   [204596] = {["mod"]= 209281, ["x"] = true , ["cooldown"] = .80 }, -- 20% 3
   [186257] = {["mod"]= 203235, ["x"] = true , ["cooldown"] = .50 }, -- 50% 4
   [202138] = {["mod"]= 211489, ["x"] = true , ["cooldown"] = .75 }, -- 25%
   [22812] = {["mod"]= 203965, ["x"] = true , ["cooldown"] = .66 }, -- 33%
   [61336] = {["mod"]= 203965, ["x"] = true , ["cooldown"] = .66 }, -- 33%
   [186289] = {["mod"]= 266921, ["x"] = true , ["cooldown"] = .80 }, -- 20%
   [186265] = {["mod"]= 266921, ["x"] = true , ["cooldown"] = .80 }, -- 20%
   [288613] = {["mod"]= 203129, ["cooldown"] = 20 }, -- 20
   [110960] = {["mod"]= 210476, ["cooldown"] = 45 }, -- 45
   [109132] = {["mod"]= 115173, ["cooldown"] = 5 }, -- 5
   [119381] = {["mod"]= 264348, ["cooldown"] = 10 }, -- 10
   [116849] = {["mod"]= 202424, ["cooldown"] = 45 }, -- 25
   [115203] = {["mod"]= 202107, ["x"] = true , ["cooldown"] = .50 }, -- 50%
   [115176] = {["mod"]= 202200, ["x"] = true , ["cooldown"] = .25 }, -- 75%
   [642] = {["mod"]= 114154, ["x"] = true , ["cooldown"] = .70 }, -- 30%
   [498] = {["mod"]= 114154, ["x"] = true , ["cooldown"] = .70 }, -- 30%
   [633] = {["mod"]= 114154, ["x"] = true , ["cooldown"] = .70 }, -- 30%
   [184662] = {["mod"]= 114154, ["x"] = true , ["cooldown"] = .70 }, -- 30%
   [31850] = {["mod"]= 114154, ["x"] = true , ["cooldown"] = .70 }, -- 30%
   [204018] = {["mod"]= 216853, ["x"] = true , ["cooldown"] = .66 }, -- 33%
   [1022] = {["mod"]= 216853, ["x"] = true , ["cooldown"] = .66 }, --  33%
   [6940] = {["mod"]= 216853, ["x"] = true , ["cooldown"] = .66 }, --  33%
   [8122] = {["mod"]= 196704, ["cooldown"] = 30 }, -- 30
   [15487] = {["mod"]= 263716, ["cooldown"] = 15 }, -- 15
   [15286] = {["mod"]= 199855, ["cooldown"] = 45 }, -- 45
   [47585] = {["mod"]= 288733, ["cooldown"] = 30 }, -- 30
   [195457] = {["mod"]= 256188, ["cooldown"] = 15 }, -- 15
   [2094] = {["mod"]= 256165, ["cooldown"] = 30 }, -- 30
   [51490] = {["mod"]= 204403, ["cooldown"] = 15 }, -- 15
   [51533] = {["mod"]= 262624, ["cooldown"] = 30 }, -- 30
   [51514] = {["mod"]= 204268, ["cooldown"] = 20 }, -- 20
   [79206] = {["mod"]= 192088, ["cooldown"] = 60 }, -- 60
   [30283] = {["mod"]= 264874, ["cooldown"] = 15 }, -- 15
   [227847] = {["mod"]= 236308, ["x"] = true , ["cooldown"] = .66 }, -- 33%
   [97462] = {["mod"]= 235941, ["cooldown"] = 60 }, -- 120
   [1160] = {["mod"]= 199023, ["cooldown"] = 15 }, -- 15
   [6544] = {["mod"]= 202163, ["cooldown"] = 15 }, -- 15
   [740] = {["mod"]= 197073, ["cooldown"] = 60 }, -- 60
   [235450] = {["mod"]= 235463, ["cooldown"] = 0 }, -- 0
   [108853] = {["mod"]= 205029, ["cooldown"] = 2 }, -- 2
   --[217832] = {["mod"]= 205596, ["cooldown"] = -15 }, -- +15 dh old
--   [119996] = {["mod"]= 353584, ["cooldown"] = 15 }, -- -15 on stun
   [196770] = {["mod"]= 287250, ["cooldown"] = -25 }, -- +25
   [191427] = {["mod"]= 235893, ["cooldown"] = 120 }, --dh meta 120
   [205180] = {["mod"]= 334183, ["cooldown"] = 60 }, --affli talent 60
   [342246] = {["mod"]= 342249, ["cooldown"] = 30 }, --mage talent 30 -- arcane alter
   -- 9.1
   [32375] = {["mod"]= 341167, ["cooldown"] = 30 }, --Improved Mass Dispel
   [115310] = {["mod"]= 353313, ["cooldown"] = 90 }, -- Peaceweaver
   [20473] = {["mod"]= 196926, ["cooldown"] = 1 }, -- Holy Shock 
   [77761] = {["mod"]= 213200, ["cooldown"] = 60 }, -- stampede roar 
   [108280] = {["mod"]= 353115, ["cooldown"] = 90 }, -- healing tide
   [1856] = {["mod"]= 354825, ["xx"] = true, ["cooldown"] = 40 }, -- 
   [1966] = {["mod"]= 354825, ["xx"] = true, ["cooldown"] = 5 }, -- 
   [121471] = {["mod"]= 354825, ["xx"] = true, ["cooldown"] = 60 }, -- 

 --  [191034] = {["mod"]= 202354, ["cooldown"] = 12 }, -- Stellar Drift
-- 353584 monk if its stun 15 sec
}

ATTdbs.dbModif2 = {
   [207684] = {["mod"]= 211489, ["x"] = true , ["cooldown"] = .75 }, -- 25% 1
   [202137] = {["mod"]= 211489, ["x"] = true , ["cooldown"] = .75 }, -- 25% 2
   [204596] = {["mod"]= 211489, ["x"] = true , ["cooldown"] = .75 }, -- 25% 3
   [186257] = {["mod"]= 266921, ["x"] = true , ["cooldown"] = .80 }, -- 20% 4
}

ATTdbs.lockPetChange = {
   [688] = 135791,
   [691] = 136174,
   [712] = 1717715,
   [697] = 136121,
   [30146] = 236316,
   [GetSpellInfo(688)] = 135791,
   [GetSpellInfo(691)] = 136174,
   [GetSpellInfo(712)] = 1717715,
   [GetSpellInfo(697)] = 136121,
   [GetSpellInfo(30146)] = 236316,
}

ATTdbs.dbLegeModif = {
   --legendary modif
   -- [7000] = { ["ability"] = 339348, ["mod"]= {[1]= 114052}, ["cooldown"] = 120 }, --test 7103
      
      [32379] = {["ability"] = 336133, ["cooldown"] = 12, ["lege"] = 6979 },
      [279302] = {["ability"] = 334692, ["cooldown"] = 90, ["lege"] = 6946},
      [195072] = {["ability"] = 337685,["cooldown"] = 28, ["lege"] = 7051},
      [49576] = {["ability"] = 334724, ["cooldown"] = 3, ["lege"] = 6948},
      [106951] = {["ability"] = 339062, ["cooldown"] = 30, ["lege"] = 7095},
      [288613] = {["ability"] = 336742, ["cooldown"] = 36, ["lege"] = 7003},
      [266779] = {["ability"] = 336742, ["cooldown"] = 36, ["lege"] = 7003 },
      [5384] = {["ability"] = 336747, ["cooldown"] = 15, ["lege"] = 7006}, --pvp 5
      [115080] = {["ability"] = 337296, ["cooldown"] = 120, ["lege"] = 7081},
      [340053] = {["ability"] = 340053, ["cooldown"] = 0, ["lege"] = 7109},
      [323764] = { ["ability"] = 354118, ["cooldown"] = 30, ["lege"] = 7571},
         --   [108271] = { ["ability"] = 354118, ["cooldown"] = 30, ["lege"] = 6986}, --test
}

ATTdbs.dbLegeReduce = {
   --legendary reduce
   [106785] ={ ["mod"]= {[1]= 106951,[2]=102543,}, ["lege"] = 7109,  ["cooldown"] = .3 },
   [106830] ={ ["mod"]= {[1]= 106951,[2]=102543,}, ["lege"] = 7109,  ["cooldown"] = .3 },
   [5221] ={ ["mod"]= {[1]= 106951,[2]=102543,}, ["lege"] = 7109,  ["cooldown"] = .3 },
   [1822] ={ ["mod"]= {[1]= 106951,[2]=102543,}, ["lege"] = 7109,  ["cooldown"] = .3 },
   [202028] ={ ["mod"]= {[1]= 106951,[2]=102543,}, ["lege"] = 7109,  ["cooldown"] = .3 },
   [274837] ={ ["mod"]= {[1]= 106951,[2]=102543,}, ["lege"] = 7109,  ["cooldown"] = .3 },
   [204883] ={ ["mod"]= {[1]= 34861,}, ["lege"] = 6977,  ["cooldown"] = 4 },
   [33076] ={ ["mod"]= {[1]= 2050,}, ["lege"] = 6977,  ["cooldown"] = 4 },
   [14914] ={ ["mod"]= {[1]= 88625,}, ["lege"] = 6977,  ["cooldown"] = 4 },
   
   [328928] ={ ["mod"]= {[1]= 198067,[2]=192249,[3]=51533,[4]=108280,}, ["lege"] = 7708,  ["cooldown"] = 7 },
   [314793] ={ ["mod"]= {[1]= 314793}, ["lege"] = 7476,  ["cooldown"] = 45 },
   [326860] ={ ["mod"]= {[1]= 326860}, ["lege"] = 7726,  ["cooldown"] = 3 },

   
   [70] ={ ["mod"]= {[1]= 1022,[2]=204018,[3]=6940,[4]=199452,[5]=1044}, ["lege"] = 7053,  ["cooldown"] = 1 },
   [65] ={ ["mod"]= {[1]= 1022,[2]=204018,[3]=6940,[4]=199452,[5]=1044}, ["lege"] = 7053,  ["cooldown"] = 1 },
   [66] ={ ["mod"]= {[1]= 1022,[2]=204018,[3]=6940,[4]=199452,[5]=1044}, ["lege"] = 7053,  ["cooldown"] = 1 },
}

ATTdbs.dbConduitMod = {
   [320658]= { ["mod"] = {310143}, ["rank"] ={15},  ["class"]= 0,} ,
   [336147]= { ["mod"] = {300728}, ["rank"] ={-30},  ["class"]= 0,},
   [339939]= { ["mod"] = {325886}, ["rank"] ={15} , ["class"]=1, },
   [334993]= { ["mod"] = {118038,871}, ["rank"] ={20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52}, ["class"]= 1, },
   [339948]= { ["mod"] = {46968, 12323}, ["rank"] ={5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13},  ["class"]= 1, },
   [338741]= { ["mod"] = {338741}, ["rank"] = {48.0, 46.0, 44.0, 42.0, 40.0, 38.0, 36.0, 34.0, 32.0, 30.0, 28.0, 26.0, 24.0, 22.0, 20.0, 18.0, 16.0},  ["class"]= 2, },
   [340030]= { ["mod"] = {86659}, ["rank"] ={15.0, 16.5, 18.0, 19.5, 21.0, 22.5, 24.0, 25.5, 27.0, 28.5, 30.0, 31.5, 33.0, 34.5, 36.0, 37.5, 39.0},  ["class"]= 2, },--
   [340028]= { ["mod"] = {317009}, ["rank"] ={5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0, 10.5, 11.0, 11.5, 12.0, 12.5 , 13.0},  ["class"]= 3, },
   [339377]= { ["mod"] = {186265}, ["rank"] ={10, 11.5, 13, 14.5, 16, 17.5, 19, 20.5, 23, 24.5, 26, 27.5, 29, 30.5, 32, 33.5, 35}, ["class"]= 3,},
   [339558]= { ["mod"] = {186257}, ["rank"] ={16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0}, ["class"]= 3, },
   [341535]= { ["mod"] = {341535}, ["rank"] = {2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.2, 3.4, 3.6, 3.8, 4.0, 4.2, 4.4, 4.6, 4.8, 5, 5.2},  ["class"]= 4,},
   [341531]= { ["mod"] = {193549,195457}, ["rank"] ={.90}, ["x"] = true,  ["class"]= 4,},
   [337678]= { ["mod"] = {73325}, ["rank"] ={20.0, 22.0, 24.0, 26.0, 28.0, 30.0, 32.0, 34.0, 36.0, 38.0, 40.0, 42.0, 44.0, 46.0, 48.0, 50.0, 52.0}, ["class"]= 5, },
   [337762]= { ["mod"] = {10060}, ["rank"] ={6.0, 6.6, 7.2, 7.8, 8.4, 9.0, 9.6, 10.2, 10.8, 11.4, 12.0, 12.6, 13.2, 13.8, 14.4, 15.0, 15.6},  ["class"]= 5,},
   [337704]= { ["mod"] = {48792}, ["rank"] ={20.0, 22.0, 24.0, 26.0, 28.0, 30.0, 32.0, 34.0, 36.0, 38.0, 40.0, 42.0, 44.0, 46.0, 48.0, 50.0, 52.0},  ["class"]= 6, },
   [339183]= { ["mod"] = {328928}, ["rank"] ={25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0},  ["class"]= 7,},
   [337964]= { ["mod"] = {20608}, ["rank"] ={180, 210, 240, 270, 300, 330, 360, 390, 420, 450, 480, 510, 540, 570, 600, 630, 660},  ["class"]= 7, },
   [338042]= { ["mod"] = {8143 , 2484, 192058}, ["rank"] ={1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17}, ["class"]= 7,},--
   [336613]= { ["mod"] = {45438}, ["rank"] ={25, 28, 30, 33, 35, 38, 40, 43, 45, 48, 50, 53, 55, 58, 60, 62, 64},  ["class"]= 8, },
   [336636]= { ["mod"] = {1953}, ["rank"] ={2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.2, 3.4, 3.6, 3.8, 4.0, 4.2, 4.4, 4.6, 4.8, 5.0, 5.2},  ["class"]= 8,},
   [336777]= { ["mod"] = {336777}, ["rank"] = {2.5, 2.8, 3.0, 3.3, 3.5, 3.8, 4.0, 4.3, 4.5, 4.8, 5.0, 5.3, 5.5, 5.8, 6.0, 6.3, 6.5},  ["class"]= 8,},
   [336992]= { ["mod"] = {336992}, ["rank"] = {1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6},  ["class"]= 8,},
   [339130]= { ["mod"] = {333889}, ["rank"] ={48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96},  ["class"]= 9, },
   [339272]= { ["mod"] = {339272}, ["rank"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16},  ["class"]= 9, },
   [340529] = { ["mod"]= {22812}, ["rank"] ={.90, .89, .88, .87, .86, .85, .84, .83, .82, .81, .80, .79, .78, .77, .76, .75, .74}, ["x"] = true,  ["class"]= 11, }, --%
   [340550] = {  ["mod"]= {132158}, ["rank"] ={.90, .89, .88, .87, .86, .85, .84, .83, .82, .81, .80, .79, .78, .77, .76, .75, .74}, ["x"] = true,  ["class"]= 11, },
   [341451] = { ["mod"] = {319454,102359,5211}, ["rank"] ={.90, .89, .88, .87, .86, .85, .84, .83, .82, .81, .80, .79, .78, .77, .76, .75, .74}, ["x"] = true,  ["class"]= 11, },
   [341378] = { ["mod"] = {326647}, ["rank"] ={.90, .89, .88, .87, .86, .85, .84, .83, .82, .81, .80, .79, .78, .77, .76, .75, .74}, ["x"] = true,  ["class"]= 11,},
   [338671] = { ["mod"] = {198589, 204021}, ["rank"] ={5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 22, 24}, ["class"]= 12, },
   [338345] = { ["mod"] = {338345},  ["rank"] ={0.06, 0.088, 0.096, 0.104, 0.112, 0.120, 0.128, 0.136, 0.144, 0.152, 0.160, 0.168, 0.176, 0.184, 0.192, 0.200, 0.208} ,["class"]= 5 },
   --[336522] = { ["mod"] = {12472}, ["rank"] = {0.75, 0.83, 0.90, 0.98, 1.05, 1.13, 1.20, 1.28, 1.35, 1.43, 1.50, 1.58, 1.65, 1.73, 1.80}, ["class"]= 10}, --icy
   	[336773] = { ["mod"] = {336773},  ["rank"] = {0.3} ,["class"]= 10 },
   	[337295] = { ["mod"] = {337295},  ["rank"] = {0.5} ,["class"]= 10 }, --to do
   	 -- [352188] = { ["mod"] = {352188},  ["rank"] = {4} ,["class"]= 10 }, --to do
   	--  [352415] = { ["mod"] = {352415},  ["rank"] = {50%} ,["class"]= 10 }, --to do
   [338553] = { ["mod"] = {338553},  ["rank"] = {0.5, 0.6, 0.6, 0.7, 0.7, 0.8, 0.8, 0.9, 0.9, 1.0, 1.0, 1.1, 1.1, 1.2, 1.2} ,["class"]= 6 }, --DK
}

ATTdbs.dbConduitModX = {
   [193549] = true,
   [195457] = true,
   [22812] = true,
   [132158] = true,
   [319454] = true,
   [102359] = true,
   [5211] = true,
   [326647] = true,
}

ATTdbs.dbReduce = {   
   [288613] = { ["mod"]= {[1]= 257044}, ["tid2"] = 1, ["rcooldown2"] = 12 }, --rel cd
   [257044] = { ["mod"]= {[1]= 257044}, ["tid2"] = 1, ["rcooldown2"] = 14 }, --rel cd
   [50334] =  {["mod"]= {[1]= 22842}, ["tid2"] = 1, ["rcooldown2"] = 14 }, --rel cd
   [22842] = { ["mod"]= {[1]= 22842}, ["tid2"] = 1, ["rcooldown2"] = 14 }, --rel cd
   [275773] = { ["mod"]= {[1]= 853}, ["tid"] = 198054, ["rcooldown"] = 10 },
   [275779] =  { ["mod"]= {[1]= 853}, ["tid"] = 198054, ["rcooldown"] = 6 },
   [47541] =  { ["mod"]= {[1]= 275699,[2]=63560,[3]=42650}, ["tid"] = 276837, ["rcooldown"] = 1 }, --["rcooldown"] = 5 },
   [207317] = { ["mod"]= {[1]= 275699,[2]=63560,[3]=42650}, ["tid"] = 276837, ["rcooldown"] = 1 }, --["rcooldown"] = 5 },
   [185358] =  { ["mod"]= {[1]= 288613}, ["tid"] = 260404, ["rcooldown"] = 2.5 },
   [257620] = { ["mod"]= {[1]= 288613}, ["tid"] = 260404, ["rcooldown"] = 2.5 },
   [193455] = { ["mod"]= {[1]= 19574}, ["tid"] = 257891, ["rcooldown"] = 1 },
   [217200] = { ["mod"]= {[1]= 19574}, ["tid2"] = 1, ["rcooldown2"] = 12 },
   [2050] = { ["mod"]= {[1]= 265202}, ["tid2"] = 1, ["rcooldown2"] = 30 },
   [34861] = { ["mod"]= {[1]= 265202}, ["tid2"] = 1, ["rcooldown2"] = 30 },
   [585] = { ["mod"]= {[1]= 88625}, ["tid"] = 196985, ["rcooldown"] = 5.32, ["tid2"] = 1, ["rcooldown2"] = 4 },
   [139] = { ["mod"]= {[1]= 34861}, ["tid"] = 196985, ["rcooldown"] = 2.66, ["tid2"] = 1, ["rcooldown2"] = 2 },
   [596] = { ["mod"]= {[1]= 34861}, ["tid"] = 196985, ["rcooldown"] = 8, ["tid2"] = 1, ["rcooldown2"] = 6 },
   [2060] = { ["mod"]= {[1]= 2050}, ["tid"] = 196985, ["rcooldown"] = 8, ["tid2"] = 1, ["rcooldown2"] = 6 },
   [2061] = { ["mod"]= {[1]= 2050}, ["tid"] = 196985, ["rcooldown"] = 8, ["tid2"] = 1, ["rcooldown2"] = 6 },
   [133] = { ["mod"]= {[1]= 190319}, ["tid"] = 203283,  ["rcooldown"] = 2, },
   -- [32546] = { ["mod"]= {[1]=2050,[2]=34861}, ["tid"] = 32546, ["rcooldown"] = 3 }, --removed
   [19434] = { ["mod"]= {[1]=186265,[2]=109304}, ["tid"] = 248443, ["rcooldown"] = 5 },
   -- { ["ability"] = 53600, ["mod"]= {[1]=31884,[2]=184092}, ["tid"] = 204074, ["rcooldown"] = 1 }, --fix protpala
   --205411

   --merge fix
   [6358] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 30 , ["merge"] = true, },
   [19647] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 24 , ["merge"] = true },
   [119907] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 120 , ["merge"] = true, }, --sb
   [119910] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 24 , ["merge"] = true,},
   [261589] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 30 , ["merge"] = true,},
   [89808] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 15 , ["merge"] = true,},
   [119905] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 15 , ["merge"] = true,},
   [132411] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 15 , ["merge"] = true,},
   [89766] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 30 , ["merge"] = true,},
   [119914] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 30 , ["merge"] = true,},
   [132409] = { ["mod"]= {[1]= 119898}, ["tid2"] = 1, ["rcooldown2"] = 24 , ["merge"] = true,},
   [204362] = { ["mod"]= {[1]= 193876}, ["tid2"] = 1, ["rcooldown2"] = 60 , ["merge"] = true,},
   [204361] = { ["mod"]= {[1]= 193876}, ["tid2"] = 1, ["rcooldown2"] = 60 , ["merge"] = true,},
   [30449] = { ["mod"]= {[1]= 198100}, ["tid2"] = 1, ["rcooldown2"] = 30 , ["merge"] = true,},

}

ATTdbs.dbReducePower = {
   [70] = {  ["mod"]= {[1]= 853}, ["tid"] = 234299, ["crd"] = 2 },
   [65] = {  ["mod"]= {[1]= 853}, ["tid"] = 234299, ["crd"] = 2 }, -- new hpala
   [66] = {  ["mod"]= {[1]= 853}, ["tid"] = 234299, ["crd"] = 2 }, -- prot
   [253] = { ["mod"]= {[1]= 109304}, ["tid"] = 270581, ["crd"] = 30 },
   [254] = { ["mod"]= {[1]= 109304}, ["tid"] = 270581, ["crd"] = 20 },
   [255] = { ["mod"]= {[1]= 109304}, ["tid"] = 270581, ["crd"] = 20 },
   [269] = { ["mod"]= {[1]= 137639}, ["tid"] = 280197, ["crd"] = 2 },
   [261] = { ["mod"]= {[1]= 185313}, ["tid"] = 238104, ["crd"] = 1.5 , ["tid2"] = 1 , ["crd2"] = 1}, --sub
   [260] = { ["mod"]= {[1]=315341,[2]=13750,[3]=195457,[4]=51690,[5]=2983,[6]=1856,[7]=137619,[8]=5277,[9]=1966, [10] = 13877, [11] = 315508, [12] = 271877}, ["tid2"] = 1, ["crd2"] = 1 }, --out
   [71] = { ["mod"]= {[1]=262161,[2]=167105,[3]=227847}, ["tid"] = 152278,  ["crd"] = 20 },
   [72] = { ["mod"]= {[1]=1719}, ["tid"] = 152278,  ["crd"] = 20 },
   [73] = {  ["mod"]= {[1]=107574,[2]=871}, ["tid"] = 152278, ["crd"] = 10 },
   [250] = {  ["mod"]= {[1]= 55233}, ["tid"] = 205723,  ["crd"] = 10 }, -- dk blood --tofix
}


ATTdbs.dbReducePowerSpell = {
   --holy power
   [53600]  = 3,
   [53385]  = 3,
   [85222]  = 3,
   [85256]  = 3,
   [85673]  = 3,
   [343527] = 3,
   [152262] = 3,
   [215661] = 5,
   --focus
   [982]    = 35,
   [1513]   = 25,
   [2643]   = 40,
   [19434]  = 40,
   [34026]  = 30,
   [53351]  = 10,
   [120360] = 60,
   --	[120679] = ,
   [131894] = 30,
   [185358] = 40,
   [186270] = 30,
   [186387] = 10,
   [187708] = 35,
   [193455] = 35,
   [195645] = 30,
   [203155] = 40,
   [205691] = 60,
   [208652] = 30,
   [212431] = 20,
   [212436] = 30,
   [257620] = 20,
   [259387] = 30,
   [259391] = 15,
   [259491] = 20,
   [271788] = 10,
   [342049] = 20,
   --chi
   [100784] = 3,
   [107428] = 2,
   [101546] = 2,
   [113656] = 3,
   [116847] = 1,
   --rage
   [772]    = 30,
   [1464]   = 20,
   [1680]   = 30,
   [1715]   = 10,
   [2565]   = 30,
   [6572]   = 20,
   [12294]  = 30,
   [163201] = 40, --
   [184367] = 80,
   [190456] = 40,
   [202168] = 10,
   [330334] = 30,
   --runes
   [47541]  = 40,
   [49998]  = 45,
   [61999]  = 30,
   [327574] = 20,
   --combopoints rogue
   [408] = 5,
   [1943] = 5,
   [196819] = 5,
   [280719] = 5,
   [315341] = 5,
   [315496] = 5,
   [319175] = 5,
   --combopoints feral
   [1079] = 5,
   [22568] = 5,
   [202031] = 5,
   [22570] = 5,
   -- fury
   [198013] = 30,
   [162794] = 40,
   [188499] = 35,
   [179057] = 30,
}

ATTdbs.dbModifCrit = { --mage (Kindling)
   [108853]  ={["mod"]= {[1]= 190319},  ["tid"] = 155148, ["cooldown"] = 1 },--
   [11366] = {["mod"]= {[1]= 190319},  ["tid"] = 155148, ["cooldown"] = 1 },--
   [133] = {["mod"]= {[1]= 190319},  ["tid"] = 155148, ["cooldown"] = 1 }, --
}

ATTdbs.dbModKick = {
   [93985]  ={["mod"]= {[1]= 61336,[2]=5217,[3]=252216}, ["tid"] = 205673, ["cooldown"] = 10 },
   [2139] = {["mod"]= {[1]= 2139}, ["tid"] = 336777, ["cooldown"] = 4}, --rank 6
   [1766] = {["mod"]= {[1]= 31224}, ["tid"] = 341535, ["cooldown"] = 4},
}

ATTdbs.dbModifCharge = {
   [122] = 205036, --
   [109132] = 115173,
   [190784] = 230332, --
   [185313] = 238104, --
   [100] = 103827, --
   [7384] = 262150, --
   [275779] = 204023, --
   [259489] = 269737, --
   [259495] = 264332, --
   [51505] = 108283, --
   [5394] = 108283, --
   [61295] = 108283, --
   [108853] = 205029, --
   -- new
   [53351] = 321460, --
   [185123] = 203556, -- new dh
   -- pvp ?
   [2050] = 235587,
   [527] = 196162,
   [1044] = 199454,
   [1022] = 199454,
   [48265] = 356367,
   [43265] = 356367,
   [49576] = 356367,
}

ATTdbs.dbReplace = {
   [1022] ={ ["mod"]= 204018 },
   [31884] ={ ["mod"]= 216331, ["mod2"]= 231895 },
   [48792] ={ ["mod"]= 287081 },
   [42650] ={ ["mod"]= 288853 },
   [194223] ={ ["mod"]= 102560 },
   [106951] ={ ["mod"]= 102543 },
   [1850] ={ ["mod"]= 252216	 },
   [34477] ={ ["mod"]= 248518 },
   [12472] ={ ["mod"]= 198144 },
   [1953] ={ ["mod"]= 212653 },
   [33395] ={ ["mod"]= 205024 },
   [137639] ={ ["mod"]= 152173 },
   [109132] ={ ["mod"]= 115008 },
   [8122] ={ ["mod"]= 205369 },
   [62618] ={ ["mod"]= 271466 }, --["mod2"]= 197590
   [5384] ={ ["mod"]= 202748 },
   [108271] ={ ["mod"]= 210918 },
   [80240] ={ ["mod"]= 200546 },
   [227847] ={ ["mod"]= 152277 },
   [167105] ={ ["mod"]= 262161 },
   [23920] ={ ["mod"]= 213915 },
   -- [192249] ={ ["mod"]= 198067 },
   [198067] ={ ["mod"]= 192249 },
   [586] ={ ["mod"]= 213602 },
   [86659] ={ ["mod"]= 228049 },
   [32182] ={ ["mod"]= 193876 },
   [2825] ={ ["mod"]= 193876 },
}

ATTdbs.dbAuraRemoved = {
   [5215]   = true,
   [34477]  = true,
   [328774] = true,
   [256948] = true,
   [248518] = true,
   [215652] = true,
   [210918] = true,
   [210294] = true, --
   [209785] = true,
   [209584] = true,
   [205025] = true,
   [202425] = true,
   [199483] = true,
   [198817] = true,
   [188501] = true,
   [132158] = true,
   [116680] = true,
   }

ATTdbs.dbAuraApplied = {
   [65116] = true,
   [273104] = true,
   [336139] = true, -- ad
   [195901] = true, -- ad
   [31616] = true, -- nat
   [87024] = true, --cau
   [20594] = true, --stone ?
   [7744] = true,
   [342246] = true, --alter
   [323436] = true, -- conv
   [110909] = true, -- alter2?
   --110909 , 342246 alter?
}

ATTdbs.dbCovFix = {
   [324739] = 323436,
   [300728] = 317320,
}

ATTdbs.RecoverySpells = {
   [740]    = true,
   [1122]   = true,
   [1719]   = true,
   [12042]  = true,
   [12472]  = true,
   [13750]  = true,
   [31884]  = true,
   [42650]  = true,
   [47536]  = true,
   [47568]  = true,
   [50334]  = true,
   [51533]  = true,
   [55233]  = true,
   [64843]  = true,
   [79140]  = true,
   [102543] = true,
   [102558] = true,
   [102560] = true,
   [106951] = true,
   [107574] = true,
   [108280] = true,
   [115310] = true,
   [121471] = true,
   [132578] = true,
   [137639] = true,
   [152173] = true,
   [152277] = true,
   [187827] = true,
   [190319] = true,
   [192249] = true,
   [193530] = true,
   [194223] = true,
   [198067] = true,
   [200166] = true,
   [205180] = true,
   [216331] = true,
   [227847] = true,
   [228260] = true,
   [231895] = true,
   [265187] = true,
   [266779] = true,
   [288613] = true,
}

ATTdbs.isStun = {
		[408]     = true,
		[853]     = true,
		[1833]    = true,
		[5211]    = true,
		[20549]   = true,
		[22703]   = true,
		[24394]   = true,
		[30283]   = true,
		[46968]   = true,
		[64044]   = true,
		[89766]   = true,
		[91797]   = true,
		[91800]   = true,
		[108194]  = true,
		[118345]  = true,
		[118905]  = true,
		[119381]  = true,
		[132168]  = true,
		[132169]  = true,
		[145047]  = true,
		[163505]  = true,
		[171017]  = true,
		[171018]  = true,
		[179057]  = true,
		[199085]  = true,
		[200166]  = true,
		[200200]  = true,
		[202244]  = true,
		[202346]  = true,
		[203123]  = true,
		[205630]  = true,
		[208618]  = true,
		[210141]  = true,
		[211881]  = true,
		[213491]  = true,
		[213688]  = true,
		[221562]  = true,
		[245638]  = true,
		[255723]  = true,
		[255941]  = true,
		[280061]  = true,
		[287254]  = true,
		[287712]  = true,
		[305485]  = true,
		[325321]  = true,
		[332423]  = true,
		[334693]  = true,
}