local _, ADDON = ...

local locale = GetLocale()

ADDON.isMetric = false -- is the metric or imperial/us unit system used?
ADDON.L = {}
local L = ADDON.L

L["Black Market"] = "Black Market"
L["DRESSUP_LABEL"] = "Journal"
L["FAVOR_AUTO"] = "Auto-favor new mounts"
L["FAVOR_DISPLAYED"] = "All Displayed"
L["FAVOR_PER_CHARACTER"] = "Per Character"
L["FILTER_ONLY_LATEST"] = "Only latest additions"
L["FILTER_SECRET"] = "Hidden by the game"
L["Family"] = "Family"
L["Hidden"] = "Hidden"
L["Only tradable"] = "Only tradable"
L["Only usable"] = "Only usable"
L["Passenger"] = "Passenger"
L["ROTATE_DOWN"] = "Rotate Down"
L["ROTATE_UP"] = "Rotate Up"
L["Reset filters"] = "Reset filters"
L["SORT_BY_LAST_USAGE"] = "Last usage"
L["SORT_BY_LEARNED_DATE"] = "Date of receipt"
L["SORT_BY_TRAVEL_DISTANCE"] = "Travelled distance"
L["SORT_BY_TRAVEL_DURATION"] = "Travelled duration"
L["SORT_BY_USAGE_COUNT"] = "Count of usage"
L["SORT_FAVORITES_FIRST"] = "Favorites First"
L["SORT_REVERSE"] = "Reverse Sort"
L["SORT_UNOWNED_BOTTOM"] = "Unowned at Bottom"
L["SORT_UNUSABLE_BOTTOM"] = "Unusable after Usable"
L["STATS_TIP_LEARNED_DATE_HEAD"] = "Possession date"
L["STATS_TIP_RARITY_HEAD"] = "Rarity"
L["STATS_TIP_RARITY_TEXT"] = "% of characters who own this mount\nData is kindly provided by {RR}."
L["STATS_TIP_TRAVEL_DISTANCE_HEAD"] = "Travel distance"
L["STATS_TIP_TRAVEL_TIME_HEAD"] = "Travel time"
L["STATS_TIP_TRAVEL_TIME_TEXT"] = "in hours:minutes:seconds"
L["STATS_TIP_USAGE_COUNT_HEAD"] = "Usage count"
L["TASK_END"] = "[MJE] Phew! I'm done."
L["TASK_FAVOR_START"] = "[MJE] Reapplying stars all over your mounts. Please wait a few seconds until I'm finished."
L["TOGGLE_COLOR"] = "Show next color variation"
L["Transform"] = "Transform"

-- Families
L["Airplanes"] = "Airplanes"
L["Airships"] = "Airships"
L["Alpacas"] = "Alpacas"
L["Amphibian"] = "Amphibian"
L["Animite"] = "Animite"
L["Aqir Flyers"] = "Aqir Flyers"
L["Arachnids"] = "Arachnids"
L["Assault Wagons"] = "Assault Wagons"
L["Basilisks"] = "Basilisks"
L["Bats"] = "Bats"
L["Bears"] = "Bears"
L["Bees"] = "Bees"
L["Birds"] = "Birds"
L["Blood Ticks"] = "Blood Ticks"
L["Boars"] = "Boars"
L["Book"] = "Book"
L["Bovids"] = "Bovids"
L["Brutosaurs"] = "Brutosaurs"
L["Camels"] = "Camels"
L["Carnivorans"] = "Carnivorans"
L["Carpets"] = "Carpets"
L["Cats"] = "Cats"
L["Cervid"] = "Cervid"
L["Chargers"] = "Chargers"
L["Chickens"] = "Chickens"
L["Clefthooves"] = "Clefthooves"
L["Cloud Serpents"] = "Cloud Serpents"
L["Core Hounds"] = "Core Hounds"
L["Crabs"] = "Crabs"
L["Cranes"] = "Cranes"
L["Crawgs"] = "Crawgs"
L["Crocolisks"] = "Crocolisks"
L["Crows"] = "Crows"
L["Demonic Hounds"] = "Demonic Hounds"
L["Demonic Steeds"] = "Demonic Steeds"
L["Demons"] = "Demons"
L["Devourer"] = "Devourer"
L["Dinosaurs"] = "Dinosaurs"
L["Dire Wolves"] = "Dire Wolves"
L["Direhorns"] = "Direhorns"
L["Discs"] = "Discs"
L["Dragonhawks"] = "Dragonhawks"
L["Drakes"] = "Drakes"
L["Dread Ravens"] = "Dread Ravens"
L["Elekks"] = "Elekks"
L["Elementals"] = "Elementals"
L["Falcosaurs"] = "Falcosaurs"
L["Fathom Rays"] = "Fathom Rays"
L["Feathermanes"] = "Feathermanes"
L["Felsabers"] = "Felsabers"
L["Fish"] = "Fish"
L["Flies"] = "Flies"
L["Flying Steeds"] = "Flying Steeds"
L["Foxes"] = "Foxes"
L["Gargon"] = "Gargon"
L["Gargoyle"] = "Gargoyle"
L["Goats"] = "Goats"
L["Gorger"] = "Gorger"
L["Gorm"] = "Gorm"
L["Grand Drakes"] = "Grand Drakes"
L["Gronnlings"] = "Gronnlings"
L["Gryphons"] = "Gryphons"
L["Gyrocopters"] = "Gyrocopters"
L["Hands"] = "Hands"
L["Hawkstriders"] = "Hawkstriders"
L["Hippogryphs"] = "Hippogryphs"
L["Horned Steeds"] = "Horned Steeds"
L["Horses"] = "Horses"
L["Hounds"] = "Hounds"
L["Hovercraft"] = "Hovercraft"
L["Humanoids"] = "Humanoids"
L["Hyenas"] = "Hyenas"
L["Infernals"] = "Infernals"
L["Insects"] = "Insects"
L["Jellyfish"] = "Jellyfish"
L["Jet Aerial Units"] = "Jet Aerial Units"
L["Kites"] = "Kites"
L["Kodos"] = "Kodos"
L["Krolusks"] = "Krolusks"
L["Larion"] = "Larion"
L["Lions"] = "Lions"
L["Lupine"] = "Lupine"
L["Mammoths"] = "Mammoths"
L["Mana Rays"] = "Mana Rays"
L["Manasabers"] = "Manasabers"
L["Mauler"] = "Mauler"
L["Mechanical Animals"] = "Mechanical Animals"
L["Mechanical Birds"] = "Mechanical Birds"
L["Mechanical Cats"] = "Mechanical Cats"
L["Mechanical Steeds"] = "Mechanical Steeds"
L["Mechanostriders"] = "Mechanostriders"
L["Mecha-suits"] = "Mecha-suits"
L["Moose"] = "Moose"
L["Moth"] = "Moth"
L["Motorcycles"] = "Motorcycles"
L["Mountain Horses"] = "Mountain Horses"
L["Mushan"] = "Mushan"
L["Nether Drakes"] = "Nether Drakes"
L["Nether Rays"] = "Nether Rays"
L["N'Zoth Serpents"] = "N'Zoth Serpents"
L["Others"] = "Others"
L["Ox"] = "Ox"
L["Pandaren Phoenixes"] = "Pandaren Phoenixes"
L["Parrots"] = "Parrots"
L["Phoenixes"] = "Phoenixes"
L["Proto-Drakes"] = "Proto-Drakes"
L["Pterrordaxes"] = "Pterrordaxes"
L["Quilen"] = "Quilen"
L["Rams"] = "Rams"
L["Raptora"] = "Raptora"
L["Raptors"] = "Raptors"
L["Rats"] = "Rats"
L["Ravagers"] = "Ravagers"
L["Rays"] = "Rays"
L["Razorwing"] = "Razorwing"
L["Reptiles"] = "Reptiles"
L["Rhinos"] = "Rhinos"
L["Riverbeasts"] = "Riverbeasts"
L["Roc"] = "Roc"
L["Rockets"] = "Rockets"
L["Ruinstriders"] = "Ruinstriders"
L["Runestag"] = "Runestag"
L["Rylaks"] = "Rylaks"
L["Sabers"] = "Sabers"
L["Scorpions"] = "Scorpions"
L["Sea Serpents"] = "Sea Serpents"
L["Seahorses"] = "Seahorses"
L["Seat"] = "Seat"
L["Silithids"] = "Silithids"
L["Snail"] = "Snail"
L["Snapdragons"] = "Snapdragons"
L["Spider Tanks"] = "Spider Tanks"
L["Spiders"] = "Spiders"
L["Steeds"] = "Steeds"
L["Stingrays"] = "Stingrays"
L["Stone Cats"] = "Stone Cats"
L["Stone Drakes"] = "Stone Drakes"
L["Talbuks"] = "Talbuks"
L["Tallstriders"] = "Tallstriders"
L["Talonbirds"] = "Talonbirds"
L["Tauralus"] = "Tauralus"
L["Tigers"] = "Tigers"
L["Toads"] = "Toads"
L["Turtles"] = "Turtles"
L["Undead Drakes"] = "Undead Drakes"
L["Undead Steeds"] = "Undead Steeds"
L["Undead Wolves"] = "Undead Wolves"
L["Ungulates"] = "Ungulates"
L["Ur'zul"] = "Ur'zul"
L["Vehicles"] = "Vehicles"
L["Vombata"] = "Vombata"
L["Vulpin"] = "Vulpin"
L["Vultures"] = "Vultures"
L["War Wolves"] = "War Wolves"
L["Wasp"] = "Wasp"
L["Water Striders"] = "Water Striders"
L["Wilderlings"] = "Wilderlings"
L["Wind Drakes"] = "Wind Drakes"
L["Wolfhawks"] = "Wolfhawks"
L["Wolves"] = "Wolves"
L["Wyverns"] = "Wyverns"
L["Yaks"] = "Yaks"
L["Yetis"] = "Yetis"

-- Settings
L["DISPLAY_ALL_SETTINGS"] = "Display all settings"
L["RESET_WINDOW_SIZE"] = "Reset journal size"
L["SETTING_ABOUT_AUTHOR"] = "Author"
L["SETTING_ACHIEVEMENT_POINTS"] = "Show achievement points"
L["SETTING_AUTO_FAVOR"] = "Automatically set new mounts as favorite"
L["SETTING_COMPACT_LIST"] = "Compact mount list"
L["SETTING_CURSOR_KEYS"] = "Enable Up&Down keys to browse mounts"
L["SETTING_FAVORITE_PER_CHAR"] = "Favorite mounts per character"
L["SETTING_HEAD_ABOUT"] = "About"
L["SETTING_HEAD_BEHAVIOUR"] = "Behavior"
L["SETTING_MOUNT_COUNT"] = "Show personal mount count"
L["SETTING_MOVE_EQUIPMENT"] = "Move equipment slot into display"
L["SETTING_PERSONAL_FILTER"] = "Apply filters only to this character"
L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "Apply hidden mounts only to this character"
L["SETTING_PERSONAL_UI"] = "Apply Interface settings only to this character"
L["SETTING_PREVIEW_LINK"] = "Show Collection button in mount preview"
L["SETTING_SEARCH_MORE"] = "Search also in description text"
L["SETTING_SEARCH_NOTES"] = "Search also in own notes"
L["SETTING_SHOP_BUTTON"] = "Show shop button at untrained shop mounts"
L["SETTING_SHOW_STATISTICS"] = "Show mount statistics in display"
L["SETTING_TRACK_USAGE"] = "Track mount usage behavior on all characters"
L["SETTING_YCAMERA"] = "Unlock Y rotation with mouse in display"

if locale == "deDE" then
    ADDON.isMetric = true
    L["Black Market"] = "Schwarzmarkt"
