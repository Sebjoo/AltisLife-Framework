#include "..\..\script_macros.hpp"
/*
    File: fn_ticketPay.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Pays the ticket.
*/
if (isNil "life_ticket_val" || isNil "life_ticket_cop") exitWith {};
if (CASH < life_ticket_val) exitWith {
    if (BANK < life_ticket_val) exitWith {
        hint "You don't have enough money in your bank account or on you to pay the ticket";
        [1,"%1 couldn't pay the ticket due to not having enough money.",true,[profileName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
        closeDialog 0;
    };

    hint format [localize "You have paid the ticket of £%1.",[life_ticket_val] call life_fnc_numberText];
    BANK = BANK - life_ticket_val;
    [1] call SOCK_fnc_updatePartial;
    life_ticket_paid = true;

    [0,"%1 paid the ticket of £%2.",true,[profileName,[life_ticket_val] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",west];
    [1,"%1 paid the ticket.",true,[profileName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
    [life_ticket_val,player,life_ticket_cop] remoteExecCall ["life_fnc_ticketPaid",life_ticket_cop];

    if (life_HC_isActive) then {
        [getPlayerUID player] remoteExecCall ["HC_fnc_wantedRemove",HC_Life];
    } else {
        [getPlayerUID player] remoteExecCall ["life_fnc_wantedRemove",RSERV];
    };
    closeDialog 0;
};

CASH = CASH - life_ticket_val;
[0] call SOCK_fnc_updatePartial;
life_ticket_paid = true;

if (life_HC_isActive) then {
    [getPlayerUID player] remoteExecCall ["HC_fnc_wantedRemove",HC_Life];
} else {
    [getPlayerUID player] remoteExecCall ["life_fnc_wantedRemove",RSERV];
};

[0,"%1 paid the ticket of £%2",true,[profileName,[life_ticket_val] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",west];
closeDialog 0;
[1,"%1 paid the ticket.",true,[profileName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
[life_ticket_val,player,life_ticket_cop] remoteExecCall ["life_fnc_ticketPaid",life_ticket_cop];