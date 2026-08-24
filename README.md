# MrNewbNameChanger

Vouchers, marriage certificates, and an optional records clerk. Names update live — no relog.

[Documentation](https://mrnewb.github.io/docs/mrnewbnamechanger) · [Install guide](https://mrnewb.github.io/docs/mrnewbnamechanger/install) · [Tebex](https://mrnewbscripts.tebex.io/) · [Discord](https://discord.gg/mrnewbscripts)

![Name change voucher](%5BINSTALL%5D/images/namechangevoucher.png)

## Features

- `namechangevoucher` — personal name change
- Blank marriage certificate — officiant fills it, recipient uses the signed copy
- Optional job gate for officiants (`Config.Marriage`)
- Optional paid records clerk (`Config.RecordsClerk`, ships off)
- Letter-only name filter, max length, blocked words
- Paper certificate NUI for filing and viewing
- `ChangePlayerName` export plus `MrNewbNameChanger:Server:NameChanged` after a successful write

## Install

Needs [ox_lib](https://github.com/overextended/ox_lib), [oxmysql](https://github.com/overextended/oxmysql), and [Newb_Bridge](https://github.com/MrNewb/Newb_Bridge). Items, images, and start order: [install guide](https://mrnewb.github.io/docs/mrnewbnamechanger/install).

```cfg
ensure ox_lib
ensure oxmysql
ensure Newb_Bridge
ensure MrNewbNameChanger
```

Do not add `server.export` on the ox_inventory items. Omit `consume` on the defs.

## Config

`configs/config.lua` — item names, `NameFilter`, marriage job gate, records clerk. Clerk cooldown is per character, in memory; a restart clears it.

```lua
bridge.inventory.addItem(src, 'namechangevoucher', 1)

local ok = exports.MrNewbNameChanger:ChangePlayerName(src, 'Jane', 'Doe')
```

Override `OpenUpdatePlayerName` in `resource/open/server/update.lua` for custom identity stacks.

[Server exports](https://mrnewb.github.io/docs/mrnewbnamechanger/exports/server-exports) · [Server events](https://mrnewb.github.io/docs/mrnewbnamechanger/exports/server-events).
