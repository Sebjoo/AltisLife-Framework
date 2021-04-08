/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\script_macros.hpp"
scopeName "fn_setPrisonTime";

_this params [
	["_target", objNull, [objNull]]
];

if (isNull _target || { !([_target] call ULP_fnc_isRestrained) } || { isDowned(player) } || { isDowned(_target) }) exitWith {};

private _prison = missionConfigFile >> "CfgPrison" >> worldName;
if !(isClass _prison) exitWith { false };

if !([player] call ULP_fnc_canImprison || { [_target] call ULP_fnc_canImprisoned }) exitWith {
	hint "You're unable to send anyone to prison from here...";
};

private _max = getNumber (_prison >> "maxDuraction");

[
	(findDisplay getNumber(configFile >> "RscDisplayMission" >> "idd")), [1, getNumber (_prison >> "maxDuraction")], [_target, _prison, _max],
	{
		_this params [
			["_target", objNull, [objNull]],
			["_prison", configNull, [configNull]],
			["_max", 1, [0]],
			["_display", displayNull, [displayNull]],
			["_duraction", 1, [0]]
		];

		if (_duraction > _max) exitWith {
			hint format ["You can only arrest someone for a max of %1", [_max, "MM:SS"] call BIS_fnc_secondsToString];
		};

		detach _target;
		[_target, _duraction, player] remoteExecCall ["ULP_fnc_imprison", _target];

		hint format["You have arrested %1 for %2", name _target, [_duraction, "MM:SS"] call BIS_fnc_secondsToString];
	}, false, "[_this, ""MM:SS""] call BIS_fnc_secondsToString", false
] call ULP_fnc_selectNumber;