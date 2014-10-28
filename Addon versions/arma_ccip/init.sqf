// CCIP script by Joni Mäkelä, eRazeri kiittää ja kuittaa mahtavasta työstä!

//only run this on clients and check that the CBA version is not running
if ((hasInterface) && !(isClass(configFile >> "CfgPatches" >> "ArmA_CCIP_CBA"))) then {

_CCIP_init = execVM "\ArmA_CCIP\jonimake_ccip.sqf";

waitUntil {sleep 0.1; scriptDone _CCIP_init;};

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
    "Peral_A10C",
    "STI_A10A"
    ];

if ((typeOf (vehicle player) in _userslist) || (count _userslist == 0)) then {

    while {true} do {

    if ((typeOf (vehicle player) in _vehiclelist) || (((vehicle player) isKindOf "Air") && (count _vehiclelist == 0))) then {

            private ["_plane","_getoutHandleri","_EngineHandleri"];
            
            _plane = (vehicle player);
            
            if (isnil {_plane getVariable "CCIP_Disabled"})  then {

            _getoutHandleri = _plane addEventHandler ["GetOut", {_this spawn ccip_shutdown}];
            _EngineHandleri = _plane addEventHandler ["Engine", {[(_this select 0), (_this select 1)] spawn ccip_start}];

            if(isPlayer driver _plane) then {
                _handle = [_plane, isEngineOn _plane] spawn ccip_start;
            };

            waitUntil {sleep 3; ((vehicle player) != _plane)};
            
            _plane removeEventHandler ["GetOut", _getoutHandleri];
            _plane removeEventHandler ["Engine", _EngineHandleri];
            _plane spawn ccip_shutdown;
           };
        };
        sleep 10;
    };
};
};