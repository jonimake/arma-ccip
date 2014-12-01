//remove the EH
if(CCIP_hasEventHandler) then {
    ["CCIP_FrameHandler", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
    CCIP_hasEventHandler = false;
};

//remove the debug elements
if!(isNull CCIP_Debug_gunPosSphere)then{
deleteVehicle CCIP_Debug_gunPosSphere;
};