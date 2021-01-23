/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\..\script_macros.hpp"
scopeName "fn_onIncapacitated";

_this params [
	["_unit", objNull, [objNull]],
	["_killer", objNull, [objNull]]
];

if (isNull _unit || { !(isPlayer _unit) } || { !(_unit isEqualTo player) } || { isDowned(_unit) }) exitWith {};

if !(isNull objectParent _unit) then { moveOut _unit }; // Move them out of any vehicles they may be in...

_unit switchmove "";
_unit setUnconscious true;

setKiller(_unit, _killer);
setDowned(_unit);

private _deathMessage = format["<t align='center' size='2'>You killed yourself</t>"];

// Notify the server...
if (!isNull _killer && { isPlayer _killer } && { !(_killer isEqualTo _unit) }) then {
	_deathMessage = format["<t align='center' size='2'>%1 seriously injured you</t>", name _killer];

	[0, format ["%1 was seriously injured by %2", 
		_unit getVariable ["realname", name _unit], 
		_killer getVariable ["realname", name _killer]
	]] remoteExecCall ["life_fnc_broadcast", RCLIENT];
} else {
	[0, format ["%1 was seriously injured", 
		_unit getVariable ["realname", name _unit]
	]] remoteExecCall ["life_fnc_broadcast", RCLIENT];
};

[] call ULP_fnc_onUnrestrained;

[] spawn ULP_fnc_closeDialogs; // Makes sure all dialogs are closed...

// Create Incapaciated screen effect...
private _effectBlur = ppEffectCreate ["DynamicBlur", 300];
_effectBlur ppEffectEnable true;
_effectBlur ppEffectAdjust [2.5];
_effectBlur ppEffectCommit 3;

private _effectColour = ppEffectCreate ["colorCorrections", 301];
_effectColour ppEffectEnable true;
_effectColour ppEffectAdjust [1, 1, 0, [0, 0, 0, 0.7], [1, 0, 0, 0.5],[1, 1, 1, 0]]; 
_effectColour ppEffectCommit 3;

private _effectId = [[_effectBlur, {}], [_effectColour, {}]] call ULP_fnc_createEffect;
if (_effectId isEqualType 0) then { uiNamespace setVariable ["IncapacitatedEffect", _effectId] };

if (["RscIncapacitated", "PLAIN", 3] call ULP_UI_fnc_createLayer) then {
	private _incapUi = ["RscIncapacitated"] call ULP_UI_fnc_getLayer;
	if (isNull _incapUi) exitWith {}; // Shouldn't happen but we'll be safe...

	(_incapUi displayCtrl 9001) ctrlSetStructuredText parseText _deathMessage;

	ULP_CanRespawn = false;

	private _startTime = time;
	private _respawnTime = getNumber(missionConfigFile >> "CfgMedical" >> "WaitForBleedOutTime");
	private _endTime = time + _respawnTime + getNumber(missionConfigFile >> "CfgMedical" >> "BleedOutTime");

	if !(isNil { uiNamespace getVariable "_fnc_bleedout" }) then { terminate (uiNamespace getVariable "_fnc_bleedout") };

	// I continue to use the _unit, _incapUi vars, etc to keep consistency throughout the script.
	private _bleedout = [_incapUi, _unit, _startTime, _respawnTime, _endTime] spawn {
		_this params [
			["_incapUi", displayNull, [displayNull]],
			["_unit", objNull, [objNull]],
			"_startTime", "_respawnTime", "_endTime" // Time vars...
		];

		if (isNull _unit || { isNull _incapUi }) exitWith {};

		private _rspMsg = "Waiting to respawn...";

		// Bleedout Loop...
		for "_i" from 0 to 1 step 0 do {
			if (!alive _unit || !(isDowned(_unit))) exitWith {};

			if (time >= _endTime) exitWith { _unit setDamage 1 }; // My time has come...

			if (time >= (_startTime + _respawnTime) && { !ULP_CanRespawn }) then {
				ULP_CanRespawn = true;
				_rspMsg = "Press <t color = '#7300e6'>Shift + F</t> to respawn...";
			};

			(_incapUi displayCtrl 9002) ctrlSetStructuredText parseText format [
				"<t align='left' size='1'>%1</t><t align='right' size='1'>Nearest Medic: 0m</t>",
				_rspMsg
			];

			(_incapUi displayCtrl 9004) progressSetPosition ((time - _startTime) / (_endTime - _startTime));
		};

		uiNamespace setVariable ["_fnc_bleedout", nil];
	};

	uiNamespace setVariable ["_fnc_bleedout", _bleedout];
};