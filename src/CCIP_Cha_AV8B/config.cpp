class CfgPatches
{
    class CCIP_Cha_AV8B
    {
        units[] = {"Cha_AV8B2"};
        weapons[] = {};
        requiredAddons[] = {"CCIP_Core","Cha_AV8B"};
        author[]= {"Jonpas","eRazeri"};
    };
};
class CfgVehicles
{
    class Plane;
    class Cha_AV8B2: Plane
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "Cha_gatling_25mm",
            "Cha_GBU12BombLauncher",
            "Cha_FFAR_Smallpod"
        };
        CCIP_Weapon_Positions[]= {
            {"Cha_gatling_25mm",{-0.778397,2.41323,-1.67921}},
            {"Cha_GBU12BombLauncher",{0,0,-1.5}},
            {"Cha_FFAR_Smallpod",{0,3,-1}}
        };
    };
};
