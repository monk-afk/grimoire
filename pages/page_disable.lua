    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

--[[ Default tool methods for when mod is loaded
    To disable the tool methods when not in use
    /grimoire page disable
  ]]

local function disable()
  local nopage_message = function(name)
    minetest.chat_send_player(name,
        "[Grimoire] No page is set! Use: /grimoire page <pagename>")
  end

  return {
  on_use = function(itemstack, player, pointed_thing)
    if not minetest.check_player_privs(player, {server = true}) then
      itemstack:take_item()
      return itemstack
    end
    nopage_message(player:get_player_name())
  end,

  on_place = function(itemstack, player, pointed_thing)
    if not minetest.check_player_privs(player, {server = true}) then
      itemstack:take_item()
      return itemstack
    end
    player:move_to(pointed_thing.above)
  end,

  on_secondary_use = function(itemstack, player, pointed_thing)
    if not minetest.check_player_privs(player, {server = true}) then
      itemstack:take_item()
      return itemstack
    end
    nopage_message(player:get_player_name())
  end,

  on_drop = function(itemstack, player, pos)
    if not minetest.check_player_privs(player, {server = true}) then			
      itemstack:take_item()
      return itemstack
    end
    nopage_message(player:get_player_name())
  end,
  }
end

return disable