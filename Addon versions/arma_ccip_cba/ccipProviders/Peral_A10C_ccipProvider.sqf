_allowedWeapons = [
"Peral_w_GAU8",
"Peral_w_FFARLauncher",
"Peral_w_GBU12LGBLaucher",
"Peral_w_Mk82BombLauncher",
"Peral_w_Mk84BombLauncher",
"Peral_w_GBU38BombLauncher",
"Peral_w_GBU32BombLauncher",
"Peral_w_GBU31BombLauncher"];

_gatlinInfo = {_this selectionPosition "Cannon_barrel_end"};
_heRocketInfo = {_this selectionPosition "Rocket_2"}; //right rocket
_apRocketInfo = {_this selectionPosition "Rocket_1"}; //left rocket
_bombInfo = {[0,0,1]};

_pairs = [];

_pairs = [_pairs,"Peral_w_GAU8",_gatlinInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Peral_w_FFARLauncher",_heRocketInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Peral_w_GBU12LGBLaucher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Peral_w_Mk82BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Peral_w_Mk84BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Peral_w_GBU38BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Peral_w_GBU32BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"Peral_w_GBU31BombLauncher",_bombInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons, _pairs];
