  --==[[   Grimoire - 0.3.0   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local function echo(grim_memory, name, vargs)
  if name ~= minetest.settings:get("name") then 
    return false, "No permission to do this"
  end

  if vargs and vargs ~= "" then
    vargs = vargs:split(" ")
  end

  for index, key in pairs(grim_memory) do
    minetest.chat_send_all(index..":"..key)
  end

  grim_memory.test_var = "the string is real"
end
return echo