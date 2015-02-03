//WIP, or is it?
_plane = (vehicle player);
_distance = CCIP_impactPos distance _plane;
_distance = _distance / 10;
_distance = floor _distance;
_distance = _distance * 10;
CCIP_HUD_string = str _distance;
_drawPos = CCIP_impactPos;
//if(!surfaceIsWater _drawPos) then {
//  _drawPos = ASLToATL _drawPos;//Hmmm?
//};
_drawColor = [0,1,0,0.5];//green
if(ccip_resultIndex < 0) then {
    _drawColor = [1,.22,0,0.5]//Orange
};
drawIcon3D ["\A3\ui_f\data\igui\cfg\weaponcursors\arifle_gs.paa", _drawColor, _drawPos, 1, 1, 0, CCIP_HUD_string, 2, 0.0175 * SafeZoneW];