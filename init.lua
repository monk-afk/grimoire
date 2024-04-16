  --==[[   Grimoire - 0.1.1   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local path = minetest.get_modpath(minetest.get_current_modname()).."/"

   -- Chat command calls functions from invoke.lua
minetest.register_chatcommand("grimoire", {
  description = "Do functions from file",
  params = "<param> [<argument>]",
  privs = {server = true},
  func = function(name, params)
    local param, argument = params:match("^([%a-zA-Z0-9_]+)%s*([%w]*)$")
    if not param then return end
    local invoke = dofile(path .. "methods_chat.lua")
    invoke(name, param)[param](argument)
  end
})

   -- Book calls tool on-events
minetest.register_tool("grimoire:spellbook", {
	description = "monk's Grimoire",
	inventory_image = "grimoire_spellbook.png",
	wield_image = "grimoire_spellbook.png",
	groups = {not_in_creative_inventory = 1},
  stack_max = 1,
  range = 230.0,
	liquids_pointable = true,

	on_use = function(itemstack, player, pointed_thing)
		if not minetest.check_player_privs(player, { server = true }) then
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path.."methods_tool.lua")
		return cast_spell(itemstack, player, pointed_thing):onuse()
	end,

	on_place = function(itemstack, player, pointed_thing)
		if not minetest.check_player_privs(player, { server = true }) then
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path.."methods_tool.lua")
		return cast_spell(itemstack, player, pointed_thing):onplace()
	end,

	on_secondary_use = function(itemstack, player, pointed_thing)
		if not minetest.check_player_privs(player, { server = true }) then
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path.."methods_tool.lua")
		return cast_spell(itemstack, player, pointed_thing):onsec()
	end,

	on_drop = function(itemstack, player, pos)
		if not minetest.check_player_privs(player, { server = true }) then			
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path.."methods_tool.lua")
		return cast_spell(itemstack, player, pos):ondrop()
	end,
})

minetest.register_alias("grimoire", "grimoire:spellbook")