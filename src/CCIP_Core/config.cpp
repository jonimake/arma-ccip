class CfgPatches
{
    class CCIP_core
    {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {};
        author[]= {"Joni Makela","eRazeri"};
    };
};
class CfgFunctions
{
    class CCIP
    {
        class functions
        {
            file = "CCIP_core";
            class calculateImpactPoint;
            class DebugWeaponPos;
            class DrawHandler;
            class getDrawPos;
            class getImpactPosBomb;
            class getImpactPosBullet;
            class getImpactPosRocket;
            class init {postInit=1;};
            class shutdown;
            class start;
        };
    };
};