L["DRESSUP_LABEL"] = "Sammlung"
L["Family"] = "Familie"
L["FAVOR_AUTO"] = "Neue Mounts automatisch setzen"
L["FAVOR_DISPLAYED"] = "Alle Angezeigten Wählen"
L["FAVOR_PER_CHARACTER"] = "Pro Charakter"
L["FILTER_ONLY_LATEST"] = "Nur Neuzugänge"
L["FILTER_SECRET"] = "vom Spiel versteckt"
L["Hidden"] = "Ausgeblendete"
L["Only tradable"] = "Nur handelbare"
L["Passenger"] = "Passagier"
L["Reset filters"] = "Filter zurücksetzen"
L["ROTATE_DOWN"] = "Abwärtsdrehung"
L["ROTATE_UP"] = "Aufwärtsdrehung"
L["SORT_BY_LAST_USAGE"] = "Letzter Benutzung"
L["SORT_BY_LEARNED_DATE"] = "Datum des Erhalts"
L["SORT_BY_TRAVEL_DISTANCE"] = "Gereiste Entfernung"
L["SORT_BY_TRAVEL_DURATION"] = "Reisedauer"
L["SORT_BY_USAGE_COUNT"] = "Nutzungshäufigkeit"
L["SORT_FAVORITES_FIRST"] = "Favoriten zuerst"
L["SORT_REVERSE"] = "Sortierung umkehren"
L["SORT_UNOWNED_BOTTOM"] = "Nicht gesammelt nach unten"
L["SORT_UNUSABLE_BOTTOM"] = "Nicht nutzbare nach nutzbaren"
L["STATS_TIP_LEARNED_DATE_HEAD"] = "Besitzdatum"
L["STATS_TIP_RARITY_HEAD"] = "Seltenheit"
L["STATS_TIP_RARITY_TEXT"] = [=[% an Charakteren die dieses Reittier besitzen.
Daten wurden freundlicherweise von {RR} bereit gestellt.]=]
L["STATS_TIP_TRAVEL_DISTANCE_HEAD"] = "Reisedistanz"
L["STATS_TIP_TRAVEL_TIME_HEAD"] = "Reisedauer"
L["STATS_TIP_TRAVEL_TIME_TEXT"] = "als Stunden:Minuten:Sekunden"
L["STATS_TIP_USAGE_COUNT_HEAD"] = "Anzahl der Einsätze"
L["TASK_END"] = "[MJE] Uff! Endlich geschafft."
L["TASK_FAVOR_START"] = "[MJE] Bitte warten. Deine Reittiere werden mit Sternen neu beklebt."
L["TOGGLE_COLOR"] = "Zeige nächste Farbvariante"
L["Transform"] = "Verwandlung"

    -- Settings
L["DISPLAY_ALL_SETTINGS"] = "Zeige alle Einstellungen"
L[ [=[RESET_WINDOW_SIZE
]=] ] = "Journalgröße zurücksetzen"
L["SETTING_ABOUT_AUTHOR"] = "Autor"
L["SETTING_ACHIEVEMENT_POINTS"] = "Zeige Erfolgspunkte"
L["SETTING_AUTO_FAVOR"] = "Setze neue Reittiere automatisch als Favoriten"
L["SETTING_COMPACT_LIST"] = "Kompakte Mount-Liste"
L["SETTING_CURSOR_KEYS"] = "Aktiviere Aufwärts- und Abwärtspfeiltaste zum Durchblättern"
L["SETTING_FAVORITE_PER_CHAR"] = "Speichere Favoriten pro Charakter"
L["SETTING_HEAD_ABOUT"] = "Über"
L["SETTING_HEAD_BEHAVIOUR"] = "Verhalten"
L["SETTING_MOUNT_COUNT"] = "Zeige Reittieranzahl diesen Charakters"
L["SETTING_MOVE_EQUIPMENT"] = "Verschiebe Ausrüstungsplatz in Modellanzeige"
L["SETTING_PERSONAL_FILTER"] = "Wende Filter-Einstellungen nur bei diesem Charakter an"
L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "Benutze versteckte Reittiere nur bei diesem Charakter"
L["SETTING_PERSONAL_UI"] = "Benutze Interface-Einstellungen nur bei diesem Charakter"
L["SETTING_PREVIEW_LINK"] = "Zeige Knopf zur Sammlung in Anprobe"
L["SETTING_SEARCH_MORE"] = "Suche auch im Beschreibungstext"
L["SETTING_SEARCH_NOTES"] = "Suche auch in eigenen Notizen"
L["SETTING_SHOP_BUTTON"] = "Zeige Shop bei verfügbaren Reittieren"
L["SETTING_SHOW_STATISTICS"] = "Zeige Statistiken in Modellanzeige"
L["SETTING_TRACK_USAGE"] = "Verfolge Reittier Nutzungsverhalten bei allen Charakteren"
L["SETTING_YCAMERA"] = "Aktiviere Y-Rotation via Maus in Modellanzeige"

    -- Families
L["Airplanes"] = "Flugzeuge"
L["Airships"] = "Luftschiffe"
L["Alpacas"] = "Alpakas"
L["Amphibian"] = "Amphibien"
L["Animite"] = "Animilbe"
L["Aqir Flyers"] = "Aqir-Flieger"
L["Arachnids"] = "Spinnentiere"
L["Assault Wagons"] = "Angriffswagen"
L["Basilisks"] = "Basilisken"
L["Bats"] = "Fledermäuse"
L["Bears"] = "Bären"
L["Bees"] = "Bienen"
L["Birds"] = "Vögel"
L["Blood Ticks"] = "Blutschwärmer"
L["Boars"] = "Eber"
L["Book"] = "Buch"
L["Bovids"] = "Hornträger"
L["Brutosaurs"] = "Brutosaurier"
L["Camels"] = "Kamele"
L["Carnivorans"] = "Raubtiere"
L["Carpets"] = "Teppiche"
L["Cats"] = "Katzen"
L["Cervid"] = "Cervid"
L["Chargers"] = "Streitrosse"
L["Chickens"] = "Hühner"
L["Clefthooves"] = "Spalthufe"
L["Cloud Serpents"] = "Wolkenschlangen"
L["Core Hounds"] = "Kernhunde"
L["Crabs"] = "Krabben"
L["Cranes"] = "Kraniche"
L["Crawgs"] = "Kroggs"
L["Crocolisks"] = "Krokilisk"
L["Crows"] = "Krähen"
L["Demonic Hounds"] = "Dämonische Hunde"
L["Demonic Steeds"] = "Dämonische Pferde"
L["Demons"] = "Dämonen"
L["Devourer"] = "Verschlinger"
L["Dinosaurs"] = "Dinosaurier"
L["Dire Wolves"] = "Terrorwölfe"
L["Direhorns"] = "Terrorhörner"
L["Discs"] = "Flugscheiben"
L["Dragonhawks"] = "Drachenfalken"
L["Drakes"] = "Drachen"
L["Dread Ravens"] = "Schreckensraben"
L["Elekks"] = "Elekks"
L["Elementals"] = "Elementare"
L["Falcosaurs"] = "Falkosaurier"
L["Fathom Rays"] = "Tiefenrochen"
L["Feathermanes"] = "Federmähnen"
L["Felsabers"] = "Teufelssäbler"
L["Fish"] = "Fische"
L["Flies"] = "Fliegen"
L["Flying Steeds"] = "Fliegende Pferde"
L["Foxes"] = "Füchse"
L["Gargon"] = "Gargon"
L["Gargoyle"] = "Wasserspeier"
L["Goats"] = "Ziegen"
L["Gorger"] = "Verschlinger"
L["Gorm"] = "Gorm"
L["Grand Drakes"] = "Großdrachen"
L["Gronnlings"] = "Gronnlinge"
L["Gryphons"] = "Greifen"
L["Gyrocopters"] = "Gyrokopter"
L["Hands"] = "Hände"
L["Hawkstriders"] = "Falkenschreiter"
L["Hippogryphs"] = "Hippogryphen"
L["Horned Steeds"] = "Behornte Pferde"
L["Horses"] = "Pferde"
L["Hounds"] = "Hunde"
L["Hovercraft"] = "Luftkissenfahrzeug"
L["Humanoids"] = "Humanoide"
L["Hyenas"] = "Hyänen"
L["Infernals"] = "Höllenbestien"
L["Insects"] = "Insekten"
L["Jellyfish"] = "Quallen"
L["Jet Aerial Units"] = "Lufteinheiten"
L["Kites"] = "Flugdrachen"
L["Kodos"] = "Kodos"
L["Krolusks"] = "Krolusk"
L["Larion"] = "Larion"
L["Lions"] = "Löwen"
L["Lupine"] = "Lupin"
L["Mammoths"] = "Mammuts"
L["Mana Rays"] = "Manarochen"
L["Manasabers"] = "Manasäbler"
L["Mauler"] = "Zerfleischer"
L["Mechanical Animals"] = "Mechanische Tiere"
L["Mechanical Birds"] = "Mechanische Vögel"
L["Mechanical Cats"] = "Mechanische Katzen"
L["Mechanical Steeds"] = "Mechanische Pferde"
L["Mechanostriders"] = "Roboschreiter"
L["Mecha-suits"] = "Mecha"
L["Moose"] = "Elche"
L["Moth"] = "Motte"
L["Motorcycles"] = "Motorräder"
L["Mountain Horses"] = "Bergpferde"
L["Mushan"] = "Mushans"
L["Nether Drakes"] = "Netherdrachen"
L["Nether Rays"] = "Netherrochen"
L["N'Zoth Serpents"] = "N'Zoth-Schlangen"
L["Others"] = "Andere"
L["Ox"] = "Ochse"
L["Pandaren Phoenixes"] = "Pandarenphönixe"
L["Parrots"] = "Papageien"
L["Phoenixes"] = "Phönixe"
L["Proto-Drakes"] = "Protodrachen"
L["Pterrordaxes"] = "Pterrordaxe"
L["Quilen"] = "Qilen"
L["Rams"] = "Widder"
L["Raptora"] = "Raptora"
L["Raptors"] = "Raptoren"
L["Rats"] = "Ratten"
L["Ravagers"] = "Felshetzer"
L["Rays"] = "Rochen"
L["Razorwing"] = "Klingenschwinge"
L["Reptiles"] = "Reptilien"
L["Rhinos"] = "Rhinozerosse"
L["Riverbeasts"] = "Flussbestien"
L["Roc"] = "Roc"
L["Rockets"] = "Raketen"
L["Ruinstriders"] = "Ruinprescher"
L["Runestag"] = "Runenhirsch"
L["Rylaks"] = "Rylaks"
L["Sabers"] = "Säbler"
L["Scorpions"] = "Skorpione"
L["Sea Serpents"] = "Seeschlangen"
L["Seahorses"] = "Seepferde"
L["Seat"] = "Wiege"
L["Silithids"] = "Qirajipanzerdrohnen"
L["Snail"] = "Schnecke"
L["Snapdragons"] = "Schnappdrachen"
L["Spider Tanks"] = "Mechaspinnen"
L["Spiders"] = "Spinnen"
L["Steeds"] = "Pferde"
L["Stingrays"] = "Stachelrochen"
L["Stone Cats"] = "Steinkatzen"
L["Stone Drakes"] = "Steindrachen"
L["Talbuks"] = "Talbuks"
L["Tallstriders"] = "Schreiter"
L["Talonbirds"] = "Raben"
L["Tauralus"] = "Tauralus"
L["Tigers"] = "Tiger"
L["Toads"] = "Kröten"
L["Turtles"] = "Schildkröten"
L["Undead Drakes"] = "Untote Drachen"
L["Undead Steeds"] = "Untote Pferde"
L["Undead Wolves"] = "Untote Wölfe"
L["Ungulates"] = "Huftiere"
L["Ur'zul"] = "Ur'zul"
L["Vehicles"] = "Fahrzeuge"
L["Vombata"] = "Vombata"
L["Vulpin"] = "Vulpin"
L["Vultures"] = "Geier"
L["War Wolves"] = "Kriegswölfe"
L["Wasp"] = "Wespe"
L["Water Striders"] = "Wasserschreiter"
L["Wilderlings"] = "Wildling"
L["Wind Drakes"] = "Winddrachen"
L["Wolfhawks"] = "Wolfsfalken"
L["Wolves"] = "Wölfe"
L["Wyverns"] = "Wyvern"
L["Yaks"] = "Yaks"
L["Yetis"] = "Yetis"


elseif locale == "esES" then
    ADDON.isMetric = true
    L["Black Market"] = "Mercado Negro"
L["DRESSUP_LABEL"] = "Diario"
L["Family"] = "Familia"
L["FAVOR_AUTO"] = "Nuevas monturas auto-favoritas"
L["FAVOR_DISPLAYED"] = "Mostrar todas"
L["FAVOR_PER_CHARACTER"] = "Por personaje"
L["FILTER_ONLY_LATEST"] = "Sólo las últimas añadidas"
L["FILTER_SECRET"] = "Oculto por el juego"
L["Hidden"] = "Oculto"
L["Only tradable"] = "Sólo comerciable"
L["Passenger"] = "Pasajeros"
L["Reset filters"] = "Restablecer los filtros"
L["ROTATE_DOWN"] = "Girar hacia abajo"
L["ROTATE_UP"] = "Girar hacia arriba"
L["SORT_BY_LAST_USAGE"] = "Usada recientemente"
L["SORT_BY_LEARNED_DATE"] = "Fecha de aprendizaje"
L["SORT_BY_TRAVEL_DISTANCE"] = "Distancia recorrida"
L["SORT_BY_TRAVEL_DURATION"] = "Duración de los viajes"
L["SORT_BY_USAGE_COUNT"] = "Recuento de uso"
L["SORT_FAVORITES_FIRST"] = "Favoritas primero"
L["SORT_REVERSE"] = "Ordenación inversa"
L["SORT_UNOWNED_BOTTOM"] = "Faltantes al final"
L["SORT_UNUSABLE_BOTTOM"] = "Inutilizables después de las Usables"
L["STATS_TIP_LEARNED_DATE_HEAD"] = "Fecha de posesión"
L["STATS_TIP_RARITY_HEAD"] = "Rareza"
L["STATS_TIP_RARITY_TEXT"] = "el % de tus personajes tienen esta montura La información es proporcionada amablemente por {RR}."
L["STATS_TIP_TRAVEL_DISTANCE_HEAD"] = "Distancia de viaje"
L["STATS_TIP_TRAVEL_TIME_HEAD"] = "Duración del viaje"
L["STATS_TIP_TRAVEL_TIME_TEXT"] = "en horas:minutos:segundos"
L["STATS_TIP_USAGE_COUNT_HEAD"] = "Contador de usos"
L["TASK_END"] = "[MJE] ¡Fiuuu! He acabado."
L["TASK_FAVOR_START"] = "[MJE] Reaplicando estrellas a tus monturas. Por favor, espera unos segundos hasta que haya acabado."
L["TOGGLE_COLOR"] = "Muestra las variaciones de colores"
L["Transform"] = "Transformaciones"

    -- Settings
