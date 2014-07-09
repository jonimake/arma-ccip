// CCIP script by Joni Mäkelä
// Addon version by Lars Storjord
//
// For custom vehicles please provide a provider TODO description

#include "includes.sqf"
ccip_iterations = 512;

if(isDedicated) exitWith{}; //only run this on clients


//Variables for public usage across other scripts
ccip_resultIndex = -1;
ccip_impactPos = [0,0,0];
ccip_enabled = false;

ccip_hasEventHandler = false;

numSamples = 10;
// _numSamples frame average so we need _numSamples samples
posSamples = [];
for "_i" from 1 to numSamples /* step +1 */ do {
  posSamples = [posSamples,  [0,0,0]] call BIS_fnc_arrayPush;
};
sampleIndex = 0;
sampleRatio = 1/numSamples;


#ifdef DEBUG
ccipString = "";
ccipColor = [0,1,0,0.5];
ccipColor2 = [1,0,0,.5];
ccipIcon = getText (configfile >> "CfgWeaponCursors" >> "arifle" >> "texture");
ccipFontSize = 0.0175 * SafeZoneW;
ccipIconHeight = 1;
ccipIconWidth = 1;
#endif

#ifdef WEAPON_POS_DEBUG
gunPosSphere = "Sign_Sphere100cm_F" createVehicleLocal [0,0,0];
#endif

trajectoryPositions = [];
currentPlane = objNull;
currentProvider = [];

getImpactPos        = compile preprocessFileLineNumbers  "arma_ccip\getImpactPos.sqf";
getImpactPosRocket  = compile preprocessFileLineNumbers  "arma_ccip\getImpactPosRocket.sqf";
getImpactPosBomb    = compile preprocessFileLineNumbers  "arma_ccip\getImpactPosBomb.sqf";

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
    _bulletVelVec = _vecDir vectorMultiply _initSpeed;

    _positions = [[0,0,0],[]];
    _providerPairs = (currentProvider select 1);
    _providerInfoPos = [_providerPairs, (currentWeapon _plane)] call BIS_fnc_findInPairs;

    _providerInfo = _providerPairs select _providerInfoPos;
    _fnGetWeaponModelSpacePos = _providerInfo select 1;
    _modelSpaceGunPos = _plane call _fnGetWeaponModelSpacePos;

    //following line tries to mend some weirdness with the modelToWorld offset when moving
    _modelSpaceGunPos = _modelSpaceGunPos vectorAdd  ((velocityModelSpace _plane) vectorMultiply -0.11);
    _gunPos = _plane modelToWorld _modelSpaceGunPos;


    if(!surfaceIsWater _gunPos) then {
      _gunPos = ATLToASL _gunPos;
    };

    #ifdef WEAPON_POS_DEBUG
      gunPosSphere setPosASL _gunPos;
    #endif

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

    _sum = [0,0,0];
    {
      _sum = _sum vectorAdd _x;
    } forEach posSamples;
    ccip_impactPos = _sum vectorMultiply sampleRatio;
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

    _distance = ccip_impactPos distance currentPlane;
    _distance = _distance / 10;
    _distance = floor _distance;
    _distance = _distance * 10;
    ccipString = str _distance;
    _drawPos = ccip_impactPos;
    //if(!surfaceIsWater _drawPos) then {
    //  _drawPos = ASLToATL _drawPos;
    //};
    _drawColor = ccipColor;
    if(ccip_resultIndex < 0) then {
        _drawColor = [1,.33,0,0.5]
    };
    drawIcon3D [ccipIcon, _drawColor, _drawPos, ccipIconWidth, ccipIconHeight, 0, ccipString, 2, ccipFontSize];
  };
};

ccip_shutdown = {
  if(ccip_hasEventHandler) then {
    ["ccip_frameHandler", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
    ccip_hasEventHandler = false;
  };
};

ccip_start = {
  private "_plane";
  _plane = _this select 0;
  _engineState = _this select 1;
  if(!_engineState) exitWith {
    call ccip_shutdown;
  };
  if(isPlayer (driver _plane) && ! ccip_hasEventHandler) then {
    currentPlane = _plane;
    _providerFileName =  "arma_ccip\ccipProviders\" + (typeOf _plane + "_ccipProvider.sqf");
    currentProvider = call compile preprocessFileLineNumbers _providerFileName; //returns a pairs array (hashmap/dictionary of some sorts)
    ["ccip_frameHandler", "onEachFrame", {
       call calculateImpactPoint;
        #ifdef DEBUG
          call ccipDrawHandler;
        #endif
    }] call BIS_fnc_addStackedEventHandler;
    ccip_hasEventHandler = true;
  };
};

// Main entry point below

while {true} do {
  // Check every 1 sec if player is in a plane
  waitUntil { sleep 1; vehicle player != player && {(vehicle player) isKindOf "plane"} };

  private "_vehicle";
  _vehicle = vehicle player;

  _getOutHandle = _vehicle addEventHandler ["GetOut", {_this spawn ccip_shutdown}];

  if(isEngineOn _vehicle) then {
    _handle = [_vehicle, true] spawn ccip_start;
  } else {
    _startHandle = _vehicle addEventHandler ["Engine", {[(_this select 0), (_this select 1)] spawn ccip_start}];
  };
};

