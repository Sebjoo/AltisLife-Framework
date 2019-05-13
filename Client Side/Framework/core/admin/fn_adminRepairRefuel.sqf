#include "..\..\script_macros.hpp"
/*
    File: fn_adminResetBank.sqf
    Author: Lewis Mackinnon
*/

if ((FETCH_CONST(life_adminlevel) < 2) && admin_duty) exitWith {closeDialog 0; hint "You must be <t color = '#7300e6'>on-duty</t> to use this."};

private _target = [call compile format ["%1",(lbData[2902,lbCurSel (2902)])],player] select (lbCurSel (2902) isEqualTo -1);
_target = call compile format ["%1", _target];

if (isNil "_target" || isNull _target) exitWith {};
if (_target == player) exitWith {hint "You are unable to do this.";};

vehicle player setfuel 1;
vehicle player setdamage 0;