L["DISPLAY_ALL_SETTINGS"] = "Mostrar todos los ajustes"
L[ [=[RESET_WINDOW_SIZE
]=] ] = "Restablecer el tamaño del diario"
L["SETTING_ABOUT_AUTHOR"] = "Autor"
L["SETTING_ACHIEVEMENT_POINTS"] = "Mostrar los puntos de logros"
L["SETTING_AUTO_FAVOR"] = "Selecciona automáticamente las nuevas monturas como favoritas"
L["SETTING_COMPACT_LIST"] = "Compactar la lista de monturas"
L["SETTING_CURSOR_KEYS"] = "Habilitar las teclas Arriba y Abajo para explorar las monturas"
L["SETTING_FAVORITE_PER_CHAR"] = "Monturas favoritas por personaje"
L["SETTING_HEAD_ABOUT"] = "Sobre"
L["SETTING_HEAD_BEHAVIOUR"] = "Comportamiento"
L["SETTING_MOUNT_COUNT"] = "Mostrar el número personal de monturas"
L["SETTING_MOVE_EQUIPMENT"] = "Mover la ranura de equipo a la vista previa de la montura"
L["SETTING_PERSONAL_FILTER"] = "Aplicar los filtros sólo para este personaje"
L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "Poner las monturas ocultas sólo para este personaje"
L["SETTING_PERSONAL_UI"] = "Aplicar las opciones de interfaz sólo para este personaje"
L["SETTING_PREVIEW_LINK"] = "Mostrar el botón Colección en la vista previa de la montura"
L["SETTING_SEARCH_MORE"] = "Buscar también en la descripción del texto"
L["SETTING_SEARCH_NOTES"] = "Buscar también en las notas propias"
L["SETTING_SHOP_BUTTON"] = "Mostrar el botón de la tienda en las monturas que no se tienen"
L["SETTING_SHOW_STATISTICS"] = "Mostrar las estadísticas de la montura en pantalla"
L["SETTING_TRACK_USAGE"] = "Seguimiento del comportamiento de uso de las monturas en todos los personajes"
L["SETTING_YCAMERA"] = "Desbloquear la rotación Y del ratón en la pantalla"

    -- Families
L["Airplanes"] = "Aviones"
L["Airships"] = "Naves de Guerra"
L["Alpacas"] = "Alpacas"
L["Amphibian"] = "Anfibios"
L["Animite"] = "Animácaros"
L["Aqir Flyers"] = "Voladores Aqir"
L["Arachnids"] = "Arácnidos"
L["Assault Wagons"] = "Catapultas de Asalto"
L["Basilisks"] = "Basiliscos"
L["Bats"] = "Murciélagos"
L["Bears"] = "Osos"
L["Bees"] = "Abejas"
L["Birds"] = "Pájaros"
L["Blood Ticks"] = "Garrapatas de Sangre"
L["Boars"] = "Jabalies"
L["Book"] = "Libro"
L["Bovids"] = "Bóvidos"
L["Brutosaurs"] = "Brutosaurios"
L["Camels"] = "Camellos"
L["Carnivorans"] = "Carnívoros"
L["Carpets"] = "Alfombras"
L["Cats"] = "Gatos"
L["Cervid"] = "Cérvidos"
L["Chargers"] = "Destreros"
L["Chickens"] = "Pollos"
L["Clefthooves"] = "Uñagrietas"
L["Cloud Serpents"] = "Dragones Nimbo"
L["Core Hounds"] = "Canes del Núcleo"
L["Crabs"] = "Cangrejos"
L["Cranes"] = "Grullas"
L["Crawgs"] = "Tragadones"
L["Crocolisks"] = "Crocoliscos"
L["Crows"] = "Cuervos"
L["Demonic Hounds"] = "Acechadores Viles"
L["Demonic Steeds"] = "Corceles Demoníacos"
L["Demons"] = "Demonios"
L["Devourer"] = "Devoradores"
L["Dinosaurs"] = "Dinosaurios"
L["Dire Wolves"] = "Lobos Temibles"
L["Direhorns"] = "Cuernoatroces"
L["Discs"] = "Discos"
L["Dragonhawks"] = "Dracohalcones"
L["Drakes"] = "Dracos"
L["Dread Ravens"] = "Cuervos Aterradores"
L["Elekks"] = "Elekks"
L["Elementals"] = "Elementales"
L["Falcosaurs"] = "Falcosaurios"
L["Fathom Rays"] = "Rayas de las Profundidades"
L["Feathermanes"] = "Crinplumas"
L["Felsabers"] = "Sablesviles"
L["Fish"] = "Peces"
L["Flies"] = "Moscas"
L["Flying Steeds"] = "Corceles Voladores"
L["Foxes"] = "Zorros"
L["Gargon"] = "Gargones"
L["Gargoyle"] = "Gárgolas"
L["Goats"] = "Cabras"
L["Gorger"] = "Engullidores"
L["Gorm"] = "Gorms"
L["Grand Drakes"] = "Dracos Grandes"
L["Gronnlings"] = "Gronnitos"
L["Gryphons"] = "Grifos"
L["Gyrocopters"] = "Helicópteros"
L["Hands"] = "Manos"
L["Hawkstriders"] = "Halcones Zancudos"
L["Hippogryphs"] = "Hipogrifos"
L["Horned Steeds"] = "Corceles Cornudos"
L["Horses"] = "Caballos"
L["Hounds"] = "Canes"
L["Hovercraft"] = "Aerodeslizadores"
L["Humanoids"] = "Humanoides"
L["Hyenas"] = "Hienas"
L["Infernals"] = "Infernales"
L["Insects"] = "Insectos"
L["Jellyfish"] = "Medusas"
L["Jet Aerial Units"] = "Unidades Aéreas Propulsadas"
L["Kites"] = "Cometas"
L["Kodos"] = "Kodos"
L["Krolusks"] = "Croluscos"
L["Larion"] = "Lariones"
L["Lions"] = "Leones"
L["Lupine"] = "Lupinos"
L["Mammoths"] = "Mamuts"
L["Mana Rays"] = "Rayas de Maná"
L["Manasabers"] = "Sables de Maná"
L["Mauler"] = "Aplastadores"
L["Mechanical Animals"] = "Animales Mecánicos"
L["Mechanical Birds"] = "Pájaros Mecánicos"
L["Mechanical Cats"] = "Gatos Mecánicos"
L["Mechanical Steeds"] = "Corceles Mecánicos"
L["Mechanostriders"] = "Mecazancudos"
L["Mecha-suits"] = "Trajes Mecánicos"
L["Moose"] = "Alces"
L["Moth"] = "Polillas"
L["Motorcycles"] = "Motos"
L["Mountain Horses"] = "Caballos de Montaña"
L["Mushan"] = "Mushans"
L["Nether Drakes"] = "Dracos Abisales"
L["Nether Rays"] = "Rayas Abisales"
L["N'Zoth Serpents"] = "Serpientes de N'Zoth"
L["Others"] = "Otros"
L["Ox"] = "Ox"
L["Pandaren Phoenixes"] = "Fénix Pandaren"
L["Parrots"] = "Loros"
L["Phoenixes"] = "Fénix"
L["Proto-Drakes"] = "Protodracos"
L["Pterrordaxes"] = "Pterrordáctilos"
L["Quilen"] = "Quilens"
L["Rams"] = "Carneros"
L["Raptora"] = "Accipítridos"
L["Raptors"] = "Raptores"
L["Rats"] = "Ratas"
L["Ravagers"] = "Atracadores"
L["Rays"] = "Rayas"
L["Razorwing"] = "Alafilada"
L["Reptiles"] = "Reptiles"
L["Rhinos"] = "Rinocerontes"
L["Riverbeasts"] = "Bestias Fluviales"
L["Roc"] = "Rocs"
L["Rockets"] = "Cohetes"
L["Ruinstriders"] = "Vagarruinas"
L["Runestag"] = "Venados Rúnicos"
L["Rylaks"] = "Rylaks"
L["Sabers"] = "Sables"
L["Scorpions"] = "Escorpiones"
L["Sea Serpents"] = "Serpientes de Mar"
L["Seahorses"] = "Caballitos de Mar"
L["Seat"] = "Asientos"
L["Silithids"] = "Silítidos"
L["Snail"] = "Caracoles"
L["Snapdragons"] = "Bocadragones"
L["Spider Tanks"] = "Arañas Mecánicas"
L["Spiders"] = "Arañas"
L["Steeds"] = "Corceles"
L["Stingrays"] = "Rayas Manta"
L["Stone Cats"] = "Gatos de Piedra"
L["Stone Drakes"] = "Dracos de Piedra"
L["Talbuks"] = "Talbuks"
L["Tallstriders"] = "Zancudos"
L["Talonbirds"] = "Pájaros Garra"
L["Tauralus"] = "Tauralus"
L["Tigers"] = "Tigres"
L["Toads"] = "Sapos"
L["Turtles"] = "Tortugas"
L["Undead Drakes"] = "Dracos no Muertos"
L["Undead Steeds"] = "Corceles no Muertos"
L["Undead Wolves"] = "Lobos no Muertos"
L["Ungulates"] = "Ungulados"
L["Ur'zul"] = "Ur'zul"
L["Vehicles"] = "Vehículos"
L["Vombata"] = "Vombatas"
L["Vulpin"] = "Vulpinos"
L["Vultures"] = "Buitres"
L["War Wolves"] = "Lobos de Guerra"
L["Wasp"] = "Avispas"
L["Water Striders"] = "Záncudos Acuáticos"
L["Wilderlings"] = "Salvajizos"
L["Wind Drakes"] = "Dracos del Viento"
L["Wolfhawks"] = "Lobohalcones"
L["Wolves"] = "Lobos"
L["Wyverns"] = "Dracoleones"
L["Yaks"] = "Yaks"
L["Yetis"] = "Yetis"


elseif locale == "frFR" then
    ADDON.isMetric = true
    L["Black Market"] = "Marché Noir"
--[[Translation missing --]]
--[[ L["DRESSUP_LABEL"] = "Journal"--]] 
L["Family"] = "Famille"
--[[Translation missing --]]
--[[ L["FAVOR_AUTO"] = "Auto-favor new mounts"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_DISPLAYED"] = "All Displayed"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_PER_CHARACTER"] = "Per Character"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden by the game"--]] 
L["Hidden"] = "Cachées"
--[[Translation missing --]]
--[[ L["Only tradable"] = "Only tradable"--]] 
L["Passenger"] = "Passagers"
L["Reset filters"] = "Réinitialiser les filtres"
--[[Translation missing --]]
--[[ L["ROTATE_DOWN"] = "Rotate Down"--]] 
--[[Translation missing --]]
--[[ L["ROTATE_UP"] = "Rotate Up"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_LAST_USAGE"] = "Last usage"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_LEARNED_DATE"] = "Date of receipt"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_TRAVEL_DISTANCE"] = "Travelled distance"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_TRAVEL_DURATION"] = "Travelled duration"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_USAGE_COUNT"] = "Count of usage"--]] 
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_BOTTOM"] = "Unowned at Bottom"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNUSABLE_BOTTOM"] = "Unusable after Usable"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_LEARNED_DATE_HEAD"] = "Possession date"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_HEAD"] = "Rarity"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_TEXT"] = [=[% of characters who own this mount
Data is kindly provided by {RR}.]=]--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_DISTANCE_HEAD"] = "Travel distance"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_HEAD"] = "Travel time"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_TEXT"] = "in hours:minutes:seconds"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_USAGE_COUNT_HEAD"] = "Usage count"--]] 
--[[Translation missing --]]
--[[ L["TASK_END"] = "[MJE] Phew! I'm done."--]] 
--[[Translation missing --]]
--[[ L["TASK_FAVOR_START"] = "[MJE] Reapplying stars all over your mounts. Please wait a few seconds until I'm finished."--]] 
--[[Translation missing --]]
--[[ L["TOGGLE_COLOR"] = "Show next color variation"--]] 
L["Transform"] = "Transformation"

    -- Settings
