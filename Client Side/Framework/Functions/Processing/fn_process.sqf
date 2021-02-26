/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\script_macros.hpp"
scopeName "fn_process";

_this params [
	["_process", "", [""]]
];

private _cfg = missionConfigFile >> "CfgProcessing" >> _process;
if !(isClass _cfg || { !([player] call ULP_fnc_getFaction in getArray (_cfg >> "factions")) }) exitWith {};

private _reqItems = getArray (_cfg >> "reqItems");
{
	if ([_x] call ULP_fnc_hasItem isEqualTo -1) exitWith {
		hint format["You need these items to process here: %1...", _reqItems];
		false breakOut "fn_process";
	};

	nil
} count _reqItems;

private _reqLicenses = getArray (_cfg >> "reqItems");
{
	if !([_x] call ULP_fnc_hasLicense) exitWith {
		hint format["You need these licenses to process here: %1...", _reqLicenses];
		false breakOut "fn_process";
	};

	nil
} count _reqLicenses;

private _items = getArray (_cfg >> "items");
private _materials = getArray (_cfg >> "materials");
if (_items isEqualTo [] || { _materials isEqualTo [] }) exitWith { false };

{
    if ([_x select 0] call ULP_fnc_hasItem < _x select 1) exitWith {
        hint format["You are missing the required materials to process here: %1...", _materials];
		false breakOut "fn_process";
    };
} forEach _materials;

[format["%1 Item(s)", getText(_cfg >> "processTitle")], getNumber(_zone >> "processTime"), [getPos player, _items, _materials, _cfg], { (player distance (_this select 0)) <= 5 }, {
	_this params [ "", "_items", "_materials", "_cfg" ];

	private _possibleConversions = [];

	{
        _possibleConversions pushBack (floor (([_x select 0] call ULP_fnc_hasItem) / (_x select 1)));
    } forEach _materials;

    private _conversion = selectMin _possibleConversions;
	if (_conversion <= 0) exitWith {};

	{
		[(_x select 0), (_x select 1) * _conversion, true] call ULP_fnc_handleItem;
	} forEach _materials;

	{
		[(_x select 0), (_x select 1) * _conversion] call ULP_fnc_handleItem;
	} forEach _items;

	hint "You've successfully processed your materials";
}] call ULP_UI_fnc_startProgress;

true