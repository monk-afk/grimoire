    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

-- Examples the various functionality of Grimoire

local page_memory = {}

local function example(grim_memory)
  return {
    on_use = function(itemstack, player, pointed_thing)
      -- click on a node to save the name to persistent memory
      if pointed_thing.type == "node" then
        local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)
        local node = minetest.get_node_or_nil(pointed_pos)

        if node then
          grim_memory[#grim_memory + 1] = node.name
        end

      -- or click on a player, and save the name to this page memory.
      elseif pointed_thing.type == "object" then
        local pointed_object = pointed_thing.ref

        if pointed_object:is_player() then
          page_memory[#page_memory + 1] = pointed_object:get_player_name()
        end
      end
    end,

    on_place = function(itemstack, player, pointed_thing)
      -- will print in chat the list of nodes collected in persistent memory
      for n = 1, #page_memory do
        if page_memory[n] then
          minetest.chat_send_all(page_memory[n])
        end
      end
    end,

    on_secondary_use = function(itemstack, player, pointed_thing)
      -- point at the sky and use to change the time of day
      if minetest.get_timeofday() >= 0.833 then
        minetest.set_timeofday(0.23)
        return
      end
      minetest.set_timeofday(0.833)
    end,

    on_drop = function(itemstack, player, pos)
      -- bring the players in page memory to drop position
      for n = 1, #page_memory do
        local player_memory = minetest.get_player_by_name(page_memory[n])
        if player_memory then
          player_memory:move_to(pos)
        end
      end
    end
  }
end

return example