--[[Translation missing --]]
--[[ L["DISPLAY_ALL_SETTINGS"] = "Display all settings"--]] 
--[[Translation missing --]]
--[[ L[ [=[RESET_WINDOW_SIZE
]=] ] = "Reset journal size"--]] 
--[[Translation missing --]]
--[[ L["SETTING_ABOUT_AUTHOR"] = "Author"--]] 
--[[Translation missing --]]
--[[ L["SETTING_ACHIEVEMENT_POINTS"] = "Show achievement points"--]] 
--[[Translation missing --]]
--[[ L["SETTING_AUTO_FAVOR"] = "Automatically set new mounts as favorite"--]] 
--[[Translation missing --]]
--[[ L["SETTING_COMPACT_LIST"] = "Compact mount list"--]] 
--[[Translation missing --]]
--[[ L["SETTING_CURSOR_KEYS"] = "Enable Up&Down keys to browse mounts"--]] 
--[[Translation missing --]]
--[[ L["SETTING_FAVORITE_PER_CHAR"] = "Favorite mounts per character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_HEAD_ABOUT"] = "About"--]] 
--[[Translation missing --]]
--[[ L["SETTING_HEAD_BEHAVIOUR"] = "Behavior"--]] 
--[[Translation missing --]]
--[[ L["SETTING_MOUNT_COUNT"] = "Show personal mount count"--]] 
--[[Translation missing --]]
--[[ L["SETTING_MOVE_EQUIPMENT"] = "Move equipment slot into display"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_FILTER"] = "Apply filters only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "Apply hidden mounts only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_UI"] = "Apply Interface settings only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PREVIEW_LINK"] = "Show Collection button in mount preview"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_MORE"] = "Search also in description text"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_NOTES"] = "Search also in own notes"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SHOP_BUTTON"] = "Show shop button at untrained shop mounts"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SHOW_STATISTICS"] = "Show mount statistics in display"--]] 
--[[Translation missing --]]
--[[ L["SETTING_TRACK_USAGE"] = "Track mount usage behavior on all characters"--]] 
--[[Translation missing --]]
--[[ L["SETTING_YCAMERA"] = "Unlock Y rotation with mouse in display"--]] 

    -- Families
--[[Translation missing --]]
--[[ L["Airplanes"] = "Airplanes"--]] 
--[[Translation missing --]]
--[[ L["Airships"] = "Airships"--]] 
--[[Translation missing --]]
--[[ L["Alpacas"] = "Alpacas"--]] 
--[[Translation missing --]]
--[[ L["Amphibian"] = "Amphibian"--]] 
--[[Translation missing --]]
--[[ L["Animite"] = "Animite"--]] 
--[[Translation missing --]]
--[[ L["Aqir Flyers"] = "Aqir Flyers"--]] 
--[[Translation missing --]]
--[[ L["Arachnids"] = "Arachnids"--]] 
--[[Translation missing --]]
--[[ L["Assault Wagons"] = "Assault Wagons"--]] 
L["Basilisks"] = "Basilics"
L["Bats"] = "Chauve-Souris"
L["Bears"] = "Ours"
--[[Translation missing --]]
--[[ L["Bees"] = "Bees"--]] 
L["Birds"] = "Oiseaux"
--[[Translation missing --]]
--[[ L["Blood Ticks"] = "Blood Ticks"--]] 
L["Boars"] = "Sangliers"
--[[Translation missing --]]
--[[ L["Book"] = "Book"--]] 
--[[Translation missing --]]
--[[ L["Bovids"] = "Bovids"--]] 
L["Brutosaurs"] = "Brontosaurus"
L["Camels"] = "Dromadaires"
--[[Translation missing --]]
--[[ L["Carnivorans"] = "Carnivorans"--]] 
--[[Translation missing --]]
--[[ L["Carpets"] = "Carpets"--]] 
L["Cats"] = "Félins"
--[[Translation missing --]]
--[[ L["Cervid"] = "Cervid"--]] 
--[[Translation missing --]]
--[[ L["Chargers"] = "Chargers"--]] 
--[[Translation missing --]]
--[[ L["Chickens"] = "Chickens"--]] 
L["Clefthooves"] = "Sabot-Fourchus"
--[[Translation missing --]]
--[[ L["Cloud Serpents"] = "Cloud Serpents"--]] 
--[[Translation missing --]]
--[[ L["Core Hounds"] = "Core Hounds"--]] 
--[[Translation missing --]]
--[[ L["Crabs"] = "Crabs"--]] 
L["Cranes"] = "Grues"
--[[Translation missing --]]
--[[ L["Crawgs"] = "Crawgs"--]] 
L["Crocolisks"] = "Crocilisque"
--[[Translation missing --]]
--[[ L["Crows"] = "Crows"--]] 
L["Demonic Hounds"] = "Molosses Démoniaques"
--[[Translation missing --]]
--[[ L["Demonic Steeds"] = "Demonic Steeds"--]] 
--[[Translation missing --]]
--[[ L["Demons"] = "Demons"--]] 
--[[Translation missing --]]
--[[ L["Devourer"] = "Devourer"--]] 
--[[Translation missing --]]
--[[ L["Dinosaurs"] = "Dinosaurs"--]] 
--[[Translation missing --]]
--[[ L["Dire Wolves"] = "Dire Wolves"--]] 
L["Direhorns"] = "Navrecornes"
--[[Translation missing --]]
--[[ L["Discs"] = "Discs"--]] 
L["Dragonhawks"] = "Faucon-Dragons"
L["Drakes"] = "Drakes"
--[[Translation missing --]]
--[[ L["Dread Ravens"] = "Dread Ravens"--]] 
L["Elekks"] = "Elekks"
L["Elementals"] = "Élémentaires"
--[[Translation missing --]]
--[[ L["Falcosaurs"] = "Falcosaurs"--]] 
--[[Translation missing --]]
--[[ L["Fathom Rays"] = "Fathom Rays"--]] 
--[[Translation missing --]]
--[[ L["Feathermanes"] = "Feathermanes"--]] 
--[[Translation missing --]]
--[[ L["Felsabers"] = "Felsabers"--]] 
L["Fish"] = "Poissons"
--[[Translation missing --]]
--[[ L["Flies"] = "Flies"--]] 
--[[Translation missing --]]
--[[ L["Flying Steeds"] = "Flying Steeds"--]] 
L["Foxes"] = "Renards"
--[[Translation missing --]]
--[[ L["Gargon"] = "Gargon"--]] 
--[[Translation missing --]]
--[[ L["Gargoyle"] = "Gargoyle"--]] 
L["Goats"] = "Chèvres"
--[[Translation missing --]]
--[[ L["Gorger"] = "Gorger"--]] 
--[[Translation missing --]]
--[[ L["Gorm"] = "Gorm"--]] 
--[[Translation missing --]]
--[[ L["Grand Drakes"] = "Grand Drakes"--]] 
L["Gronnlings"] = "Gronnlins"
L["Gryphons"] = "Griffons"
--[[Translation missing --]]
--[[ L["Gyrocopters"] = "Gyrocopters"--]] 
--[[Translation missing --]]
--[[ L["Hands"] = "Hands"--]] 
L["Hawkstriders"] = "Faucon-Pérégrins"
L["Hippogryphs"] = "Hippogriffes"
--[[Translation missing --]]
--[[ L["Horned Steeds"] = "Horned Steeds"--]] 
L["Horses"] = "Chevaux"
L["Hounds"] = "Molosses"
--[[Translation missing --]]
--[[ L["Hovercraft"] = "Hovercraft"--]] 
--[[Translation missing --]]
--[[ L["Humanoids"] = "Humanoids"--]] 
L["Hyenas"] = "Hyènes"
L["Infernals"] = "Infernaux"
--[[Translation missing --]]
--[[ L["Insects"] = "Insects"--]] 
L["Jellyfish"] = "Méduses"
--[[Translation missing --]]
--[[ L["Jet Aerial Units"] = "Jet Aerial Units"--]] 
--[[Translation missing --]]
--[[ L["Kites"] = "Kites"--]] 
L["Kodos"] = "Kodos"
--[[Translation missing --]]
--[[ L["Krolusks"] = "Krolusks"--]] 
--[[Translation missing --]]
--[[ L["Larion"] = "Larion"--]] 
--[[Translation missing --]]
--[[ L["Lions"] = "Lions"--]] 
--[[Translation missing --]]
--[[ L["Lupine"] = "Lupine"--]] 
L["Mammoths"] = "Mammouths"
--[[Translation missing --]]
--[[ L["Mana Rays"] = "Mana Rays"--]] 
--[[Translation missing --]]
--[[ L["Manasabers"] = "Manasabers"--]] 
--[[Translation missing --]]
--[[ L["Mauler"] = "Mauler"--]] 
--[[Translation missing --]]
--[[ L["Mechanical Animals"] = "Mechanical Animals"--]] 
--[[Translation missing --]]
--[[ L["Mechanical Birds"] = "Mechanical Birds"--]] 
--[[Translation missing --]]
--[[ L["Mechanical Cats"] = "Mechanical Cats"--]] 
--[[Translation missing --]]
--[[ L["Mechanical Steeds"] = "Mechanical Steeds"--]] 
L["Mechanostriders"] = "Mécanotrotteurs"
--[[Translation missing --]]
--[[ L["Mecha-suits"] = "Mecha-suits"--]] 
L["Moose"] = "Élans"
--[[Translation missing --]]
--[[ L["Moth"] = "Moth"--]] 
--[[Translation missing --]]
--[[ L["Motorcycles"] = "Motorcycles"--]] 
--[[Translation missing --]]
--[[ L["Mountain Horses"] = "Mountain Horses"--]] 
L["Mushan"] = "Mushans"
--[[Translation missing --]]
--[[ L["Nether Drakes"] = "Nether Drakes"--]] 
--[[Translation missing --]]
--[[ L["Nether Rays"] = "Nether Rays"--]] 
--[[Translation missing --]]
--[[ L["N'Zoth Serpents"] = "N'Zoth Serpents"--]] 
--[[Translation missing --]]
--[[ L["Others"] = "Others"--]] 
--[[Translation missing --]]
--[[ L["Ox"] = "Ox"--]] 
--[[Translation missing --]]
--[[ L["Pandaren Phoenixes"] = "Pandaren Phoenixes"--]] 
L["Parrots"] = "Psittaciformes"
L["Phoenixes"] = "Phénix"
--[[Translation missing --]]
--[[ L["Proto-Drakes"] = "Proto-Drakes"--]] 
L["Pterrordaxes"] = "Pterreurdactyles"
--[[Translation missing --]]
--[[ L["Quilen"] = "Quilen"--]] 
L["Rams"] = "Béliers"
--[[Translation missing --]]
--[[ L["Raptora"] = "Raptora"--]] 
L["Raptors"] = "Raptors"
L["Rats"] = "Rats"
L["Ravagers"] = "Saccageurs"
L["Rays"] = "Raies"
--[[Translation missing --]]
--[[ L["Razorwing"] = "Razorwing"--]] 
--[[Translation missing --]]
--[[ L["Reptiles"] = "Reptiles"--]] 
L["Rhinos"] = "Rhinocéros"
L["Riverbeasts"] = "Potamodontes"
--[[Translation missing --]]
--[[ L["Roc"] = "Roc"--]] 
--[[Translation missing --]]
--[[ L["Rockets"] = "Rockets"--]] 
--[[Translation missing --]]
--[[ L["Ruinstriders"] = "Ruinstriders"--]] 
--[[Translation missing --]]
--[[ L["Runestag"] = "Runestag"--]] 
--[[Translation missing --]]
--[[ L["Rylaks"] = "Rylaks"--]] 
--[[Translation missing --]]
--[[ L["Sabers"] = "Sabers"--]] 
L["Scorpions"] = "Scorpides"
--[[Translation missing --]]
--[[ L["Sea Serpents"] = "Sea Serpents"--]] 
L["Seahorses"] = "Hippocampes"
--[[Translation missing --]]
--[[ L["Seat"] = "Seat"--]] 
L["Silithids"] = "Silithides"
--[[Translation missing --]]
--[[ L["Snail"] = "Snail"--]] 
--[[Translation missing --]]
--[[ L["Snapdragons"] = "Snapdragons"--]] 
--[[Translation missing --]]
--[[ L["Spider Tanks"] = "Spider Tanks"--]] 
L["Spiders"] = "Araignées"
--[[Translation missing --]]
--[[ L["Steeds"] = "Steeds"--]] 
--[[Translation missing --]]
--[[ L["Stingrays"] = "Stingrays"--]] 
--[[Translation missing --]]
--[[ L["Stone Cats"] = "Stone Cats"--]] 
--[[Translation missing --]]
--[[ L["Stone Drakes"] = "Stone Drakes"--]] 
L["Talbuks"] = "Talbuks"
L["Tallstriders"] = "Trotteurs"
L["Talonbirds"] = "Rapaces"
--[[Translation missing --]]
--[[ L["Tauralus"] = "Tauralus"--]] 
--[[Translation missing --]]
--[[ L["Tigers"] = "Tigers"--]] 
--[[Translation missing --]]
--[[ L["Toads"] = "Toads"--]] 
L["Turtles"] = "Tortues"
--[[Translation missing --]]
--[[ L["Undead Drakes"] = "Undead Drakes"--]] 
--[[Translation missing --]]
--[[ L["Undead Steeds"] = "Undead Steeds"--]] 
--[[Translation missing --]]
--[[ L["Undead Wolves"] = "Undead Wolves"--]] 
--[[Translation missing --]]
--[[ L["Ungulates"] = "Ungulates"--]] 
--[[Translation missing --]]
--[[ L["Ur'zul"] = "Ur'zul"--]] 
--[[Translation missing --]]
--[[ L["Vehicles"] = "Vehicles"--]] 
--[[Translation missing --]]
--[[ L["Vombata"] = "Vombata"--]] 
--[[Translation missing --]]
--[[ L["Vulpin"] = "Vulpin"--]] 
--[[Translation missing --]]
--[[ L["Vultures"] = "Vultures"--]] 
--[[Translation missing --]]
--[[ L["War Wolves"] = "War Wolves"--]] 
--[[Translation missing --]]
--[[ L["Wasp"] = "Wasp"--]] 
L["Water Striders"] = "Trotteurs aquatiques"
--[[Translation missing --]]
--[[ L["Wilderlings"] = "Wilderlings"--]] 
--[[Translation missing --]]
--[[ L["Wind Drakes"] = "Wind Drakes"--]] 
--[[Translation missing --]]
--[[ L["Wolfhawks"] = "Wolfhawks"--]] 
L["Wolves"] = "Loups"
L["Wyverns"] = "Wyvernes"
L["Yaks"] = "Yacks"
L["Yetis"] = "Yétis"


