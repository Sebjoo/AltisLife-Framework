/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\script_macros.hpp"
scopeName "fn_issueTicket";

_this params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit || { !([_unit] call ULP_fnc_isRestrained) } || { isDowned(player) } || { isDowned(_unit) }) exitWith {};

if !([player, ["Police"]] call ULP_fnc_isFaction) exitWith {
	["You must be a police officer to issue a penalty notice!"] call ULP_fnc_hint;
};

[
	(findDisplay getNumber(configFile >> "RscDisplayMission" >> "idd")), getArray (missionConfigFile >> "CfgSettings" >> "Police" >> "ticketFee"), [_unit],
	{
		_this params [
			["_unit", objNull, [objNull]],
			["_display", displayNull, [displayNull]],
			["_fine", 1, [0]]
		];

		["TicketRecieved", [player, _fine]] remoteExecCall ["ULP_fnc_invokeEvent", _unit];
		["IssuedFine", [[player, true] call ULP_fnc_getName, [_unit, true] call ULP_fnc_getName, format ["%1%2", "£", [_fine] call ULP_fnc_numberText]]] remoteExecCall ["ULP_fnc_chatMessage", RCLIENT];

		[format["You have issued %1 a penalty notice of %2", [_unit, true] call ULP_fnc_getName, format ["%1%2", "£", [_fine] call ULP_fnc_numberText]]] call ULP_fnc_hint;
		["FirstTicket"] call ULP_fnc_achieve;
	}, false, "format [""%1%2"", ""£"", [_this] call ULP_fnc_numberText]", false
] call ULP_fnc_selectNumber;