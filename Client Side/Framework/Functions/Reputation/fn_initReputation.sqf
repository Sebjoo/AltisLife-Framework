/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\script_macros.hpp"
scopeName "fn_initReputation";

["ReputationChanged", {
	_this params [
		["_reason", "", [""]],
		["_oldReputation", 0, [0]],
		["_newReputation", 0, [0]]
	];

	if !(_newReputation isEqualTo _oldReputation) then {
		ULP_Reputation = _newReputation;
	};

	hint format ["Your reputation has %1 from %2 to %3 because you %4", 
		(["decreased", "increased"] select (ULP_Reputation > _oldReputation)), 
		[_oldReputation] call ULP_fnc_numberText,
		[ULP_Reputation] call ULP_fnc_numberText, 
		getText (_cfg >> "reason")
	];
}] call ULP_fnc_addEventHandler;

["Incapacitated", {
	_this params [
		"_unit", "_killer"
	];

	[_killer, missionConfigFile >> "CgReputation" >> "Types" >> (switch (true) do {
		case (ULP_Reputation >= 500): { "IncapHighRep" };
		case (ULP_Reputation > -500): { "IncapNormal" };
		default { "IncapLowRep" };
	})] remoteExecCall ["ULP_SRV_fnc_reputation", RSERV];
}] call ULP_fnc_addEventHandler;