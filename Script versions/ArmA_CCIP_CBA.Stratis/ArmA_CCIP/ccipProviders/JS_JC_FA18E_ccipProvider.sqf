_allowedWeapons = [
"js_w_fa18_m61",
"js_w_fa18_GBU12LGBLaucher",
"js_w_fa18_GBU38BombLauncher"];

_gatlinInfo = {_this selectionPosition "nosegun"};
_gbu12 = {[0,0,-1]};
_gbu38 = {[0,0,-1]};

_pairs = [];

_pairs = [_pairs,"js_w_fa18_m61",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"js_w_fa18_GBU12LGBLaucher",_gbu12,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"js_w_fa18_GBU38BombLauncher",_gbu38,false] call BIS_fnc_addToPairs;

[_allowedWeapons, _pairs];