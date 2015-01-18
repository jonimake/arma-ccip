class CfgPatches
{
    class CCIP_FIR_F16_F
    {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"CCIP_Core","FIR_F16_F"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane_Fighter_03_base_F;
    class FIR_F16_Base: Plane_Fighter_03_base_F
	{
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "FIR_M61A2",
            //"FIR_RKT_Launcher",//produced errors to ccip_resultindex
            "FIR_GBU31",
            "FIR_GBU32",
            "FIR_GBU38",
            "FIR_GBU10",
            "FIR_GBU12",
            "FIR_mk82_Snakeye",
            "FIR_CBU103"
        };
        CCIP_Weapon_Positions[]= {
            {"FIR_M61A2",{-0.794477,2.05694,-1.41989}},
            //{"FIR_RKT_Launcher",{0,-1,-2}},
            {"FIR_GBU31",{0,-1,-2}},
            {"FIR_GBU32",{0,-1,-2}},
            {"FIR_GBU38",{0,-1,-2}},
            {"FIR_GBU10",{0,-1,-2}},
            {"FIR_GBU12",{0,-1,-2}},
            {"FIR_mk82_Snakeye",{0,-1,-2}},
            {"FIR_CBU103",{0,-1,-2}}
        };
    };
};
