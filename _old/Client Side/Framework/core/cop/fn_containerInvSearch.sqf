#include "..\..\script_macros.hpp"
/*
    File: fn_containerInvSearch.sqf
    Author: NiiRoZz
    Inspired : Bryan "Tonic" Boardwine

    Description:
    Searches the container for illegal items.
*/
private ["_container","_containerInfo","_value"];
_container = [_this,0,objNull,[objNull]] call BIS_fnc_param;
if (isNull _container) exitWith {};

_containerInfo = _container getVariable ["Trunk",[]];
if (count _containerInfo isEqualTo 0) exitWith {hint "This container is empty."};

_value = 0;
_illegalValue = 0;
{
    _var = _x select 0;
    _val = _x select 1;
    _isIllegalItem = M_CONFIG(getNumber,"CfgItems",_var,"illegal");
    if (_isIllegalItem isEqualTo 1 ) then {
        _illegalPrice = M_CONFIG(getNumber,"CfgItems",_var,"sellPrice");
        if (!isNull (missionConfigFile >> "CfgItems" >> _var >> "processedItem")) then {
            _illegalItemProcessed = M_CONFIG(getText,"CfgItems",_var,"processedItem");
            _illegalPrice = M_CONFIG(getNumber,"CfgItems",_illegalItemProcessed,"sellPrice");
        };

        _illegalValue = _illegalValue + (round(_val * _illegalPrice / 2));
    };
} forEach (_containerInfo select 0);
_value = _illegalValue;
if (_value > 0) then {
    [0,"A container of house was searched and has £%1 worth of contraband.",true,[[_value] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
    BANK = BANK + _value;
    [1] call SOCK_fnc_updatePartial;
    _container setVariable ["Trunk",[[],0],true];
    [_container] remoteExecCall ["TON_fnc_updateHouseTrunk",2];
} else {
    hint "Nothing illegal has been found in this container.";
};