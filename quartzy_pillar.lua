-- Author: This mod was made by Norbert Thien, multimediamobil – Region Süd (mmmsued), 2025
-- Code: Except otherwise specified, all code in this project is licensed as LGPLv3.
-- Media: Except otherwise specified, all media and any other content in this project which is not source code is licensed as CC BY SA 3.0. 

local S = minetest.get_translator("quartzy")
local setting_for_inventory = tonumber(minetest.settings:get("quartzy_disable_for_inventory") or 1)

local definition = {							-- Beginn verschachtelte Tabelle »definition« für »Quartzy Pillar«
	{"quartzy_pillar_white", "Pillar white"}, 	-- 1. Eintrag der Unter-Tabelle für Node-Name, Textur, Rezept - 2. Eintrag für Description
    {"quartzy_pillar_light_gray", "Pillar light gray"},
	{"quartzy_pillar_gray", "Pillar gray"},
	{"quartzy_pillar_dark_gray", "Pillar dark gray"},
	{"quartzy_pillar_pink", "Pillar pink"},
	{"quartzy_pillar_dark_pink", "Pillar dark pink"}
}												-- Ende verschachtelte Tabelle »definition«

local name = "" 		-- lokale Variablen, die später in der for-Schleife benötigt werden
local description = ""	-- lokale Variablen, die später in der for-Schleife benötigt werden


for _, row in ipairs(definition) do -- Schleife zum Auslesen der Tabelle »definition«, _ (Unterstrich): übliches formales Vorgehen, wenn ein Rückgabewert nicht benötigt wird, aber abgefangen werden muss

	name = row[1]			-- ersten Eintrag aus der inneren Tabelle »definition« auslesen und der lokalen Variable »name« zuweisen
	description = row[2]	-- zweiten Eintrag aus der inneren Tabelle »definition« auslesen und der lokalen Variable »description« zuweisen

	minetest.register_node("quartzy:" .. name, {	-- zusammengesetzten Node-Namen generieren
		description = S("Quartzy " .. description),	-- zusammengesetzte Beschreibung generieren
		drawtype = "nodebox",
		tiles = {
			name .. "_top.png", name .. "_bottom.png", name .. "_side.png"	-- zusammengesetzten Textur-Namen generieren
		},
		paramtype2 = "facedir", -- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
		groups = {
			cracky = 3,
            stone = 1
		},
		sounds = default.node_sound_stone_defaults()
	})


    -- Zugriff auf den Mod »moreblocks« (genauer auf »stairsplus« - siehe dort »API.md«) - in der »mod.conf« muss »optional_depends = moreblocks« stehen
	if minetest.get_modpath("moreblocks") then
	    stairsplus:register_all("quartzy", name, "quartzy:" .. name, {	-- zusammengesetzte Namen generieren
            description = "Quartzy " .. description,					-- zusammengesetzte Beschreibung generieren
			drawtype = "nodebox",	
			tiles = {
				name .. "_top.png", name .. "_bottom.png", name .. "_side.png"	-- zusammengesetzten Textur-Namen generieren
			},
			paramtype = "light",	-- verhindert u. a. fehlerhafte Lichtberechnung bei Quadern ohne Kantenlänge 1x1x1. Nachteil: Block wird insgesamt lichtdurchlässing
			paramtype2 = "facedir", -- macht Objekt mit Schraubendreher rotierbar und richtet -Z-Seite beim Ablegen immer in Richtung des Ablegenden
		    groups = {
			    cracky = 3,
                stone = 1,
                not_in_creative_inventory = setting_for_inventory   -- verhindert, dass der Output der Kreissäge im Kreativ-Modus das Inventar überfluten
		    },
			sounds = default.node_sound_stone_defaults()
	    })
	end -- Ende der if-Abfrage zu minetest.get_modpath() - Start in Zeile 42
end     -- Ende for-Schleife (Start in Zeile 21)


-- Rezepte für »Quartzy Pillar« herstellen
local crafting_array = {    					-- Beginn verschachtelte Tabelle für »Quartzy Pillar«-Rezepte
	{"", "quartzy:quartzy_raw", ""},
	{"", "", ""},
	{"", "", ""}
}												-- Ende verschachtelte Tabelle für »Quartzy Pillar«-Rezepte

local crafting_input = "quartzy:quartzy_raw" 	-- lokale Variable, die später in der inneren for-Schleife neuen Wert in Tabelle »crafting_array« setzt
local crafting_index = 2 						-- lokale Variable, die später in der for-Schleife die obige Tabelle »crafting_array« ansteuert
local quartzy_name = 1							-- Namen aus der obigen Tabelle »definition« auslesen

for irow = crafting_index,3 do 					-- äußere Schleife für die Zeilen des Crafting-Gitters
  for icell = 1, 3 do							-- innere Schleife für die Zellen des Crafting-Gitters
      crafting_array[irow][icell] = crafting_input
	  	minetest.register_craft({
		output = "quartzy:" .. definition[quartzy_name][1],		-- zusammengesetzten Output-Namen generieren
		recipe = crafting_array
	})

      crafting_array[irow][icell] = ""			-- die Tabelle »crafting_array« wieder auf Originalbelegung zurücksetzen
	  quartzy_name = quartzy_name + 1			-- Tabellenindex für »definition« hochzählen
  end
end