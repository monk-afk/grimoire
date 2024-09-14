  --==[[   Grimoire - 0.3.0   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local path = minetest.get_modpath(minetest.get_current_modname()).."/pages/"

local grim_memory = {
    page_name = "not set"
}

local function override(methods)
  return minetest.override_item("grimoire:spellbook", {
      on_use = methods.on_use,
      on_place = methods.on_place,
      on_secondary_use = methods.on_secondary_use,
      on_drop = methods.on_drop,
    })
end

  -- Chat command to change book functions
minetest.register_chatcommand("grimoire", {
  description = "Change Grimoire page or invoke a command",
  params = "<page|invoke> <param> [<arguments>]",
  privs = {server = true},
  func = function(name, params)
    local action, script, vargs = params:match("^(%S+)%s+(%S+)%s*([%S%s]*)$")

    if not action or not script then
      return false, "[Grimoire] Missing parameters! <page|invoke> <script>"

    elseif action == "help" then
      return false, "[Grimoire] Current page is: "..grim_memory.page_name
    end

    local dir_list = minetest.get_dir_list(path, false)
    local requested_page = action.."_"..script..".lua"
    local full_path = path..requested_page

    for n = 1, #dir_list do
      if dir_list[n] == requested_page then
        if action == "page" then

          local methods
          local status, err = pcall(function()
              methods = dofile(full_path)(grim_memory)
            return methods
          end)

          print(dump(status))

          if not status then
            return false, "[Grimoire] Error: "..err

          else
            grim_memory.page_name = script  -- saved to call back later if needed
            minetest.chat_send_player(name, "[Grimoire] Using page ".. script .. "!")
            return override(methods)
          end

        elseif action == "invoke" then
          local status, err = pcall(function()
            return dofile(full_path)(grim_memory, name, vargs)
          end)

          if not status then
            return false, "[Grimoire] Error: "..err
          else
            return true, "[Grimoire] Invoked ".. script .. "!"
          end
        end
      end
    end
    return false, "[Grimoire] "..action.." "..script.." not found!"
  end
})


minetest.register_tool("grimoire:spellbook", {
  description = "魔導書",
  inventory_image = "grimoire_spellbook.png",
  wield_image = "grimoire_spellbook.png",
  groups = {not_in_creative_inventory = 1},
  damage_groups = {fleshy = -9},
  stack_max = 1,
  range = 230.0,
  liquids_pointable = true,
  light_source = 8,

  on_use = function(itemstack, player, pointed_thing)
    if not minetest.check_player_privs(player, {server = true}) then
      itemstack:take_item()
      return itemstack
    end
  end,

  on_place = function(itemstack, player, pointed_thing)
    if not minetest.check_player_privs(player, {server = true}) then
      itemstack:take_item()
      return itemstack
    end
  end,

  on_secondary_use = function(itemstack, player, pointed_thing)
    if not minetest.check_player_privs(player, {server = true}) then
      itemstack:take_item()
      return itemstack
    end
  end,

  on_drop = function(itemstack, player, pos)
    if not minetest.check_player_privs(player, {server = true}) then			
      itemstack:take_item()
      return itemstack
    end
  end,
})

minetest.register_alias("grimoire", "grimoire:spellbook")



-------------------------------------------------------------------------------------
-- MIT License                                                                     --
--                                                                                 --
-- Copyright (c) 2024 monk                                                         --
--                                                                                 --
-- Permission is hereby granted, free of charge, to any person obtaining a copy    --
-- of this software and associated documentation files (the "Software"), to deal   --
-- in the Software without restriction, including without limitation the rights    --
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell       --
-- copies of the Software, and to permit persons to whom the Software is           --
-- furnished to do so, subject to the following conditions:                        --
--                                                                                 --
-- The above copyright notice and this permission notice shall be included in all  --
-- copies or substantial portions of the Software.                                 --
--                                                                                 --
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR      --
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,        --
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE     --
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER          --
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,   --
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE   --
-- SOFTWARE.                                                                       --
-------------------------------------------------------------------------------------