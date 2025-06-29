    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

local page_memory = {}

local function builder(grim_memory)
  return {
    on_use = function(itemstack, player, pointed_thing)
      -- use like a pick or shovel to 'dig'
      if pointed_thing.type == "node" then
        local n = 1
        local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)
        local v = pointed_pos
        local pressed = player:get_player_control()

        -- hold aux1 during the click to remove 3x3 cube
        if pressed.aux1 then
          local min_pos = {x = v.x-n, y = v.y-n, z = v.z-n}
          local max_pos = {x = v.x+n, y = v.y+n, z = v.z+n}
          local min_x, max_x = math.min(min_pos.x, max_pos.x), math.max(min_pos.x, max_pos.x)
          local min_y, max_y = math.min(min_pos.y, max_pos.y), math.max(min_pos.y, max_pos.y)
          local min_z, max_z = math.min(min_pos.z, max_pos.z), math.max(min_pos.z, max_pos.z)
          for y = max_y, min_y, -1 do
            for x = min_x, max_x do
              for z = min_z, max_z do
                minetest.remove_node({x = x, y = y, z = z})
              end
            end
          end
        else
          minetest.remove_node(v)
        end

      elseif pointed_thing.type == "object" then
        local pointed_object = pointed_thing.ref
        if pointed_object:is_player() then

        end
      end
    end,

    -- place like a node to duplicate the pointed node
    on_place = function(itemstack, player, pointed_thing)
      if pointed_thing.type == "node" then
        local pressed = player:get_player_control()
        local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)
        local pointed_node = minetest.get_node(pointed_pos).name
        local v = pointed_thing.above

        -- hold aux1 while placing to duplicate a 3x3 cube of the pointed node
        if pressed.aux1 and not pressed.sneak then
          local n = minetest.find_nodes_in_area(
            {x = v.x - 1, y = v.y - 1, z = v.z - 1},
            {x = v.x + 1, y = v.y + 1, z = v.z + 1},
            {"air"}
          )
          if #n == 0 then return end

          for _, p in pairs(n) do
            minetest.set_node(p, {name=pointed_node})
          end

        -- hold sneak while placing to duplicate one of the pointed node
        elseif pressed.sneak and not pressed.aux1 then
          minetest.set_node(v, {name=pointed_node})

        else
          -- teleport to pointed location if not holding aux1 or sneak
          return player:move_to(pointed_thing.above)
        end
      end
    end,

    on_secondary_use = function(itemstack, player, pointed_thing)
    end,

    on_drop = function(itemstack, player, v)
      -- hold aux1 while 'dropping' to clear water from in a 10 radius area
      local pressed = player:get_player_control()

      if pressed.aux1 then

        local n = 5
        local min_pos = {x = v.x-n, y = v.y-n, z = v.z-n}
        local max_pos = {x = v.x+n, y = v.y+n, z = v.z+n}
        local min_x, max_x = math.min(min_pos.x, max_pos.x), math.max(min_pos.x, max_pos.x)
        local min_y, max_y = math.min(min_pos.y, max_pos.y), math.max(min_pos.y, max_pos.y)
        local min_z, max_z = math.min(min_pos.z, max_pos.z), math.max(min_pos.z, max_pos.z)

        for y = min_y, max_y do
          for x = min_x, max_x do
            for z = min_z, max_z do
              local v_pos = {x = x, y = y, z = z}
              local node = minetest.get_node(v_pos)
              if node.name == "default:water_flowing"
                  or node.name == "default:water_source" then
                minetest.remove_node(v_pos)
              end
            end
          end
        end
      end
    end,
  }
end

return builder
