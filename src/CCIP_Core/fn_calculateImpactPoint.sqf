_plane = (vehicle player);
if((currentWeapon _plane) in CCIP_current_Allowed_Weapons) then {
    CCIP_enabled = true;
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
};