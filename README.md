# MrNewbNameChanger

Vouchers, marriage certificates, and an optional records clerk. Name updates live. No relog.

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

`configs/config.lua` has the item names, `NameFilter` (length + blocked words), the marriage job gate, and the records clerk. Clerk ships off (`Enabled = false`).

Clerk cooldown is `Config.RecordsClerk.Cooldown`, per character, in memory. A restart clears it. Vouchers and certificates don't have one; using the item is the cost.

```lua
bridge.inventory.addItem(src, 'namechangevoucher', 1)
```

From other resources, server-side. Still runs the name filter:

```lua
local ok = exports.MrNewbNameChanger:ChangePlayerName(src, 'Jane', 'Doe')
```

After a successful write (voucher, certificate, clerk, or that export):

```lua
AddEventHandler('MrNewbNameChanger:Server:NameChanged', function(src, identifier, firstName, lastName)
    -- logs, MDT, etc
end)
```
