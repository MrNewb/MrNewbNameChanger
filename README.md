# MrNewbNameChanger

Name-change vouchers, marriage certificates, and an optional records clerk. No relog.

[Documentation](https://mrnewb.github.io/docs/mrnewbnamechanger) · [GitHub](https://github.com/MrNewb/MrNewbNameChanger) · [Discord](https://discord.gg/mrnewbscripts)

## Install

Needs [ox_lib](https://github.com/overextended/ox_lib), [oxmysql](https://github.com/overextended/oxmysql), and [Newb_Bridge](https://github.com/MrNewb/Newb_Bridge).

```cfg
ensure ox_lib
ensure oxmysql
ensure Newb_Bridge
ensure MrNewbNameChanger
```

Item defs: [docs](https://mrnewb.github.io/docs/mrnewbnamechanger/install).

## Config

`configs/config.lua` — item names, `NameFilter` (length + bad words), marriage job gate, records clerk (`Enabled` ships `false`; set `true` to spawn the NPC).

```lua
bridge.inventory.addItem(src, 'namechangevoucher', 1)
```

Records clerk has a per-character cooldown (`Config.RecordsClerk.Cooldown`) so the paid NPC cannot be spammed. Vouchers and certificates have no cooldown — using the item is the cost.

```lua
-- other resources, server-side; still runs the name filter
local ok = exports.MrNewbNameChanger:ChangePlayerName(src, 'Jane', 'Doe')
```

After a successful write (voucher, certificate, clerk, or that export) the server fires a local event other resources can listen for:

```lua
AddEventHandler('MrNewbNameChanger:Server:NameChanged', function(src, identifier, firstName, lastName)
    -- logs, MDT, whatever you need
end)
```
