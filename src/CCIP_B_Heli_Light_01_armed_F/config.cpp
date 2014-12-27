class CfgPatches
{
    class CCIP_B_Heli_Light_01_armed_F
    {
        units[] = {"B_Heli_Light_01_armed_F"};
        weapons[] = {};
        requiredAddons[] = {"CCIP_Core","A3_Air_F_Heli_Light_01"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Heli_Light_01_armed_base_F;
    class B_Heli_Light_01_armed_F: Heli_Light_01_armed_base_F
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "M134_minigun",
            "missiles_DAR"
        };
        CCIP_Weapon_Positions[]= {
            {"M134_minigun",{0,1,-0.5}},
            {"missiles_DAR",{0,1,-0.55}}
        };
    };
};