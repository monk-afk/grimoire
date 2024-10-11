    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

--[[ This will add the player as "owner" to any node with infotext.
    To use:
      - Use or left-click a player, their name is saved to page_memory
      - Optionally, do /grimoire invoke save player_name <name of player>
      - Place or right-click a node, the node will be owned by that player
      - 'Drop' will remove the player from page_memory
]]

local page_memory = {}

local function meta(grim_memory)
  return {
    on_use = function(itemstack, player, pointed_thing)
      if pointed_thing.type == "object" then
        local pointed_object = pointed_thing.ref
        if pointed_object:is_player() then
          local name = pointed_object:get_player_name()
          page_memory.player_name = name
          minetest.chat_send_player(player:get_player_name(),
              "[Grimoire] Saved player name "..name.."to memory")
        end
      end
    end,

    on_place = function(itemstack, player, pointed_thing)
      if pointed_thing.type == "node" then
        local saved_name = page_memory.player_name or grim_memory.player_name

        if not saved_name or saved_name == "" then
          return minetest.chat_send_player(player:get_player_name(),
              "[Grimoire] No name in memory!")
        end

        local pos = minetest.get_pointed_thing_position(pointed_thing)
        local meta = minetest.get_meta(pos)

        if meta then
          meta:set_string("owner", saved_name)
          meta:set_string("infotext","Owned by: "..saved_name)
        end

        return minetest.chat_send_player(player:get_player_name(),
            "[Grimoire] Node meta saved!")
      end
    end,

    on_secondary_use = function(itemstack, player, pointed_thing)
    end,

    on_drop = function(itemstack, player, pos)
      page_memory.player_name = nil
      grim_memory.player_name = nil
    end
  }
end

return meta