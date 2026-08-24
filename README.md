# Blacksmith's Workshop

Blacksmith's Workshop is a mod for **Battle Brothers** that adds a unique master blacksmith location to the world map. The workshop gives established companies a reliable, expensive way to commission famed equipment instead of relying entirely on random shop inventories and loot.

When a campaign is created or loaded, the mod places one workshop on a reachable tile near a randomly selected settlement. Visiting it opens an event where the company can commission:

- a melee weapon from a selected family (sword, axe, mace, hammer, cleaver, flail, spear, polearm, or dagger);
- a ranged weapon from a selected family (bow, crossbow, handgonne, or throwing weapon);
- a random famed suit of body armor;
- a random famed helmet; or
- a random famed shield.

Successful commissions are delivered directly to the company stash. They require enough renown and crowns, and a configurable cooldown prevents another commission until the required number of days has passed.

## Requirements

- Battle Brothers with all DLC
- Modern Hooks
- [Modding Standards & Utilities (MSU)](https://github.com/MSUTeam/MSU) 1.2.0 or newer

## Installation

1. Install Modern Hooks and MSU.
2. Download `mod_blacksmith_workshop.zip`.
3. Place the zip file in the Battle Brothers `data` directory. Do not extract it.
4. Start or load a campaign. The workshop is created automatically if the world does not already contain one.

## Configuration

The **Balance** page in MSU's mod settings exposes the following options:

| Setting | Default | Purpose |
| --- | ---: | --- |
| Minimum Renown | 3,000 | Renown required to commission an item |
| Weapon Commission Cost | 40,000 crowns | Price of a famed weapon |
| Armor Commission Cost | 45,000 crowns | Price of famed body armor |
| Helmet Commission Cost | 35,000 crowns | Price of a famed helmet |
| Shield Commission Cost | 20,000 crowns | Price of a famed shield |
| Commission Cooldown | 20 days | Wait after a successful commission |

The item is added before payment is taken. If the stash cannot accept it, the commission fails without charging crowns or starting the cooldown.

## Project structure

```text
.
|-- blacksmith_workshop/
|   |-- blacksmith_manager.nut    # Item creation, validation, payment, and delivery
|   |-- config.nut                # MSU settings and commission eligibility helpers
|   |-- weapon_pools.nut          # Famed weapon paths grouped by weapon family
|   `-- hooks/
|       `-- world_state.nut       # Workshop discovery, placement, and campaign-load hook
|-- scripts/
|   |-- !mods_preload/
|   |   `-- mod_blacksmith_workshop.nut
|   |                                # Mod registration, dependency, and load order
|   |-- entity/world/locations/
|   |   `-- blacksmith_workshop_location.nut
|   |                                # Unique world-map location and interaction
|   `-- events/events/
|       `-- blacksmith_workshop_enter_event.nut
|                                    # Commission menus, dialogue, and result screens
|-- CHANGELOG.md                      # Version history and release notes
|-- TODO.md                           # Planned project work
`-- mod_blacksmith_workshop.zip       # Installable release archive (when built)
```

The `scripts/` paths mirror Battle Brothers' script hierarchy so the game can discover the preload entry point, location, and event. Mod-specific logic lives under `blacksmith_workshop/` and is loaded explicitly by the preload script.

## Development and packaging

The project is written in Squirrel. To make an installable archive, package the `scripts/` and `blacksmith_workshop/` directories at the root of a zip named `mod_blacksmith_workshop.zip`. The archive must not contain an extra parent directory.

The current mod ID is `mod_blacksmith_workshop` and the version is defined in `scripts/!mods_preload/mod_blacksmith_workshop.nut`.

See [CHANGELOG.md](CHANGELOG.md) for release history.
