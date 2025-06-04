# MrNewb Name Changer

> **Professional FiveM Character Name System** - Seamless in-game name changing with Community Bridge integration and real-time updates across all supported frameworks.

![GitHub Stars](https://img.shields.io/github/stars/MrNewb/MrNewbNameChanger?style=for-the-badge&color=FFD700) ![GitHub Downloads](https://img.shields.io/github/downloads/MrNewb/MrNewbNameChanger/total?style=for-the-badge&color=00FF00) ![GitHub Views](https://img.shields.io/badge/Views-1.8K+-purple?style=for-the-badge&logo=github) ![Framework](https://img.shields.io/badge/Framework-ESX%20%7C%20QBCore%20%7C%20Qbox-blue?style=for-the-badge)

[![Discord](https://img.shields.io/discord/1204398264812830720?label=Discord&logo=discord&color=7289DA&style=for-the-badge)](https://discord.gg/mrnewbscripts) [![Ko-fi](https://img.shields.io/badge/Support-Ko--fi-FF5E5B?style=for-the-badge&logo=ko-fi)](https://ko-fi.com/R5R76BIM9) [![Documentation](https://img.shields.io/badge/Docs-GitBook-blue?style=for-the-badge&logo=gitbook)](https://mrnewbs-scrips.gitbook.io/guide)

---

## Overview

**MrNewb Name Changer** introduces a convenient item-based system that allows players to seamlessly modify their character's first and last names without requiring a relog. Built with Community Bridge integration for universal framework compatibility.

### Key Features

- **Universal Compatibility** - ESX, QBCore, and Qbox/QBX via Community Bridge
- **Real-Time Updates** - Instant name changes without relog requirement
- **Automatic Item Removal** - Seamless item consumption upon successful use
- **OxLib Integration** - Modern input interface for name entry
- **Lightweight Design** - Minimal resource impact

<details>
<summary><strong>Enhanced Features</strong></summary>

**Character Management:**
- **First Name Updates** • **Last Name Updates** • **Instant Metadata Sync** • **Character Info Updates**

**User Experience:**
- **Modern Input Interface** • **No Relog Required** • **Automatic Validation** • **Error Handling**

</details>

---

## Installation Guide

<details>
<summary><strong>Step-by-Step Installation</strong></summary>

### Prerequisites
- **Community Bridge** (install first) • **Ox Library** • **Framework** (auto-detected) • **Inventory System**

### Quick Setup
1. Extract to `resources` folder
2. Add `ensure MrNewbNameChanger` to `server.cfg`
3. Configure the item in your inventory system
4. Restart server

### Item Configuration
**QBCore Example:**
```lua
['name_changer'] = {
    ['name'] = 'name_changer',
    ['label'] = 'Name Changer',
    ['weight'] = 100,
    ['type'] = 'item',
    ['image'] = 'name_changer.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'Change your character name'
}
```

For detailed configuration guides, visit our complete documentation.

</details>

---

## Compatibility Matrix

### Dependencies & Requirements
![Community Bridge](https://img.shields.io/badge/Requires-Community_Bridge-critical?style=for-the-badge&logo=bridge&logoColor=white) ![Ox Library](https://img.shields.io/badge/Requires-ox__lib-orange?style=for-the-badge&logo=library&logoColor=white)

**Required Dependencies:**
- **[Community Bridge](https://github.com/The-Order-Of-The-Sacred-Framework/community_bridge)** - Cross-framework compatibility bridge maintained by 12+ developers
- **[Ox Library](https://github.com/overextended/ox_lib)** - Essential utility library used across most servers
- **Framework** - ESX, QBCore, or Qbox/QBX (auto-detected)
- **Inventory System** - Any system supported by Community Bridge

### Framework Support
![ESX](https://img.shields.io/badge/ESX-✅_Compatible-green?style=flat-square) ![QBCore](https://img.shields.io/badge/QBCore-✅_Compatible-green?style=flat-square) ![Qbox](https://img.shields.io/badge/Qbox/QBX-✅_Compatible-green?style=flat-square)

**Supported:** ESX • QBCore • Qbox/QBX (Qbox and QBX are the same framework)

---

## Features & Functionality

### Core Operations
**Name Change System:**
- **Item-Based Activation** • **Input Validation** • **Character Updates** • **Metadata Sync**

**User Experience:**
- **Modern Interface** • **Real-Time Updates** • **No Disconnection** • **Seamless Integration**

**Administrative Features:**
- **Automatic Logging** • **Error Handling** • **Framework Detection** • **Security Validation**

---

## Usage Instructions

### Player Experience
1. **Acquire the Name Changer item** - Obtain through your server's distribution method
2. **Use the item** - Activate to trigger the OxLib input interface
3. **Enter desired names** - Input new first and last names via the modern interface
4. **Automatic Processing** - Item removal and instant character name updates

### Administrative Setup
**Item Distribution** • **Server Configuration** • **Permission Management** • **Logging Options**

---

## Documentation & Support

### Resources
- **[Documentation](https://mrnewbs-scrips.gitbook.io/guide)** • **[Video Tutorials](https://www.youtube.com/@mrnewb2819)** • **[GitHub Repository](https://github.com/MrNewb/MrNewbNameChanger)**

### Community Support
[![Discord](https://discordapp.com/api/guilds/1204398264812830720/widget.png?style=banner2)](https://discord.gg/mrnewbscripts)

**Join our Discord for support, feature requests, and community feedback.**

### Developer Notes
**From MrNewb:**
> "Simple solutions for common problems - this name changer eliminates the hassle of character recreation while maintaining server stability and framework compatibility."

---

## Acknowledgments

**Special thanks to Decay Studios** for creating the professional inventory icons used in this release.

[![Decay Studios](https://i.imgur.com/a6n1J4u.png)](https://discord.gg/yDXZwZPjdN)

**Visit Decay Studios on [Discord](https://discord.gg/yDXZwZPjdN) for more amazing assets.**

---

## Contributing & Community

**Contributions:** Pull Requests • Issue Reporting • Feature Suggestions • Community Driven

**Values:** Free Resource • No Reselling • Legacy Support • Regular Updates • Community First

---

<details>
<summary><strong>SEO Keywords & Search Optimization</strong></summary>

**FiveM Scripts:** FiveM scripts • FiveM resources • FiveM development • FiveM server scripts • Custom FiveM scripts • Professional FiveM scripts • FiveM script developer • FiveM lua scripts • Best FiveM scripts • Free FiveM scripts • Quality FiveM scripts • Name changer scripts

**Character Management:** FiveM name changer • Character name change • Player name system • FiveM character management • Name update script • Character customization • Player identity • Character modification

**Framework Compatibility:** ESX scripts • QBCore scripts • Qbox scripts • QBX scripts • QB-Core resources • Multi-framework scripts • ESX resources • QBCore resources • Framework compatibility • Universal FiveM scripts • Cross-framework development • ESX QBCore Qbox compatibility

**User Experience:** No relog required • Real-time updates • Seamless integration • Modern interface • OxLib integration • User-friendly scripts • Quality of life • Player convenience

**Free Resources:** Free FiveM scripts • Open source FiveM • Community FiveM scripts • No escrow FiveM • Unencrypted scripts • Community resources • Free roleplay scripts • Open source roleplay • Community driven development

**Roleplay Enhancement:** GTA V roleplay • GTA RP scripts • Roleplay server scripts • RP server resources • Immersive roleplay • Professional roleplay scripts • Roleplay enhancement tools • Character roleplay • Identity management

**Technical Features:** Lua programming • Lua scripting • FiveM development • Lightweight scripts • Performance optimization • Community Bridge integration • Ox Library integration • Modern framework support • Item-based systems

**Search Tags:** `fivem-scripts` `name-changer` `character-management` `esx-scripts` `qbcore-scripts` `qbox-scripts` `qbx-scripts` `player-identity` `character-customization` `no-relog` `real-time-updates` `free-fivem` `lua-programming` `gta5-roleplay` `roleplay-scripts` `oxlib-integration` `community-bridge` `item-based` `professional-scripts` `open-source` `multi-framework` `qb-core` `qbox` `qbx` `free` `script` `mrnewb` `community_bridge`

</details>

---
