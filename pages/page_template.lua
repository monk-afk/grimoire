    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

  -- page_memory is the local context of this page, it is not passed to outside functions 
local page_memory = {}

  -- grim_memory is the high-level context, received and passed to pages/invokes
local function template(grim_memory)
  -- the privilege check is the wrapper function found in the init.lua, not required here

  -- additional functions can by added before the return

  return {
    on_use = function(itemstack, player, pointed_thing)
      
    end,

    on_place = function(itemstack, player, pointed_thing)

    end,

    on_secondary_use = function(itemstack, player, pointed_thing)

    end,

    on_drop = function(itemstack, player, pos)

    end
  }
end

-- always return the function which provides the return table containing tool methods
return template