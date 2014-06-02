// CCIP script by Joni Mäkelä
// For custom vehicles please provide a provider TODO description

#define  DEBUG true
GLOBAL_ITERATION_COUNT = 512;
GLOBAL_DT = 0.01;

if(isDedicated) exitWith{}; //only run this on clients

CCIP_enabled = false;
ccipString = "";
ccipColor = [0,1,0,0.5];
ccipColor2 = [1,0,0,.5];
ccipIcon = getText (configfile >> "CfgWeaponCursors" >> "arifle" >> "texture");//(configfile >> "CfgWeaponIcons" >> "srifle");
ccipFontSize = 0.02 * SafeZoneW;
impactPos = [0,0,0];
trajectoryPositions = [];
currentPlane = objNull;
fancyColors = [];
currentProvider = [];


getImpactPos = compile preprocessFileLineNumbers  "getImpactPos.sqf";
getImpactPosRocket = compile preprocessFileLineNumbers  "getImpactPosRocket.sqf";
getImpactPosBomb = compile preprocessFileLineNumbers  "getImpactPosBomb.sqf";

getDrawPos = {
    _plane = _this;

    _initSpeed = getNumber(configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "initSpeed");
    _ammoName = getText(configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "ammo");
    _airFriction = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "airFriction");
    _sideAirFriction = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "sideAirFriction");
    _timeToLive = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "timeToLive");
    _mass = getNumber(configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "mass");

    _vecDir =_plane weaponDirection (currentWeapon _plane);

    _vel = velocity _plane;
    _bulletVelVec = [
            (_vecDir select 0)*_initSpeed,
            (_vecDir select 1)*_initSpeed,
            (_vecDir select 2)*_initSpeed];

    _positions = [[0,0,0],[]];
    _providerPairs = (currentProvider select 1);
    _providerInfoPos = [_providerPairs, (currentWeapon currentPlane)] call BIS_fnc_findInPairs;

    _providerInfo = _providerPairs select _providerInfoPos;
    _gunName = _providerInfo select 1;
    _gunPos = ATLToASL (_plane modelToWorld (_plane selectionPosition _gunName)); //asl pos ATLToASL



    if(_ammoName isKindOf "MissileCore") then {
      _thrust = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "thrust");
      _thrustTTL = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "thrustTime");
      _positions = [_bulletVelVec, _gunPos, _airFriction, _sideAirFriction, _vel, _timeToLive, _thrust, _thrustTTL, _mass] call getImpactPosRocket;
    };

    if(_ammoName isKindOf "BulletCore") then {
      _positions = [_bulletVelVec, _gunPos, _airFriction, _sideAirFriction, _vel, _timeToLive] call getImpactPos;
    };

    if(_ammoName isKindOf "BombCore") then {
      _positions = [_bulletVelVec, _gunPos, _airFriction, _sideAirFriction, _vel, _timeToLive, 0, 0, _mass] call getImpactPosBomb;
    };

   _positions;
};

calculateImpactPoint = {
  if((currentWeapon currentPlane) in (currentProvider select 0)) then {
    CCIP_enabled = true;
    startTime = diag_tickTime;
    _info = currentPlane call getDrawPos;
    endTime = diag_tickTime;
    impactPos = _info select 0;
    trajectoryPositions = _info select 1;
  } else {
    CCIP_enabled = false;
  };
};

ccipDrawHandler = {
  if(CCIP_enabled) then {
    if((count trajectoryPositions) > 1) then {
      for "_i" from 1 to ((count trajectoryPositions) - 1) do {
        _start = trajectoryPositions select (_i - 1);
        _end = trajectoryPositions select _i;
        _r = _i % 1;
        _g = _i % 2;
        _b = _i % 3;
        _color = [_r, _g, _b, 1];
        drawLine3D [_start, _end, _color];
      };
    };
    ccipString = str (impactPos distance currentPlane);
    drawIcon3D [ccipIcon, ccipColor, impactPos, 2, 2, 0, ccipString, 2, ccipFontSize];
  };
};

CCIP_main = {
  _plane = _this;
  if(isPlayer (driver _plane)) then {
    currentPlane = _plane;
    _providerFileName =  "ccipProviders\" + (typeOf _plane + "_ccipProvider.sqf");
    systemChat _providerFileName;
    currentProvider = call compile preprocessFileLineNumbers _providerFileName; //returns a pairs array (hashmap/dictionary of some sorts)

    onEachFrame {
      call calculateImpactPoint;
  #ifdef DEBUG
      call ccipDrawHandler;
  #endif
    };
  };
};

if(_this isKindOf "plane") then {
  systemChat str _this;
  _plane = _this;
  _ccipHandle = _this addEventHandler ["GetIn", {_nil = (_this select 0) spawn CCIP_main;}];
  if(isPlayer (driver _plane)) then { //this handles starting mission in a plane without getting in
    _this spawn CCIP_main;
  };
} else {
  hint "Can only execute ccip script on planes";
};