_allowedWeapons = [
"Rocket_04_HE_Plane_CAS_01_F",
"Rocket_04_AP_Plane_CAS_01_F",
"Gatling_30mm_Plane_CAS_01_F",
"Bomb_04_Plane_CAS_01_F"];

//weapon memory position name
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

[_allowedWeapons , _pairs];
