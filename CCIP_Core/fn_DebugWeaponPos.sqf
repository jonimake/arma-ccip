//private ["_gunPos"];
_gunPos = _this select 0;
if(isNil "CCIP_Debug_gunPosSphere")then{
    CCIP_Debug_gunPosSphere = "Sign_Sphere100cm_F" createVehicleLocal [0,0,0];
};
CCIP_Debug_gunPosSphere setPosASL _gunPos;//setPosASL
