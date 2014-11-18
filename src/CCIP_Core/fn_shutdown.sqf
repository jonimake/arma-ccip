if(CCIP_hasEventHandler) then {
    ["CCIP_FrameHandler", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
    CCIP_hasEventHandler = false;
};