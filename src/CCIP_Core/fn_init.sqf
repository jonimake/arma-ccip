// CCIP script by Joni Mäkelä, eRazeri kiittää ja kuittaa mahtavasta työstä!

//only run this on clients and check that the CBA version is not running
if (hasInterface) then {

    ccip_iterations = 512;//512

//Variables for public usage across other scripts
    ccip_resultIndex = -1;
    ccip_impactPos = [0,0,0];
    ccip_enabled = false;

    ccip_hasEventHandler = false;

    numSamples = 10;
// _numSamples frame average so we need _numSamples samples
    posSamples = [];
    for "_i" from 1 to numSamples /* step +1 */ do {
        posSamples = [posSamples,  [0,0,0]] call BIS_fnc_arrayPush;
        };
    sampleIndex = 0;
    sampleRatio = 1/numSamples;

    trajectoryPositions = [];


    private ["_vehiclelist"];

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

    while {true} do {
    sleep 10;

    if (getNumber (configFile >> "CfgVehicles" >> (typeOf (vehicle player)) >> "CCIP_Configured") == 1) then {

            private ["_plane","_getoutHandleri","_EngineHandleri"];

            _plane = (vehicle player);

            if (isnil {_plane getVariable "CCIP_Disabled"})  then {

                _getoutHandleri = _plane addEventHandler ["GetOut", {_this spawn CCIP_fnc_shutdown}];
                _EngineHandleri = _plane addEventHandler ["Engine", {[(_this select 0), (_this select 1)] spawn CCIP_fnc_start}];

                if(isPlayer driver _plane) then {
                    _handle = [_plane, isEngineOn _plane] spawn CCIP_fnc_start;
                };

                waitUntil {sleep 3; ((vehicle player) != _plane)};

                _plane removeEventHandler ["GetOut", _getoutHandleri];
                _plane removeEventHandler ["Engine", _EngineHandleri];
                _plane spawn CCIP_fnc_shutdown;
            };
        };
    };
};
