_allowedWeapons = ["Rocket_04_HE_Plane_CAS_01_F","Rocket_04_AP_Plane_CAS_01_F","Gatling_30mm_Plane_CAS_01_F"];

//weapon memory position name
//???
_gatlinInfo = "Gatling_barrels_end";
_heRocketInfo = "Rocket_2";
_apRocketInfo = "Rocket_1";
_pairs = [];
_pairs = [_pairs,"Gatling_30mm_Plane_CAS_01_F",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Rocket_04_HE_Plane_CAS_01_F",_heRocketInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Rocket_04_AP_Plane_CAS_01_F",_apRocketInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons , _pairs];
