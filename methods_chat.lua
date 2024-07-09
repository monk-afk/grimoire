  --==[[   Grimoire - 0.2.0   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local function invoke(name, param)
  if name ~= minetest.settings:get("name") then 
    return
  end

  local player = minetest.get_player_by_name(name)

  if not player then return end

  local pos = vector.round(player:get_pos())

  local param_args = {

    page = function(arg)  -- show formspec 
      return "grimoire_page_"..arg..".lua"
      -- local pages = {
      --   manipulate = "grimoire_page_manipulate.lua",
      --   destroy = "grimoire_page_destroy.lua",
      --   create = "grimoire_page_create.lua",
      -- }
      -- if pages[arg] then
      --   return pages[arg]
      -- end
    end,

    echo = function(arg)  -- prints the command argument in chat
      minetest.chat_send_player(name, "Entered: [<"..arg..">]")
    end,

    spiral = function()  -- generates a spiral pattern
      local player = minetest.get_player_by_name(name)
      local pos = vector.round(player:get_pos())
      local blocks = {
        "default:stonebrick",
        "default:stonebrick",
        "default:diamondblock",
        "default:diamondblock",
        "default:bronzeblock",
        "default:bronzeblock",
      }
      local phi = function(n) return (n + math.sqrt(5)) / 2 end
      local qui = function(x) return (x * 2) end
      local psi = function(x) return (math.sqrt(x) - 1) end
      local gg = 0
      for i = 0,23,2.30 do -- density
        if gg > 5 then gg = 0 end -- which block to place
        gg = gg + 1
        for radius = 0,360,1.369 do -- number of spiral branches
          local angle = phi(radius * math.pi) -- golden pies
                radius = math.rad(radius) -- rad rad rad
          local x = pos.x + qui(i * radius * psi(phi(math.cos(angle))))
          local z = pos.z + qui(i * radius * psi(phi(math.sin(angle))))
          local y = pos.y-1 -- flat. for height/depth: y = pos.y + i * 0.1
          minetest.set_node({x = x, z = z, y = y},  {name=blocks[gg]})
        end
      end
    end,
  }


  if not param_args[param] then
    local coms = {}
    for command,_ in pairs(param_args) do
      coms[#coms+1] = command
    end

    return {[param] = function()
      minetest.chat_send_player(name, "Cannot invoke ["..param.."], it does not exist.")
      minetest.chat_send_player(name, "Available commands: "..table.concat(coms, ", "))
    end}
  end
  return param_args
end

return invoke