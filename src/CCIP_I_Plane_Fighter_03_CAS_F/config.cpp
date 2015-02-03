class CfgPatches
{
    class CCIP_I_Plane_Fighter_03_CAS_F
    {
        units[] = {"I_Plane_Fighter_03_CAS_F"};
        weapons[] = {};
        requiredAddons[] = {"CCIP_Core","A3_Air_F_Gamma_Plane_Fighter_03","A3_Air_F_EPC_Plane_Fighter_03"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane_Fighter_03_base_F;
    class I_Plane_Fighter_03_CAS_F: Plane_Fighter_03_base_F
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "Twin_Cannon_20mm",
            "GBU12BombLauncher"
        };
        CCIP_Weapon_Positions[]= {
            {"Twin_Cannon_20mm",{0,2.75,-1.9}},
            {"GBU12BombLauncher",{0,0,-1.8}}
        };
    };
};