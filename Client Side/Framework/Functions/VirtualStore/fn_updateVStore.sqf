/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\script_macros.hpp"
scopeName "fn_updateVStore";

_this params [
	["_display", displayNull, [displayNull]]
];

if (isNull _display) exitWith {};

private _list = _display displayCtrl 3303;
lnbClear _list;

private _info = _display displayCtrl 3304;

// Privating outside loop...
private _itemClass = "";
private _cfg = configNull;
private _row = -1;
private _itemIcon = "";
private _itemName = "";
private _itemCount = 0;
private _buyPrice = -1;
private _sellPrice = -1;

{
	_itemClass = configName _x;
	_cfg = missionConfigFile >> "CfgVirtualItems" >> _itemClass;

	if (isClass _cfg && { call compile getText(_cfg >> "conditions") }) then {
		_itemIcon = getText (_cfg >> "icon");
		_itemName = getText (_cfg >> "displayName");
		_itemCount = (0 max ([_itemClass] call ULP_fnc_hasItem));
		_buyPrice = getNumber (_cfg >> "buyPrice");
		_sellPrice = getNumber (_cfg >> "sellPrice");

		private _row = _list lnbAddRow [
			_itemName, 
			([format["£%1", [_buyPrice] call life_fnc_numberText], "-"] select (_buyPrice isEqualTo -1)),
			([format["£%1", [_sellPrice] call life_fnc_numberText], "-"] select (_sellPrice isEqualTo -1)), 
			[_itemCount] call life_fnc_numberText
		];

		if !(_itemIcon isEqualTo "") then {
			_list lnbSetPicture [[_row, 0], _itemIcon];
		};

		_list lnbSetData [[_row, 0], _itemClass];
		_list lnbSetValue [[_row, 1], _buyPrice];
		_list lnbSetValue [[_row, 2], _sellPrice];
		_list lnbSetValue [[_row, 3], _itemCount];
	};
} forEach ("isClass _x" configClasses ((_display getVariable "curStore") >> "Items"));

if ((lbSize _list) > 0) then {
	_list lnbSetCurSelRow (_display getVariable ["lastSel", 0]);
} else {
	_list lnbAddRow "No Items...";
	_info ctrlSetStructuredText parseText "";
};