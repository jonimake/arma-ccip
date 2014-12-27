class CfgPatches
{
    class CCIP_JS_JC_SU35
    {
        units[] = {"JS_JC_SU35"};
        weapons[] = {};
        requiredAddons[] = {"CCIP_Core","JS_JC_SU35"};
        author[]= {"eRazeri"};
    };
};
class CfgVehicles
{
    class Plane;
    class JS_JC_SU35: Plane
    {
        CCIP_Configured = 1;
        CCIP_Allowed_Weapons[]= {
            "js_w_su35_gsh30",
            "js_w_su35_s8Laucher",
            "js_w_su35_kab500lLaucher"
        };
        CCIP_Weapon_Positions[]= {
            {"js_w_su35_gsh30",{0.901851,3.85368,-0.26394}},
            {"js_w_su35_s8Laucher",{0,0,-1}},//no way to know if the rockets are on the right side or left side
            {"js_w_su35_kab500lLaucher",{0,0,-1}}
        };
    };    
};
