Durability Mod - Savage Wind Edition
====================================

This package translates the Switch durability mod (1.5x, 2x, 5x, 10x,
and Infinite) into Savage Wind's native Weapon wear setting.

The installed values are:

  1.5x durability: weapon_wear = 67
  2x durability:   weapon_wear = 50
  5x durability:   weapon_wear = 20
  10x durability:  weapon_wear = 10
  Infinite:        no_weapon_wear = 1
                   weapon_wear = 0

Close Savage Wind before applying a profile.

Windows
-------

Run apply-durability-profile.ps1 and follow the prompt:

  powershell -ExecutionPolicy Bypass -File .\apply-durability-profile.ps1

Or pass the profile directory explicitly:

  powershell -ExecutionPolicy Bypass -File .\apply-durability-profile.ps1 -Profile 2x

Linux / Steam Deck
------------------

  chmod +x apply-durability-profile.sh
  ./apply-durability-profile.sh 2x

Data folder override
-------------------

Set SAVAGEWIND_DATA_ROOT to the data folder if it is not the default.

If SAVAGEWIND_DATA_ROOT is not set or you prefer to use the UI, open
Savage Wind Configuration or the game's Options and choose
Options > Accessibility > Weapon wear.
