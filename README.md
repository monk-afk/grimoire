Grimoire
========

[![ContentDB](https://content.minetest.net/packages/monk/grimoire/shields/downloads/)](https://content.minetest.net/packages/monk/grimoire/)


A Powerful Book of Spells

(c) 2024 monk

MIT Licensed Source, CC0 Licensed Media

___

## Summary

- New to version 0.3.x: grim_memory and page_memory
  - grim_memory: high-level local persistent context (until nil or shutdown)
  - page_memory: block-level local temporary context (until overrided)

- Override Grimoire's on-callbacks with files named "page_*.lua"
  - Apply with the chat command: `/grimoire page <name of page>`

- Single-use scripts are called from files named "invoke_*.lua"
  - Execute invoke files with `/grimoire invoke <name of file>`


## Runtime Modifiable

Mod files can be *edited or introduced* during runtime without restarting Minetest.

The files within the `pages` folder are prefixed with either 'page_' or 'invoke_'.

Files named `pages_` contain overriding callback methods used by the `spellbook` item.

Files named `invoke_` contain functions to execute with the `invoke` chat command.


## Grimoire Pages

The item `grimoire:spellbook` does nothing by default.

To use the spellbook, first use the chat command: `/grimoire page builder`.

This will select the file named `page_builder.lua` and will override the book's existing functions.

When a new page is added, or an existing page is modified, the `page` command can be used to apply the new functions.

You can use any callback functions such as `on_use`, `on_place`, `on_secondary`, `on_drop`, in combination with player controls (if they have been included in the function): up, down, left, right, jump, aux1, sneak, dig, place, LMB, RMB, and zoom.

- Dropping and placing the spellbook won't drop or place the book
- The book is destroyed if it is used by a player without the `server` privilege

- Available pages:
  - `builder` place and dig nodes
  - `meta` set owner to node
  - `example` various functional examples
  - `template` functionless template
  - `disable` disables Grimoire functions

## Grimoire Invoke

Similar to pages, the `invoke` command will execute functions from file.

For example: `/grimoire invoke echo` will execute the function within `invoke_echo.lua`.

The functions will run only from chat command, and not added to the spellbook's functionality.

The invoke files can be modified and run again using the same command.

To add a new invoke command, a new file can be created from the `invoke_template.lua` template.

- Available invoke files:
  - `echo` sends chat message of command parameter
  - `vanish` make yourself disappear
  - `memory` basic grimoire context manager
  - `formspec` opens a formspec with parameter label
  - `template` functionless template

## Grimoire Memory

The init.lua file contains a table `grim_memory` which is passed as a variable to pages or commands.

Using a new page or invoke command will not erase the `grim_memory`.

Each Grimoire page file can have a table for storing temporary variables to be used by the spellbook.

The `page_memory` table will be forgotten when a new page is selected.

___

Current Version **`0.3.1`**

<sup>Discord monk.moe (ID:699370563235479624)</sup>