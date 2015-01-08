class CfgPatches
{
    class CCIP_Peral_A10
    {
        units[] = {"Peral_A10C"};
        weapons[] = {};
        requiredAddons[] = {"CCIP_Core","Peral_A10"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane;
    class Peral_A10C: Plane
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "Peral_w_GAU8",
            "Peral_w_FFARLauncher",
            "Peral_w_Mk82BombLauncher",
            "Peral_w_GBU12LGBLaucher"
        };
        CCIP_Weapon_Positions[]= {
            {"Peral_w_GAU8",{-0.0978186,7.75574,-0.391498}},
            {"Peral_w_FFARLauncher",{0,0,-1}},
            {"Peral_w_Mk82BombLauncher",{0,0,-1}},
            {"Peral_w_GBU12LGBLaucher",{0,0,-1}}
        };
    };
};
