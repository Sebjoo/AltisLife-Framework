/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\script_macros.hpp"
scopeName "fn_onPause";

disableSerialization;

with missionNamespace do {
	private _display = _this select 0;
	private _saveButton = _display displayCtrl 103;
	private _abortButton = _display displayCtrl 104;
	private _fieldButton = _display displayCtrl 122;

	[_saveButton] call ULP_UI_fnc_setSyncButton;

	_fieldButton ctrlEnable false;
	_fieldButton ctrlSetText "https://ascensionroleplay.co.uk/";
	_fieldButton ctrlSetTooltip "";

	private _abortDelay = time + getNumber(missionConfigFile >> "Life_Settings" >> "abort_delay");
	
	_abortButton ctrlEnable false;
	_abortButton ctrlSetEventHandler["ButtonClick", "with missionNamespace do { [] call ULP_fnc_syncPlayerInfo; [""Abort"", true, false] call BIS_fnc_endMission; }; true"];

	[[_abortButton, _abortDelay], {
		_this params ["_abortButton", "_abortDelay"];
		
		if (isNull _abortButton) exitWith { [_thisEventHandler] call ULP_fnc_removeEachFrame; };

		if (time < _abortDelay) then {
			_abortButton ctrlSetText format["ABORT (%1)", [_abortDelay - time, "SS.MS"] call BIS_fnc_secondsToString];
		} else {
			_abortButton ctrlSetText "ABORT";
			_abortButton ctrlEnable true;
            [_thisEventHandler] call GTA_fnc_removeEachFrameHandler;
		};
    }] call ULP_fnc_addEachFrame;
};