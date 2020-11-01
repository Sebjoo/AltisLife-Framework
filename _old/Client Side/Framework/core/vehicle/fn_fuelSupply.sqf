#include "..\..\script_macros.hpp"
/*
    File: fn_fuelSupply.sqf
    Author: Ulrich "Zero" Werren

    Description:
    Fuel Tank Job, Fill Gas Station with Fuel.
*/
params [
    ["_vehicle",objNull,[objNull]]
];
if (isNull _vehicle) exitWith {};

closeDialog 0;
if (_vehicle getVariable ["fuelTankWork",false]) exitWith {titleText["Tanker is already in use.","PLAIN"]};
if !(local _vehicle) exitWith {titleText["This can only be done by the last driver of this vehicle.","PLAIN"]};

life_action_inUse = true;

private _vehTank = _vehicle getVariable ["fuelTank",[]];

if (_vehTank isEqualTo []) exitWith {
    _vehicle setVariable ["fuelTank",[(getNumber(missionConfigFile >> "LifeCfgVehicles" >> (typeOf _vehicle) >> "vFuelSpace")),0],true];
    titleText["Tanker is empty.","PLAIN"];
    life_action_inUse = false;
};

_vehTank params [
    ["_fuelSpace",19500,[0]],
    ["_fuelState",0,[0]]
];
if (_fuelState isEqualTo 0) exitWith {
    titleText["Tanker is empty.","PLAIN"];
    life_action_inUse = false;
};

private _trucks = (nearestObjects [_vehicle, ["C_Van_01_fuel_F","I_Truck_02_fuel_F","B_Truck_01_fuel_F"], 100]) findIf {_x getVariable ["fuelTankWork",false]};
if !(_trucks isEqualTo -1) exitWith {titleText["Gas station is in use.","PLAIN"]; life_action_inUse = false};

private _fuelFeedState = 0;
private _random = floor((random 11000) + 1500);
{
    private _stationTank = _x getVariable ["fuelTank",[]];
    if (_stationTank isEqualTo []) then {
        _x setVariable ["fuelTank",[_random,time],true];
        _fuelFeedState = _random;
    } else {
        _stationTank params ["_fuelFeedState","_fuelFeedTime"];
        if (_fuelFeedState isEqualTo 0) then {
            if (time >= _fuelFeedTime) then {
                _x setVariable ["fuelTank",[_random,time],true];
                _fuelFeedState = _random;
            };
        };
    };   
} forEach (nearestObjects [_vehicle, ["Land_FuelStation_Feed_F","Land_fs_feed_F"], 100]);
if (_fuelFeedState isEqualTo 0) exitWith {titleText ["Gas station has enough fuel.","PLAIN"]; life_action_inUse = false;};

private _shortest = 100000;
{
    private _distance = _vehicle distance (getMarkerPos _x);
    if (_distance < _shortest) then {_shortest = _distance};
} forEach ["fuel_storage_1","fuel_storage_2"];
if (_shortest < 1000) exitWith {titleText ["This gas station is supplied through a pipeline.","PLAIN"]; life_action_inUse = false;};

private _pricem = getNumber(missionConfigFile >> "CfgSettings" >> "fuelTank_winMultiplier");
private _price = floor((((floor(_shortest / 100) * 100) / 1337) * _pricem) * 100) / 100;
private _win = 0;

_vehicle setVariable ["fuelTankWork",true,true];
_vehicle remoteExec ["life_fnc_soundDevice",-2];
life_action_inUse = false;

disableSerialization;
"progressBar" cutRsc ["life_progress","PLAIN"];
private _ui = uiNamespace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format ["Tank  %1 Ltr / %2 Ltr",_fuelState,_fuelSpace];
private _fuelLevel = (1 / _fuelSpace) * _fuelState;
_progress progressSetPosition _fuelLevel;

waitUntil {
    if (!alive _vehicle || isNull _vehicle) exitWith {true};
    if (isEngineOn _vehicle) exitWith {titleText["Discontinued operation.","PLAIN"]; true};
    if !(_vehicle getVariable ["fuelTankWork",false]) exitWith {titleText["Discontinued operation.","PLAIN"]; true};
    if (player distance _vehicle > 20) exitWith {titleText["Discontinued operation.","PLAIN"]; true};
    if !(local _vehicle) exitWith {titleText["This can only be done by the last driver of this vehicle.","PLAIN"]; true};

    _fuelState = _fuelState - 100;
    _fuelFeedState = _fuelFeedState - 100;

    _win = _win + (_price * 100);
    _vehicle setVariable ["fuelTank",[_fuelSpace,_fuelState],true];

    _fuelLevel = (1 / _fuelSpace) * _fuelState;
    _progress progressSetPosition _fuelLevel;
    _pgText ctrlSetText format ["Tank  %1 Ltr / %2 Ltr  ( £ %3 / Ltr )",_fuelState,_fuelSpace,_price];

    if (_fuelState isEqualTo 0 || _fuelFeedState <= 0) exitWith {true};

    sleep 1;
    false
};


{
    if (_fuelFeedState <= 0) then {
        _x setVariable ["fuelTank",[0,(time + 1800)],true];
    } else {
        _x setVariable ["fuelTank",[_fuelFeedState,time],true];
    };
} forEach (nearestObjects [_vehicle, ["Land_FuelStation_Feed_F","Land_fs_feed_F"], 100]);

if (_fuelFeedState <= 0) then {titleText ["Gas station has enough fuel.","PLAIN"]};
if (_fuelState <= 0) then {titleText ["Tanker is empty.","PLAIN"]};
sleep 2;

CASH = CASH + _win;
[0] call SOCK_fnc_updatePartial;

titleText [format ["Your share is £%1.", _win], "PLAIN"];
"progressBar" cutText ["","PLAIN"];
_vehicle setVariable ["fuelTankWork",nil,true];