  --==[[   Grimoire - 0.2.0   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local vector_new = vector.new

local function cast_spell(itemstack, player, pointed_thing)
  local pressed = player:get_player_control()
  local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)

  return {
    onuse = function()
      --[[ Duplicate Node ]]--
      if pointed_thing.type == "node" then
        local pointed_node = minetest.get_node(pointed_pos).name
          print(dump(pointed_node))
          minetest.set_node(pointed_thing.above, {name=pointed_node})
        return 
      end
    end,

    onplace = function()
      --[[ Set Dirt ]]--
      if pressed.aux1 then -- 
          minetest.set_node(pointed_thing.above, {name="default:dirt"})
        return
      end
      --[[ Teleport ]]--
      player:move_to(pointed_thing.above)
    end,

    onsec = function()
      if pressed.sneak then

      end
    end,

    ondrop = function()
      --[[ Spawn falling cobble, fire, or water ]]--
      local v_pos = vector.round(player:get_pos())
      local node = "default:cobble"      
      local drops = 7
      
      if pressed.aux1 then
        node = "fire:permanent_flame"
      elseif pressed.sneak then
        node = "default:water_flowing"
      end

      local function add_node()
        if drops <= 0 then return end
        drops = drops - 1
        local npos = vector.new(
          v_pos.x + math.random(-11, 11),
          v_pos.y + math.random(6, 16),
          v_pos.z + math.random(-11, 11)
        )
        minetest.set_node(npos, {name=node})
        minetest.spawn_falling_node(npos)
        minetest.check_for_falling(npos)
        minetest.after(0.5, add_node)
      end
      minetest.after(0.5, add_node)
      return
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