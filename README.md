# MrNewb Name Changer

## Description
This script implements an item that, when used, prompts an OxLib input allowing players to change their character's first and last names. Upon submission, the item is removed, and the name changes are reflected in both the character info and metadata for the QBCore and QBx_Core frameworks. This feature allows players to update their names without requiring a relog.

## Features
- OxLib input for user-friendly name changes
- Compatible with QBCore and QBx_Core frameworks
- Automatic removal of the item upon name change
- No relog required for changes to take effect

## Usage
1. Acquire the Name Changer item. (Example item configuration for QBCore below)
2. Use the item to prompt the OxLib input for name modification.
3. Enter the desired first and last names and submit the changes.
4. The item is automatically removed, and the player's name is updated in character info and metadata.

## Dependencies
- [OxLib](https://github.com/overextended/ox_lib): OxLib is required

## Credits
- Blue: Original idea to use an item for name changes.
- Kamui Kody: Provided the charInfo table.

## Notes
This script was developed because existing free alternatives did not meet the requirement of immediate name changes without the need for a relog. The item approach was adopted for its simplicity and user-friendly interface.


## Item Configuration for QBCore
	['namechangevoucher'] 			 = {['name'] = 'namechangevoucher', 			['label'] = 'namechangevoucher', 		    	 ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'namechangevoucher.png', 		['unique'] = true,		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,                     ['description'] = ''},
	['blankmarriagecertificate'] 	 = {['name'] = 'blankmarriagecertificate', 		['label'] = 'blankmarriagecertificate', 		 ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'blankmarriagecertificate.png', ['unique'] = true,		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,                     ['description'] = ''},
	['filledcertificate'] 			 = {['name'] = 'filledcertificate', 			['label'] = 'filledcertificate', 		    	 ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'filledcertificate.png', 		['unique'] = true,		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,                     ['description'] = ''},
