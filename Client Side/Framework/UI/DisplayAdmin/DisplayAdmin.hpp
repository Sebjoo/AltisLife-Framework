#define WIDTH 0.12375012375
#define XP_WIDTH (WIDTH + (WIDTH / 4))

class DisplayAdmin {
    name = "DisplayAdmin";
    idd = 600;
    onLoad=" [""Load"", _this] call ULP_fnc_adminCamera;";
	onUnload=" [""Unload"", _this] call ULP_fnc_adminCamera;";
    objects[]={};

    class ControlsBackground {
        class MapView : Life_RscMapControl {
            idc = 601;
			SAFEZONE_X(0);
			SAFEZONE_Y(0);
			SAFEZONE_W(1);
			SAFEZONE_H(1);
            maxSatelliteAlpha = 0.75;
            alphaFadeStartScale = 1.15;
            alphaFadeEndScale = 1.29;
        };
    };
    class Controls {};
};