elseif locale == "koKR" then
    ADDON.isMetric = true
    L["Black Market"] = "암시장"
--[[Translation missing --]]
--[[ L["DRESSUP_LABEL"] = "Journal"--]] 
L["Family"] = "종류"
--[[Translation missing --]]
--[[ L["FAVOR_AUTO"] = "Auto-favor new mounts"--]] 
L["FAVOR_DISPLAYED"] = "모두 표시"
L["FAVOR_PER_CHARACTER"] = "캐릭터별 표시"
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden by the game"--]] 
L["Hidden"] = "숨김"
L["Only tradable"] = "교환가능"
L["Passenger"] = "승객"
L["Reset filters"] = "필터 초기화"
--[[Translation missing --]]
--[[ L["ROTATE_DOWN"] = "Rotate Down"--]] 
--[[Translation missing --]]
--[[ L["ROTATE_UP"] = "Rotate Up"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_LAST_USAGE"] = "Last usage"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_LEARNED_DATE"] = "Date of receipt"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_TRAVEL_DISTANCE"] = "Travelled distance"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_TRAVEL_DURATION"] = "Travelled duration"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_USAGE_COUNT"] = "Count of usage"--]] 
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_BOTTOM"] = "Unowned at Bottom"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNUSABLE_BOTTOM"] = "Unusable after Usable"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_LEARNED_DATE_HEAD"] = "Possession date"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_HEAD"] = "Rarity"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_TEXT"] = [=[% of characters who own this mount
Data is kindly provided by {RR}.]=]--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_DISTANCE_HEAD"] = "Travel distance"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_HEAD"] = "Travel time"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_TEXT"] = "in hours:minutes:seconds"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_USAGE_COUNT_HEAD"] = "Usage count"--]] 
L["TASK_END"] = "[MJE] 작업 완료"
L["TASK_FAVOR_START"] = "[MJE] 탈것 목록 즐겨찾기 재설정을 시작합니다"
--[[Translation missing --]]
--[[ L["TOGGLE_COLOR"] = "Show next color variation"--]] 
L["Transform"] = "변환"

    -- Settings
--[[Translation missing --]]
--[[ L["DISPLAY_ALL_SETTINGS"] = "Display all settings"--]] 
--[[Translation missing --]]
--[[ L[ [=[RESET_WINDOW_SIZE
]=] ] = "Reset journal size"--]] 
--[[Translation missing --]]
--[[ L["SETTING_ABOUT_AUTHOR"] = "Author"--]] 
--[[Translation missing --]]
--[[ L["SETTING_ACHIEVEMENT_POINTS"] = "Show achievement points"--]] 
--[[Translation missing --]]
--[[ L["SETTING_AUTO_FAVOR"] = "Automatically set new mounts as favorite"--]] 
L["SETTING_COMPACT_LIST"] = "간소한 목록"
L["SETTING_CURSOR_KEYS"] = "위 아래 화살표 키로 목록 탐색하기"
L["SETTING_FAVORITE_PER_CHAR"] = "캐릭터별 즐겨찾기"
--[[Translation missing --]]
--[[ L["SETTING_HEAD_ABOUT"] = "About"--]] 
--[[Translation missing --]]
--[[ L["SETTING_HEAD_BEHAVIOUR"] = "Behavior"--]] 
--[[Translation missing --]]
--[[ L["SETTING_MOUNT_COUNT"] = "Show personal mount count"--]] 
L["SETTING_MOVE_EQUIPMENT"] = "착용 장비 표시 이동"
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_FILTER"] = "Apply filters only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "Apply hidden mounts only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PERSONAL_UI"] = "Apply Interface settings only to this character"--]] 
--[[Translation missing --]]
--[[ L["SETTING_PREVIEW_LINK"] = "Show Collection button in mount preview"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_MORE"] = "Search also in description text"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_NOTES"] = "Search also in own notes"--]] 
L["SETTING_SHOP_BUTTON"] = "구매 버튼 활성화"
--[[Translation missing --]]
--[[ L["SETTING_SHOW_STATISTICS"] = "Show mount statistics in display"--]] 
--[[Translation missing --]]
--[[ L["SETTING_TRACK_USAGE"] = "Track mount usage behavior on all characters"--]] 
L["SETTING_YCAMERA"] = "표시 화면에서 마우스로 Y 축 회전 잠금 해제"

    -- Families
L["Airplanes"] = "비행기"
L["Airships"] = "비행선"
L["Alpacas"] = "알파카"
L["Amphibian"] = "양서류"
--[[Translation missing --]]
--[[ L["Animite"] = "Animite"--]] 
L["Aqir Flyers"] = "아퀴르 날벌레"
L["Arachnids"] = "거미"
L["Assault Wagons"] = "공성차량"
L["Basilisks"] = "바실리스크"
L["Bats"] = "박쥐"
L["Bears"] = "곰"
L["Bees"] = "벌"
L["Birds"] = "새"
L["Blood Ticks"] = "흡혈충"
L["Boars"] = "멧돼지"
--[[Translation missing --]]
--[[ L["Book"] = "Book"--]] 
L["Bovids"] = "노루"
L["Brutosaurs"] = "브루토사우루스"
L["Camels"] = "낙타"
L["Carnivorans"] = "육식동물"
L["Carpets"] = "카페트"
L["Cats"] = "고양이과"
--[[Translation missing --]]
--[[ L["Cervid"] = "Cervid"--]] 
L["Chargers"] = "군마"
L["Chickens"] = "닭"
L["Clefthooves"] = "갈래발굽"
L["Cloud Serpents"] = "운룡"
L["Core Hounds"] = "심장부사냥개"
L["Crabs"] = "게"
L["Cranes"] = "학"
L["Crawgs"] = "크로그"
L["Crocolisks"] = "크로코리스크"
L["Crows"] = "까마귀"
L["Demonic Hounds"] = "지옥사냥개"
L["Demonic Steeds"] = "지옥군마"
L["Demons"] = "악마"
--[[Translation missing --]]
--[[ L["Devourer"] = "Devourer"--]] 
L["Dinosaurs"] = "공룡"
L["Dire Wolves"] = "다이어울프"
L["Direhorns"] = "다이어혼"
L["Discs"] = "원반"
L["Dragonhawks"] = "용매"
L["Drakes"] = "비룡"
L["Dread Ravens"] = "지옥까마귀"
L["Elekks"] = "엘레크"
L["Elementals"] = "정령"
L["Falcosaurs"] = "팔코사우루스"
L["Fathom Rays"] = "심해 가오리"
L["Feathermanes"] = "뾰족갈기"
L["Felsabers"] = "지옥표범"
L["Fish"] = "물고기"
--[[Translation missing --]]
--[[ L["Flies"] = "Flies"--]] 
L["Flying Steeds"] = "비행군마"
L["Foxes"] = "여우"
--[[Translation missing --]]
--[[ L["Gargon"] = "Gargon"--]] 
--[[Translation missing --]]
--[[ L["Gargoyle"] = "Gargoyle"--]] 
L["Goats"] = "염소"
--[[Translation missing --]]
--[[ L["Gorger"] = "Gorger"--]] 
--[[Translation missing --]]
--[[ L["Gorm"] = "Gorm"--]] 
L["Grand Drakes"] = "거대 비룡"
L["Gronnlings"] = "그론링"
L["Gryphons"] = "그리폰"
L["Gyrocopters"] = "자이로콥터"
--[[Translation missing --]]
--[[ L["Hands"] = "Hands"--]] 
L["Hawkstriders"] = "매타조"
L["Hippogryphs"] = "히포그리프"
L["Horned Steeds"] = "뿔 군마"
L["Horses"] = "말"
L["Hounds"] = "사냥개"
L["Hovercraft"] = "호버크래프트"
L["Humanoids"] = "휴머노이드"
L["Hyenas"] = "하이에나"
L["Infernals"] = "지옥불정령"
L["Insects"] = "곤충"
L["Jellyfish"] = "해파리"
L["Jet Aerial Units"] = "제트 비행기"
L["Kites"] = "연"
L["Kodos"] = "코도"
L["Krolusks"] = "크롤러스크"
--[[Translation missing --]]
--[[ L["Larion"] = "Larion"--]] 
L["Lions"] = "사자"
--[[Translation missing --]]
--[[ L["Lupine"] = "Lupine"--]] 
L["Mammoths"] = "매머드"
L["Mana Rays"] = "마나 가오리"
L["Manasabers"] = "마나호랑이"
--[[Translation missing --]]
--[[ L["Mauler"] = "Mauler"--]] 
L["Mechanical Animals"] = "기계형 야수"
L["Mechanical Birds"] = "기계형 새"
L["Mechanical Cats"] = "기계형 고양이"
L["Mechanical Steeds"] = "기계형 군마"
L["Mechanostriders"] = "기계타조"
L["Mecha-suits"] = "메카수트"
L["Moose"] = "엘크"
--[[Translation missing --]]
--[[ L["Moth"] = "Moth"--]] 
L["Motorcycles"] = "오토바이"
L["Mountain Horses"] = "산악마"
L["Mushan"] = "무샨"
L["Nether Drakes"] = "황천의 비룡"
L["Nether Rays"] = "황천 가오리"
L["N'Zoth Serpents"] = "느조스 뱀"
L["Others"] = "기타"
--[[Translation missing --]]
--[[ L["Ox"] = "Ox"--]] 
L["Pandaren Phoenixes"] = "판다렌 불사조"
L["Parrots"] = "앵무새"
L["Phoenixes"] = "불사조"
L["Proto-Drakes"] = "원시 비룡"
L["Pterrordaxes"] = "테러닥스"
L["Quilen"] = "기렌"
L["Rams"] = "산양"
--[[Translation missing --]]
--[[ L["Raptora"] = "Raptora"--]] 
L["Raptors"] = "랩터"
L["Rats"] = "쥐"
L["Ravagers"] = "칼날발톱"
L["Rays"] = "가오리"
--[[Translation missing --]]
--[[ L["Razorwing"] = "Razorwing"--]] 
L["Reptiles"] = "파충류"
L["Rhinos"] = "코뿔소"
L["Riverbeasts"] = "강물하마"
--[[Translation missing --]]
--[[ L["Roc"] = "Roc"--]] 
L["Rockets"] = "로켓"
L["Ruinstriders"] = "파멸발굽"
--[[Translation missing --]]
--[[ L["Runestag"] = "Runestag"--]] 
L["Rylaks"] = "라일라크"
L["Sabers"] = "표범"
L["Scorpions"] = "전갈"
L["Sea Serpents"] = "바다뱀"
L["Seahorses"] = "해마"
--[[Translation missing --]]
--[[ L["Seat"] = "Seat"--]] 
L["Silithids"] = "실리시드"
--[[Translation missing --]]
--[[ L["Snail"] = "Snail"--]] 
L["Snapdragons"] = "치악룡"
L["Spider Tanks"] = "거미 전차"
L["Spiders"] = "거미"
L["Steeds"] = "군마"
L["Stingrays"] = "독침가오리"
L["Stone Cats"] = "고양이 석상"
L["Stone Drakes"] = "비룡 석상"
L["Talbuks"] = "탈부크"
L["Tallstriders"] = "타조"
L["Talonbirds"] = "탈론 버드"
--[[Translation missing --]]
--[[ L["Tauralus"] = "Tauralus"--]] 
L["Tigers"] = "호랑이"
L["Toads"] = "두꺼비"
L["Turtles"] = "거북이"
L["Undead Drakes"] = "언데드 비룡"
L["Undead Steeds"] = "언데드 군마"
L["Undead Wolves"] = "언데드 늑대"
L["Ungulates"] = "유제류"
L["Ur'zul"] = "우르줄"
L["Vehicles"] = "차량"
--[[Translation missing --]]
--[[ L["Vombata"] = "Vombata"--]] 
--[[Translation missing --]]
--[[ L["Vulpin"] = "Vulpin"--]] 
--[[Translation missing --]]
--[[ L["Vultures"] = "Vultures"--]] 
L["War Wolves"] = "전투 늑대"
--[[Translation missing --]]
--[[ L["Wasp"] = "Wasp"--]] 
L["Water Striders"] = "소금쟁이"
--[[Translation missing --]]
--[[ L["Wilderlings"] = "Wilderlings"--]] 
L["Wind Drakes"] = "바람 비룡"
L["Wolfhawks"] = "늑대매"
L["Wolves"] = "늑대"
L["Wyverns"] = "와이번"
L["Yaks"] = "야크"
L["Yetis"] = "예티"


