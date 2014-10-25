class CfgPatches 
{
	class ArmA_CCIP_CBA 
	{
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {"cba_main"};	
		author[]= {"Joni Makela","eRazeri","Codingboy","lstor"}; 		
	};
};
class CfgFunctions
{
	class ArmA_CCIP 
	{
		class ArmA_CCIP 
		{
			class _init
			{
				file = "\ArmA_CCIP_CBA\jonimake_ccip.sqf";
				//preInit = 1;
        postInit = 1;
			};
		};
	};
};
class Extended_Init_EventHandlers {
    class AllVehicles {
        init = "[_this] execVM ""\ArmA_CCIP_CBA\init.sqf"";";
    };
};