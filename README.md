Arma-CCIP
=========
Arma-CCIP is a CCIP (Continously Computed Impact Point) solver for aircraft in
ArmA 3. It is a client side script that only runs on clients. The script
calculates the approximate impact point of the currently selected weapon in the
aircraft. It is an approximation, so there will be a small degree of error
between the calculated impact point and the real impact point.

Who it is for?
--
- Vehicle authors
- Other modders
- Pilots and other enthusiasts

The script only calculates the impact point. There is just a crude cross on the
HUD along with distance text to indicate the computed impact point. HUD
development was never a focus of this project but that might change.

The script provides two variables that can be accessed to get the impact point information:

```
// These are subject to change
ccip_impactPos    - contains the impact position in ASL format
ccip_resultIndex  - Value will be -1 if no impact point could be solved during the iteration.
              Otherwise the value will indicate which step of the Euler's method was below the ground.
```
These variables are calculated on each frame and the `ccip_impactPos` variable is
a moving average of the past ten frames. This is done to minimize jittering of
the position.  Vehicle authors and other mod makers should only need to read
these two variables in order to create a proper HUD for their aircraft. Of
course suggestions for additional variables are welcome. 

How does it work?
--
Approximation is done by using Euler's method to solve the projectile motion.

The following ammo types are supported more or less:

  - `MissileCore` and its sub-types.
  - `BulletCore` and its sub-types.
  - `BombCore` and its sub-types.

Installing and usage
--
**Note:** Running on ArmA 3 dev branch is no longer a requirement.

[Install as a regular ArmA 3 addon](http://www.armaholic.com/forums.php?m=posts&q=20866).

Configuring allowed weapons
--
In order to enable CCIP on a certain aircraft, you have to define all CCIP
compatible weapons in a file that uses the vehicle type name suffixed with
`_ccipProvider.sqf`.

For example, the BLUFOR jet would use a file called
`B_Plane_CAS_01_F_ccipProvider.sqf` of which you can find an example below.

```sqf
_allowedWeapons = [
  "Rocket_04_HE_Plane_CAS_01_F",
  "Rocket_04_AP_Plane_CAS_01_F",
  "Gatling_30mm_Plane_CAS_01_F",
  "Bomb_04_Plane_CAS_01_F"
];

// These functions will be called in the jonimake_ccip.sqf file.
// The current plane is passed as _this parameter and the function
// has to return the position of the weapon in model space. This means
// you can either call _this selectionPosition "memoryposname" or just
// return the position as a three index array like the _heRocketInfo for example.
_gatlinInfo = {
  _this selectionPosition "Gatling_barrels_end";
};

_heRocketInfo = {
  [5.3,1.5,-0.5];
};

_apRocketInfo = {
  [-5.3,1.5,-0.5];
};

_bombInfo = {
  [0,0,-1];
};

_pairs = [];
_pairs = [_pairs,"Bomb_04_Plane_CAS_01_F",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Gatling_30mm_Plane_CAS_01_F",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Rocket_04_HE_Plane_CAS_01_F",_heRocketInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Rocket_04_AP_Plane_CAS_01_F",_apRocketInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons , _pairs]; // Return as an array that contains the allowed weapons list and the pairs data structure
```

Authors
--

- Arma-CCIP is written by Joni Mäkelä (@jonimake).
- Addon version by Lars Storjord (@lstor).

License
--
MIT License:

Copyright (C) 2014 Joni Mäkelä

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