elseif locale == "ptBR" then
    ADDON.isMetric = true
    L["Black Market"] = "Mercado Negro"
L["DRESSUP_LABEL"] = "Diário"
L["Family"] = "Família"
L["FAVOR_AUTO"] = "Auto-favoritar novas montarias"
L["FAVOR_DISPLAYED"] = "Exibir todos"
L["FAVOR_PER_CHARACTER"] = "Por personagem"
L["FILTER_ONLY_LATEST"] = "Apenas adições mais recentes"
L["FILTER_SECRET"] = "Oculto pelo jogo"
L["Hidden"] = "Oculto"
L["Only tradable"] = "Apenas negociável"
L["Passenger"] = "Passageiro"
L["Reset filters"] = "Resetar filtros "
L["ROTATE_DOWN"] = "Girar para Baixo"
L["ROTATE_UP"] = "Girar para Cima"
L["SORT_BY_LAST_USAGE"] = "Último uso"
L["SORT_BY_LEARNED_DATE"] = "Data da recebimento"
L["SORT_BY_TRAVEL_DISTANCE"] = "Distância percorrida"
L["SORT_BY_TRAVEL_DURATION"] = "Duração de viagem"
L["SORT_BY_USAGE_COUNT"] = "Contagem de uso"
L["SORT_FAVORITES_FIRST"] = "Favoritos Primeiro"
L["SORT_REVERSE"] = "Ordem Inversa"
L["SORT_UNOWNED_BOTTOM"] = "Não aprendidos por último"
L["SORT_UNUSABLE_BOTTOM"] = "Inutilizável depois de utilizável"
--[[Translation missing --]]
--[[ L["STATS_TIP_LEARNED_DATE_HEAD"] = "Possession date"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_HEAD"] = "Rarity"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_TEXT"] = [=[% of characters who own this mount
Data is kindly provided by {RR}.]=]--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_DISTANCE_HEAD"] = "Travel distance"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_HEAD"] = "Travel time"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_TEXT"] = "in hours:minutes:seconds"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_USAGE_COUNT_HEAD"] = "Usage count"--]] 
L["TASK_END"] = "[MJE] Ufa! Terminei."
L["TASK_FAVOR_START"] = "[MJE] Reaplicando estrelas em todas as suas montagens. Por favor, espere alguns segundos até eu terminar."
L["TOGGLE_COLOR"] = "Mostrar próxima variação de cor"
L["Transform"] = "Transformar"

    -- Settings
L["DISPLAY_ALL_SETTINGS"] = "Exibir todas as configurações"
L[ [=[RESET_WINDOW_SIZE
]=] ] = "Redefinir tamanho do diário"
--[[Translation missing --]]
--[[ L["SETTING_ABOUT_AUTHOR"] = "Author"--]] 
L["SETTING_ACHIEVEMENT_POINTS"] = "Mostrar Pontos de Conquista"
L["SETTING_AUTO_FAVOR"] = "Definir automaticamente novas montagens como favoritas"
L["SETTING_COMPACT_LIST"] = "Lista de Montarias Compacta"
L["SETTING_CURSOR_KEYS"] = "Ativar as teclas para cima e para baixo para navegar pelas montarias"
L["SETTING_FAVORITE_PER_CHAR"] = "Montarias favoritas por personagem"
--[[Translation missing --]]
--[[ L["SETTING_HEAD_ABOUT"] = "About"--]] 
L["SETTING_HEAD_BEHAVIOUR"] = "Comportamento"
L["SETTING_MOUNT_COUNT"] = "Mostrar contagem de montaria pessoal"
L["SETTING_MOVE_EQUIPMENT"] = "Mova o slot do equipamento para a tela"
L["SETTING_PERSONAL_FILTER"] = "Aplicar filtros apenas para este personagem"
L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "Aplicar montarias ocultas apenas para este personagem"
L["SETTING_PERSONAL_UI"] = "Aplicar configurações de inferface apenas para este personagem"
L["SETTING_PREVIEW_LINK"] = "Mostrar Botão de Coleção na pré-visualização de montaria"
L["SETTING_SEARCH_MORE"] = "Pesquisar também no texto de descrição"
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_NOTES"] = "Search also in own notes"--]] 
L["SETTING_SHOP_BUTTON"] = "Mostrar o botão de loja em montarias de loja não aprendidas"
--[[Translation missing --]]
--[[ L["SETTING_SHOW_STATISTICS"] = "Show mount statistics in display"--]] 
L["SETTING_TRACK_USAGE"] = "Rastreie o comportamento de uso da montaria em todos os personagens"
L["SETTING_YCAMERA"] = "Desbloquear rotação vertical com o mouse na tela"

    -- Families
L["Airplanes"] = "Aviões"
L["Airships"] = "Dirigíveis"
L["Alpacas"] = "Alpacas"
L["Amphibian"] = "Anfíbios"
L["Animite"] = "Animácaros"
L["Aqir Flyers"] = "Aqir Voadores "
L["Arachnids"] = "Aracnídeos"
L["Assault Wagons"] = "Carroças de Assalto"
L["Basilisks"] = "Basiliscos"
L["Bats"] = "Morcegos"
L["Bears"] = "Ursos"
L["Bees"] = "Abelhas"
L["Birds"] = "Aves"
L["Blood Ticks"] = "Tiques Sangrentos"
L["Boars"] = "Javalis"
L["Book"] = "Livro"
L["Bovids"] = "Bovídeos"
L["Brutosaurs"] = "Brutossauros"
L["Camels"] = "Camelos"
L["Carnivorans"] = "Carnívoros"
L["Carpets"] = "Tapetes"
L["Cats"] = "Gatos"
L["Cervid"] = "Cervídeo"
L["Chargers"] = "Corcéis"
L["Chickens"] = "Galinhas"
L["Clefthooves"] = "Fenocerontes"
L["Cloud Serpents"] = "Serpentes das Nuvens"
L["Core Hounds"] = "Cães-Magma"
L["Crabs"] = "Caranguejos"
L["Cranes"] = "Garças"
L["Crawgs"] = "Crorgs"
L["Crocolisks"] = "Crocoliscos"
L["Crows"] = "Corvos"
L["Demonic Hounds"] = "Cães Demoníacos"
L["Demonic Steeds"] = "Corcéis Demoníacos"
L["Demons"] = "Demônios"
L["Devourer"] = "Devorador"
L["Dinosaurs"] = "Dinossauros"
L["Dire Wolves"] = "Lobos Hediondos"
L["Direhorns"] = "Escornantes"
L["Discs"] = "Discos"
L["Dragonhawks"] = "Falcodragos"
L["Drakes"] = "Dracos"
L["Dread Ravens"] = "Corvos Medonhos"
L["Elekks"] = "Elekks"
L["Elementals"] = "Elementais"
L["Falcosaurs"] = "Falcossauros"
L["Fathom Rays"] = "Raias-Profundas"
L["Feathermanes"] = "Aquifélix"
L["Felsabers"] = "Sabrevis"
L["Fish"] = "Peixe"
L["Flies"] = "Moscas"
L["Flying Steeds"] = "Corcéis Voadores"
L["Foxes"] = "Raposas"
L["Gargon"] = "Gargono"
L["Gargoyle"] = "Gárgula"
L["Goats"] = "Bodes"
L["Gorger"] = "Engolidor"
L["Gorm"] = "Gorm"
L["Grand Drakes"] = "Dracos Grandes"
L["Gronnlings"] = "Gronnídeos"
L["Gryphons"] = "Grifos"
L["Gyrocopters"] = "Girocóptero"
L["Hands"] = "Mãos"
L["Hawkstriders"] = "Falcostruzes"
L["Hippogryphs"] = "Hipogrifos"
L["Horned Steeds"] = "Corcéis com Chifres"
L["Horses"] = "Cavalos"
L["Hounds"] = "Cães"
L["Hovercraft"] = "Aerodeslizador"
L["Humanoids"] = "Humanoides"
L["Hyenas"] = "Hienas"
L["Infernals"] = "Infernais"
L["Insects"] = "Insetos"
L["Jellyfish"] = "Água-viva"
L["Jet Aerial Units"] = "Unidades Aéreas a Jato"
L["Kites"] = "Pipas"
L["Kodos"] = "Kodos"
L["Krolusks"] = "Croluscos"
L["Larion"] = "Larião"
L["Lions"] = "Leões"
L["Lupine"] = "Lupino"
L["Mammoths"] = "Mamutes"
L["Mana Rays"] = "Arraias de Mana"
L["Manasabers"] = "Manassabres"
L["Mauler"] = "Espancador"
L["Mechanical Animals"] = "Animais Mecânicos"
L["Mechanical Birds"] = "Pássaros Mecânicos"
L["Mechanical Cats"] = "Gatos Mecânicos"
L["Mechanical Steeds"] = "Corcéis Mecânicos"
L["Mechanostriders"] = "Mecanostruzes"
L["Mecha-suits"] = "Mecatrajes"
L["Moose"] = "Alce"
L["Moth"] = "Mariposa"
L["Motorcycles"] = "Motocicletas"
L["Mountain Horses"] = "Cavalos da Montanha"
L["Mushan"] = "Mushan"
L["Nether Drakes"] = "Dracos Etéreos"
L["Nether Rays"] = "Arraias Etéreas "
L["N'Zoth Serpents"] = "Serpentes de N'Zoth"
L["Others"] = "Outros"
L["Ox"] = "Boi"
L["Pandaren Phoenixes"] = "Fênix Pandarênicas"
L["Parrots"] = "Papagaios"
L["Phoenixes"] = "Fênix"
L["Proto-Drakes"] = "Protodracos"
L["Pterrordaxes"] = "Pterrordaxes"
L["Quilen"] = "Quílen"
L["Rams"] = "Carneiros"
L["Raptora"] = "Raptora"
L["Raptors"] = "Raptores"
L["Rats"] = "Ratos"
L["Ravagers"] = "Assoladores"
L["Rays"] = "Arraias"
L["Razorwing"] = "Talhasa"
L["Reptiles"] = "Répteis"
L["Rhinos"] = "Rinocerontes"
L["Riverbeasts"] = "Feras-do-rio"
L["Roc"] = "Rocas"
L["Rockets"] = "Foguetes"
L["Ruinstriders"] = "Andarilho das Ruínas"
L["Runestag"] = "Runicervo"
L["Rylaks"] = "Rylaks"
L["Sabers"] = "Sabres"
L["Scorpions"] = "Escorpiões"
L["Sea Serpents"] = "Serpente Marinha"
L["Seahorses"] = "Cavalos-marinhos"
L["Seat"] = "Assento"
L["Silithids"] = "Silitídeos"
L["Snail"] = "Caracol"
L["Snapdragons"] = "Dracoliscos"
L["Spider Tanks"] = "Tanques Aranha"
L["Spiders"] = "Aranhas"
L["Steeds"] = "Corcéis"
L["Stingrays"] = "Arraias Aguilhantes"
L["Stone Cats"] = "Gatos de Pedra"
L["Stone Drakes"] = "Dracos de Pedra"
L["Talbuks"] = "Talbulques"
L["Tallstriders"] = "Moas"
L["Talonbirds"] = "Pássaros-garra"
L["Tauralus"] = "Tauralus"
L["Tigers"] = "Tigres"
L["Toads"] = "Sapos"
L["Turtles"] = "Tartarugas"
L["Undead Drakes"] = "Dracos Mortos-vivos"
L["Undead Steeds"] = "Corcéis Mortos-vivos"
L["Undead Wolves"] = "Lobos Mortos-vivos"
L["Ungulates"] = "Ungulados"
L["Ur'zul"] = "Ur'zul"
L["Vehicles"] = "Veículos"
L["Vombata"] = "Vombate"
L["Vulpin"] = "Vulpino"
L["Vultures"] = "Abutres"
L["War Wolves"] = "Lobos de Guerra"
L["Wasp"] = "Vespa"
L["Water Striders"] = "Caminhante das Águas "
L["Wilderlings"] = "Silvestritos"
L["Wind Drakes"] = "Dracos do Vento"
L["Wolfhawks"] = "Falcolobos"
L["Wolves"] = "Lobos"
L["Wyverns"] = "Mantícoras"
L["Yaks"] = "Iaques"
L["Yetis"] = "Yetis"


