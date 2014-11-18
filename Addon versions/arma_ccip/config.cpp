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
      file = "functions";
      class init {postInit = 1;};
      class getImpactPos;
      class getImpactPosBomb;
      class getImpactPosRocket;
		};
	};
};