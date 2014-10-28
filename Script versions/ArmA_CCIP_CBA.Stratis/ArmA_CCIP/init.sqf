// CCIP script by Joni Mäkelä, eRazeri kiittää ja kuittaa mahtavasta työstä!

if (hasInterface) then {

private ["_userslist","_vehiclelist"];

_userslist=
    [//list of classnames able to use this script, if left empty, runs on everyone   
    
    ];

_vehiclelist=
    [//vehicle classnames able to use this script, if left empty, runs on all planes
    "B_Heli_Light_01_armed_F",
    "B_Plane_CAS_01_F",
    "O_Plane_CAS_02_F",
    "I_Plane_Fighter_03_CAS_F",
    "I_Plane_Fighter_03_AA_F",
    "JS_JC_FA18E",
    "JS_JC_FA18F",
    "JS_JC_FA18E_NEW",
    "JS_JC_FA18F_NEW",
    "Peral_A10C",
    "STI_A10A"
    ];

if ((typeOf (vehicle player) in _userslist) || (count _userslist == 0)) then {
    
      //Vehicle the EH gets attached to
      _veh = _this select 0;

    if ((typeOf _veh in _vehiclelist) || ((_veh isKindOf "Air") && (count _vehiclelist == 0))) then {

            private ["_plane","_getoutHandleri","_EngineHandleri"];
            
            _plane = _veh;
            
            if (isnil {_plane getVariable "CCIP_Disabled"})  then {

            _KilledHandleri = _plane addEventHandler ["Killed", {(_this select 0) removeAllEventHandlers "GetOut"; (_this select 0) removeAllEventHandlers "Killed"; (_this select 0) removeAllEventHandlers "Engine"; (_this select 0) spawn ccip_shutdown;}];
            _getoutHandleri = _plane addEventHandler ["GetOut", {_this spawn ccip_shutdown}];
            _EngineHandleri = _plane addEventHandler ["Engine", {[(_this select 0), (_this select 1)] spawn ccip_start}];
           };
        };
};
};
