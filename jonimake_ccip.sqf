// CCIP script by Joni Mäkelä
// For custom vehicles please provide a provider TODO description
#include "includes.sqf"

GLOBAL_ITERATION_COUNT = 512;
GLOBAL_DT = 0.01;

if(isDedicated) exitWith{}; //only run this on clients


//Variables for public usage across other scripts
ccip_resultIndex = -1;
ccip_impactPos = [0,0,0];
ccip_enabled = false;


numSamples = 10;
// _numSamples frame average so we need _numSamples samples
posSamples = [];
for "_i" from 1 to numSamples /* step +1 */ do {
  posSamples = [posSamples,  [0,0,0]] call BIS_fnc_arrayPush;
};
sampleIndex = 0;
sampleRatio = 1/numSamples;


debugPos = [0,0,0];

ccipString = "";
ccipColor = [0,1,0,0.5];
ccipColor2 = [1,0,0,.5];
ccipIcon = getText (configfile >> "CfgWeaponCursors" >> "arifle" >> "texture");//(configfile >> "CfgWeaponIcons" >> "srifle");
ccipFontSize = 0.02 * SafeZoneW;

trajectoryPositions = [];
currentPlane = objNull;
fancyColors = [];
currentProvider = [];

getImpactPos        = compile preprocessFileLineNumbers  "jonimake_ccip\getImpactPos.sqf";
getImpactPosRocket  = compile preprocessFileLineNumbers  "jonimake_ccip\getImpactPosRocket.sqf";
getImpactPosBomb    = compile preprocessFileLineNumbers  "jonimake_ccip\getImpactPosBomb.sqf";

getDrawPos = {
    _plane = _this;
    _ammoName         = getText  (configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "ammo");
    _initSpeed        = getNumber(configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "initSpeed");
    _mass             = getNumber(configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "mass");
    _airFriction      = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "airFriction");
    _sideAirFriction  = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "sideAirFriction");
    _timeToLive       = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "timeToLive");


    _vecDir =_plane weaponDirection (currentWeapon _plane);

    _vel = velocity _plane;
    _bulletVelVec = vectorMultiply [_vecDir, _initSpeed];

    _positions = [[0,0,0],[]];
    _providerPairs = (currentProvider select 1);
    _providerInfoPos = [_providerPairs, (currentWeapon currentPlane)] call BIS_fnc_findInPairs;

    _providerInfo = _providerPairs select _providerInfoPos;
    _gunName = _providerInfo select 1;
    _gunPos = _plane modelToWorld (_plane selectionPosition _gunName);//this is in getPos format?
    if(!surfaceIsWater _gunPos) then {
      _gunPos = ATLToASL _gunPos;
    };
    debugPos = _gunPos;
    if(_ammoName isKindOf "MissileCore") then {
      _thrust    = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "thrust");
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
    ccip_enabled = true;
    startTime = diag_tickTime;
    _info = currentPlane call getDrawPos;
    endTime = diag_tickTime;
    _pos = _info select 0;
    ccip_resultIndex = _info select 1;
    posSamples set [sampleIndex, _pos];

    _sumX = 0;
    _sumY = 0;
    _sumZ = 0;
    {
      _sumX = _sumX + (_x select 0);
      _sumY = _sumY + (_x select 1);
      _sumZ = _sumZ + (_x select 2);
    } forEach posSamples;
    ccip_impactPos = vectorMultiply [[_sumX, _sumY, _sumZ], sampleRatio];
    sampleIndex = sampleIndex + 1;
    if(sampleIndex > (numSamples-1)) then {
      sampleIndex = 0;
    };

#ifdef TRACE
    trajectoryPositions = _info select 2;
#endif


  } else {
    ccip_enabled = false;
  };
};

ccipDrawHandler = {
  if(ccip_enabled) then {

#ifdef TRACE
    if((count trajectoryPositions) > 1) then {
      for "_i" from 1 to ((count trajectoryPositions) - 1) do {
        _start = trajectoryPositions select (_i - 1);
        _end = trajectoryPositions select _i;

        if(!surfaceIsWater _start) then {
          _start = ASLToATL _start;
        };
        if(!surfaceIsWater _end) then {
          _end = ASLToATL _end;
        };

        _r = _i % 2;
        _g = _i % 3;
        _b = _i % 4;
        _color = [_r, _g, _b, 1];
        drawLine3D [_start, _end, _color];
      };
    };
#endif

    ccipString = str (ccip_impactPos distance currentPlane);
    _drawPos = ccip_impactPos;
    //if(!surfaceIsWater _drawPos) then {
    //  _drawPos = ASLToATL _drawPos;
    //};
    _drawColor = ccipColor;
    if(ccip_resultIndex < 0) then {
        _drawColor = [1,.33,0,0.5]
    };
    drawIcon3D [ccipIcon, _drawColor, _drawPos, 2, 2, 0, ccipString, 2, ccipFontSize];
  };
};

CCIP_main = {
  _plane = _this;
  if(isPlayer (driver _plane)) then {
    currentPlane = _plane;
    _providerFileName =  "jonimake_ccip\ccipProviders\" + (typeOf _plane + "_ccipProvider.sqf");
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