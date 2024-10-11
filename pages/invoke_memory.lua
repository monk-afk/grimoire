    --==[[   Grimoire - 0.3.1   ]]==--
    --==[[  MIT 2024 (c)  monk  ]]==--

--[[ For managing Grimoire high-level context table
    /grimoire memory save index_or_key value_of_index_or_key
    /grimoire memory erase index_or_key
    /grimoire memory recall index_or_key
  ]]

local function memory(grim_memory, name, vargs)
  if not minetest.check_player_privs(name, {server = true}) then
    return false, "No permission to do this"
  end

  if vargs and vargs ~= "" then
    vargs = vargs:split(" ")
  end

  local cmd, index, value = vargs[1], vargs[2], vargs[3]

  if cmd and index then
    if cmd == "save" and value then
      grim_memory[index] = value
      return true, "[Grimoire] Saved "..index.." "..value.." to memory"

    else
      local memory = grim_memory[index]

      if not grim_memory[index] then
        return minetest.chat_send_player(name, "[Grimoire] I have no memory of "..index)
      end
    
      if cmd == "erase" then
        if grim_memory[index] then
          grim_memory[index] = nil
          return minetest.chat_send_player(name, "[Grimoire] Erased "..index.." from memory")
        end

      elseif cmd == "recall" then
        local memory_type = type(memory)
      
        if memory_type == "string" then
          return minetest.chat_send_player(name, "[Grimoire] My memory of "..index.." is "..memory)

        elseif memory_type == "table" then
          return minetest.chat_send_player(name, "[Grimoire] Here's what I know about "..index..": "..dump(i .." = ".. key))

        elseif memory_type == "function" then
          return minetest.chat_send_player(name, "[Grimoire] "..index.." is a "..memory_type)

        elseif memory_type == "userdata" then
           return minetest.chat_send_player(name, dump(memory))
          
        else
          return  minetest.chat_send_player(name, "[Grimoire] I have "..index.." in memory as "..memory_type)

        end
      end
    end
  end
end

return memory