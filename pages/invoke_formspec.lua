    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

-- Displays a formspec with a text label containing the command string
local function get_formspec(str)
  local fs = {}
    fs[#fs+1] = "size[7,4]"
    fs[#fs+1] = "button_exit[6.5,0.1;1.8,1.8;exit;Exit]"
    fs[#fs+1] = "label[0.5,0.55;Label]"
    fs[#fs+1] = "label[0.5,2;" ..
      table.concat(
        minetest.wrap_text(
          minetest.formspec_escape(str), 40, true), "\n") .. "]"
  return table.concat(fs)
end

local function formspec(grim_memory, name, vargs)
  if not minetest.check_player_privs(name, {server = true}) then
    return false, "No permission to do this"
  end

  return minetest.show_formspec(name, "grimoire:formspec", get_formspec(vargs))
end
return formspec