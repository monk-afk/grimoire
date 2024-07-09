  --==[[   Grimoire - 0.2.0   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local vector_new = vector.new

local function cast_spell(itemstack, player, pointed_thing)
  local pressed = player:get_player_control()
  local pointed_pos = minetest.get_pointed_thing_position(pointed_thing)

  return {
    onuse = function()
      --[[ Dig Node ]]--
      if pointed_thing.type == "node" then
      --[[ Hold AUX1 to remove any node (ignores protection) ]]--
        if pressed.aux1 then
        	minetest.remove_node(pointed_pos)
          return
        end
        minetest.dig_node(pointed_pos)
        return 
      end
    end,

    onplace = function()
      --[[ Remove Nodes in (n) radius ]]--
      if pressed.aux1 then -- 
        local v = pointed_pos
        local n = 5
        if n == 0 then return end
        local min_pos = {x = v.x-n, y = v.y-n, z = v.z-n}
        local max_pos = {x = v.x+n, y = v.y+n, z = v.z+n}
        local min_x, max_x = math.min(min_pos.x, max_pos.x), math.max(min_pos.x, max_pos.x)
        local min_y, max_y = math.min(min_pos.y, max_pos.y), math.max(min_pos.y, max_pos.y)
        local min_z, max_z = math.min(min_pos.z, max_pos.z), math.max(min_pos.z, max_pos.z)
        for x = min_x, max_x do
          for y = min_y, max_y do
            for z = min_z, max_z do
              local pos = {x = x, y = y, z = z}
              minetest.set_node(pos, {name="air"})
              minetest.remove_node(pos)
            end
          end
        end
        return
      end
      --[[ Teleport ]]--
      player:move_to(pointed_thing.above)
    end,

    onsec = function()
      --[[ ? ]]--
    end,

    ondrop = function()
      --[[ Remove Water ]]--
      local v_pos = vector.round(player:get_pos())
      local r = 5
      local num = minetest.find_nodes_in_area(
        {x = v_pos.x - r, y = v_pos.y - r, z = v_pos.z - r},
        {x = v_pos.x + r, y = v_pos.y + r, z = v_pos.z + r},
        {"group:water"})
      if #num == 0 then return end
      for _, w in pairs(num) do
        minetest.swap_node(w, {name = "air"})
      end
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