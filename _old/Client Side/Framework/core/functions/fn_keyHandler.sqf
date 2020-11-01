#include "..\..\script_macros.hpp"
/*
*    File: fn_keyHandler.sqf
*    Author: Bryan "Tonic" Boardwine
*
*    Description:
*    Main key handler for event 'keyDown'.
*/
scopeName "InputHandle";
params [
    "_ctrl",
    "_code",
    "_shift",
    "_ctrlKey",
    "_alt"
];

private _speed = speed cursorObject;
private _handled = false;
private _interactionKey = if (actionKeys "User10" isEqualTo []) then {219} else {(actionKeys "User10") select 0};
private _interruptionKeys = [17, 30, 31, 32]; //A,S,W,D

//Vault handling...
if ((_code in (actionKeys "GetOver") || _code in (actionKeys "salute") || _code in (actionKeys "SitDown") || _code in (actionKeys "Throw") || _code in (actionKeys "GetIn") || _code in (actionKeys "GetOut") || _code in (actionKeys "Fire") || _code in (actionKeys "ReloadMagazine") || _code in [16,18]) && ((player getVariable ["restrained",false]) || (player getVariable ["playerSurrender",false]) || life_isknocked || life_istazed)) exitWith {
    true;
};

// We're incapacitated... Block keys...
if (isDowned(player)) then {
    switch true do {
        case (_code isEqualTo 1): { true breakOut "InputHandle" }; // Block Escape Key...
        case (_code isEqualTo 57 && { FF_canRespawn }): { player setDamage 1; true breakOut "InputHandle" }; // Rebind Space Key to Respawn...
        case (_code in (actionKeys "personView")): { true breakOut "InputHandle" }; // Block Third Person...
    };
};

if (life_action_inUse) exitWith {
    if (!life_interrupted && _code in _interruptionKeys) then {life_interrupted = true};
    _handled;
};

//Hotfix for Interaction key not being able to be bound on some operation systems.
if (!(actionKeys "User10" isEqualTo []) && {(inputAction "User10" > 0)}) exitWith {
    //Interaction key (default is Left Windows, can be mapped via Controls -> Custom -> User Action 10)
    if (!life_action_inUse) then {
        [] spawn {
            private _handle = [] spawn life_fnc_actionKeyHandler;
            waitUntil {scriptDone _handle};
            life_action_inUse = false;
        };
    };
    true;
};

if (life_container_active) exitwith {
    //ignore movement actions
    private _allowedMoves = [
        "MoveForward",
        "MoveBack",
        "TurnLeft",
        "TurnRight",
        "MoveFastForward",
        "MoveSlowForward",
        "turbo",
        "TurboToggle",
        "MoveLeft",
        "MoveRight",
        "WalkRunTemp",
        "WalkRunToggle",
        "AdjustUp",
        "AdjustDown",
        "AdjustLeft",
        "AdjustRight",
        "Stand",
        "Crouch",
        "Prone",
        "MoveUp",
        "MoveDown",
        "LeanLeft",
        "LeanLeftToggle",
        "LeanRight",
        "LeanRightToggle"
    ];
    if (({_code in (actionKeys _x)} count _allowedMoves) > 0) exitwith {
        false;
    };
    //handle other keys
    if (_code isEqualTo 57) then {//space key -> place
        life_storagePlacing = 0 spawn life_fnc_placestorage;
    } else { //other keys -> abort
        if (!isNull life_storagePlacing) exitWith {}; //already placing down a box
        if (!isNull life_container_activeObj) then {
            deleteVehicle life_container_activeObj;
            titleText ["Placement of container has been cancelled.", "PLAIN"];
        };
        life_container_active = false;
    };
    true;
};

