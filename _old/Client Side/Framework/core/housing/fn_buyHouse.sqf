#include "..\..\script_macros.hpp"
/*
    File: fn_buyHouse.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Buys the house?
*/
private ["_house","_uid","_action","_houseCfg"];
_house = param [0,objNull,[objNull]];
_uid = getPlayerUID player;

if (isNull _house) exitWith {};
if (!(_house isKindOf "House_F")) exitWith {};
if (_house getVariable ["house_owned",false]) exitWith {hint "This house is already owned even though you shouldn't be seeing this hint...";};
if (!isNil {(_house getVariable "house_sold")}) exitWith {hint "This house was recently sold and is still processing on the market..."};
if (!license_civ_home) exitWith {hint "You do not have a homeowner's approval!"};
if (count life_houses >= (LIFE_SETTINGS(getNumber,"house_limit"))) exitWith {hint format ["You can only own %1 houses at a time.",LIFE_SETTINGS(getNumber,"house_limit")]};
closeDialog 0;

_houseCfg = [(typeOf _house)] call life_fnc_houseConfig;
if (count _houseCfg isEqualTo 0) exitWith {};

_action = [
    format ["This house is available for &lt;t color='#8cff9b'&gt;£%1&lt;/t&gt;&lt;br/&gt;It supports up to %2 storage containers",
    [(_houseCfg select 0)] call life_fnc_numberText,
    (_houseCfg select 1)],"Purchase House","Buy","Cancel"
] call BIS_fnc_guiMessage;

if (_action) then {
    if (BANK < (_houseCfg select 0)) exitWith {hint format ["You do not have enough money!"]};
    BANK = BANK - (_houseCfg select 0);
    [1] call SOCK_fnc_updatePartial;

    if (life_HC_isActive) then {
        [_uid,_house] remoteExec ["HC_fnc_addHouse",HC_Life];
    } else {
        [_uid,_house] remoteExec ["TON_fnc_addHouse",RSERV];
    };

    if (LIFE_SETTINGS(getNumber,"player_advancedLog") isEqualTo 1) then {
        if (LIFE_SETTINGS(getNumber,"battlEye_friendlyLogging") isEqualTo 1) then {
            advanced_log = format ["bought a house for £%1. Bank Balance: £%2  On Hand Cash: £%3",[(_houseCfg select 0)] call life_fnc_numberText,[BANK] call life_fnc_numberText,[CASH] call life_fnc_numberText];
        } else {
            advanced_log = format ["%1 - %2 bought a house for £%3. Bank Balance: £%4  On Hand Cash: £%5",profileName,(getPlayerUID player),[(_houseCfg select 0)] call life_fnc_numberText,[BANK] call life_fnc_numberText,[CASH] call life_fnc_numberText];
        };
        publicVariableServer "advanced_log";
    };

    _house setVariable ["house_owner",[_uid,profileName],true];
    _house setVariable ["locked",true,true];
    _house setVariable ["containers",[],true];
    _house setVariable ["uid",floor(random 99999),true];

    life_vehicles pushBack _house;
    life_houses pushBack [str(getPosATL _house),[]];
    _marker = createMarkerLocal [format ["house_%1",(_house getVariable "uid")],getPosATL _house];
    _houseName = FETCH_CONFIG2(getText,"CfgVehicles",(typeOf _house), "displayName");
    _marker setMarkerTextLocal _houseName;
    _marker setMarkerColorLocal "ColorBlue";
    _marker setMarkerTypeLocal "loc_Lighthouse";
    _numOfDoors = FETCH_CONFIG2(getNumber,"CfgVehicles",(typeOf _house),"numberOfDoors");
    for "_i" from 1 to _numOfDoors do {
        _house setVariable [format ["bis_disabled_Door_%1",_i],1,true];
    };
};