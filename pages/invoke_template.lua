  --==[[   Grimoire - 0.3.0   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local function echo(grim_memory, name, vargs)
  if name ~= minetest.settings:get("name") then 
    return false, "No permission to do this"
  end

  -- functions go here

end
return echo