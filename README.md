
# MrNewb Name Changer

## Description
The MrNewb Name Changer script introduces a convenient item that, when used, triggers an input menu, allowing players to seamlessly modify their character's first and last names. Upon submission, the item is automatically removed, and the changes are reflected in both the character info and metadata for the QBCore and QBx_Core frameworks. This feature empowers players to update their names without the hassle of a relog.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/R5R76BIM9)

## Features
- **User-Friendly Interface:** Utilizes OxLib input for a smooth and intuitive name-changing experience.
- **Framework Compatibility:** Compatible with both QBCore and QBx_Core frameworks.
- **Automatic Item Removal:** Ensures the seamless removal of the item upon successful name change.
- **No Relog Required:** Allows players to see the changes in real-time without the need for a relog.

## Usage
1. **Acquire the Name Changer item:** Configure the item in your inventory (Example item configuration for QBCore provided below).
2. **Use the item:** Trigger the OxLib input to modify your character's first and last names.
3. **Enter desired names:** Input the desired first and last names and submit the changes.
4. **Automatic Removal:** The item is automatically removed, and your character's name is instantly updated in character info and metadata.

## Dependencies
- [OxLib](https://github.com/overextended/ox_lib): OxLib is a optional dependency, if not using it remove it from the manifest and set the config value.

## Credits ❤️
- **Dirk:** Script concept and encouragement to create my version. ([DirkScripts](https://www.dirkscripts.com/))
- **Blue:** Feedback on using an item for name changes (originally command-based)([Blue](https://github.com/JustBlueDolphin))
- **Kamui Kody:** Provided the charInfo table. ([Kody](https://github.com/KamuiKody))
- **Pickle:** Emotional support. ([PickleModifications](https://github.com/PickleModifications))
- **OnlyCure & mr.olson:** Testing assistance.

## Notes
This script was developed to address the need for immediate name changes without requiring a relog. The item approach was chosen for its simplicity and user-friendly interface.


## QBCore logging Configuration
If you intend to use the QB logs from qb-smallresources, it's necessary to set up your own webhook. You can find the webhook creation in the logs.lua file at the following location:

[QB Smallresources logs.lua](https://github.com/qbcore-framework/qb-smallresources/blob/0dbfc5157fe21133ad2bd5ce1239c56c4d56f3d3/server/logs.lua#L2)

Make sure to name the webhook as "namechangelog"

## Item Configuration for QBCore
```lua
	['namechangevoucher'] 			 = {['name'] = 'namechangevoucher', 			['label'] = 'namechangevoucher', 		    	 ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'namechangevoucher.png', 		['unique'] = true,		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,                     ['description'] = ''},
	['blankmarriagecertificate'] 	 = {['name'] = 'blankmarriagecertificate', 		['label'] = 'blankmarriagecertificate', 		 ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'blankmarriagecertificate.png', ['unique'] = true,		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,                     ['description'] = ''},
	['filledcertificate'] 			 = {['name'] = 'filledcertificate', 			['label'] = 'filledcertificate', 		    	 ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'filledcertificate.png', 		['unique'] = true,		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,                     ['description'] = ''},

	--Weird new qb item format just in case you are on that version/not on qbx
	namechangevoucher				= {name = 'namechangevoucher',				label = 'namechangevoucher',				weight = 200,         type = 'item',         image = 'namechangevoucher.png',			unique = true,        useable = true,     shouldClose = true,       combinable = nil,                     description = ''},
	blankmarriagecertificate		= {name = 'blankmarriagecertificate',		label = 'blankmarriagecertificate',			weight = 200,         type = 'item',         image = 'blankmarriagecertificate.png', 	unique = true,        useable = true,     shouldClose = true,       combinable = nil,                     description = ''},
	filledcertificate				= {name = 'filledcertificate',				label = 'filledcertificate',				weight = 200,         type = 'item',         image = 'filledcertificate.png',			unique = true,        useable = true,     shouldClose = true,       combinable = nil,                     description = ''},


```



## Qb-inventory Edit for Metadata/Info Display on Hover
On line 362 of [qb-inventory](https://github.com/qbcore-framework/qb-inventory/blob/c8b7ffb910c41bdff619ac23281bfbe1b927e64b/html/js/app.js#L362), add the following line:
```javascript
case "filledcertificate":
    return `<p><strong>First Name: </strong><span>${itemData.info.firstname}</span></p>
    <p><strong>Last Name: </strong><span>${itemData.info.lastname}</span></p>`;
```

## ps-inventory Edit for Metadata/Info Display on Hover
On line 647 of [ps-inventory](https://github.com/Project-Sloth/ps-inventory/blob/d8e99de867b2b6d49186f707548c4f4ecde201ab/html/js/app.js#L647), add the following line:
```javascript
        } else if (itemData.name == "filledcertificate") {
            $(".item-info-title").html("<p>" + itemLabel + "</p>");
            $(".item-info-description").html(
                "<p><strong>First Name: </strong><span>" +
                itemData.info.firstname +
                "</span></p><p><strong>Last Name: </strong><span>" +
                itemData.info.lastname +
                "</span></p>"
            );
        }
```

## Acknowledgments

Special thanks to Decay Studios for creating the inventory icons used in this release. You can find them on Discord [here](https://discord.gg/yDXZwZPjdN).
[![Decay Studios](https://i.imgur.com/a6n1J4u.png)]([https://i.imgur.com/a6n1J4u.png](https://i.imgur.com/a6n1J4u.png))
