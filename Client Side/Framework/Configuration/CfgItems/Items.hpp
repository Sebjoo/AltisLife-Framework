class ItemMap {
	price = 0;
	class Textures {};	
};
class ItemCompass : ItemMap{};
class ItemWatch : ItemMap{};

class ItemGPS {
	price = 0;
	class Textures {};	
};
class B_UavTerminal : ItemGPS{};
class ItemRadio : ItemGPS{};

class Binocular {
	price = 0;
	class Textures {};	
};
class Rangefinder : Binocular{};

class NVGoggles {
	price = 0;
	class Textures {
        class NVGoggles {
			displayName = "Brown";
            condition = "true";
		};
		class NVGoggles_OPFOR : NVGoggles {
			displayName = "Black";
		};
        class NVGoggles_INDEP : NVGoggles {
			displayName = "Green";
		};
    };	
};
class NVGoggles_OPFOR : NVGoggles {};
class NVGoggles_INDEP : NVGoggles {};

class FirstAidKit {
	price = 0;
	class Textures {};	
};

class Medikit {
	price = 0;
	class Textures {};	
};
class ToolKit : Medikit{};

class HandGrenade_Stone {
	displayName = "Flash Grenade";
	price = 0;
	class Textures {};	
};

class SmokeShell {
	price = 0;
	class Textures {
        class SmokeShell {
			displayName = "White";
            condition = "true";
		};
		class SmokeShellRed : SmokeShell {
			displayName = "Red";
		};
        class SmokeShellGreen : SmokeShell {
			displayName = "Green";
		};
        class SmokeShellBlue : SmokeShell {
			displayName = "Blue";
		};
		class SmokeShellOrange : SmokeShell {
			displayName = "Orange";
		};
        class SmokeShellPurple : SmokeShell {
			displayName = "Purple";
		};
    };	
};
class SmokeShellRed : SmokeShell {};
class SmokeShellGreen : SmokeShell {};
class SmokeShellBlue : SmokeShell {};
class SmokeShellOrange : SmokeShell {};
class SmokeShellPurple : SmokeShell {};

class SmokeShellYellow {
	displayName = "Tear Gas";
	price = 0;
	class Textures {};	
};