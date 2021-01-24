class CfgClothesStore {
	onItemBuy = "_this call ULP_fnc_onBuyClothes";
	toolBoxIDC = 3102;
	itemCfg = "CfgClothing";

	class Police {
		storeName = "Police Clothing Store";
		class Uniforms {
			
		};
		class Headgear {
			class H_WirelessEarpiece_F {};
			class H_Cap_blk {};
			class H_Cap_red {};
			class H_Cap_blu {};
			class H_Cap_tan {};
			class H_Cap_oli {};
			class H_Cap_police {};
			class H_Beret_blk {};
			class H_Watchcap_blk { condition = "[""Police_Main"", 3] call ULP_fnc_hasAccess"; };
			class H_Beret_EAF_01_F { condition = "[""Police_SFO"", 1] call ULP_fnc_hasAccess;"; };
			class H_Beret_gen_F { condition = "[""Police_Main"", 7] call ULP_fnc_hasAccess"; };
			class H_PilotHelmetHeli_B { condition = "[""Police_Main"", 2] call ULP_fnc_hasAccess"; };
			class H_CrewHelmetHeli_B { condition = "[""Police_Main"", 2] call ULP_fnc_hasAccess"; };
			class H_HelmetSpecB_blk { condition = "[""Police_SFO"", 1] call ULP_fnc_hasAccess;"; };
		};
		class Facewear {
			class G_WirelessEarpiece_F {};
			class G_Aviator {};
			class G_Squares {};
			class G_Squares_Tinted {};
			class G_Spectacles {};
			class G_Spectacles_Tinted {};
			class G_Shades_Black {};
			class G_Shades_Red {};
			class G_Squares_Green {};
			class G_Squares_Blue {};
			class G_Sport_Red {};
			class G_Shades_BlackWhite {};
			class G_Shades_Blackred {};
			class G_Shades_Blackyellow {};
			class G_Shades_Greenblack {};
			class G_Shades_checkered {};
			class G_Lady_Blue {};
			class G_Tactical_Clear {};
			class G_B_Diving { condition = "[""Police_SFO"", 1] call ULP_fnc_hasAccess;"; };
			class G_Respirator_white_F {};
			class G_Respirator_blue_F {};
			class G_Respirator_yellow_F {};
			class G_RegulatorMask_F {};
			class G_Bandanna_aviator {};
			class G_Bandanna_shades {};
			class G_Bandanna_sport {};
			class G_Bandanna_beast {};
			class G_Bandanna_blk {};
			class G_Balaclava_TI_blk_F {};
			class G_Balaclava_TI_G_blk_F {};
		};
		class Vests {
			class V_LegStrapBag_black_F {};
			class V_Rangemaster_belt {};
			class V_BandollierB_blk {};
			class V_TacVest_blk_POLICE {};
			class V_PlateCarrier1_blk {};
			class V_PlateCarrier2_blk {};
			class V_RebreatherB { condition = "[""Police_SFO"", 1] call ULP_fnc_hasAccess;"; };
		};
		class Backpacks {
			class B_Carryall_cbr { displayName = "Invisible Backpack"; };
		};
	};

	class Medic {
		storeName = "Medic Clothing Store";
		class Uniforms {
			
		};
		class Headgear {
			class H_HeadBandage_clean_F {};
			class H_WirelessEarpiece_F {};
			class H_Cap_blk {};
			class H_Cap_red {};
			class H_Cap_blu {};
			class H_Cap_tan {};
			class H_Cap_oli {};
			class H_Cap_surfer {};
			class H_Watchcap_blk {};
			class H_Watchcap_cbr {};
			class H_Watchcap_khk {};
			class H_Watchcap_camo {};
			class H_Beret_CSAT_01_F { condition = "[""Medic_Main"", 5] call ULP_fnc_hasAccess"; };
			class H_PilotHelmetHeli_B { condition = "[""Medic_Main"", 2] call ULP_fnc_hasAccess"; };
			class H_CrewHelmetHeli_B { condition = "[""Medic_Main"", 2] call ULP_fnc_hasAccess"; };
		};
		class Facewear {
			class G_WirelessEarpiece_F {};
			class G_Aviator {};
			class G_Squares {};
			class G_Squares_Tinted {};
			class G_Spectacles {};
			class G_Spectacles_Tinted {};
			class G_Shades_Black {};
			class G_Shades_Red {};
			class G_Squares_Green {};
			class G_Squares_Blue {};
			class G_Sport_Red {};
			class G_Shades_BlackWhite {};
			class G_Shades_Blackred {};
			class G_Shades_Blackyellow {};
			class G_Shades_Greenblack {};
			class G_Shades_checkered {};
			class G_Lady_Blue {};
			class G_Tactical_Clear {};
			class G_B_Diving { condition = "[""Medic_Main"", 2] call ULP_fnc_hasAccess"; };
			class G_Respirator_white_F {};
			class G_Respirator_blue_F {};
			class G_Respirator_yellow_F {};
			class G_RegulatorMask_F {};
		};
		class Vests {
			class V_LegStrapBag_black_F {};
			class V_Safety_yellow_F {};
			class V_BandollierB_blk {};
			class V_RebreatherB { condition = "[""Medic_Main"", 2] call ULP_fnc_hasAccess"; };
		};
		class Backpacks {
			class B_Carryall_cbr { displayName = "Invisible Backpack"; };
		};
	};

	class Civilian {
		storeName = "Civilian Clothing Store";
		class Uniforms {
			
		};
		class Headgear {
			class H_WirelessEarpiece_F {};
			class H_Bandanna_gry {};
			class H_Bandanna_blu {};
			class H_Bandanna_khk {};
			class H_Bandanna_cbr {};
			class H_Bandanna_sand {};
			class H_Bandanna_sgg {};
			class H_Bandanna_camo {};
			class H_Bandanna_mcamo {};
			class H_Cap_blk {};
			class H_Cap_usblack {};
			class H_Cap_tan_specops_US {};
			class H_Cap_khaki_specops_UK {};
			class H_Cap_brn_SPECOPS {};
			class H_Cap_blk_Raven {};
			class H_Cap_grn_BI {};
			class H_Cap_blk_ION {};
			class H_Cap_blk_CMMG {};
			class H_Cap_red {};
			class H_Cap_blu {};
			class H_Cap_tan {};
			class H_Cap_oli {};
			class H_Hat_grey {};
			class H_Hat_blue {};
			class H_Hat_brown {};
			class H_Hat_tan {};
			class H_Hat_checker {};
			class H_Hat_camo {};
			class H_StrawHat {};
			class H_StrawHat_dark {};
			class H_Hat_Safari_sand_F {};
			class H_Hat_Safari_olive_F {};
			class H_Watchcap_blk {};
			class H_Watchcap_cbr {};
			class H_Watchcap_khk {};
			class H_Watchcap_camo {};
			class H_Booniehat_khk {};
			class H_Booniehat_khk_hs {};
			class H_Booniehat_grn {};
			class H_Booniehat_oli {};
			class H_Booniehat_tan {};
			class H_Booniehat_mcamo {};
			class H_Booniehat_dgtl {};
			class H_Booniehat_wdl {};
			class H_EarProtectors_black_F {};
			class H_EarProtectors_white_F {};
			class H_EarProtectors_red_F {};
			class H_EarProtectors_orange_F {};
			class H_EarProtectors_yellow_F {};
			class H_HeadSet_black_F {};
			class H_HeadSet_white_F {};
			class H_HeadSet_red_F {};
			class H_HeadSet_orange_F {};
			class H_HeadSet_yellow_F {};
			class H_Construction_basic_black_F {};
			class H_Construction_headset_black_F {};
			class H_Construction_basic_white_F {};
			class H_Construction_headset_white_F {};
			class H_Construction_basic_red_F {};
			class H_Construction_headset_red_F {};
			class H_Construction_basic_orange_F {};
			class H_Construction_headset_orange_F {};
			class H_Construction_basic_yellow_F {};
			class H_Construction_headset_yellow_F {};
			class H_Construction_basic_vrana_F {};
			class H_Construction_headset_vrana_F {};
			class H_Helmet_Skate {};
		};
		class Facewear {
			class G_WirelessEarpiece_F {};
			class G_Aviator {};
			class G_Squares {};
			class G_Squares_Tinted {};
			class G_Spectacles {};
			class G_Spectacles_Tinted {};
			class G_Shades_Black {};
			class G_Shades_Red {};
			class G_Squares_Green {};
			class G_Squares_Blue {};
			class G_Sport_Red {};
			class G_Shades_BlackWhite {};
			class G_Shades_Blackred {};
			class G_Shades_Blackyellow {};
			class G_Shades_Greenblack {};
			class G_Shades_checkered {};
			class G_Lady_Blue {};
			class G_Tactical_Clear {};
			class G_EyeProtectors_F {};
			class G_EyeProtectors_Earpiece_F {};
			class G_Respirator_white_F {};
			class G_Respirator_blue_F {};
			class G_Respirator_yellow_F {};
		};
		class Vests {
			class V_LegStrapBag_black_F {};
			class V_LegStrapBag_coyote_F {};
			class V_LegStrapBag_olive_F {};
			class V_Pocketed_black_F {};
			class V_Pocketed_coyote_F {};
			class V_Pocketed_olive_F {};
			class V_Safety_yellow_F {};
			class V_Safety_orange_F {};
			class V_Safety_blue_F {};
		};
		class Backpacks {
			class B_LegStrapBag_black_F {};
			class B_LegStrapBag_coyote_F {};
			class B_LegStrapBag_olive_F {};
			class B_Messenger_Black_F {};
			class B_Messenger_Gray_F {};
			class B_Messenger_Coyote_F {};
			class B_Messenger_Olive_F {};
			class B_AssaultPack_blk {};
			class B_AssaultPack_cbr {};
			class B_AssaultPack_khk {};
			class B_AssaultPack_rgr {};
			class B_AssaultPack_sgg {};
			class B_AssaultPack_wdl_F {};
			class B_FieldPack_blk {};
			class B_FieldPack_cbr {};
			class B_FieldPack_khk {};
			class B_FieldPack_oli {};
			class B_FieldPack_green_F {};
			class B_Kitbag_cbr {};
			class B_Kitbag_tan {};
			class B_Kitbag_rgr {};
			class B_Kitbag_sgg {};
			class B_Kitbag_mcamo {};
			class B_TacticalPack_blk {};
			class B_TacticalPack_oli {};
			class B_TacticalPack_rgr {};
			class B_Carryall_cbr {};
			class B_Carryall_khk {};
			class B_Carryall_oli {};
			class B_Carryall_green_F {};
			class B_Carryall_wdl_F {};
			class B_ViperLightHarness_khk_F {};
			class B_ViperLightHarness_oli_F {};
			class B_ViperHarness_khk_F {};
			class B_ViperHarness_oli_F {};
			class B_Bergen_mcamo_F {};
			class B_Bergen_dgtl_F {};
			class B_Bergen_hex_F {};
		};
	};

	class GoKart {
		storeName = "Go-Kart Clothing Store";
		class Uniforms {
			
		};
		class Headgear {
			class H_RacingHelmet_1_black_F {};
			class H_RacingHelmet_1_white_F {};
			class H_RacingHelmet_1_red_F {};
			class H_RacingHelmet_1_blue_F {};
			class H_RacingHelmet_1_green_F {};
			class H_RacingHelmet_1_orange_F {};
			class H_RacingHelmet_1_yellow_F {};
			class H_RacingHelmet_4_F {};
			class H_RacingHelmet_3_F {};
			class H_RacingHelmet_2_F {};
			class H_RacingHelmet_1_F {};
		};
		class Facewear {
			
		};
		class Vests {
			
		};
		class Backpacks {
			
		};
	};

	class Diving {
		storeName = "Go-Kart Clothing Store";
		class Uniforms {
			
		};
		class Headgear {
			class H_Bandanna_surfer {};
			class H_Bandanna_surfer_blk {};
			class H_Bandanna_surfer_grn {};
			class H_Cap_surfer {};
		};
		class Facewear {
			class G_B_Diving {};
			class G_O_Diving {};
			class G_I_Diving {};
		};
		class Vests {
			class V_RebreatherB {};
			class V_RebreatherIR {};
			class V_RebreatherIA {};
		};
		class Backpacks {
			class B_ViperLightHarness_blk_F {};
			class B_ViperHarness_blk_F {};
		};
	};

	class Press {
		storeName = "Go-Kart Clothing Store";
		class Uniforms {
			
		};
		class Headgear {
			class H_Cap_press {};
			class H_PASGT_basic_blue_press_F {};
			class H_PASGT_neckprot_blue_press_F {};
		};
		class Facewear {
			class G_WirelessEarpiece_F {};
			class G_Aviator {};
			class G_Squares {};
			class G_Squares_Tinted {};
			class G_Spectacles {};
			class G_Spectacles_Tinted {};
			class G_Shades_Black {};
			class G_Shades_Red {};
			class G_Squares_Green {};
			class G_Squares_Blue {};
			class G_Sport_Red {};
			class G_Shades_BlackWhite {};
			class G_Shades_Blackred {};
			class G_Shades_Blackyellow {};
			class G_Shades_Greenblack {};
			class G_Shades_checkered {};
			class G_Lady_Blue {};
			class G_Tactical_Clear {};
			class G_EyeProtectors_F {};
			class G_EyeProtectors_Earpiece_F {};
			class G_Respirator_white_F {};
			class G_Respirator_blue_F {};
			class G_Respirator_yellow_F {};
		};
		class Vests {
			class V_Press_F {};
		};
		class Backpacks {
			class B_Messenger_Black_F {};
			class B_Messenger_Gray_F {};
			class B_Messenger_Coyote_F {};
			class B_Messenger_Olive_F {};
		};
	};

	class Syndikat {
		storeName = "Syndikat Clothing Store";
		class Uniforms {
			
		};
		class Headgear {
			class H_WirelessEarpiece_F {};
			class H_Bandanna_gry {};
			class H_Bandanna_blu {};
			class H_Bandanna_khk {};
			class H_Bandanna_cbr {};
			class H_Bandanna_sand {};
			class H_Bandanna_sgg {};
			class H_Bandanna_camo {};
			class H_Bandanna_mcamo {};
			class H_Cap_blk {};
			class H_Cap_usblack {};
			class H_Cap_tan_specops_US {};
			class H_Cap_khaki_specops_UK {};
			class H_Cap_brn_SPECOPS {};
			class H_Cap_blk_Raven {};
			class H_Cap_grn_BI {};
			class H_Cap_blk_ION {};
			class H_Cap_blk_CMMG {};
			class H_Cap_red {};
			class H_Cap_blu {};
			class H_Cap_tan {};
			class H_Cap_oli {};
			class H_Watchcap_blk {};
			class H_Watchcap_cbr {};
			class H_Watchcap_khk {};
			class H_Watchcap_camo {};
			class H_Booniehat_khk {};
			class H_Booniehat_khk_hs {};
			class H_Booniehat_grn {};
			class H_Booniehat_oli {};
			class H_Booniehat_tan {};
			class H_Booniehat_mcamo {};
			class H_Booniehat_dgtl {};
			class H_Booniehat_wdl {};
			class H_ShemagOpen_khk {};
			class H_Shemag_tan {};
			class H_Shemag_olive {};
			class H_HelmetB_light {};
			class H_HelmetB_light_black {};
			class H_HelmetB_light_desert {};
			class H_HelmetB_light_sand {};
			class H_HelmetB_light_snakeskin {};
			class H_HelmetB_light_grass {};
			class H_HelmetB_light_wdl {};
			class H_HelmetB {};
			class H_HelmetB_plain_blk {};
			class H_HelmetB_desert {};
			class H_HelmetB_sand {};
			class H_HelmetB_snakeskin {};
			class H_HelmetB_grass {};
			class H_HelmetB_camo {};
			class H_HelmetB_paint {};
			class H_HelmetB_plain_wdl {};
			class H_HelmetSpecB {};
			class H_HelmetSpecB_blk {};
			class H_HelmetSpecB_paint2 {};
			class H_HelmetSpecB_sand {};
			class H_HelmetSpecB_snakeskin {};
			class H_HelmetSpecB_paint1 {};
		};
		class Facewear {
			class G_WirelessEarpiece_F {};
			class G_Aviator {};
			class G_Squares {};
			class G_Squares_Tinted {};
			class G_Spectacles {};
			class G_Spectacles_Tinted {};
			class G_Shades_Black {};
			class G_Shades_Red {};
			class G_Squares_Green {};
			class G_Squares_Blue {};
			class G_Sport_Red {};
			class G_Shades_BlackWhite {};
			class G_Shades_Blackred {};
			class G_Shades_Blackyellow {};
			class G_Shades_Greenblack {};
			class G_Shades_checkered {};
			class G_Lowprofile {};
			class G_Combat {};
			class G_Tactical_Clear {};
			class G_RegulatorMask_F {};
			class G_Blindfold_01_black__F {};
			class G_Blindfold_01_white__F {};
			class G_Bandanna_aviator {};
			class G_Bandanna_shades {};
			class G_Bandanna_sport {};
			class G_Bandanna_beast {};
			class G_Bandanna_blk {};
			class G_Bandanna_khk {};
			class G_Bandanna_oli {};
			class G_Balaclava_blk {};
			class G_Balaclava_lowprofile {};
			class G_Balaclava_combat {};
			class G_Balaclava_oli {};
		};
		class Vests {
			class V_LegStrapBag_black_F {};
			class V_LegStrapBag_coyote_F {};
			class V_LegStrapBag_olive_F {};
			class V_Pocketed_black_F {};
			class V_Pocketed_coyote_F {};
			class V_Pocketed_olive_F {};
			class V_Rangemaster_belt {};
			class V_BandollierB_cbr {};
			class V_BandollierB_khk {};
			class V_BandollierB_oli {};
			class V_BandollierB_rgr {};
			class V_HarnessO_brn {};
			class V_HarnessO_gry {};
			class V_HarnessOGL_brn {};
			class V_HarnessOGL_gry {};
			class V_Chestrig_khk {};
			class V_Chestrig_oli {};
			class V_Chestrig_rgr {};
			class V_TacChestrig_cbr_F {};
			class V_TacChestrig_oli_F {};
			class V_TacChestrig_grn_F {};
			class V_TacVest_camo {};
			class V_TacVest_brn {};
			class V_TacVest_khk {};
			class V_TacVest_oli {};
			class V_PlateCarrier1_rgr {};
			class V_PlateCarrier1_rgr_noflag_F {};
			class V_PlateCarrier1_wdl {};
			class V_PlateCarrierL_CTRG {};
			class V_PlateCarrier2_rgr {};
			class V_PlateCarrier2_rgr_noflag_F {};
			class V_PlateCarrier2_wdl {};
			class V_PlateCarrierH_CTRG {};
		};
		class Backpacks {
			class B_LegStrapBag_black_F {};
			class B_LegStrapBag_coyote_F {};
			class B_LegStrapBag_olive_F {};
			class B_Messenger_Black_F {};
			class B_Messenger_Gray_F {};
			class B_Messenger_Coyote_F {};
			class B_Messenger_Olive_F {};
			class B_AssaultPack_blk {};
			class B_AssaultPack_cbr {};
			class B_AssaultPack_khk {};
			class B_AssaultPack_rgr {};
			class B_AssaultPack_sgg {};
			class B_AssaultPack_wdl_F {};
			class B_FieldPack_blk {};
			class B_FieldPack_cbr {};
			class B_FieldPack_khk {};
			class B_FieldPack_oli {};
			class B_FieldPack_green_F {};
			class B_Kitbag_cbr {};
			class B_Kitbag_tan {};
			class B_Kitbag_rgr {};
			class B_Kitbag_sgg {};
			class B_Kitbag_mcamo {};
			class B_TacticalPack_blk {};
			class B_TacticalPack_oli {};
			class B_TacticalPack_rgr {};
			class B_Carryall_cbr {};
			class B_Carryall_khk {};
			class B_Carryall_oli {};
			class B_Carryall_green_F {};
			class B_Carryall_wdl_F {};
			class B_ViperLightHarness_khk_F {};
			class B_ViperLightHarness_oli_F {};
			class B_ViperHarness_khk_F {};
			class B_ViperHarness_oli_F {};
			class B_Bergen_mcamo_F {};
			class B_Bergen_dgtl_F {};
			class B_Bergen_hex_F {};
			class B_Parachute {};
		};
	};
};