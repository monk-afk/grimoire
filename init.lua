  --==[[   Grimoire - 0.01   ]]==--
  --==[[  MIT 2024 (c) monk  ]]==--

local path = minetest.get_modpath(minetest.get_current_modname()).."/"

minetest.register_tool("grimoire:spellbook", {
	description = "monk's Grimoire",
	inventory_image = "grimoire_spellbook.png",
	wield_image = "grimoire_spellbook.png",
	groups = {not_in_creative_inventory = 1},
    stack_max = 1,
    range = 200.0,
	liquids_pointable = true,
    tool_capabilities = {
        full_punch_interval = 0.1,
        max_drop_level = 3,
        groupcaps = {
            bendy         = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
            snappy        = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
            fleshy        = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
            cracky        = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
            choppy        = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
            crumbly       = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
            unbreakable   = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
            dig_immediate = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
        },
        punch_attack_uses = 0,
    },

	on_use = function(itemstack, player, pointed_thing)
		if not minetest.check_player_privs(player, { server = true }) then
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path.."cast.lua")
		return cast_spell(itemstack, player, pointed_thing):onuse()
	end,

	on_place = function(itemstack, player, pointed_thing)
		if not minetest.check_player_privs(player, { server = true }) then
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path.."cast.lua")
		return cast_spell(itemstack, player, pointed_thing):onplace()
	end,

	on_secondary_use = function(itemstack, player, pointed_thing)
		if not minetest.check_player_privs(player, { server = true }) then
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path.."cast.lua")
		return cast_spell(itemstack, player, pointed_thing):onsec()
	end,

	on_drop = function(itemstack, player, pos)
		if not minetest.check_player_privs(player, { server = true }) then			
			itemstack:take_item()
			return itemstack
		end
		local cast_spell = dofile(path.."cast.lua")
		return cast_spell(itemstack, player, pos):ondrop()
	end,
})