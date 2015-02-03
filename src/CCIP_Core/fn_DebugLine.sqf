//(vehicle player) setVariable ["CCIP_DebugLine", true];
_CCIP_Debug_trajectoryPositions = _this select 0;
if((count _CCIP_Debug_trajectoryPositions) > 1) then {
    for "_i" from 1 to ((count _CCIP_Debug_trajectoryPositions) - 1) do {
            _start = _CCIP_Debug_trajectoryPositions select (_i - 1);
            _end = _CCIP_Debug_trajectoryPositions select _i;

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