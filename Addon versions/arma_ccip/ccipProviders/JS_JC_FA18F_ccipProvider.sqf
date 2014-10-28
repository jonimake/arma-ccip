_allowedWeapons = [
"js_w_fa18_m61",
"js_w_fa18_GBU12LGBLaucher",
"js_w_fa18_GBU31BombLauncher",
"js_w_fa18_GBU32BombLauncher",
"js_w_fa18_GBU38BombLauncher"];

_gatlinInfo = {_this selectionPosition "Cannon_barrel_end"};
_heRocketInfo = {_this selectionPosition "Rocket_2"}; //right rocket
_apRocketInfo = {_this selectionPosition "Rocket_1"}; //left rocket
_bombInfo = {[0,0,-1]};

_pairs = [];

_pairs = [_pairs,"js_w_fa18_m61",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"js_w_fa18_GBU12LGBLaucher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"js_w_fa18_GBU31BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"js_w_fa18_GBU32BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"js_w_fa18_GBU38BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons, _pairs];
