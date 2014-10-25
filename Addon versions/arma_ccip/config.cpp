class CfgPatches 
{
	class ArmA_CCIP
	{
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {};	
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
				file = "\ArmA_CCIP\init.sqf";
				postInit = 1;
			};
		};
	};
};