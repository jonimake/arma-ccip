#include "includes.sqf"

private ["_velocityVec","_pos","_airFriction","_initialVelocity","_gravity","_thrust","_thrustTTL","_mass"];
debugVel = [];

//All of this is calculated in relation to the firer ASL pos
_velocityVec 		= _this select 0;
_pos 				= _this select 1;
_airFriction 		= _this select 2;
_sideAirFriction 	= _this select 3;
_initialVelocity 	= _this select 4;
_timeToLive  		= _this select 5;
_thrust 			= _this select 6;
_thrustTTL 			= _this select 7;
_mass 				= _this select 8;

_gravity = 9.80665; //http://en.wikipedia.org/wiki/Standard_gravity

private ["_posX","_posY","_posZ","_totalVelocityX","_totalVelocityY","_totalVelocityZ","_Vmag","_elapsedTime"];

vXYZ = [];
dragF = [];
factor = 0;
accXYZ = [];
_acceleration = [0,0,0];
//_velMag = sqrt((_initialVelocity select 0)^2 + (_initialVelocity select 1)^2 + (_initialVelocity select 2)^2);
//projectile velocity in meters per second
_totalVelocity = vectorAdd [_velocityVec, _initialVelocity];
//_totalVelocityX = (_velocityVec select 0);
//_totalVelocityY = (_velocityVec select 1);
//_totalVelocityZ = (_velocityVec select 2);


//_gunUnitV = [(_velocityVec select 0), (_velocityVec select 1), (_velocityVec select 2)] call BIS_fnc_unitVector;
//_accelerationV = [_gunUnitV, _thrust]call CBA_fnc_scaleVectTo;
//accelerationV = _accelerationV;
//hintSilent format ["AccelV = %1 \nThrust TTL = %2 \nThrust = %3 \nMass = %4", _accelerationV, _thrustTTL, _thrust, _mass];

private ["_result","_altPos","_positions","_vectorM","_time"];

_positions = [];
_positions = [_positions,  _pos] call BIS_fnc_arrayPush;

_minResolution = 0.01;
_maxResolution = 0.20;
_maxIterations = 512;

_result = _pos;

_maxIterations = GLOBAL_ITERATION_COUNT;
_resultIndex = -1;

_dt = _minResolution;
_elapsedTime = 0;
_velocity = _totalVelocity;
_vx = _totalVelocityX;              // v begin with initial velocity
_vy = _totalVelocityY;              // y begin with initial position
_vz = _totalVelocityZ;

_posX = _pos select 0;
_posY = _pos select 1;
_posZ = _pos select 2;

forceAir = 0;
_ATLPos = [0,0,0];

private "_startTime";
_startTime = diag_tickTime;

for "_i" from 1 to _maxIterations do {
	private["_ax","_ay","_az"];
	_dt = (_i^-0.1)/8 max _minResolution;
	_elapsedTime = _elapsedTime + _dt;
	_a = [0,0,0];

	if(_elapsedTime < _thrustTTL) then {
		_a = vectorAdd [_a, _accelerationV];
	};

	//http://physics.gmu.edu/~amin/phys251/Topics/NumAnalysis/Odes/projectileMotion.html
	_Vmagnitude = sqrt vectorMagnitude _velocity;
	//0.6 is a magic number to reduce the error caused by the Euler method
	//0.5 would be the proper one I think.
	_Vmagnitude = 0.6 * _Vmagnitude*-_airFriction;
	_Fdrag = vectorMultiply [_velocity, _Vmagnitude];


	//determine the velocity: v  ←  v + Δv = v + a*Δt
	_deltaV = vectorMultiply [_Fdrag, (1/_mass)];
	_deltaV = vectorAdd [_a, _deltaV];
	_deltaV = vectorAdd [_deltaV, [0,0,-_gravity]];
	_deltaV = vectorMultiply [_deltaV, _dt];
	_velocity = vectorAdd [_velocity, _deltaV];


	//determine the position: pos  ←  pos + Δpos = pos + v*Δt
	_deltaPos = vectorMultiply [_velocity, _dt];
	_pos = vectorAdd [_pos, _deltaPos];

#ifdef TRACE
	_positions = [_positions, _pos] call BIS_fnc_arrayPush;
#endif
	_ATLPos = _pos;
	if(!surfaceIsWater _ATLPos) then {
		_ATLPos = ASLToATL _ATLPos;
	};
	if((_ATLPos select 2 ) < 0) exitWith {
		_resultIndex = _i;
	};

};
_result = _ATLPos;
[_result, _resultIndex, _positions];
