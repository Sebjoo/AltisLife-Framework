#include "..\..\script_macros.hpp"
/*
    File: fn_vehInvSearch.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Searches the vehicle for illegal items.
*/
private ["_vehicle","_vehicleInfo","_value","_list"];
_vehicle = cursorObject;
_list = ["Air","Ship","LandVehicle"];
if (isNull _vehicle || {!(KINDOF_ARRAY(_vehicle,_list))}) exitWith {};

_vehicleInfo = _vehicle getVariable ["Trunk",[]];
if (count _vehicleInfo isEqualTo 0) exitWith {hint "This vehicle is empty."};

_value = 0;
_illegalValue = 0;
{
    _var = _x select 0;
    _val = _x select 1;
    _isIllegalItem = M_CONFIG(getNumber,"CfgItems",_var,"illegal");
    if (_isIllegalItem isEqualTo 1 ) then{
        _illegalPrice = M_CONFIG(getNumber,"CfgItems",_var,"sellPrice");
        if (!isNull (missionConfigFile >> "CfgItems" >> _var >> "processedItem")) then {
            _illegalItemProcessed = M_CONFIG(getText,"CfgItems",_var,"processedItem");
            _illegalPrice = M_CONFIG(getNumber,"CfgItems",_illegalItemProcessed,"sellPrice");
        };

        _illegalValue = _illegalValue + (round(_val * _illegalPrice / 2));
    };
} forEach (_vehicleInfo select 0);
_value = _illegalValue;
if (_value > 0) then {
    [0,"A vehicle was searched and has £%1 worth of contraband.",true,[[_value] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
    BANK = BANK + _value;
    [1] call SOCK_fnc_updatePartial;
    _vehicle setVariable ["Trunk",[[],0],true];
} else {
    hint "Nothing illegal has been found in this this vehicle.";
};