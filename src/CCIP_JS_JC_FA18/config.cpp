class CfgPatches
{
    class CCIP_JS_JC_FA18
    {
        units[] = {"JS_JC_FA18E","JS_JC_FA18F"};
        weapons[] = {};
        requiredAddons[] = {"JS_JC_FA18"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane;
    class JS_JC_FA18E: Plane
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "js_w_fa18_m61",
            "js_w_fa18_GBU12LGBLaucher",
            "js_w_fa18_GBU31BombLauncher",
            "js_w_fa18_GBU32BombLauncher",
            "js_w_fa18_GBU38BombLauncher"
        };
        CCIP_Weapon_Positions[]= {
            {"js_w_fa18_m61",{-0,7.56972,0.317191}},
            {"js_w_fa18_GBU12LGBLaucher",{0,0,-1}},
            {"js_w_fa18_GBU31BombLauncher",{0,0,-1}},
            {"js_w_fa18_GBU32BombLauncher",{0,0,-1}},
            {"js_w_fa18_GBU38BombLauncher",{0,0,-1}}
        };
    };
    class JS_JC_FA18F: Plane
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "js_w_fa18_m61",
            "js_w_fa18_GBU12LGBLaucher",
            "js_w_fa18_GBU31BombLauncher",
            "js_w_fa18_GBU32BombLauncher",
            "js_w_fa18_GBU38BombLauncher"
        };
        CCIP_Weapon_Positions[]= {
            {"js_w_fa18_m61",{-0,7.56972,0.317191}},
            {"js_w_fa18_GBU12LGBLaucher",{0,0,-1}},
            {"js_w_fa18_GBU31BombLauncher",{0,0,-1}},
            {"js_w_fa18_GBU32BombLauncher",{0,0,-1}},
            {"js_w_fa18_GBU38BombLauncher",{0,0,-1}}
        };
    };    
};