elseif locale == "ruRU" then
    ADDON.isMetric = true
    L["Black Market"] = "Черный рынок"
L["DRESSUP_LABEL"] = "Журнал"
L["Family"] = "Семейство"
L["FAVOR_AUTO"] = "Автоматически добавлять новый транспорт в избранное"
L["FAVOR_DISPLAYED"] = "Показать всех"
L["FAVOR_PER_CHARACTER"] = "Избранный транспорт для каждого персонажа"
L["FILTER_ONLY_LATEST"] = "Только последний патч"
L["FILTER_SECRET"] = "Скрытые игрой"
L["Hidden"] = "Скрытые"
L["Only tradable"] = "Только передающиеся"
L["Passenger"] = "Пассажирские"
L["Reset filters"] = "Сбросить фильтры"
L["ROTATE_DOWN"] = "Вращение вниз"
L["ROTATE_UP"] = "Вращение вверх"
L["SORT_BY_LAST_USAGE"] = "Последнее использование"
L["SORT_BY_LEARNED_DATE"] = "Дата получения"
L["SORT_BY_TRAVEL_DISTANCE"] = "Преодоленное расстояние"
L["SORT_BY_TRAVEL_DURATION"] = "Продолжительность поездки"
L["SORT_BY_USAGE_COUNT"] = "Количество использований"
L["SORT_FAVORITES_FIRST"] = "Избранные первыми"
L["SORT_REVERSE"] = "Обратная сортировка"
L["SORT_UNOWNED_BOTTOM"] = "Не полученные в конце списка"
L["SORT_UNUSABLE_BOTTOM"] = "Не используемые после используемых"
--[[Translation missing --]]
--[[ L["STATS_TIP_LEARNED_DATE_HEAD"] = "Possession date"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_HEAD"] = "Rarity"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_TEXT"] = [=[% of characters who own this mount
Data is kindly provided by {RR}.]=]--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_DISTANCE_HEAD"] = "Travel distance"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_HEAD"] = "Travel time"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_TEXT"] = "in hours:minutes:seconds"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_USAGE_COUNT_HEAD"] = "Usage count"--]] 
L["TASK_END"] = "[MJE] Фух! Все готово."
L["TASK_FAVOR_START"] = "[MJE] Применяю звездочки для всего вашего транспорта. Пожалуйста подождите пару секунд  для завершения."
L["TOGGLE_COLOR"] = "Показать следующую вариацию цвета"
L["Transform"] = "Трансформация"

    -- Settings
L["DISPLAY_ALL_SETTINGS"] = "Показать все настройки"
L[ [=[RESET_WINDOW_SIZE
]=] ] = "Сбросить настройки журнала"
--[[Translation missing --]]
--[[ L["SETTING_ABOUT_AUTHOR"] = "Author"--]] 
L["SETTING_ACHIEVEMENT_POINTS"] = "Показать достижения"
L["SETTING_AUTO_FAVOR"] = "Автоматически добавлять новый транспорт в избранное"
L["SETTING_COMPACT_LIST"] = "Компактный список транспорта"
L["SETTING_CURSOR_KEYS"] = "Включить Клавиши \"Вверх\" и \"Вниз\" для навигации по списку транспорта"
L["SETTING_FAVORITE_PER_CHAR"] = "Избранный транспорт для персонажа"
--[[Translation missing --]]
--[[ L["SETTING_HEAD_ABOUT"] = "About"--]] 
L["SETTING_HEAD_BEHAVIOUR"] = "Поведение"
L["SETTING_MOUNT_COUNT"] = "Показать персональный счетчик транспорта"
L["SETTING_MOVE_EQUIPMENT"] = "Переместить слот экипировки на экран обзора"
L["SETTING_PERSONAL_FILTER"] = "Применить фильтры только для этого персонажа"
L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "Применить скрытый транспорт только для этого персонажа"
L["SETTING_PERSONAL_UI"] = "Применить настройки интерфейса только для этого персонажа"
L["SETTING_PREVIEW_LINK"] = "Показать кнопку коллекции на экрана обзора транспорта"
L["SETTING_SEARCH_MORE"] = "Искать также в описании транспорта"
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_NOTES"] = "Search also in own notes"--]] 
L["SETTING_SHOP_BUTTON"] = "Показать кнопку магазина на неизученном транспорте из магазина"
--[[Translation missing --]]
--[[ L["SETTING_SHOW_STATISTICS"] = "Show mount statistics in display"--]] 
L["SETTING_TRACK_USAGE"] = "Отслеживание использования транспорта для всех персонажей"
L["SETTING_YCAMERA"] = "Разблокировать вертикальное вращение транспорта с помощью мыши"

    -- Families
L["Airplanes"] = "Самолеты"
L["Airships"] = "Воздушные Судна"
L["Alpacas"] = "Альпаки"
L["Amphibian"] = "Амфибии"
L["Animite"] = "Анимаклещи"
L["Aqir Flyers"] = "Акиры Летуны"
L["Arachnids"] = "Арахниды"
L["Assault Wagons"] = "Штурмовые Повозки"
L["Basilisks"] = "Василиски"
L["Bats"] = "Летучие мыши"
L["Bears"] = "Медведи"
L["Bees"] = "Пчелы"
L["Birds"] = "Птицы"
L["Blood Ticks"] = "Кровяной Клещ"
L["Boars"] = "Кабаны"
L["Book"] = "Книги"
L["Bovids"] = "Полорогие"
L["Brutosaurs"] = "Брутозавры"
L["Camels"] = "Верблюды"
L["Carnivorans"] = "Плотоядные"
L["Carpets"] = "Ковры"
L["Cats"] = "Кошки"
L["Cervid"] = "Сервиды"
L["Chargers"] = "Скакуны"
L["Chickens"] = "Курицы"
L["Clefthooves"] = "Копытни"
L["Cloud Serpents"] = "Облачные змеи"
L["Core Hounds"] = "Гончие Недр"
L["Crabs"] = "Крабы"
L["Cranes"] = "Журавли"
L["Crawgs"] = "Кроги"
L["Crocolisks"] = "Кроколиски"
L["Crows"] = "Вороны"
L["Demonic Hounds"] = "Демонические Гончие"
L["Demonic Steeds"] = "Демонические Скакуны"
L["Demons"] = "Демонические"
L["Devourer"] = "Пожиратели"
L["Dinosaurs"] = "Динозавры"
L["Dire Wolves"] = "Лютоволки"
L["Direhorns"] = "Дикороги"
L["Discs"] = "Диски"
L["Dragonhawks"] = "Дракондоры"
L["Drakes"] = "Драконы"
L["Dread Ravens"] = "Грозные вороны"
L["Elekks"] = "Элекки"
L["Elementals"] = "Элементали"
L["Falcosaurs"] = "Грифозавры"
L["Fathom Rays"] = "Глубинные Скаты"
L["Feathermanes"] = "Пернатые"
L["Felsabers"] = "Саблезубы"
L["Fish"] = "Рыбы"
L["Flies"] = "Мухи"
L["Flying Steeds"] = "Летающие Скакуны"
L["Foxes"] = "Лисы"
L["Gargon"] = "Гаргоны"
L["Gargoyle"] = "Гаргульи"
L["Goats"] = "Козлы"
L["Gorger"] = "Поглотители"
L["Gorm"] = "Гормы"
L["Grand Drakes"] = "Великие Драконы"
L["Gronnlings"] = "Малые гронны"
L["Gryphons"] = "Грифоны"
L["Gyrocopters"] = "Гирокоптеры"
L["Hands"] = "Руки"
L["Hawkstriders"] = "Крылобеги"
L["Hippogryphs"] = "Гиппогрифы"
L["Horned Steeds"] = "Рогатые Скакуны"
L["Horses"] = "Скакуны"
L["Hounds"] = "Гончие"
L["Hovercraft"] = "Везделеты"
L["Humanoids"] = "Гуманоиды"
L["Hyenas"] = "Гиены"
L["Infernals"] = "Инферналы"
L["Insects"] = "Насекомые"
L["Jellyfish"] = "Медузы"
L["Jet Aerial Units"] = "Реактивные Воздушные"
L["Kites"] = "Воздушные Змеи"
L["Kodos"] = "Кодо"
L["Krolusks"] = "Кролуски"
L["Larion"] = "Ларионы"
L["Lions"] = "Львы"
L["Lupine"] = "Люпины"
L["Mammoths"] = "Мамонты"
L["Mana Rays"] = "Манаскаты"
L["Manasabers"] = "Манапарды"
L["Mauler"] = "Терзатели"
L["Mechanical Animals"] = "Механические Животные"
L["Mechanical Birds"] = "Механические Птицы"
L["Mechanical Cats"] = "Механические Кошки"
L["Mechanical Steeds"] = "Механические Скакуны"
L["Mechanostriders"] = "Механодолгоноги"
L["Mecha-suits"] = "Мехакостюмы"
L["Moose"] = "Лоси"
L["Moth"] = "Мотыльки"
L["Motorcycles"] = "Мотоциклы"
L["Mountain Horses"] = "Горные Скакуны"
L["Mushan"] = "Мушаны"
L["Nether Drakes"] = "Драконы Пустоты"
L["Nether Rays"] = "Скаты Пустоты"
L["N'Zoth Serpents"] = "Черви Н'Зота"
L["Others"] = "Прочие"
L["Ox"] = "Волы"
L["Pandaren Phoenixes"] = "Пандаренские Фениксы"
L["Parrots"] = "Попугаи"
L["Phoenixes"] = "Фениксы"
L["Proto-Drakes"] = "Протодраконы"
L["Pterrordaxes"] = "Терродактили"
L["Quilen"] = "Цийлини"
L["Rams"] = "Бараны"
L["Raptora"] = "Рапторы"
L["Raptors"] = "Ящеры"
L["Rats"] = "Крысы"
L["Ravagers"] = "Опустошители"
L["Rays"] = "Скаты"
L["Razorwing"] = "Острокрылы"
L["Reptiles"] = "Рептилии"
L["Rhinos"] = "Носороги"
L["Riverbeasts"] = "Речные чудовища"
L["Roc"] = "Рухи"
L["Rockets"] = "Ракеты"
L["Ruinstriders"] = "Скитальцы"
L["Runestag"] = "Рунический Олень"
L["Rylaks"] = "Рилаки"
L["Sabers"] = "Саблезубы"
L["Scorpions"] = "Скорпионы"
L["Sea Serpents"] = "Морские Змеи"
L["Seahorses"] = "Морские коньки"
L["Seat"] = "Повозки"
L["Silithids"] = "Силитиды"
L["Snail"] = "Улитки"
L["Snapdragons"] = "Вараны"
L["Spider Tanks"] = "Механопауки"
L["Spiders"] = "Пауки"
L["Steeds"] = "Кони"
L["Stingrays"] = "Жалохвосты"
L["Stone Cats"] = "Каменные Кошки"
L["Stone Drakes"] = "Каменные Драконы"
L["Talbuks"] = "Талбуки"
L["Tallstriders"] = "Долгоноги"
L["Talonbirds"] = "Когти"
L["Tauralus"] = "Тауралы"
L["Tigers"] = "Тигры"
L["Toads"] = "Жабы"
L["Turtles"] = "Черепахи"
L["Undead Drakes"] = "Драконы Нежить"
L["Undead Steeds"] = "Скакуны Нежить"
L["Undead Wolves"] = "Волки Нежить"
L["Ungulates"] = "Копытные"
L["Ur'zul"] = "Ур'зул"
L["Vehicles"] = "Транспортные средства"
L["Vombata"] = "Вомбаты"
L["Vulpin"] = "Лисохвосты"
L["Vultures"] = "Падальщики"
L["War Wolves"] = "Боевые Волки"
L["Wasp"] = "Осы"
L["Water Striders"] = "Водные долгоноги"
L["Wilderlings"] = "Чащобники"
L["Wind Drakes"] = "Драконы Ветра"
L["Wolfhawks"] = "Звероястребы"
L["Wolves"] = "Волки"
L["Wyverns"] = "Виверны"
L["Yaks"] = "Яки"
L["Yetis"] = "Йети"


