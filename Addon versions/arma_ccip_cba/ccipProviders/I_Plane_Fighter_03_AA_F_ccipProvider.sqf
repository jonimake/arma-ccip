_allowedWeapons = [
"Twin_Cannon_20mm"];

_gatlinInfo = {[0,2.75,-1.9]};

_pairs = [];
_pairs = [_pairs,"Twin_Cannon_20mm",_gatlinInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons, _pairs];