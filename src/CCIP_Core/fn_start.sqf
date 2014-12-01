//WIP
_plane = _this select 0;
_engineState = _this select 1;
if(_engineState) then {

    if(isPlayer (driver _plane) && !ccip_hasEventHandler) then {
        ["CCIP_FrameHandler", "onEachFrame", {
            call CCIP_fnc_calculateImpactPoint;
            //call CCIP_fnc_DrawHandler;
        }] call BIS_fnc_addStackedEventHandler;
        CCIP_hasEventHandler = true;
        true;
    };
} else {
    call CCIP_fnc_shutdown;
    false;
};
