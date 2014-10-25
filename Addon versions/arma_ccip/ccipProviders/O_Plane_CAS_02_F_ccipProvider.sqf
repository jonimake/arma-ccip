_allowedWeapons = [
"Cannon_30mm_Plane_CAS_02_F",
"Rocket_03_HE_Plane_CAS_02_F",
"Rocket_03_AP_Plane_CAS_02_F",
"Bomb_03_Plane_CAS_02_F"];

_gatlinInfo = {_this selectionPosition "Cannon_barrel_end"};
_heRocketInfo = {_this selectionPosition "Rocket_2"}; //right rocket
_apRocketInfo = {_this selectionPosition "Rocket_1"}; //left rocket
_bombInfo = {[0,0,-2]};

_pairs = [];

_pairs = [_pairs,"Cannon_30mm_Plane_CAS_02_F",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Rocket_03_HE_Plane_CAS_02_F",_heRocketInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Rocket_03_AP_Plane_CAS_02_F",_apRocketInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Bomb_03_Plane_CAS_02_F",_bombInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons, _pairs];
