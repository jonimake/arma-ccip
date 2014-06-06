arma-ccip
=========
Arma-ccip is a CCIP (continously computed impact point) solver for aircrafts in ArmA 3. It is a client side script that only runs on clients. The script calculates the approximate impact point of the currently selected weapon in the aircraft. It is an approximation, so there will be a small degree of error between the calculated impact point and the real impact point.

Who it is for?
--
- Vehicle authors
- Other modders

The script only calculates the impact point. There is no fancy HUD showing the impact point reticle (except for debugging purposes). This means it isn't really suitable for just plugging into your mission or for other general play. The script provides two variables that can be accessed to get the impact point information:
```
//these are subject to change
ccip_impactPos		- contains the impact position in ASL format
ccip_resultIndex	- Value will be -1 if no impact point could be solved during the iteration.
			  		  Otherwise the value will indicate which step of the Euler's method was below the ground.
```
Vehicle authors and other mod makers should only need to read these two variables in order to create a proper HUD for their aircraft.

How does it work?
--
Approximation is done by using Euler's method to solve the projectile  motion.

The following ammo types are supported more or less:

  - MissileCore and its sub-types.
  - BulletCore and its sub-types.
  - BombCore and its sub-types (this is still a work in progress).

Installing and usage
--
The script package has been tested with the following folder structure:
```sh
missionRoot
│   mission.sqm 
│
└───jonimake_ccip
    │   getImpactPos.sqf        - BulletCore solver
    │   getImpactPosBomb.sqf    - BombCore solver
    │   getImpactPosRocket.sqf  - MissileCore solver
    │   includes.sqf            - contains pre-processor defs for debugging 
    │   jonimake_ccip.sqf       - main script file
    │
    └───ccipProviders - place additional ccipProvider.sqf files here
            B_Plane_CAS_01_F_ccipProvider.sqf
            O_Plane_CAS_02_F_ccipProvider.sqf
```

Configuring allowed weapons
--
In order to enable CCIP on a certain aircraft, you have to define all CCIP compatible weapons in a file that uses the vehicle type name suffixed with _ccipProvider.sqf. 

For example, the BLUFOR jet would use a file called B_Plane_CAS_01_F_ccipProvider.sqf of which you can find an example below.
```sqf
_allowedWeapons = ["Rocket_04_HE_Plane_CAS_01_F","Rocket_04_AP_Plane_CAS_01_F","Gatling_30mm_Plane_CAS_01_F", "Bomb_04_Plane_CAS_01_F"];

//weapon memory position name
_gatlinInfo = "Gatling_barrels_end";
_heRocketInfo = "Rocket_2";
_apRocketInfo = "Rocket_1";
_bombInfo = "pos cargo";

_pairs = [];
_pairs = [_pairs,"Bomb_04_Plane_CAS_01_F",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Gatling_30mm_Plane_CAS_01_F",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Rocket_04_HE_Plane_CAS_01_F",_heRocketInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Rocket_04_AP_Plane_CAS_01_F",_apRocketInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons , _pairs];
```

License
--
Copyright (C) 2014 Joni Mäkelä

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
