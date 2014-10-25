_allowedWeapons = [
"Twin_Cannon_20mm",
"GBU12BombLauncher"];

_gatlinInfo = {[0,2.75,-1.9]};
_bombInfo = {[0,0,-1.8]};

_pairs = [];
_pairs = [_pairs,"Twin_Cannon_20mm",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"GBU12BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons, _pairs];