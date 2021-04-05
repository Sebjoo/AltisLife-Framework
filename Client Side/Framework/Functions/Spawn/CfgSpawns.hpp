class CfgSpawns {
    class BaseSpawn {
        factions[] = { "Civilian" };
        buildings[] = {};
        radius = 100;
        conditions = "true";
    };
    class Police : BaseSpawn { factions[] = { "Police" }; };
    class HATO : BaseSpawn { factions[] = { "Hato" }; };
    class Medic : BaseSpawn { factions[] = { "Medic" }; };
    class Civilian : BaseSpawn {
        buildings[] = {
            "Land_i_Shop_01_V1_F",
            "Land_i_Shop_02_V1_F",
            "Land_i_Shop_03_V1_F",
            "Land_i_Stone_HouseBig_V1_F",
            "Land_Chapel_V1_F",
            "Land_Chapel_V2_F",
            "Land_u_House_Big_02_V1_F",
            "Land_u_House_Big_01_V1_F",
            "Land_i_Stone_HouseBig_V1_F",
            "Land_d_Stone_HouseBig_V1_F",
            "Land_d_Stone_HouseSmall_V1_F",
            "Land_d_House_Big_01_V1_F"
        };
    };

    class Altis {
        // Altis Police Constabulary
        class KavalaStation : Police {
            displayName = "Kavala Headquarters";
            marker = "apc_spawn_kavala";
            icon = "Data\UI\Spawns\kavala.paa";
        };
        class AthiraStation : Police {
            displayName = "Athira Station";
            marker = "apc_spawn_athira";
            icon = "Data\UI\Spawns\athira.paa";
        };
        class PyrgosStation : Police {
            displayName = "Pyrgos Station";
            marker = "apc_spawn_pyrgos";
            icon = "Data\UI\Spawns\pyrgos.paa";
        };
        class AgiosStation : Police {
            displayName = "Agios Station";
            marker = "apc_spawn_agios";
            icon = "Data\UI\Spawns\agios.paa";
        };

        // National Health Service
        class KavalaHospital : Medic {
            displayName = "Kavala Hospital";
            marker = "nhs_spawn_kavala";
            icon = "Data\UI\Spawns\kavala.paa";
        };
        class AthiraClinic : Medic {
            displayName = "Athira Clinic";
            marker = "nhs_spawn_athira";
            icon = "Data\UI\Spawns\athira.paa";
        };
        class PyrgosHClinic : Medic {
            displayName = "Pyrgos Clinic";
            marker = "nhs_spawn_pyrgos";
            icon = "Data\UI\Spawns\pyrgos.paa";
        };
        class SofiaHClinic : Medic {
            displayName = "Sofia Clinic";
            marker = "nhs_spawn_sofia";
            icon = "Data\UI\Spawns\sofia.paa";
        };

        // Altis Police Constabulary / National Health Service
        class MarineStation {
            displayName = "Marine Base";
            factions[] = { "Police", "Medic" };
            marker = "joint_spawn_marine";
            icon = "Data\UI\Spawns\marine.paa";
        };

        // HATO
        class HatoKavala : HATO {
            displayName = "Highways Agency";
            marker = "hato_spawn_kavala";
            icon = "Data\UI\Spawns\kavala.paa";
        };

        // Civilian
        class Kavala : Civilian {
            displayName = "Kavala";
            marker = "civ_spawn_kavala";
            icon = "Data\UI\Spawns\kavala.paa";
        };
        class Athira : Civilian {
            displayName = "Athira";
            marker = "civ_spawn_athira";
            icon = "Data\UI\Spawns\athira.paa";
        };
        class Pyrgos : Civilian {
            displayName = "Pyrgos";
            marker = "civ_spawn_pyrgos";
            icon = "Data\UI\Spawns\pyrgos.paa";
        };
        class Sofia : Civilian {
            displayName = "Sofia";
            marker = "civ_spawn_sofia";
            icon = "Data\UI\Spawns\sofia.paa";
            conditions = "[""WideTraveller""] call ULP_fnc_hasPerk";
        };
        class Agios : Civilian {
            displayName = "Agios";
            marker = "civ_spawn_agios";
            icon = "Data\UI\Spawns\agios.paa";
            conditions = "[""WideTraveller""] call ULP_fnc_hasPerk";
        };
        class Neochori : Civilian {
            displayName = "Neochori";
            marker = "civ_spawn_neochori";
            icon = "Data\UI\Spawns\neochori.paa";
            conditions = "[""WideTraveller""] call ULP_fnc_hasPerk";
        };

        class Taxi : Civilian {
            displayName = "Taxi Altis";
            marker = "civ_spawn_taxi";
            icon = "Data\UI\Spawns\taxi.paa";
        };
        class Solicitor : Civilian {
            displayName = "Altis Solicitors";
            marker = "civ_spawn_solicitor";
            icon = "Data\UI\Spawns\solicitor.paa";
        };
        class News : Civilian {
            displayName = "AAN World News";
            marker = "civ_spawn_news";
            icon = "Data\UI\Spawns\news.paa";
        };
        class IDAP : Civilian {
            displayName = "IDAP Camp";
            marker = "civ_spawn_idap";
            icon = "Data\UI\Spawns\idap.paa";
        };
    };

    class Malden {
        class LaTriniteConstabulary : Police {
            displayName = "La Trinité Constabulary";
            marker = "cop_spawn_1";
            icon = "\a3\ui_f\data\map\LocationTypes\vegetationBroadleaf_CA.paa";
        };

        class test : Police {
            displayName = "Another Option";
            marker = "cop_spawn_2";
            icon = "\a3\ui_f\data\map\LocationTypes\vegetationBroadleaf_CA.paa";
        };

        class LaTriniteHospital : Medic {
            displayName = "La Trinité HQ";
            marker = "medic_spawn";
            icon = "\a3\ui_f\data\map\VehicleIcons\pictureLogic_ca.paa";
        };

        class LaTrinite : BaseSpawn {
            displayName = "La Trinité";
            marker = "civ_spawn_1";
            icon = "\a3\ui_f\data\map\LocationTypes\vegetationBroadleaf_CA.paa";
        };
    };
};