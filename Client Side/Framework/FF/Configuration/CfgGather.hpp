class CfgGather {
    class Resources {
        class mango {
            text = "Gathering mangos...";
            amount = 5;
            zones[] = { "mango_area_1", "mango_area_2", "mango_area_3", "mango_area_4" };
            item = "mango";
            profession[] = { "Prof_Gathering", 1, 50 };
            zoneSize = 30;
        }; // Gather Profession NONE

        class coconut {
            text = "Gathering coconuts...";
            amount = 5;
            zones[] = { "coconut_area_1", "coconut_area_2", "coconut_area_3" };
            item = "coconut";
            profession[] = { "Prof_Gathering", 1, 50 };
            zoneSize = 30;
        }; // Gather Profession NONE

        class bannana {
            text = "Gathering bannanas...";
            amount = 5;
            zones[] = { "banana_area" };
            item = "bannana";
            profession[] = { "Prof_Gathering", 1, 50 };
            zoneSize = 30;
        }; // Gather Profession Novice

        class rice {
            text = "Gathering rice...";
            amount = 5;
            zones[] = { "rice_area" };
            item = "rice";
            profession[] = { "Prof_Gathering", 1, 50 };
            zoneSize = 30;
        }; // Gather Profession Novice

        class wood {
            text = "Gathering wood...";
            amount = 5;
            zones[] = { "logging_area_area_1", "logging_area_area_2", "logging_area_area_3" };
            item = "wood";
            profession[] = { "Prof_Gathering", 1, 50 };
            zoneSize = 30;
        }; // Gather Profession Intermediate

        class cannabis {
            text = "Gathering cannabis...";
            amount = 3;
            zones[] = { "cannabis_area" };
            item = "cannabis";
            profession[] = { "Prof_Gathering", 1, 50 };
            zoneSize = 30;
        }; // Gather Profession Novice

        class opium {
            text = "Gathering opium...";
            amount = 3;
            zones[] = { "opium_area" };
            item = "opium";
            profession[] = { "Prof_Gathering", 1, 50 };
            zoneSize = 30;
        }; // Gather Profession Advanced

        class coca {
            text = "Gathering coca...";
            amount = 3;
            zones[] = { "coca_area" };
            item = "coca";
            profession[] = { "Prof_Gathering", 1, 50 };
            zoneSize = 30;
        }; // Gather Profession Expert
    };

/*
This block can be set using percent,if you want players to mine only one resource ,just leave it as it is.
Example:
        class copper_unrefined
    {
            amount = 2;
        zones[] = { "copper_mine" };
        item = "pickaxe";
        mined[] = { "copper_unrefined" };
This will make players mine only copper_unrefined
Now let's go deeper
Example 2:
        class copper_unrefined
    {
            amount = 2;
        zones[] = { "copper_mine" };
        item = "pickaxe";
        mined[] = { {"copper_unrefined",0,25},{"iron_unrefined",25,95},{"diamond_uncut",95,100} };
    };
    This will give :
    25(±1)% to copper_unrefined;
    70(±1)% to iron_unrefined;
    5%(±1)% to diamond_uncut;

                                                         ! Watch Out !
 If percents are used,you MUST put more than 1 resource in the mined parameter
 mined[] = { {"copper_unrefined",0,25} }; NOT OK (But the script will work)
 mined[] = { {"copper_unrefined",0,45 },{"iron_unrefined",45} };  NOT OK (The script won't work )
 mined[] = { {"copper_unrefined",0,45},{"copper_unrefined",80,100} }; NOT OK
 mined[] = { "copper_unrefined" }; OK
 mined[] = { {"copper_unrefined",0,35} , { "iron_unrefined" ,35,100 } }; OK
*/

    class Minerals {
        class coal {
            amount = 1;
            zones[] = { "coal_area" };
            item = "pickaxe";
            mined[] = {{"coal",0,100},{"uncut_diamond",90,100}};
            zoneSize = 30;
        }; // Mining Profession Novice

        class coral {
            text = "Gathering coral...";
            amount = 5;
            zones[] = { "coral_area" };
            mined[] = {"coral"};
            zoneSize = 30;
        }; // Mining Profession Advanced
        
        class copper_ore {
            amount = 2;
            zones[] = { "copper_area" };
            item = "pickaxe";
            mined[] = {{"copper_ore",0,100},{"uncut_opal",80,100},{"uncut_sapphire",85,100},{"uncut_ruby",88,100},{"uncut_emerald",93,100},{"uncut_diamond",97,100}};
            zoneSize = 30;
        }; // Mining Profession NONE

        class silver_ore {
            amount = 2;
            zones[] = { "silver_area" };
            item = "pickaxe";
            mined[] = {{"silver_ore",0,100},{"uncut_opal",80,100},{"uncut_sapphire",85,100},{"uncut_ruby",88,100},{"uncut_emerald",93,100},{"uncut_diamond",97,100}};
            zoneSize = 30;
        }; // Mining Profession Novice

        class iron_ore {
            amount = 2;
            zones[] = { "iron_area" };
            item = "pickaxe";
            mined[] = {{"iron_ore",0,100},{"uncut_opal",80,100},{"uncut_sapphire",85,100},{"uncut_ruby",88,100},{"uncut_emerald",93,100},{"uncut_diamond",97,100}};
            zoneSize = 30;
        }; // Mining Profession Novice

        class platinum_ore {
            amount = 2;
            zones[] = { "platinum_area" };
            item = "pickaxe";
            mined[] = {{"platinum_ore",0,100},{"uncut_opal",80,100},{"uncut_sapphire",85,100},{"uncut_ruby",88,100},{"uncut_emerald",93,100},{"uncut_diamond",97,100}};
            zoneSize = 30;
        }; // Mining Profession Intermediate

        class rock {
            amount = 1;
            zones[] = { "rock_area" };
            item = "pickaxe";
            mined[] = {{"rock",0,100},{"uncut_opal",80,100},{"uncut_sapphire",85,100},{"uncut_ruby",88,100}};
            zoneSize = 30;
        }; // Mining Profession Intermediate

        class crude_oil {
            amount = 3;
            zones[] = { "oil_rig" };
            item = "";
            mined[] = {{"crude_oil",0,100},{"uncut_opal",70,100},{"uncut_sapphire",75,100},{"uncut_ruby",78,100},{"uncut_emerald",83,100},{"uncut_diamond",87,100} };
            zoneSize = 30;
        }; // Mining Profession Advanced

        class iridium_ore {
            amount = 3;
            zones[] = { "iridium_area" };
            item = "";
            mined[] = {"iridium_ore" };
            zoneSize = 30;
        }; // Mining Profession Expert
    };
};