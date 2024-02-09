  --==[[   Grimoire - 0.01   ]]==--
  --==[[  MIT 2024 (c) monk  ]]==--

local vector_new = vector.new

local function cast_spell(itemstack, player, pointed_thing)
	local pressed = player:get_player_control()
    local pos = minetest.get_pointed_thing_position(pointed_thing)

    return {
		onuse = function()  -- left click		
			--[[ Add Dirt ]]--
			if pointed_thing.type == "node" then
				if pressed.aux1 then
					minetest.set_node(pointed_thing.above, {name="default:dirt"})
					return
				end
				minetest.dig_node(pos)
				return 
			end
        end,

		onplace = function()
			--[[ Drop Stone ]]--
			if pressed.aux1 then -- Right click + aux1
				local npos = vector_new(pos.x, pos.y + 5, pos.z)
				minetest.set_node(npos, {name="default:stone"})
				minetest.spawn_falling_node(npos)
				minetest.check_for_falling(npos)
				return
			end
			
			--[[ Teleport ]]--
			player:move_to(pointed_thing.above)
		end,

		onsec = function()  -- right click not pointing at nothing
			--[[ Vanish ]]--
			if minetest.global_exists("invisibility") then
				local name = player:get_player_name()
				if invisibility[name] then
						invisibility.invisible(player, nil)
						return
				end
				invisibility.invisible(player, true)
			end
		end,

		ondrop = function()  -- q keypress
			--[[ Remove Water ]]--
			local pos = pointed_thing
			local r = 22
			local num = minetest.find_nodes_in_area(
				{x = pos.x - r, y = pos.y - r, z = pos.z - r},
				{x = pos.x + r, y = pos.y + r, z = pos.z + r},
				{"group:water"})
			if #num == 0 then return end
			for _, w in pairs(num) do
				minetest.swap_node(w, {name = "air"})
			end
		end,
	}
end

return cast_spell