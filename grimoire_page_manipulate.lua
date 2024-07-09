  --==[[   Grimoire - 0.2.0   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local vector_new = vector.new

local function cast_spell(itemstack, player, pointed_thing)
  local pressed = player:get_player_control()
  local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)

  return {
    onuse = function()
      if pointed_thing.type == "node" then
        if pressed.aux1 then

          return
        end
        return
      end
    end,

    onplace = function()
      if pressed.aux1 then
        return
      end

      --[[ Teleport ]]--
      player:move_to(pointed_thing.above)
    end,

    onsec = function()
      --[[ Control Day/Night ]]--
      if minetest.get_timeofday() >= 0.833 then
        minetest.set_timeofday(0.23)
        return
      end
      minetest.set_timeofday(0.833)
    end,

    ondrop = function()

    end,
  }
end

return cast_spell



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