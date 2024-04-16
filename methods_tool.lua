  --==[[   Grimoire - 0.1.1   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local vector_new = vector.new

local function cast_spell(itemstack, player, pointed_thing)
  local pressed = player:get_player_control()
  local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)

  return {
    onuse = function()
      --[[ Dig or Remove node ]]--
      if pointed_thing.type == "node" then
        if pressed.aux1 then
        	minetest.remove_node(pointed_pos)
          return
        end
        minetest.dig_node(pointed_pos)
        return 
      end
    end,

    onplace = function()
      --[[ Set Dirt ]]--
      if pressed.aux1 then -- 
          minetest.set_node(pointed_thing.above, {name="default:dirt"})
        return
      end
      --[[ Teleport ]]--
      player:move_to(pointed_thing.above)
    end,

    onsec = function()
      --[[ Control Day/Night ]]--
      if pressed.sneak then
        minetest.set_timeofday(0.23)
        return
      end
      minetest.set_timeofday(0.833)
    end,

    ondrop = function()
      local v_pos = vector.round(player:get_pos())
      
      --[[ Drop Stone ]]--
      if pressed.aux1 then
        local npos = vector_new(v_pos.x + 3, v_pos.y + 9, v_pos.z + 3)
        minetest.set_node(npos, {name="default:stone"})
        minetest.spawn_falling_node(npos)
        minetest.check_for_falling(npos)
        return
      end

      --[[ Remove Water ]]--
      local r = 11
      local num = minetest.find_nodes_in_area(
        {x = v_pos.x - r, y = v_pos.y - r, z = v_pos.z - r},
        {x = v_pos.x + r, y = v_pos.y + r, z = v_pos.z + r},
        {"group:water"})
      if #num == 0 then return end
      for _, w in pairs(num) do
        minetest.swap_node(w, {name = "air"})
      end
    end,
  }
end

return cast_spell