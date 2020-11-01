/*
    File: fn_queryRequest.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Handles the incoming request and sends an asynchronous query
    request to the database.

    Return:
    ARRAY - If array has 0 elements it should be handled as an error in client-side files.
    STRING - The request had invalid handles or an unknown error and is logged to the RPT.
*/
#include "\ff_server\script_macros.hpp"
params [
    ["_uid", "", [""]],
    ["_side", sideUnknown, [civilian]],
    ["_ownerID", objNull, [objNull]]
];

if (isNull _ownerID) exitWith {};
_ownerID = owner _ownerID;

private _query = switch (_side) do {
    // West - 14 entries returned
    case west: {format ["SELECT pid, name, cash, bankacc, adminlevel, donorlevel, cop_licenses, coplevel, cop_gear, blacklist, cop_stats, playtime, cop_professions, level, xp, cop_perks FROM players WHERE pid='%1'",_uid];};
    // Civilian - 13 entries returned
    case civilian: {format ["SELECT pid, name, cash, bankacc, adminlevel, donorlevel, civ_licenses, arrested, civ_gear, civ_stats, playtime, civ_professions, level, xp, civ_perks, gangid FROM players WHERE pid='%1'",_uid];};
    // Independent - 13 entries returned
    case independent: {format ["SELECT pid, name, cash, bankacc, adminlevel, donorlevel, med_licenses, mediclevel, med_gear, med_stats, playtime, med_professions, level, xp, med_perks FROM players WHERE pid='%1'",_uid];};
};

private _tickTime = diag_tickTime;
private _queryResult = [_query,2] call DB_fnc_asyncCall;

if (EXTDB_SETTING(getNumber,"DebugMode") isEqualTo 1) then {
    diag_log "------------- Client Query Request -------------";
    diag_log format ["QUERY: %1",_query];
    diag_log format ["Time to complete: %1 (in seconds)",(diag_tickTime - _tickTime)];
    diag_log format ["Result: %1",_queryResult];
    diag_log "------------------------------------------------";
};

if (_queryResult isEqualType "") exitWith {
    [] remoteExecCall ["SOCK_fnc_insertPlayerInfo",_ownerID];
};

if (count _queryResult isEqualTo 0) exitWith {
    [] remoteExecCall ["SOCK_fnc_insertPlayerInfo",_ownerID];
};

//Blah conversion thing from a2net->extdb
private _tmp = _queryResult select 2;
_queryResult set[2,[_tmp] call DB_fnc_numberSafe];
_tmp = _queryResult select 3;
_queryResult set[3,[_tmp] call DB_fnc_numberSafe];

//Parse licenses (Always index 6)
_new = [(_queryResult select 6)] call DB_fnc_mresToArray;
if (_new isEqualType "") then {_new = parseSimpleArray _new;};
_queryResult set[6,_new];

//Convert tinyint to boolean
_old = _queryResult select 6;
for "_i" from 0 to (count _old)-1 do {
    _data = _old select _i;
    _old set[_i,[_data select 0, ([_data select 1,1] call DB_fnc_bool)]];
};

_queryResult set[6,_old];

_new = [(_queryResult select 8)] call DB_fnc_mresToArray;
if (_new isEqualType "") then {_new = parseSimpleArray _new;};
_queryResult set[8,_new];
//Parse data for specific side.
switch (_side) do {
    case west: {
        _queryResult set[9,([_queryResult select 9,1] call DB_fnc_bool)];

        //Parse Stats
        _new = [(_queryResult select 10)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _queryResult set[10,_new];

        //Playtime
        _new = [(_queryResult select 11)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _index = TON_fnc_playtime_values_request find [_uid, _new];
        if (_index != -1) then {
            TON_fnc_playtime_values_request set[_index,-1];
            TON_fnc_playtime_values_request = TON_fnc_playtime_values_request - [-1];
            TON_fnc_playtime_values_request pushBack [_uid, _new];
        } else {
            TON_fnc_playtime_values_request pushBack [_uid, _new];
        };
        [_uid,_new select 0] call TON_fnc_setPlayTime;

        // Professions
        _new = [(_queryResult select 12)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _queryResult set[12,_new];

        _queryResult set[13,_queryResult select 13]; // Level
        _queryResult set[14,_queryResult select 14]; // XP

        // Active Perks...
        _new = [(_queryResult select 15)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _queryResult set[15,_new];
    };

    case civilian: {
        _queryResult set[7,([_queryResult select 7,1] call DB_fnc_bool)];

        //Parse Stats
        _new = [(_queryResult select 9)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _queryResult set[9,_new];

        //Playtime
        _new = [(_queryResult select 10)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _index = TON_fnc_playtime_values_request find [_uid, _new];
        if (_index != -1) then {
            TON_fnc_playtime_values_request set[_index,-1];
            TON_fnc_playtime_values_request = TON_fnc_playtime_values_request - [-1];
            TON_fnc_playtime_values_request pushBack [_uid, _new];
        } else {
            TON_fnc_playtime_values_request pushBack [_uid, _new];
        };
        [_uid,_new select 2] call TON_fnc_setPlayTime;

        // Professions
        _new = [(_queryResult select 11)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _queryResult set[11,_new];

        _queryResult set[12,_queryResult select 12]; // Level
        _queryResult set[13,_queryResult select 13]; // XP

        // Active Perks...
        _new = [(_queryResult select 14)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _queryResult set[14,_new];

        /* Make sure nothing else is added under here */
        _houseData = _uid spawn TON_fnc_fetchPlayerHouses;
        waitUntil {scriptDone _houseData};
        _queryResult pushBack (missionNamespace getVariable [format ["houses_%1",_uid],[]]);

        life_gangLoaded = false;
        private _gangData = [parseNumber(_queryResult select 15)] call TON_fnc_queryPlayerGang;
        waitUntil {life_gangLoaded};

        _queryResult pushBack _gangData;
    };

    case independent: {
        //Parse Stats
        _new = [(_queryResult select 9)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _queryResult set[9,_new];

        //Playtime
        _new = [(_queryResult select 10)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _index = TON_fnc_playtime_values_request find [_uid, _new];
        if !(_index isEqualTo -1) then {
            TON_fnc_playtime_values_request set[_index,-1];
            TON_fnc_playtime_values_request = TON_fnc_playtime_values_request - [-1];
            TON_fnc_playtime_values_request pushBack [_uid, _new];
        } else {
            TON_fnc_playtime_values_request pushBack [_uid, _new];
        };
        [_uid,_new select 1] call TON_fnc_setPlayTime;

        // Professions
        _new = [(_queryResult select 11)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _queryResult set[11,_new];

        _queryResult set[12,_queryResult select 12]; // Level
        _queryResult set[13,_queryResult select 13]; // XP

        // Active Perks...
        _new = [(_queryResult select 14)] call DB_fnc_mresToArray;
        if (_new isEqualType "") then {_new = parseSimpleArray _new;};
        _queryResult set[14,_new];
    };
};

publicVariable "TON_fnc_playtime_values_request";

_keyArr = missionNamespace getVariable [format ["%1_KEYS_%2",_uid,_side],[]];
_queryResult pushBack _keyArr;

_queryResult remoteExec ["SOCK_fnc_requestReceived",_ownerID];