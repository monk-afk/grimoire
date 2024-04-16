  --==[[   Grimoire - 0.1.1   ]]==--
  --==[[  MIT 2024 (c)  monk  ]]==--

local function invoke(name, param)

  local player = minetest.get_player_by_name(name)

  if not player then return end

  local pos = vector.round(player:get_pos())

  local param_args = {

    fire = function(radius)
      if not tonumber(radius) then radius = 4 end
      local radius = math.min(math.max(1, radius), 11)

      local x, z, y = pos.x, pos.z, pos.y+1
      for i = 1, 360 do
      local angle = i * math.pi / 180
      local ptx, ptz = x + radius * math.cos( angle ), z + radius * math.sin( angle )
      minetest.set_node({x = ptx, z = ptz, y = y}, {name = "fire:permanent_flame"} )
      end
    end,

    water = function(drops)
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

    formspec = function(arg)
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

    echo_arg = function(arg)
      minetest.chat_send_player(name, "Entered: [<"..arg..">]")
    end,
  }

  if not param_args[param] then
    return {[param] = function()
      minetest.chat_send_player(name, "The requested param: ["..param.."] does not exist.")
    end}
  end
  return param_args
end

return invoke