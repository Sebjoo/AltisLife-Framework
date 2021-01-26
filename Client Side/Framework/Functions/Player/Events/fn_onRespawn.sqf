/*
** Author: Jack "Scarso" Farhall
** Description: 
*/
#include "..\..\..\script_macros.hpp"
scopeName "fn_onRespawn";

_this params [
	["_unit", objNull, [objNull]],
	["_corpse", objNull, [objNull]]
];

// Corpse & Weapon Removal...
if !(isNull _corpse) then {
	{ deleteVehicle _x } forEach (nearestObjects [_corpse, ["WeaponHolderSimulated"], 5]);
	deleteVehicle _corpse;
};

// TODO : Reset Variables, Reset Custom Channels and Actions...

_unit setUnconscious false;
unsetKiller(_unit);
unsetDowned(_unit);

// Handle creation of "new life"...
ULP_Respawned = true;

player playMove "AmovPercMstpSnonWnonDnon";

// TODO : Check if arrested and rearrest if so, if not arrested reset record and reset hud...

[] call ULP_fnc_setLoadout;
[] call ULP_fnc_syncPlayerInfo;