_allowedWeapons = [
"Twin_Cannon_20mm",
"GBU12BombLauncher"];

_gatlinInfo = "Cannon_barrel_end";
_bombInfo = "N/A";

_pairs = [];

_pairs = [_pairs,"Twin_Cannon_20mm",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"GBU12BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons, _pairs];