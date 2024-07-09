Grimoire
========

A Powerful Book of Spells

(c) 2024 monk

MIT Licensed Source, CC0 Licensed Media

___

## Runtime Modifiable

Mod files can be *edited or introduced* during runtime without restarting Minetest.

Copy any existing 'page' to use as a template, then modify it with the desired functions. The new page must follow the naming format `grimoire_page_`*pagename*`.lua`

## Grimoire Pages

Pages can be 'selected' with the command `/grimoire page pagename`.

For example; There are three pages included in the default release of this mod: create, destroy, manipulate. To use the spells (functions) from the create page, use `/grimoire page create`. This will set the current page to create and you can now use the Grimoire functions from that file.

You can use any callback functions such as `on_use`, `on_place`, `on_secondary`, `on_drop`, in combination with player controls (if they have been included): up, down, left, right, jump, aux1, sneak, dig, place, LMB, RMB, and zoom.

- If you return a function not nil, the Grimoire is taken from inventory.
- Don't worry: the on_drop and on_place won't drop or place the book
- The book is destroyed if it is used by a player without the `server` privilege

The pages contain a few functions to get started. I encourage you to craft your own spells! What powers are you capable?

## Grimoire Commands

The default format for chat commands is `/grimoire <main_function> [optional_argument]`

If you call a non-existing function, the list of available functions is printed in the chat.

Currently, only `/grimoire spiral` and `/grimoire page [pagename]` are included in this release.
___

Current Version **`0.2.0`**

<sup>Discord monk.moe (ID:699370563235479624)</sup>