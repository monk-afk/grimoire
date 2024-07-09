  --==[[   Grimoire - 0.2.0   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local path = minetest.get_modpath(minetest.get_current_modname()).."/"

local page = "grimoire_page_manipulate.lua"

   -- Chat command method calls
minetest.register_chatcommand("grimoire", {
  description = "Do functions from file",
  params = "<param> [<argument>]",
  privs = {server = true},
  func = function(name, params)
    local param, argument = params:match("^([%S]+)%s*([%S]*)$")
    if not param then return end
    local invoke = dofile(path .. "methods_chat.lua")
    if param == "page" then
      page = invoke(name, param)[param](argument) or page
      minetest.chat_send_player(name, "Grimoire page set to "..page)
    else
      invoke(name, param)[param](argument)
    end
  end
})

   -- Book calls book on-events
minetest.register_tool("grimoire:spellbook", {
	description = "魔導書",
	inventory_image = "grimoire_book.png",
	wield_image = "grimoire_book.png",
	groups = {not_in_creative_inventory = 1},
  damage_groups = {fleshy = -9},
  stack_max = 1,
  range = 230.0,
	liquids_pointable = true,
	light_source = 8,

	on_use = function(itemstack, player, pointed_thing)
		if not minetest.check_player_privs(player, { server = true }) then
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path..page)
		return cast_spell(itemstack, player, pointed_thing):onuse()
	end,

	on_place = function(itemstack, player, pointed_thing)
		if not minetest.check_player_privs(player, { server = true }) then
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path..page)
		return cast_spell(itemstack, player, pointed_thing):onplace()
	end,

	on_secondary_use = function(itemstack, player, pointed_thing)
		if not minetest.check_player_privs(player, { server = true }) then
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path..page)
		return cast_spell(itemstack, player, pointed_thing):onsec()
	end,

	on_drop = function(itemstack, player, pos)
		if not minetest.check_player_privs(player, { server = true }) then			
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path..page)
		return cast_spell(itemstack, player, pos):ondrop()
	end,
})

minetest.register_alias("grimoire", "grimoire:spellbook")



-------------------------------------------------------------------------------------
-- MIT License                                                                     --
--                                                                                 --
-- Copyright (c) 2024 monk                                                         --
--                                                                                 --
-- Permission is hereby granted, free of charge, to any person obtaining a copy    --
-- of this software and associated documentation files (the "Software"), to deal   --
-- in the Software without restriction, including without limitation the rights    --
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell       --
-- copies of the Software, and to permit persons to whom the Software is           --
-- furnished to do so, subject to the following conditions:                        --
--                                                                                 --
-- The above copyright notice and this permission notice shall be included in all  --
-- copies or substantial portions of the Software.                                 --
--                                                                                 --
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR      --
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,        --
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE     --
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER          --
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,   --
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE   --
-- SOFTWARE.                                                                       --
-------------------------------------------------------------------------------------