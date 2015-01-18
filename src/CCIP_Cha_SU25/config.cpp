class CfgPatches
{
    class CCIP_Cha_Su25
    {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"CCIP_Core","Cha_Su25"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane;
    class Cha_Su25_base: Plane
	{
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "Cha_SU25_Cannon_30mm",
            //"Cha_Su25_S8_Rocket",//produced errors to ccip_resultindex
            "Cha_Su25_Fab250Launcher"
        };
        CCIP_Weapon_Positions[]= {
            {"Cha_SU25_Cannon_30mm",{-0.331117,5.74396,-1.53995}},
            //{"Cha_Su25_S8_Rocket",{0,0,-1.4}},
            {"Cha_Su25_Fab250Launcher",{0,0,-1.4}}
        };
    };
};
