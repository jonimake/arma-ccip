//(vehicle player) setVariable ["CCIP_DebugWeaponPos", true];
_plane = _this select 0;
_gunPos = _this select 1;

//Create depending on conditions
if(
(alive _plane)
&&
(currentWeapon _plane) in getArray(configFile >> "CfgVehicles" >> (typeOf _plane) >> "CCIP_Allowed_Weapons")
&& 
(isNull CCIP_Debug_gunPosSphere)
)then{
CCIP_Debug_gunPosSphere = "Sign_Sphere100cm_F" createVehicleLocal [0,0,0];// Sign_Sphere25cm_F
};

//set the position of the sphere to visually demonstrate the gunPos
if!(isNull CCIP_Debug_gunPosSphere)then{
CCIP_Debug_gunPosSphere setPosASL _gunPos;//setPosASL
};

//delete depending on conditions
[_plane] spawn {
_plane = _this select 0;
sleep 0.1;//workaround because the framework is not called when using other weapons
if(
!(_plane == vehicle player)
||
!(alive _plane)
||
!((currentWeapon _plane) in getArray(configFile >> "CfgVehicles" >> (typeOf _plane) >> "CCIP_Allowed_Weapons"))
)then{
deleteVehicle CCIP_Debug_gunPosSphere;
};
};
