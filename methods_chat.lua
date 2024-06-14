  --==[[   Grimoire - 0.1.1   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local function invoke(name, param)

  local player = minetest.get_player_by_name(name)

  if not player then return end

  local pos = vector.round(player:get_pos())

  local param_args = {

    fire = function(radius)  -- the ring of fire
      if not tonumber(radius) then radius = 4 end
      local radius = math.min(math.max(1, radius), 11)

      local x, z, y = pos.x, pos.z, pos.y+1
      for i = 1, 360 do
      local angle = i * math.pi / 180
      local ptx, ptz = x + radius * math.cos( angle ), z + radius * math.sin( angle )
      minetest.set_node({x = ptx, z = ptz, y = y}, {name = "fire:permanent_flame"} )
      end
    end,

    water = function(drops)  -- causes water droplets to fall
      if not tonumber(drops) then drops = 5 end
      local drops = math.min(math.max(1, drops), 15)

      local function add_water()
        if drops <= 0 then return end
        drops = drops - 1
        local npos = vector.new(
            pos.x + math.random(-11, 11),
            pos.y + math.random(6, 16),
            pos.z + math.random(-11, 11)
          )
        minetest.set_node(npos, {name="default:water_flowing"})
        minetest.spawn_falling_node(npos)
        minetest.check_for_falling(npos)
        minetest.after(0.5, add_water)
      end
			minetest.after(0.5, add_water)
    end,

    formspec = function(arg)  -- show formspec 
      if arg == "" then arg = "<arg>" end
      local form = "size[7.1,6.5]".."no_prepend[]"..
        "bgcolor[#1F1F1F;both]"..
        "box[-0.1,-0.10;7.1,0.77;#C10023]"..
        "box[-0.1,5.925;7.1,0.77;#C10023]"..
        "button_exit[6.352,-0.051;0.8,0.8;exit;X]"..
        "label[1.25,0.025;Demo Formspec]"..
        "label[0.75,0.9;Edit and run `/grimoire formspec` again]"..
        "label[0.25,1.7;`/grimoire formspec "..arg.."`]"
        minetest.show_formspec(name, "grimoire:demoform", form)
    end,

    echo_arg = function(arg)  -- prints the command argument in chat
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
      minetest.chat_send_player(name, "Cannot invoke ["..param.."], it does not exist. \
					Available commands: "..table.concat(coms, ", "))
    end}
  end
  return param_args
end

return invoke
