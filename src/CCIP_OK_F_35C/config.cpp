class CfgPatches
{
    class CCIP_OK_F_35C
    {
        units[] = {"F_35C","F_35C_I"};
        weapons[] = {};
        requiredAddons[] = {"F_35C"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane_Base_F;
    class F_35C_Base: Plane_Base_F
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "OK_F_35C_CANNON_W",
            "OK_F_35C_GBU32_W",
            "OK_F_35C_4Rnd_GBU32_W",
            "OK_F_35C_GBU32_int_W",
            "OK_F_35C_GBU53_int_W"
        };
        CCIP_Weapon_Positions[]= {
            {"OK_F_35C_CANNON_W",{9.51067e-006,-0.0563808,-1.22627}},
            {"OK_F_35C_GBU32_W",{0,0,-1}},
            {"OK_F_35C_4Rnd_GBU32_W",{0,0,-1}},
            {"OK_F_35C_GBU32_int_W",{0,0,-1}},
            {"OK_F_35C_GBU53_int_W",{0,0,-1}},
        };
    };
};
