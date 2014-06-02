private ["_velocityVec","_pos","_airFriction","_initialVelocity","_gravity", "_timeToLive"];

//All of this is calculated in relation to the firer ASL pos
_velocityVec = _this select 0;
_pos = _this select 1;
_airFriction = _this select 2;
_sideAirFriction = _this select 3;
_initialVelocity = _this select 4;
_timeToLive = _this select 5;
_gravity = 9.80665; //http://en.wikipedia.org/wiki/Standard_gravity

private ["_posX","_posY","_posZ","_totalVelocityX","_totalVelocityY","_totalVelocityZ","_Vmag","_elapsedTime"];

_elapsedTime = 0;

_posX = _pos select 0;
_posY = _pos select 1;
_posZ = _pos select 2;

//projectile velocity in meters per second
_totalVelocity = vectorAdd [_velocityVec, _initialVelocity];
_totalVelocityX = (_velocityVec select 0) + (_initialVelocity select 0);
_totalVelocityY = (_velocityVec select 1) + (_initialVelocity select 1);
_totalVelocityZ = (_velocityVec select 2) + (_initialVelocity select 2);

private ["_result","_altPos","_positions","_vectorM","_time"];

_positions = [];
_positions = [_positions,  _pos] call BIS_fnc_arrayPush;

_minResolution = 0.05;
_maxResolution = 0.0125;
_maxIterations = 512;

_result = [0,0,0];

_maxIterations = GLOBAL_ITERATION_COUNT;
_resultIndex = 0;
_ATLPos = [];
_dt = _minResolution;
_maxIterations = ceil (_timeToLive/_dt);
_maxIterations = _maxIterations max 256;

private "_startTime";
_startTime = diag_tickTime;
for "_i" from 1 to _maxIterations do {

	//The idea here is to bias the simulation time so that the start of the trajectory
	//is simulated with a worse resolution than the end. Reason is that the start of the
	//trajectory is relatively flat compared to the end, meaning the impactPos should
	//be accurate with that worse resolution.
	//_time = _maxResolution min (_i^-4);

	_elapsedTime = _elapsedTime + _dt;
	//Calculate vector magnitude so that velocity vectors are calculated properly
	_vectorM = sqrt (_totalVelocityX^2 + _totalVelocityY^2 + _totalVelocityZ^2); //velocity sqrt
	_vectorM = _vectorM*_airFriction;

	//Recalculate velocity at the current point in time
	_totalVelocityX = _totalVelocityX + _dt * (_vectorM*_totalVelocityX);
	_totalVelocityY = _totalVelocityY + _dt * (_vectorM*_totalVelocityY);
	_totalVelocityZ = _totalVelocityZ + _dt * (_vectorM*_totalVelocityZ - _gravity);

	//Add recalculated position to previous position
	_posX = _posX + _totalVelocityX*_dt;
	_posY = _posY + _totalVelocityY*_dt;
	_posZ = _posZ + _totalVelocityZ*_dt;

	_potentialImpactPosASL = [_posX, _posY, _posZ];


	_ATLPos = _potentialImpactPosASL;
	if(surfaceIsWater _potentialImpactPosASL) then {
		_ATLPos = ASLToATL _ATLPos;
	};
	_positions = [_positions, _ATLPos] call BIS_fnc_arrayPush;
	if((_ATLPos select 2 ) < 0) exitWith {
		_resultIndex = _i;
	};

};
_result = _ATLPos;
systemChat format["%1 - %2 ms", _resultIndex, (diag_tickTime - _startTime)];
[_result, _positions];