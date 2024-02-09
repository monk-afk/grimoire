Grimoire
========
A book with runtime editable functions

Copyright (c) 2024 monk <monk.squareone@gmail.com>

<sup>Source: MIT License</sup>

<sup>Media: CC0 1.0 Universal</sup>

## Details

Registers a tool which makes use of on_use, on_place, on_secondary, on_drop, which can be combined with button presses such as aux1.

The functions within `cast.lua` may be modified and will reflect in-game during runtime (no reboot).

> [!WARNING]
> Editing cast.lua during runtime is risky, and may cause server crash if updated with invalide code!

The grimoire has some basic functions included:
   - `Left click` dig any node
   - `Left click + Aux1` place dirt
   - `Right click` teleport
   - `Right click + Aux1` drop stone
   - `Secondary (right click pointing at nothing)` vanish (depends: Invisibility)
   - `Drop Key` remove water in radius (book will not be dropped)

The grimoire requires `server` priv to use and will be removed from inventory without it.

##
