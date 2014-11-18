_plane = _this;//_this
_ammoName         = getText  (configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "ammo");
_initSpeed        = getNumber(configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "initSpeed");
_mass             = getNumber(configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "mass");
_airFriction      = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "airFriction");
_sideAirFriction  = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "sideAirFriction");
_timeToLive       = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "timeToLive");


_vecDir =_plane weaponDirection (currentWeapon _plane);

_vel = velocity _plane;
_bulletVelVec = _vecDir vectorMultiply _initSpeed;

_positions = [[0,0,0],[]];
_providerPairs = getArray(configFile >> "CfgVehicles" >> (typeOf _plane) >> "CCIP_Weapon_Positions");
_providerInfoPos = [_providerPairs, (currentWeapon _plane)] call BIS_fnc_findInPairs;

_providerInfo = _providerPairs select _providerInfoPos;
_modelSpaceGunPos = _providerInfo select 1;

//_modelSpaceGunPos = _plane call _fnGetWeaponModelSpacePos;//what the hell was this sorcery??

//following line tries to mend some weirdness with the modelToWorld offset when moving
_modelSpaceGunPos = _modelSpaceGunPos vectorAdd  ((velocityModelSpace _plane) vectorMultiply -0.11);
_gunPos = _plane modelToWorld _modelSpaceGunPos;


if(!surfaceIsWater _gunPos) then {
    _gunPos = ATLToASL _gunPos;
};

if(_plane getVariable ["CCIP_DebugWeaponPos", true])then { //false
    [_gunPos] call CCIP_fnc_DebugWeaponPos;
};

if(_ammoName isKindOf "MissileCore") then {
    _thrust    = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "thrust");
    _thrustTTL = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "thrustTime");
    _positions = [_bulletVelVec, _gunPos, _airFriction, _sideAirFriction, _vel, _timeToLive, _thrust, _thrustTTL, _mass] call CCIP_fnc_getImpactPosRocket;
};

if(_ammoName isKindOf "BulletCore" || _ammoName isKindOf "SubMunitionCore") then {
    _positions = [_bulletVelVec, _gunPos, _airFriction, _sideAirFriction, _vel, _timeToLive] call CCIP_fnc_getImpactPosBullet;
};

if(_ammoName isKindOf "BombCore") then {
    _positions = [_bulletVelVec, _gunPos, _airFriction, _sideAirFriction, _vel, _timeToLive, 0, 0, _mass] call CCIP_fnc_getImpactPosBomb;
};

_positions;