if (_code in (actionKeys "GetOver")) then {
    if (isNil "jumpActionTime") then {jumpActionTime = 0;};
    if (_shift && {!(animationState player isEqualTo "AovrPercMrunSrasWrflDf")} && {isTouchingGround player} && {stance player isEqualTo "STAND"} && {speed player > 2} && {!life_is_arrested} && {((velocity player) select 2) < 2.5} && {time - jumpActionTime > 1.5}) then {
        jumpActionTime = time; //Update the time.
        [player] remoteExec ["life_fnc_jumpFnc",RANY]; //Global execution
        _handled = true;
    };
};

switch (_code) do {
    // -- Disable commander/tactical view
    if (LIFE_SETTINGS(getNumber,"disableCommanderView") isEqualTo 1) then {
        private _CommandMode = actionKeys "tacticalView";

        if (_code in _CommandMode) then {
            _handled = true;
        };
    };

    case 3:
	{
		if(vehicle player isEqualTo player) then {
			if(!life_action_inUse) then {
				player playActionNow "gestureHi";
			};
		};
	};

	case 4:
	{
		if(vehicle player isEqualTo player) then {
			if(!life_action_inUse) then {
				player playActionNow "gestureHiC";
			};
		};
	};

	case 5:
	{
		if(vehicle player isEqualTo player) then {
			if(!life_action_inUse) then {
				player playActionNow "gestureHiB";
			};
		};
	};

	case 6:
	{
		if(vehicle player isEqualTo player) then {
			if(!life_action_inUse) then {
				player playActionNow "gesturenod";
			};
		};
	};

    //Surrender (Shift + B)
    case 48: {
        if (isDowned(player)) exitWith {};

        if (_shift) then {
            if (player getVariable ["playerSurrender",false]) then {
                player setVariable ["playerSurrender",false,true];
            } else {
                [] spawn life_fnc_surrender;
            };
            _handled = true;
        } else {
            // Seatbelt...
            if ( !(isNull objectParent player) && ((vehicle player) isKindOf "Car")) then {

                FF_seatbelt = !FF_seatbelt;
                player setVariable ["seatbelt", FF_seatbelt, true];

                [] call FF(hudUpdate);
                _handled = true;
            };
        };
    };

    //Holster / recall weapon. (Shift + H)
    case 35: {
        if (isDowned(player)) exitWith {};

        if (_shift && !_ctrlKey && !(currentWeapon player isEqualTo "")) then {
            life_curWep_h = currentWeapon player;
            player action ["SwitchWeapon", player, player, 100];
            player switchCamera cameraView;
        };

        if (!_shift && _ctrlKey && !isNil "life_curWep_h" && {!(life_curWep_h isEqualTo "")}) then {
            if (life_curWep_h in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
                player selectWeapon life_curWep_h;
            };
        };
    };

    //Interaction key (default is Left Windows, can be mapped via Controls -> Custom -> User Action 10)
    case _interactionKey: {
        if (!life_action_inUse) then {
            [] spawn  {
                private _handle = [] spawn life_fnc_actionKeyHandler;
                waitUntil {scriptDone _handle};
                life_action_inUse = false;
            };
        };
    };

    // Fullscreen Nightvision...
    case ((actionKeys "NightVision") select 0): {
        if (cameraView isEqualTo "GUNNER" || { !((goggles player) in (LIFE_SETTINGS(getArray,"fullnightvision"))) } ) exitWith {};

        switch (currentVisionMode player) do {
            case 0: { player action ["nvGoggles", player] };
            case 1: { player action ["nvGogglesOff", player] };
        };

        _handled = true;
    };

    //Restraining (Shift + R)
    case 19: {
        if (isDowned(player)) exitWith {};

        if (_shift) then {_handled = true};
        if (_shift && {(playerSide isEqualTo west) || admin_duty} && {!isNull cursorObject} && {cursorObject isKindOf "CAManBase"} && {(isPlayer cursorObject)} && {alive cursorObject} && { !(isDowned(cursorObject)) } && {cursorObject distance player < 3.5} && {!(cursorObject getVariable "Escorting")} && {!(cursorObject getVariable "restrained")} && {speed cursorObject < 1}) then {
            [] call life_fnc_restrainAction;
        };
    };

    //Knock out, this is experimental and yeah... (Shift + G)
    case 34: {
        if (isDowned(player)) exitWith {};

        if (_shift) then {_handled = true};
        if (_shift && !isNull cursorObject && cursorObject isKindOf "CAManBase" && isPlayer cursorObject && alive cursorObject && !(isDowned(cursorObject)) && cursorObject distance player < 4 && speed cursorObject < 1) then {
            if ((animationState cursorObject) != "Incapacitated" && (currentWeapon player == primaryWeapon player || currentWeapon player == handgunWeapon player) && currentWeapon player != "" && !life_knockout && !(player getVariable ["restrained",false]) && !life_istazed && !life_isknocked) then {
                [cursorObject] spawn life_fnc_knockoutAction;
            };
        };
    };

    //T Key (Trunk)
    case 20: {
        if (!_alt && {!_ctrlKey} && {!dialog} && {!life_action_inUse} && {!(player getVariable ["playerSurrender",false])} && {!(player getVariable ["restrained",false])} && {!life_isknocked} && {!life_istazed}) then {
            if (isDowned(player)) exitWith {};
            
            if (!(isNull objectParent player) && alive vehicle player) then {
                if ((vehicle player) in life_vehicles) then {
                    [vehicle player] spawn life_fnc_openInventory;
                };
            } else {
                private "_list";
                _list = ((ASLtoATL (getPosASL player)) nearEntities [["Box_IND_Grenades_F","B_supplyCrate_F"], 2.5]) select 0;
                if (!(isNil "_list")) then {
                    _house = nearestObject [(ASLtoATL (getPosASL _list)), "House"];
                    if (_house getVariable ["locked", false]) then {
                        hint "You are not allowed to access this storage container without the owner opening it.";
                    } else {
                        [_list] spawn life_fnc_openInventory;
                    };
                } else {
                    _list = ["landVehicle","Air","Ship"];
                    if (KINDOF_ARRAY(cursorObject,_list) && {player distance cursorObject < 7} && {isNull objectParent player} && {alive cursorObject} && {!life_action_inUse}) then {
                        if (cursorObject in life_vehicles || {locked cursorObject isEqualTo 0}) then {
                            [cursorObject] spawn life_fnc_openInventory;
                        };
                    };
                };
            };
        };
    };

    //L Key?
    case 38: {
        //If cop run checks for turning lights on.
        if (_shift && playerSide in [west,independent]) then {
            if (isDowned(player)) exitWith {};

            if (!(isNull objectParent player) && (typeOf vehicle player) in ["C_Offroad_01_F","B_MRAP_01_F","C_SUV_01_F","C_Hatchback_01_sport_F","B_Heli_Light_01_F","B_Heli_Transport_01_F"]) then {
                if (!isNil {vehicle player getVariable "lights"}) then {
                    if (playerSide isEqualTo west) then {
                        [vehicle player] call life_fnc_sirenLights;
                    } else {
                        [vehicle player] call life_fnc_medicSirenLights;
                    };
                    _handled = true;
                };
            };
        };

        if (!_alt && !_ctrlKey) then { [] call life_fnc_radar; };
    };

    case 21: { if (!_alt && !_ctrlKey && !(isDowned(player))) then { [] call FF(openMenu) }; }; // Y Player Menu

    //F Key
    case 33: {
        if (playerSide in [west,independent] && {vehicle player != player} && {!life_siren_active} && {((driver vehicle player) == player)}) then {
            if (isDowned(player)) exitWith {};

            [] spawn {
                life_siren_active = true;
                sleep 4.7;
                life_siren_active = false;
            };

            private _veh = vehicle player;
            if (isNil {_veh getVariable "siren"}) then {_veh setVariable ["siren",false,true];};
            if ((_veh getVariable "siren")) then {
                titleText ["Your sirens are now off","PLAIN"];
                _veh setVariable ["siren",false,true];
                if !(isNil {(_veh getVariable "sirenJIP")}) then {
                    private _jip = _veh getVariable "sirenJIP";
                    _veh setVariable ["sirenJIP",nil,true];
                    remoteExec ["",_jip]; //remove from JIP queue
                };
            } else {
                titleText ["Your sirens are now on","PLAIN"];
                _veh setVariable ["siren",true,true];
                private "_jip";
                if (playerSide isEqualTo west) then {
                    _jip = [_veh] remoteExec ["life_fnc_copSiren",RCLIENT,true];
                } else {
                    _jip = [_veh] remoteExec ["life_fnc_medicSiren",RCLIENT,true];
                };
                _veh setVariable ["sirenJIP",_jip,true];
            };
        };
    };

    //O Key
    case 24: {
        if (_shift) then {
            if(!([false,"earPlugs",1] call life_fnc_handleInv)) exitWith { hint "You require ear plugs if you wish to do this!" };
            if(([false,"earPlugs",1] call life_fnc_handleInv)) then {
                if !(soundVolume isEqualTo 1) then {
                1 fadeSound 1;
                systemChat "You remove your earplugs!";
                } else {
                    1 fadeSound 0.1;
                    systemChat "You put your earplugs in!";
                };
                [true,"earPlugs",1] call life_fnc_handleInv; 
            }
        };
    };

    //Shift + 0 - On/Off Duty
    case 11: {
        if(_shift) then {
            [] spawn life_fnc_staffDuty;
        };
    };

    //U Key
    case 22: {
        if (!_alt && !_ctrlKey) then {
            if (isDowned(player)) exitWith {};
            private _veh = if (isNull objectParent player) then {
                cursorObject;
            } else {
                vehicle player;
            };

            if (_veh isKindOf "House_F" && {playerSide isEqualTo civilian}) then {
                if (_veh in life_vehicles && {player distance _veh < 20}) then {
                    private _door = [_veh] call life_fnc_nearestDoor;
                    if (_door isEqualTo 0) exitWith {hint "You are not near a door!"};
                    private _locked = _veh getVariable [format ["bis_disabled_Door_%1",_door],0];

                    if (_locked isEqualTo 0) then {
                        _veh setVariable [format ["bis_disabled_Door_%1",_door],1,true];
                        _veh animateSource [format ["Door_%1_source", _door], 0];
                        systemChat "You have locked the door.";
                    } else {
                        _veh setVariable [format ["bis_disabled_Door_%1",_door],0,true];
                        _veh animateSource [format ["Door_%1_source", _door], 1];
                        systemChat "You have unlocked the door.";
                    };
                };
            } else {
                private _locked = locked _veh;
                if (_veh in life_vehicles && {player distance _veh < 20}) then {
                    if (_locked isEqualTo 2) then {
                        if (local _veh) then {
                            _veh lock 0;
                        } else {
                            [_veh,0] remoteExecCall ["life_fnc_lockVehicle",_veh];
                        };
                        systemChat "You have unlocked the vehicle.";
                        [_veh,"unlockCarSound",50,1] remoteExec ["life_fnc_say3D",RANY];
                    } else {
                        if (local _veh) then {
                            _veh lock 2;
                        } else {
                            [_veh,2] remoteExecCall ["life_fnc_lockVehicle",_veh];
                        };
                        systemChat "You have locked the vehicle.";
                        [_veh,"lockCarSound",50,1] remoteExec ["life_fnc_say3D",RANY];
                    };

                    // Update Locked / Unlocked HUD Icons...
                    [] RemoteExecCall ["FF_fnc_hudUpdate", (crew _veh)];
                };
            };
        };
    };

    // Repair Object - Instert
    case 210: {
        if (admin_duty && {!isNull cursorObject} && {cursorObject distance player < 10}) then {
            cursorTarget setDamage 0;
        };
    };

    // Delete Vehicle - Delete
    case 211: {
        if (admin_duty && {!isNull cursorObject} && {cursorObject distance player < 10}) then {
            deleteVehicle cursorTarget;
        };
    };
};

_handled;