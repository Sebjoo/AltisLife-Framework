/*
    File: fn_civMarkers.sqf
    Author:

    Description:
    Add markers for civilians in groups.
*/
#include "..\..\script_macros.hpp"
private ["_markers","_members"];
_markers = [];
_members = [];

for "_i" from 0 to 1 step 0 do {
    sleep 0.5;
    if (visibleMap) then
    {
        _members = units (group player);
        {
            _marker = createMarkerLocal [format ["%1_marker",_x],visiblePosition _x];
            _marker setMarkerColorLocal "ColorCivilian";
            _marker setMarkerTypeLocal "Mil_dot";
            _marker setMarkerTextLocal format ["%1", _x getVariable ["realname",name _x]];
            _markers pushBack [_marker,_x];
        } forEach _members;

        while {visibleMap} do
        {
            {
                private ["_unit"];
                _unit = _x select 1;
                if (!isNil "_unit" && { !isNull _unit }) then {
                    if ([player, "gps"] call FF(hasItem)) then {
                        (_x select 0) setMarkerAlphaLocal 1;
                        (_x select 0) setMarkerPosLocal (visiblePosition _unit);
                    } else {
                        (_x select 0) setMarkerAlphaLocal 0;
                    };
                };
            } forEach _markers;
            if (!visibleMap) exitWith {};
            sleep 0.02;
        };

        {deleteMarkerLocal (_x select 0);} forEach _markers;
        _markers = [];
        _members = [];
    };
};