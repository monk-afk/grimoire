    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

local function echo(grim_memory, name, vargs)
  if not minetest.check_player_privs(name, {server = true}) then
    return false, "No permission to do this"
  end

  if vargs and vargs ~= "" then
    vargs = vargs:split(" ")
  end

  grim_memory.test_var = "the string is real"

  for index, key in pairs(grim_memory) do
    minetest.chat_send_all(index..":"..key)
  end

end
return echo