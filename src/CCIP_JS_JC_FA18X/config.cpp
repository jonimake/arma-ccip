class CfgPatches
{
    class CCIP_JS_S_FA18X
    {
        units[] = {"JS_S_FA18X"};
        weapons[] = {};
        requiredAddons[] = {"CCIP_Core","JS_S_FA18X"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane;
    class JS_S_FA18X: Plane
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "js_w_fa18x_m61",
            "js_w_fa18x_GBU12LGBLaucher",
            "js_w_fa18x_Mk82BombLauncher",
            "js_w_fa18x_GBU38BombLauncher",
            "js_w_fa18x_GBU32BombLauncher",
            "js_w_fa18x_GBU31BombLauncher",
            "js_w_fa18x_GBU39BombLauncher"
        };
        CCIP_Weapon_Positions[]= {
            {"js_w_fa18x_m61",{-0,7.69647,0.041035}},
            {"js_w_fa18x_GBU12LGBLaucher",{0,0,-1}},
            {"js_w_fa18x_Mk82BombLauncher",{0,0,-1}},
            {"js_w_fa18x_GBU38BombLauncher",{0,0,-1}},
            {"js_w_fa18x_GBU32BombLauncher",{0,0,-1}},
            {"js_w_fa18x_GBU31BombLauncher",{0,0,-1}},
            {"js_w_fa18x_GBU39BombLauncher",{0,0,-1}}
        };
    };   
};
