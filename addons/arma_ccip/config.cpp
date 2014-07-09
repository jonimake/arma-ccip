class CfgPatches {
    class arma_ccip {
        units[] = {};
        weapons[] = {};
        requiredVersion = 0.1;
        requiredAddons[] = {"A3_Air_F"};
        author[] = {"jonimake", "Lstor"};
    };
};

class CfgFunctions {
    class ccip {
        class ccip_functions {
            class ccip_main {
                file = "\arma_ccip\init.sqf";
                postInit = 1;
            };
        };
    };
};
