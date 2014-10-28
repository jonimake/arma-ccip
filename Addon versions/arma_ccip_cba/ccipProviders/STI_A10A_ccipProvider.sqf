_allowedWeapons = [
"sti_w_GAU8",
"sti_w_FFARLauncher",
"sti_w_GBU12LGBLaucher",
"sti_w_Mk82BombLauncher",
"sti_w_Mk84BombLauncher",
"sti_w_GBU38BombLauncher",
"sti_w_GBU32BombLauncher",
"sti_w_GBU31BombLauncher"];

_gatlinInfo = {_this selectionPosition "Cannon_barrel_end"};
_heRocketInfo = {_this selectionPosition "Rocket_2"}; //right rocket
_apRocketInfo = {_this selectionPosition "Rocket_1"}; //left rocket
_bombInfo = {[0,0,1]};

_pairs = [];

_pairs = [_pairs,"sti_w_GAU8",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"sti_w_FFARLauncher",_heRocketInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"sti_w_GBU12LGBLaucher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"sti_w_Mk82BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"sti_w_Mk84BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"sti_w_GBU38BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"sti_w_GBU32BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"sti_w_GBU31BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons, _pairs];
