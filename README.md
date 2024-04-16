Grimoire
========
Tool and Chat Commands with Runtime Editable Modfiles

(c)(0) 2024 monk

MIT Licensed Software, CC0 Licensed Media

##
Apply Lua file edits without restarting Minetest. Not intended for multiplayer.

Requires `server` privilege.

Local table data within the files called by dofile will not persist between callbacks.

> [!WARNING]
> Editing mod files with invalid code will cause server crash.

### Chat Command, `/grimoire`
**methods_chat.lua**

Command parameters can be introduced or removed from the method table.

Keys with function values indexed in the param_args table are returned methods called as chat command parameters.

In this demo, the following parameters are included:

- `/grimoire <fire> [<size>]`
    - Sets a ring of fire of optional size around player

- `/grimoire <water> [<drops>]`
    - Spawn falling water nodes around player

- `/grimoire <echo_arg> [<arg>]`
    - Sends chat message containing the <arg> value

- `/grimoire formspec [<arg>]`
    - Shows demo formspec

If the parameter does not exist in the param_args table, the table returns with a catchall function. 

### Registered Tool, "grimoire:spellbook"
**methods_tool.lua**

Callback functions `on_use`, `on_place`, `on_secondary`, `on_drop`, in combination with player controls.

The table returned from `get_player_control()` may contain: up, down, left, right, jump, aux1, sneak, dig, place, LMB, RMB, and zoom

If the method function return not nil, the spellbook is taken from inventory.

Grimoire Demo includes:
   - Use Item: Dig pointed node
   - Aux1 + Use Item: Remove pointed node
   
   - Secondary Use, (Pointing at Nothing): Set time to morning
   - Sneak + Secondary, : Set time to night

   - Place Item: Teleport to pointed pos
   - Aux1 + Place Item: Place dirt against pointed node

   - Drop Item: Remove water in radius
   - Aux + Drop Item: Spawn falling stone

  > 'Place' and 'Drop' will return the book to inventory.

##

Current Version **`0.1.1`**

<sup>monk.moe @ Discord ID: 699370563235479624</sup