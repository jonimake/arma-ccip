class CfgPatches
{
    class CCIP_STI_A10
    {
        units[] = {"STI_A10A"};
        weapons[] = {};
        requiredAddons[] = {"sti_A10"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane_Base_F;
    class STI_A10A: Plane_Base_F
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "sti_w_GAU8",
            "sti_w_FFARLauncher",
            "sti_w_GBU12LGBLaucher",
            "sti_w_Mk82BombLauncher",
            "sti_w_Mk84BombLauncher",
            "sti_w_GBU31BombLauncher",
            "sti_w_GBU32BombLauncher",
            "sti_w_GBU38BombLauncher"
        };
        CCIP_Weapon_Positions[]= {
            {"sti_w_GAU8",{-0.0633307,7.5732,0.970087}},
            {"sti_w_FFARLauncher",{0,0,0}},
            {"sti_w_GBU12LGBLaucher",{0,0,0}},
            {"sti_w_Mk82BombLauncher",{0,0,0}},
            {"sti_w_Mk84BombLauncher",{0,0,0}},
            {"sti_w_GBU31BombLauncher",{0,0,0}},
            {"sti_w_GBU32BombLauncher",{0,0,0}},
            {"sti_w_GBU38BombLauncher",{0,0,0}}
        };
    };
};