elseif locale == "zhCN" then
    ADDON.isMetric = true
    L["Black Market"] = "黑市"
--[[Translation missing --]]
--[[ L["DRESSUP_LABEL"] = "Journal"--]] 
L["Family"] = "系列"
--[[Translation missing --]]
--[[ L["FAVOR_AUTO"] = "Auto-favor new mounts"--]] 
L["FAVOR_DISPLAYED"] = "全部显示"
L["FAVOR_PER_CHARACTER"] = "每角色"
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden by the game"--]] 
L["Hidden"] = "隐藏"
L["Only tradable"] = "仅可交易"
L["Passenger"] = "载客"
L["Reset filters"] = "重置过滤器"
L["ROTATE_DOWN"] = "向下旋转"
L["ROTATE_UP"] = "向上旋转"
--[[Translation missing --]]
--[[ L["SORT_BY_LAST_USAGE"] = "Last usage"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_LEARNED_DATE"] = "Date of receipt"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_TRAVEL_DISTANCE"] = "Travelled distance"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_TRAVEL_DURATION"] = "Travelled duration"--]] 
--[[Translation missing --]]
--[[ L["SORT_BY_USAGE_COUNT"] = "Count of usage"--]] 
L["SORT_FAVORITES_FIRST"] = "收藏优先"
L["SORT_REVERSE"] = "反向排序"
L["SORT_UNOWNED_BOTTOM"] = "未收集在底部"
--[[Translation missing --]]
--[[ L["SORT_UNUSABLE_BOTTOM"] = "Unusable after Usable"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_LEARNED_DATE_HEAD"] = "Possession date"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_HEAD"] = "Rarity"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_RARITY_TEXT"] = [=[% of characters who own this mount
Data is kindly provided by {RR}.]=]--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_DISTANCE_HEAD"] = "Travel distance"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_HEAD"] = "Travel time"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_TRAVEL_TIME_TEXT"] = "in hours:minutes:seconds"--]] 
--[[Translation missing --]]
--[[ L["STATS_TIP_USAGE_COUNT_HEAD"] = "Usage count"--]] 
L["TASK_END"] = "[MJE] 唷！完成了。"
L["TASK_FAVOR_START"] = "[MJE] 正在给你的坐骑重新标星收藏。请等待一会儿直到完成。"
--[[Translation missing --]]
--[[ L["TOGGLE_COLOR"] = "Show next color variation"--]] 
L["Transform"] = "变形"

    -- Settings
--[[Translation missing --]]
--[[ L["DISPLAY_ALL_SETTINGS"] = "Display all settings"--]] 
--[[Translation missing --]]
--[[ L[ [=[RESET_WINDOW_SIZE
]=] ] = "Reset journal size"--]] 
--[[Translation missing --]]
--[[ L["SETTING_ABOUT_AUTHOR"] = "Author"--]] 
L["SETTING_ACHIEVEMENT_POINTS"] = "显示成就点"
--[[Translation missing --]]
--[[ L["SETTING_AUTO_FAVOR"] = "Automatically set new mounts as favorite"--]] 
L["SETTING_COMPACT_LIST"] = "紧凑坐骑列表"
L["SETTING_CURSOR_KEYS"] = "启用上下键浏览坐骑"
L["SETTING_FAVORITE_PER_CHAR"] = "每角色坐骑收藏"
--[[Translation missing --]]
--[[ L["SETTING_HEAD_ABOUT"] = "About"--]] 
L["SETTING_HEAD_BEHAVIOUR"] = "行为"
L["SETTING_MOUNT_COUNT"] = "显示个人坐骑数量"
L["SETTING_MOVE_EQUIPMENT"] = "移动装备插槽到展示窗口"
L["SETTING_PERSONAL_FILTER"] = "仅对这个角色应用过滤器"
L["SETTING_PERSONAL_HIDDEN_MOUNTS"] = "仅对这个角色应用坐骑隐藏"
L["SETTING_PERSONAL_UI"] = "仅对这个角色应用界面设置"
L["SETTING_PREVIEW_LINK"] = "在坐骑预览中显示收集按钮"
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_MORE"] = "Search also in description text"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_NOTES"] = "Search also in own notes"--]] 
L["SETTING_SHOP_BUTTON"] = "在未学习的商店坐骑上显示购买按钮"
--[[Translation missing --]]
--[[ L["SETTING_SHOW_STATISTICS"] = "Show mount statistics in display"--]] 
L["SETTING_TRACK_USAGE"] = "跟踪所有角色的坐骑使用行为"
L["SETTING_YCAMERA"] = "展示窗解锁鼠标Y轴旋转"

    -- Families
L["Airplanes"] = "飞机"
L["Airships"] = "飞艇"
L["Alpacas"] = "羊驼"
L["Amphibian"] = "两栖"
L["Animite"] = "飞虫"
L["Aqir Flyers"] = "工蜂"
L["Arachnids"] = "蛛形"
L["Assault Wagons"] = "攻城车"
L["Basilisks"] = "蜥蜴"
L["Bats"] = "蝙蝠"
L["Bears"] = "熊"
L["Bees"] = "蜜蜂"
L["Birds"] = "鸟"
L["Blood Ticks"] = "吮血蛛"
L["Boars"] = "野猪"
--[[Translation missing --]]
--[[ L["Book"] = "Book"--]] 
L["Bovids"] = "牛"
L["Brutosaurs"] = "雷龙"
L["Camels"] = "骆驼"
L["Carnivorans"] = "食肉"
L["Carpets"] = "飞毯"
L["Cats"] = "猫"
--[[Translation missing --]]
--[[ L["Cervid"] = "Cervid"--]] 
L["Chargers"] = "战马"
L["Chickens"] = "鸡"
L["Clefthooves"] = "裂蹄牛"
L["Cloud Serpents"] = "云端翔龙"
L["Core Hounds"] = "熔火犬"
L["Crabs"] = "螃蟹"
L["Cranes"] = "仙鹤"
L["Crawgs"] = "抱齿兽"
L["Crocolisks"] = "鳄鱼"
L["Crows"] = "乌鸦"
L["Demonic Hounds"] = "恶魔犬"
L["Demonic Steeds"] = "恶魔马"
L["Demons"] = "恶魔"
--[[Translation missing --]]
--[[ L["Devourer"] = "Devourer"--]] 
L["Dinosaurs"] = "恐龙"
L["Dire Wolves"] = "恐狼"
L["Direhorns"] = "恐角龙"
L["Discs"] = "飞碟"
L["Dragonhawks"] = "龙鹰"
L["Drakes"] = "龙"
L["Dread Ravens"] = "恐鸦"
L["Elekks"] = "雷象"
L["Elementals"] = "元素"
L["Falcosaurs"] = "猎龙"
L["Fathom Rays"] = "海波鳐"
L["Feathermanes"] = "羽鬃"
L["Felsabers"] = "邪刃豹"
L["Fish"] = "鱼"
--[[Translation missing --]]
--[[ L["Flies"] = "Flies"--]] 
L["Flying Steeds"] = "天马"
L["Foxes"] = "狐"
L["Gargon"] = "加尔贡"
--[[Translation missing --]]
--[[ L["Gargoyle"] = "Gargoyle"--]] 
L["Goats"] = "山羊"
L["Gorger"] = "饕餮者"
L["Gorm"] = "甲虫"
L["Grand Drakes"] = "大型龙"
L["Gronnlings"] = "小戈隆"
L["Gryphons"] = "狮鹫"
L["Gyrocopters"] = "旋翼"
--[[Translation missing --]]
--[[ L["Hands"] = "Hands"--]] 
L["Hawkstriders"] = "陆行鸟"
L["Hippogryphs"] = "角鹰"
L["Horned Steeds"] = "角马"
L["Horses"] = "马"
L["Hounds"] = "犬"
L["Hovercraft"] = "气垫船"
L["Humanoids"] = "人型"
L["Hyenas"] = "狼"
L["Infernals"] = "地狱火"
L["Insects"] = "昆虫"
L["Jellyfish"] = "水母"
L["Jet Aerial Units"] = "空中单位"
L["Kites"] = "风筝"
L["Kodos"] = "科多兽"
L["Krolusks"] = "三叶虫"
L["Larion"] = "羽鬃兽"
L["Lions"] = "狮"
--[[Translation missing --]]
--[[ L["Lupine"] = "Lupine"--]] 
L["Mammoths"] = "猛犸象"
L["Mana Rays"] = "法力鳐"
L["Manasabers"] = "魔刃豹"
--[[Translation missing --]]
--[[ L["Mauler"] = "Mauler"--]] 
L["Mechanical Animals"] = "机械生物"
L["Mechanical Birds"] = "机械鸟"
L["Mechanical Cats"] = "机械猫"
L["Mechanical Steeds"] = "机械马"
L["Mechanostriders"] = "机械陆行鸟"
L["Mecha-suits"] = "机甲"
L["Moose"] = "驼鹿"
L["Moth"] = "蛾"
L["Motorcycles"] = "摩托车"
L["Mountain Horses"] = "山地马"
L["Mushan"] = "穆山兽"
L["Nether Drakes"] = "灵翼幼龙"
L["Nether Rays"] = "虚空鳐"
L["N'Zoth Serpents"] = "恩佐斯蛇"
L["Others"] = "其他"
--[[Translation missing --]]
--[[ L["Ox"] = "Ox"--]] 
L["Pandaren Phoenixes"] = "熊猫人凤凰"
L["Parrots"] = "鹦鹉"
L["Phoenixes"] = "凤凰"
L["Proto-Drakes"] = "始祖幼龙"
L["Pterrordaxes"] = "啸天龙"
L["Quilen"] = "魁麟"
L["Rams"] = "公羊"
--[[Translation missing --]]
--[[ L["Raptora"] = "Raptora"--]] 
L["Raptors"] = "迅猛龙"
L["Rats"] = "鼠"
L["Ravagers"] = "掠夺者"
L["Rays"] = "鳐"
--[[Translation missing --]]
--[[ L["Razorwing"] = "Razorwing"--]] 
L["Reptiles"] = "爬虫"
L["Rhinos"] = "犀牛"
L["Riverbeasts"] = "淡水兽"
L["Roc"] = "大鹏"
L["Rockets"] = "火箭"
L["Ruinstriders"] = "游荡者"
L["Runestag"] = "符文牡鹿"
L["Rylaks"] = "魔龙"
L["Sabers"] = "刃豹"
L["Scorpions"] = "蝎子"
L["Sea Serpents"] = "海蛇"
L["Seahorses"] = "海马"
L["Seat"] = "摇篮"
L["Silithids"] = "异种蝎"
--[[Translation missing --]]
--[[ L["Snail"] = "Snail"--]] 
L["Snapdragons"] = "毒鳍龙"
L["Spider Tanks"] = "蜘蛛坦克"
L["Spiders"] = "蜘蛛"
L["Steeds"] = "马"
L["Stingrays"] = "鳐鱼"
L["Stone Cats"] = "石猎豹"
L["Stone Drakes"] = "石幼龙"
L["Talbuks"] = "塔布羊"
L["Tallstriders"] = "蛇鸟"
L["Talonbirds"] = "鸦神"
L["Tauralus"] = "荒牛"
L["Tigers"] = "虎"
L["Toads"] = "蟾蜍"
L["Turtles"] = "龟"
L["Undead Drakes"] = "不死幼龙"
L["Undead Steeds"] = "不死战马"
L["Undead Wolves"] = "不死战狼"
L["Ungulates"] = "有蹄"
L["Ur'zul"] = "乌祖尔"
L["Vehicles"] = "载具"
--[[Translation missing --]]
--[[ L["Vombata"] = "Vombata"--]] 
L["Vulpin"] = "烁裘"
L["Vultures"] = "秃鹫"
L["War Wolves"] = "战狼"
--[[Translation missing --]]
--[[ L["Wasp"] = "Wasp"--]] 
L["Water Striders"] = "水黾"
--[[Translation missing --]]
--[[ L["Wilderlings"] = "Wilderlings"--]] 
L["Wind Drakes"] = "风幼龙"
L["Wolfhawks"] = "狼鹰"
L["Wolves"] = "狼"
L["Wyverns"] = "双足飞龙"
L["Yaks"] = "牦牛"
L["Yetis"] = "雪人"

end