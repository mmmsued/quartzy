-- Author: This mod was made by Norbert Thien, multimediamobil – Region Süd (mmmsued), 2025
-- Code: Except otherwise specified, all code in this project is licensed as LGPLv3.
-- Media: Except otherwise specified, all media and any other content in this project which is not source code is licensed as CC BY SA 3.0. 

local S = minetest.get_translator("quartzy")

--  Quartzy Crafting Material
minetest.register_craftitem("quartzy:quartzy_raw", {
	description = S("Quartzy Raw"),
	inventory_image = "quartzy_raw.png",
})


dofile(minetest.get_modpath("quartzy").."/quartzy_brick.lua")
dofile(minetest.get_modpath("quartzy").."/quartzy_chiseled.lua")
dofile(minetest.get_modpath("quartzy").."/quartzy_pillar.lua")
dofile(minetest.get_modpath("quartzy").."/quartzy_plain.lua")