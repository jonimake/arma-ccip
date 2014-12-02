//WIP
_plane = (vehicle player);
_CCIP_current_Allowed_Weapons = getArray(configFile >> "CfgVehicles" >> (typeOf _plane) >> "CCIP_Allowed_Weapons");//local variabled this
if (((currentWeapon _plane) in _CCIP_current_Allowed_Weapons) && (_plane ammo (currentWeapon _plane)) != 0) then {//added ammo check
    CCIP_Enabled = true;
    startTime = diag_tickTime;
    _info = _plane call CCIP_fnc_getDrawPos;
    endTime = diag_tickTime;
    _pos = _info select 0;
    CCIP_resultIndex = _info select 1;
    posSamples set [sampleIndex, _pos];

    _sum = [0,0,0];
    {
        _sum = _sum vectorAdd _x;
    } forEach posSamples;
    CCIP_impactPos = _sum vectorMultiply sampleRatio;
    sampleIndex = sampleIndex + 1;
    if(sampleIndex > (numSamples-1)) then {
        sampleIndex = 0;
    };
    call CCIP_fnc_DrawHandler;//moved from the eachframe EH
    if(_plane getVariable ["CCIP_DebugLine", false])then {
        [_info select 2] call CCIP_fnc_DebugLine; 
    };
}else{
CCIP_Enabled = false;
};