class CfgPatches
{
    class CCIP_O_Plane_CAS_02_F
    {
        units[] = {"O_Plane_CAS_02_F"};
        weapons[] = {};
        requiredAddons[] = {"A3_Air_F_EPC_Plane_CAS_02"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane_CAS_02_base_F;
    class O_Plane_CAS_02_F: Plane_CAS_02_base_F
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "Cannon_30mm_Plane_CAS_02_F",
            "Rocket_03_HE_Plane_CAS_02_F",
            "Rocket_03_AP_Plane_CAS_02_F",
            "Bomb_03_Plane_CAS_02_F"
        };
        CCIP_Weapon_Positions[]= {
            {"Cannon_30mm_Plane_CAS_02_F",{-0.170947,5.85286,-1.88885}},
            {"Rocket_03_HE_Plane_CAS_02_F",{4.28559,-0.750281,-1.82167}},
            {"Rocket_03_AP_Plane_CAS_02_F",{-4.32534,-0.750281,-1.82167}},
            {"Bomb_03_Plane_CAS_02_F",{0,0,-2}}
        };
    };
};