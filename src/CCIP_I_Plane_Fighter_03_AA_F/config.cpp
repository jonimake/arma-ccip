class CfgPatches
{
    class CCIP_I_Plane_Fighter_03_AA_F
    {
        units[] = {"I_Plane_Fighter_03_AA_F"};
        weapons[] = {};
        requiredAddons[] = {"A3_Air_F_Gamma_Plane_Fighter_03","A3_Air_F_EPC_Plane_Fighter_03"};
        author[]= {"Joni Makela","eRazeri","Codingboy","lstor"};
    };
};
class CfgVehicles
{
    class I_Plane_Fighter_03_CAS_F;
    class I_Plane_Fighter_03_AA_F: I_Plane_Fighter_03_CAS_F
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "Twin_Cannon_20mm"
        };
        CCIP_Weapon_Positions[]= {
            {"Twin_Cannon_20mm",{0,2.75,-1.9}}
        };
    };
};