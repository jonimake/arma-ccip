#include "includes.sqf"


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


//projectile velocity in meters per second
_velocity = vectorAdd [_velocityVec, _initialVelocity];
_gunUnitV = _velocityVec call BIS_fnc_unitVector;
_accelerationV = vectorMultiply [_gunUnitV, _thrust];

_positions = [];
#ifdef TRACE
_positions = [_positions,  _pos] call BIS_fnc_arrayPush;
#endif

_minResolution = 0.01;
_maxResolution = 0.20;
_maxIterations = 512;

_result = _pos;

_maxIterations = 256;
_resultIndex = 0;

_dt = _minResolution;
_elapsedTime = 0;

//forceAir = 0;
_ATLPos = [0,0,0];
_resultIndex = -1;
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
