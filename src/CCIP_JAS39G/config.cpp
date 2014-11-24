class CfgPatches
{
    class CCIP_JAS39G
    {
        units[] = {"JAS39G"};
        weapons[] = {};
        requiredAddons[] = {"JAS39G"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane_Fighter_03_base_F;
    class JAS39G: Plane_Fighter_03_base_F
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "cannon_27mm_gripen", 
            "GBU12BombLauncher_gripen"
        };
        CCIP_Weapon_Positions[]= {
            {"cannon_27mm_gripen",{-0.327091,2.42144,-1.18671}},
            {"GBU12BombLauncher_gripen",{0,0,-1}}
        };
    };
};
