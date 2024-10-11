    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

--[[ /grimoire invoke vanish
    the only issue with this is the vanish table retains the nametag attribute for the 
    player until it is cleared explicitly. It's not possible to register an on_leave callback
    using this invoke function. The command would have to be called twice if the player
    leaves game while invisible; once to remove and again to re-add their name to the table
  ]]

local function vanish(grim_memory, name, vargs)
  if not minetest.check_player_privs(name, {server = true}) then
    return false, "No permission to invoke!"
  end

  if not grim_memory.vanish then
    grim_memory.vanish = {}
  end

  local player = minetest.get_player_by_name(name)

  if not player then return end

  if grim_memory.vanish[name] then
    player:set_nametag_attributes(grim_memory.vanish[name])
    player:set_properties({visual_size = {x = 1, y = 1}})
    grim_memory.vanish[name] = nil

  else
    grim_memory.vanish[name] = player:get_nametag_attributes()
    player:set_nametag_attributes({color = {a = 0, r = 0, g = 0, b = 0}})
    player:set_properties({visual_size = {x = 0, y = 0}})
  end
end

return vanish