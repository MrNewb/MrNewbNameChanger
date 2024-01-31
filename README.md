``markdown
# MrNewb Name Changer

## Description
The MrNewb Name Changer script introduces a convenient item that, when used, triggers an input menu, allowing players to seamlessly modify their character's first and last names. Upon submission, the item is automatically removed, and the changes are reflected in both the character info and metadata for the QBCore and QBx_Core frameworks. This feature empowers players to update their names without the hassle of a relog.

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
- **Blue:** Feedback on using an item for name changes (originally command-based).
- **Kamui Kody:** Provided the charInfo table. ([GitHub](https://github.com/KamuiKody))
- **Pickle:** Emotional support. ([PickleModifications](https://github.com/PickleModifications))
- **OnlyCure & mr.olson:** Testing assistance.

## Notes
This script was developed to address the need for immediate name changes without requiring a relog. The item approach was chosen for its simplicity and user-friendly interface.

## Item Configuration for QBCore
```lua
	['namechangevoucher'] 			 = {['name'] = 'namechangevoucher', 			['label'] = 'namechangevoucher', 		    	 ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'namechangevoucher.png', 		['unique'] = true,		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,                     ['description'] = ''},
	['blankmarriagecertificate'] 	 = {['name'] = 'blankmarriagecertificate', 		['label'] = 'blankmarriagecertificate', 		 ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'blankmarriagecertificate.png', ['unique'] = true,		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,                     ['description'] = ''},
	['filledcertificate'] 			 = {['name'] = 'filledcertificate', 			['label'] = 'filledcertificate', 		    	 ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'filledcertificate.png', 		['unique'] = true,		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,                     ['description'] = ''},

	--Weird new qb item format just in case you are on that version/not on qbx
	namechangevoucher				= {name = 'namechangevoucher',				label = 'namechangevoucher',				weight = 200,         type = 'item',         image = 'namechangevoucher.png',			unique = true,        useable = true,     shouldClose = true,       combinable = nil,                     description = ''},
	blankmarriagecertificate		= {name = 'blankmarriagecertificate',		label = 'blankmarriagecertificate',			weight = 200,         type = 'item',         image = 'blankmarriagecertificate.png', 	unique = true,        useable = true,     shouldClose = true,       combinable = nil,                     description = ''},
	filledcertificate				= {name = 'filledcertificate',				label = 'filledcertificate',				weight = 200,         type = 'item',         image = 'filledcertificate.png',			unique = true,        useable = true,     shouldClose = true,       combinable = nil,                     description = ''},


``



## Qb-inventory Edit for Metadata/Info Display on Hover
On line 362 of [qb-inventory](https://github.com/qbcore-framework/qb-inventory/blob/c8b7ffb910c41bdff619ac23281bfbe1b927e64b/html/js/app.js#L362), add the following line:
```javascript
case "filledcertificate":
    return `<p><strong>First Name: </strong><span>${itemData.info.firstname}</span></p>
    <p><strong>Last Name: </strong><span>${itemData.info.lastname}</span></p>`;
```
