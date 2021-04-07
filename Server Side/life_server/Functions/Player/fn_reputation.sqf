/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "\life_server\script_macros.hpp"
scopeName "fn_reputation";

_this params [
	["_unit", objNull, [objNull]],
	["_cfg", configNull, [configNull]]
];

if (isNull _unit || { isNull _cfg } || { !(isClass _cfg) }) exitWith { false };

private _rep = _unit getVariable ["reputation", 0];
private _newRep = ((_rep + getNumber (_cfg >> "change")) min getNumber (missionConfigFile >> "CfgReputation" >> "Highest")) max getNumber (missionConfigFile >> "CfgReputation" >> "Lowest");

["ReputationChanged", [getText (_cfg >> "reason"), _rep, _newRep]] remoteExecCall ["ULP_fnc_invokeEvent", _unit];