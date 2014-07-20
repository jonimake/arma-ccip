_allowedWeapons = [
"M134_minigun",
"missiles_DAR"];

_minigunInfo = {
	[0,0,0];
};

_rocketsInfo = {
	[0,0,0];
};

_pairs = [];
_pairs = [_pairs,"M134_minigun",_minigunInfo,false] call BIS_fnc_addToPairs;
_pairs = [_pairs,"missiles_DAR",_rocketsInfo,false] call BIS_fnc_addToPairs;

[_allowedWeapons , _pairs];
