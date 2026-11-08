# Changelog

## 1.1.2
- Replaced the legacy campaign-loaded hook with Modern Hooks to fix the missing `mods_addHook` error.
- Explicitly declared Modern Hooks as a mod dependency alongside MSU.

## 1.1.1
- Fixed the workshop not spawning until the first save was reloaded in a new campaign.

## 1.1.0
- Added separate melee and ranged weapon commissions to the workshop's main menu.
- Added bow, crossbow, handgonne, and throwing weapon commissions at the existing weapon price.

## 1.0.1
- Added text and image in the smith's dialogue to show the item obtained and money spent.
- Added error case and dialogue for when the player has no room in their inventory.
- Modified some flavor text.

## 1.0.0
- A unique Blacksmith's Workshop location that is placed near a settlement when a campaign is loaded.
- An event-driven interface for commissioning famed weapons, body armor, helmets, and shields.
- Weapon commissions organized into sword, axe, mace, hammer, cleaver, flail, spear, polearm, and dagger families.
- Direct delivery of successful commissions to the company stash.
- Configurable minimum renown, category-specific prices, and commission cooldown through MSU settings.
- Eligibility checks and feedback for insufficient renown, insufficient crowns, an active cooldown, or a failed delivery.
- Persistent commission cooldown tracking across campaign saves.
- Support for refreshing the workshop's map sprite when loading workshops created by earlier builds.

