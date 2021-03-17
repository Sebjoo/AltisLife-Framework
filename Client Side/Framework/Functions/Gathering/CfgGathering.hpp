class CfgGathering {
	class BaseGather {
		actionTitle = "Gathering";
		gatherTime = 4;
		factions[] = { "Civilian", "Police", "Medic", "Hato" };
		reqItems[] = {};
		reqLicenses[] = {};
		profession[] = { "Gathering", 1, 100 };
		leveling[] = { 1, "Gathering", 100 }; // Amount, Reason, Chance of increasing xp...
	};

	class BaseMine : BaseGather {
		actionTitle = "Mining";
		profession[] = { "Mining", 1, 100 };
	};

	class Apple : BaseGather {
		areas[] = { { "apple_field_1", 20 }, { "apple_field_2", 20 }, { "apple_field_3", 20 }, { "apple_field_4", 20 } };
		items[] = { { "Apple", 100 } };
	};

	class Peach : BaseGather {
		areas[] = { { "peach_field_1", 20 }, { "peach_field_2", 20 }, { "peach_field_3", 20 }, { "peach_field_4", 20 } };
		items[] = { { "FreshPeach", 100 } };
	};

	class Corn : BaseGather {
		areas[] = { { "corn_field", 20 } };
		items[] = { { "Corn", 100 } };
	};

	class Tobacco : BaseGather {
		areas[] = { { "tobacco_field", 20 } };
		items[] = { { "Tobacco", 100 } };
	};

	class Weed : BaseGather {
		areas[] = { { "weed_field", 20 } };
		items[] = { { "UnprocessedWeed", 100 } };
	};

	class Heroin : BaseGather {
		areas[] = { { "heroin_field", 20 } };
		items[] = { { "UnprocessedHeroin", 100 } };
	};

	class Cocaine : BaseGather {
		areas[] = { { "cocaine_field", 20 } };
		items[] = { { "UnprocessedCocaine", 100 } };
	};

	class Copper : BaseMine {
		areas[] = { { "copper_mine", 20 } };
		items[] = { { "CopperOre", 100 } };
	};

	class Silver : BaseMine {
		areas[] = { { "silver_mine", 20 } };
		items[] = { { "SilverOre", 100 } };
	};

	class Iron : BaseMine {
		areas[] = { { "iron_mine", 20 } };
		items[] = { { "IronOre", 100 } };
	};

	class Sand : BaseMine {
		areas[] = { { "sand_mine", 20 } };
		items[] = { { "Sand", 100 } };
	};

	class Salt : BaseMine {
		areas[] = { { "salt_mine", 20 } };
		items[] = { { "UnrefinedSalt", 100 } };
	};

	class Diamond : BaseMine {
		areas[] = { { "diamond_mine", 20 } };
		items[] = { { "UncutDiamond", 100 } };
	};

	class Uranium : BaseMine {
		areas[] = { { "uranium_mine", 20 } };
		items[] = { { "UraniumOre", 100 } };
	};
};