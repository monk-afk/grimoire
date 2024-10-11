    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

local function template(grim_memory, name, vargs)
  -- its a good idea to always check the privs
  if not minetest.check_player_privs(player, {server = true}) then
    return false, "No permission to do this"
  end

  -- processes go here

end

--[[ always return the name of the function. 
    if there is more than one function in the invoke script, return
    the last one which produces the desired output
]]
return template