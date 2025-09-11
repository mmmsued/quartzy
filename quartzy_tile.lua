-- Author: This mod was made by Norbert Thien, multimediamobil – Region Süd (mmmsued), 2025
-- Code: Except otherwise specified, all code in this project is licensed as LGPLv3.
-- Media: Except otherwise specified, all media and any other content in this project which is not source code is licensed as CC BY SA 3.0. 

local setting_for_inventory = tonumber(minetest.settings:get("quartzy_disable_for_inventory") or 1)

local definition = {    -- Beginn verschachtelte Tabelle
	{"quartzy_tile_white", "Tile white"}, -- 1. Eintrag der Unter-Tabelle für Node-Name, Textur, Rezept - 2. Eintrag für Description
	{"quartzy_tile_light_gray", "Tile light gray"},
	{"quartzy_tile_gray", "Tile gray"},
	{"quartzy_tile_dark_gray", "Tile dark gray"},
	{"quartzy_tile_pink", "Tile pink"},
	{"quartzy_tile_dark_pink", "Tile dark pink"}
} -- Ende verschachtelte Tabelle

for _, row in ipairs(definition) do -- Schleife zum Auslesen der Tabelle »definition«, _ (Unterstrich): übliches formales Vorgehen, wenn ein Rückgabewert nicht benötigt wird, aber abgefangen werden muss

	local name = row[1]			-- ersten Eintrag aus der inneren Tabelle auslesen und der lokalen Variable »name« zuweisen (der Variablenname könnte auch anders lauten)
	local description = row[2]	-- zweiten Eintrag aus der inneren Tabelle auslesen und der lokalen Variable »description« zuweisen (der Variablenname könnte auch anders lauten)

	minetest.register_node("quartzy:" .. name, {		-- zusammengesetzten Node-Namen generieren
		description = "Quartzy " .. description,	-- zusammengesetzte Beschreibung generieren
		drawtype = "nodebox",
		paramtype2 = "facedir",
		tiles = {
			name .. ".png"	-- zusammengesetzten Textur-Namen generieren
		},
		groups = {
			cracky = 3,
            stone = 1
		},
		sounds = default.node_sound_stone_defaults()
	})


    -- Zugriff auf den Mod »moreblocks« (genauer auf »stairsplus« - siehe dort »API.md«) - in der »mod.conf« muss »optional_depends = moreblocks« stehen
	if minetest.get_modpath("moreblocks") then
	    stairsplus:register_all("quartzy", name, "quartzy:" .. name, {	-- zusammengesetzte Namen generieren
            description = "Quartzy " .. description,	-- zusammengesetzte Beschreibung generieren
			drawtype = "nodebox",
			paramtype2 = "facedir",
			tiles = {
				name .. ".png"	-- zusammengesetzten Textur-Namen generieren
			},
			paramtype = "light",	-- verhindert u. a. fehlerhafte Lichtberechnung bei Quadern ohne Kantenlänge 1x1x1. Nachteil: Block wird insgesamt lichtdurchlässing
			paramtype2 = "facedir",	-- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
		    groups = {
			    cracky = 3,
                stone = 1,
                not_in_creative_inventory = setting_for_inventory   -- verhindert, dass alle Formen, die die Kreissäge produzieren kann, im Kreativ-Modus das Inventar überfluten
		    },
			sounds = default.node_sound_stone_defaults()
	    })
	end -- Ende der if-Abfrage zu minetest.get_modpath() - Start in Zeile 35

end     -- Ende for-Schleife (Start in Zeile 16)