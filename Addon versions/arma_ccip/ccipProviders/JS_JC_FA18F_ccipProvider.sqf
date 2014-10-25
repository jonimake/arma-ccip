_allowedWeapons = [
"js_w_fa18_m61"];

_gatlinInfo = {_this selectionPosition "nosegun"};

_pairs = [];

_pairs = [_pairs,"js_w_fa18_m61",_gatlinInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons, _pairs];