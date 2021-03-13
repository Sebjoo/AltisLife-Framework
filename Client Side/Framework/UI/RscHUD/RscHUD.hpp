#define WIDTH 0.12375012375
#define XP_WIDTH (WIDTH + (WIDTH / 4))

class RscHUD {
    name = "RscHUD";
    idd = 500;
    fadein=0;
    duration = 10e10;
    fadeout=0;
    movingEnable = 0;
    onLoad="uiNamespace setVariable ['RscHUD', _this select 0]";
	onUnload="";
    objects[]={};

    class ControlsBackground {
        class FoodBackground: Life_RscText {
            idc = -1;
            colorBackground[] = {0.1,0.1,0.1,0.85};
            SAFEZONE_X((1 - WIDTH) - MARGIN_X);
			SAFEZONE_Y(((1 - (BUTTON_H * 3)) - MARGIN_Y) - MARGIN_Y);
            SAFEZONE_W(WIDTH);
			SAFEZONE_H(BUTTON_H);
        };

        class WaterBackground: Life_RscText {
            idc = -1;
            colorBackground[] = {0.1,0.1,0.1,0.85};
           SAFEZONE_X((1 - WIDTH) - MARGIN_X);
			SAFEZONE_Y(((1 - (BUTTON_H * 2)) - MARGIN_Y) - (MARGIN_Y / 2));
             SAFEZONE_W(WIDTH);
			SAFEZONE_H(BUTTON_H);
        };

        class HealthBackground: Life_RscText {
            idc = -1;
            colorBackground[] = {0.1,0.1,0.1,0.85};
            SAFEZONE_X((1 - WIDTH) - MARGIN_X);
			SAFEZONE_Y(((1 - BUTTON_H) - MARGIN_Y));
             SAFEZONE_W(WIDTH);
			SAFEZONE_H(BUTTON_H);
        };

        class XPBackground: Life_RscText {
            idc = 511;
            colorBackground[] = {0.1,0.1,0.1,0.85};
            SAFEZONE_X(0.5 - (XP_WIDTH / 2));
			SAFEZONE_Y(((1 - BUTTON_H) - MARGIN_Y));
            SAFEZONE_W(XP_WIDTH);
			SAFEZONE_H(BUTTON_H);
        };
    };

    class Controls {
        class FoodText: Life_RscStructuredText {
            idc = 501;
            text = "<t><img image='Data\UI\food.paa' size='0.8'/></t><t align='right'>100%</t>";
            SAFEZONE_X((1 - WIDTH) - MARGIN_X);
			SAFEZONE_Y(((1 - (BUTTON_H * 3)) - MARGIN_Y) - MARGIN_Y);
            SAFEZONE_W(WIDTH);
			SAFEZONE_H(BUTTON_H);
        };

        class WaterText: Life_RscStructuredText {
            idc = 503;
            text = "<t><img image='Data\UI\water.paa' size='0.8'/></t><t align='right'>100%</t>";
            SAFEZONE_X((1 - WIDTH) - MARGIN_X);
			SAFEZONE_Y(((1 - (BUTTON_H * 2)) - MARGIN_Y) - (MARGIN_Y / 2));
             SAFEZONE_W(WIDTH);
			SAFEZONE_H(BUTTON_H);
        };

        class HealthText: Life_RscStructuredText {
            idc = 505;
            text = "<t><img image='Data\UI\health.paa' size='0.8'/></t><t align='right'>100%</t>";
            SAFEZONE_X((1 - WIDTH) - MARGIN_X);
			SAFEZONE_Y(((1 - BUTTON_H) - MARGIN_Y));
            SAFEZONE_W(WIDTH);
			SAFEZONE_H(BUTTON_H);
        };

        class XPBar: Life_RscProgress {
            idc = 507;
            colorBar[] = { 0.06, 0.06, 0.06, 0.85 };
            SAFEZONE_X(0.5 - (XP_WIDTH / 2));
			SAFEZONE_Y(((1 - BUTTON_H) - MARGIN_Y));
            SAFEZONE_W(XP_WIDTH);
			SAFEZONE_H(BUTTON_H);
        };

        class XPText: Life_RscStructuredText {
            idc = 508;
            text = "<t align='center'>0/2250</t>";
            SAFEZONE_X(0.5 - (XP_WIDTH / 2));
			SAFEZONE_Y(((1 - BUTTON_H) - MARGIN_Y));
            SAFEZONE_W(XP_WIDTH);
			SAFEZONE_H(BUTTON_H);
        };

        class currentLevelText: Life_RscStructuredText {
            idc = 509;
            text = "1<t align='center'>0/2250</t><t align='right'>2</t>";
            colorBackground[] = {0.1,0.1,0.1, 1};
            SAFEZONE_X(0.5 - (XP_WIDTH / 2));
			SAFEZONE_Y(((1 - BUTTON_H) - MARGIN_Y));
            SAFEZONE_W(XP_WIDTH);
			SAFEZONE_H(BUTTON_H);
        };

        class nextLevelText: Life_RscStructuredText {
            idc = 510;
            text = "1<t align='center'>0/2250</t><t align='right'>2</t>";
            colorBackground[] = {0.1,0.1,0.1, 1};
            SAFEZONE_X(0.5 - (XP_WIDTH / 2));
			SAFEZONE_Y(((1 - BUTTON_H) - MARGIN_Y));
            SAFEZONE_W(XP_WIDTH);
			SAFEZONE_H(BUTTON_H);
        };
    };
};