/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\..\script_macros.hpp"
scopeName "fn_overview";

_display = _this;
if (isNull _display) exitWith {};

private _members = [] call ULP_fnc_groupMembers;

private _listHeader = _display displayCtrl 23063;
private _memberList = _display displayCtrl 23062;
lnbClear _memberList;

if !(_listHeader getVariable ["setup", false]) then {
	[_listHeader, _memberList, [0, 1]] call BIS_fnc_initListNBoxSorting;
	_listHeader getVariable ["setup", true];
};

if (_display getVariable ["funds_changed", -1] < 0) then {
	_display setVariable ["funds_changed", (["GroupMoneyChanged", {
		private _display = findDisplay 23000;
		if (isNull _display) exitWith {
			["GroupMoneyChanged", _x] call ULP_fnc_removeEventHandler;
		};

		private _toolbox = _display displayCtrl 23061;

		if ((lbCurSel _toolbox) isEqualTo 0) then {
			_this params [
				"", "_total"
			];

			(_display displayCtrl 23066) ctrlSetStructuredText parseText format["<t align='left'>%1</t><t align='right'>1.5%</t><br/><t size='0.9'>Balance<t align='right'>Tax</t></t>", 
				([format["%1%2", "£", [_total] call ULP_fnc_numberText], "-"] select (_total <= 0))
			];
		};
	}] call ULP_fnc_addEventHandler)];
};

{
	private _offline = (_forEachIndex isEqualTo 1);

	{
		_y params [
			"_name", "_level"
		];

		private _item = _memberList lnbAddRow [
			_name, 
			[_level] call ULP_fnc_rankName
		];

		_memberList lnbSetData [[_item, 0], _name];
		_memberList lnbSetValue [[_item, 1], _level];

		if (_offline) then {
			_memberList lnbSetColor [[_item, 0], [1, 1, 1, 0.6]];
			_memberList lnbSetColor [[_item, 1], [1, 1, 1, 0.6]];
		};
	} forEach _x;
} forEach _members;

private _total = [] call ULP_fnc_groupFunds;
(_display displayCtrl 23066) ctrlSetStructuredText parseText format["<t align='left'>%1</t><t align='right'>1.5%</t><br/><t size='0.9'>Balance<t align='right'>Tax</t></t>", 
	([format["%1%2", "£", [_total] call ULP_fnc_numberText], "-"] select (_total <= 0))
];