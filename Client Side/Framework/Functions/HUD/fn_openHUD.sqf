/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\script_macros.hpp"
scopeName "fn_openHud";

if ([] call ULP_UI_fnc_isHudShown) exitWith {
	false
};

if (["RscHUD", "PLAIN", 3] call ULP_UI_fnc_createLayer) then {
	private _ui = ["RscHUD"] call ULP_UI_fnc_getLayer;
	if (isNull _ui) exitWith {}; // Shouldn't happen but we'll be safe...

	_ui setVariable ["cash", 0];
	_ui setVariable ["food", 100];
	_ui setVariable ["water", 100];
	_ui setVariable ["health", 100];
	_ui setVariable ["icons", []];

	disableSerialization;

	private _foodText = _ui displayCtrl 503;
	private _waterText = _ui displayCtrl 503;
	private _healthText = _ui displayCtrl 505;

	[[_ui, _foodText, _waterText, _healthText], { _this call ULP_UI_fnc_eachFrameHUD }] call ULP_fnc_addEachFrame;

	true breakOut "fn_openHud";
};

false