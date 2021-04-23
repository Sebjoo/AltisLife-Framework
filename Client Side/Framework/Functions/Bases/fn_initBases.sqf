/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\script_macros.hpp"
scopeName "fn_initBases";

if ([player, ["Civilian"]] call ULP_fnc_isFaction && { missionNamespace getVariable ["ULP_SRV_BaseBidding", false] }) then {
	["Initialising Base Bidding..."] call ULP_fnc_logIt;

	{
		private _flag = missionNamespace getVariable [format ["ULP_SRV_Base_%1", configName _x], objNull];

		if !(isNull _flag) then {
			_flag addAction [format["Bid on %1", getText (_x >> "displayName")], { (_this select 3) call ULP_fnc_openLicenses }, _flag, 1.25, true, true, "", "true", 3];
		};
	} forEach ("[getNumber (_x >> ""includeBidding"")] call ULP_fnc_bool" configClasses (missionConfigFile >> "CfgBases"));

	["KilledSomeone", {
		_this params [
			["_unit", objNull, [objNull]]
		];

		if (isNull _unit || { !(isPlayer _unit) } || { !(["redzone_"] call ULP_fnc_isUnitsInZone) }) exitWith {};

		private _reward = getNumber (missionConfigFile >> "CfgBases" >> "RedzoneKillReward");

		if ([_reward, false, "Gang Wars Kill"] call ULP_fnc_addMoney) then {
			[format ["You have recieved %1%2 for killing someone in a redzone during gang wars...", "£", [_reward] call ULP_fnc_numberText]] call ULP_fnc_hint;
		};
	}] call ULP_fnc_addEventHandler;
};