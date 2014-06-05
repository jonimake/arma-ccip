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
_resultIndex = 0;
numWithoutThrust = 0;
numWithThrust = 0;

_dt = _minResolution;
_elapsedTime = 0;
_v = _totalVelocity;
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

	//_dt = _maxResolution min (_i^-1);
	//_dt = _dt max _minResolution;
	_dt = (_i^-0.1)/8 max _minResolution;
	_elapsedTime = _elapsedTime + _dt;
	_a = [0,0,0];
/*
	if(_elapsedTime < _thrustTTL) then {
		_ax = _ax + (_accelerationV select 0);
		_ay = _ay + (_accelerationV select 1);
		_az = _az + (_accelerationV select 2);
	};
*/
	//TODO try Heun's method
	/*
	for _i from 1 to n do {
		_val = func[array _i]
		array _i+1 = array _i +  0.5 * _dt * (_val + func[(_array _i + _dt * _val)])
	};


	*/
	_speedP2 = vectorMagnitudeSqr _v;
	//_speedP2 = _vx^2 + _vy^2 + _vz^2;


	//http://physics.gmu.edu/~amin/phys251/Topics/NumAnalysis/Odes/projectileMotion.html
	//_Vmagnitude = sqrt (vectorMagnitudeSqr _v);
	//_Vmagnitude = sqrt(abs _vx + abs _vy + abs _vz);

	//0.6 is a magic number to reduce the error caused by the euler's method
	//0.5 would be the proper one I think.
	_Vmagnitude = 0.6 * (sqrt(_speedP2))*-_airFriction;

	_Fdrag = vectorMultiply [_v, _Vmagnitude];

 	//_FdragX = _Vmagnitude * _vx;
 	//_FdragY = _Vmagnitude * _vy;
 	//_FdragZ = _Vmagnitude * _vz;
 	//vXYZ = [_vx, _vy, _vz];
 	//dragF = [_FdragX, _FdragY, _FdragZ];
 	//accXYZ = [_ax, _ay, _az];

	//determine the velocity: v  ←  v + Δv = v + a*Δt
	_Fdrag = vectorMultiply [_Fdrag, (1/_mass)];
	_Fdrag = vectorAdd [_a, _Fdrag];
	_Fdrag = vectorAdd [0,0, -(_gravity/2)];
	_deltaV = vectorMultiply [_Fdrag, _dt];

	_v = vectorAdd [_v, _deltaV];

	//_vx = _vx + _dt * (_ax + _FdragX/_mass);
	//_vy = _vy + _dt * (_ay + _FdragY/_mass);
	//_vz = _vz + _dt * (_az + _FdragZ/_mass - _gravity/2);

	//determine the position: pos  ←  pos + Δpos = pos + v*Δt
	_deltaPos = vectorMultiply [_v, _dt];
	_pos = vectorAdd [_pos, _deltaPos];

	//_posX = _posX + _vx * _dt;
	//_posY = _posY + _vy * _dt;
	//_posZ = _posZ + _vz * _dt;

	_potentialImpactPosASL = _pos;

	_positions = [_positions, _potentialImpactPosASL] call BIS_fnc_arrayPush;

	_ATLPos = ASLToATL _potentialImpactPosASL;
	if((_ATLPos select 2 ) < 0) exitWith {
		_resultIndex = _i;
	};

};
_result = _ATLPos;
systemChat format["%1 - %2 ms", _resultIndex, (diag_tickTime - _startTime)];
[_result, _positions];

