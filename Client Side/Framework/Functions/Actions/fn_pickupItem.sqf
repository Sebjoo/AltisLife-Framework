#include "..\..\script_macros.hpp"
#define INUSE(ENTITY) ENTITY setVariable ["inUse",false,true]
/*
    File: fn_pickupItem.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Master handling for picking up an item.
*/
private ["_itemInfo","_itemName","_illegal","_diff"];
if ((time - life_action_delay) < 2) exitWith {hint "You're doing it too fast!"; INUSE(_this);};
if (isNull _this || {player distance _this > 3}) exitWith {INUSE(_this);};

_itemInfo = _this getVariable ["item",[]]; if (count _itemInfo isEqualTo 0) exitWith {deleteVehicle _this;};
_illegal = ITEM_ILLEGAL(_itemInfo select 0);
_itemName = ITEM_NAME(_itemInfo select 0);
if (isLocalized _itemName) then {
    _itemName = (localize _itemName);
};

if (playerSide isEqualTo west && _illegal isEqualTo 1) exitWith {
    titleText[format ["%1 has been placed in evidence, you have received £%2 as a reward.",_itemName,[round(ITEM_SELLPRICE(_itemInfo select 0) / 2)] call life_fnc_numberText],"PLAIN"];
    BANK = BANK + round(ITEM_SELLPRICE(_itemInfo select 0) / 2);
    deleteVehicle _this;
    [1] call SOCK_fnc_updatePartial;
    life_action_delay = time;
};

life_action_delay = time;
_diff = [(_itemInfo select 0),(_itemInfo select 1),life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if (_diff <= 0) exitWith {hint "Your inventory space is full."; INUSE(_this);};

if (!(_diff isEqualTo (_itemInfo select 1))) then {
    if ([true,(_itemInfo select 0),_diff] call life_fnc_handleInv) then {
        player playMove "AinvPknlMstpSlayWrflDnon";

        _this setVariable ["item",[(_itemInfo select 0),(_itemInfo select 1) - _diff],true];
        titleText[format ["You have picked %1 %2",_diff,_itemName],"PLAIN"];
        INUSE(_this);
    } else {
        INUSE(_this);
    };
} else {
    if ([true,(_itemInfo select 0),(_itemInfo select 1)] call life_fnc_handleInv) then {
        deleteVehicle _this;
        //waitUntil{isNull _this};
        player playMove "AinvPknlMstpSlayWrflDnon";

        titleText[format ["You have picked %1 %2",_diff,_itemName],"PLAIN"];
    } else {
        INUSE(_this);
    };
};

if (LIFE_SETTINGS(getNumber,"player_advancedLog") isEqualTo 1) then {
    if (LIFE_SETTINGS(getNumber,"battlEye_friendlyLogging") isEqualTo 1) then {
        advanced_log = format ["picked up %1 %2",_diff,_itemName];
    } else {
        advanced_log = format ["%1 - %2 picked up %3 %4",profileName,(getPlayerUID player),_diff,_itemName];
    };
    publicVariableServer "advanced_log";
};
