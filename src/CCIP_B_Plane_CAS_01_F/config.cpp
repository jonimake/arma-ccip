class CfgPatches
{
    class CCIP_B_Plane_CAS_01_F
    {
        units[] = {"B_Plane_CAS_01_F"};
        weapons[] = {};
        requiredAddons[] = {"A3_Air_F_EPC_Plane_CAS_01"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane_CAS_01_base_F;
    class B_Plane_CAS_01_F: Plane_CAS_01_base_F
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "Rocket_04_HE_Plane_CAS_01_F",
            "Rocket_04_AP_Plane_CAS_01_F",
            "Gatling_30mm_Plane_CAS_01_F",
            "Bomb_04_Plane_CAS_01_F"
        };
        CCIP_Weapon_Positions[]= {
            {"Rocket_04_HE_Plane_CAS_01_F",{5.3,1.5,-0.5}},
            {"Rocket_04_AP_Plane_CAS_01_F",{-5.3,1.5,-0.5}},
            {"Gatling_30mm_Plane_CAS_01_F",{-0.0888353,7.66998,-0.690658}},
            {"Bomb_04_Plane_CAS_01_F",{0,0,-1}}
        };
    };
};