f_newGroupLeader = [];

f_joinGroup = {

	private ["_grp","_joinDistance"];

	_joinDistance = 10000;

	f_var_JIP_state = 0;
	x = createDialog "GrpPicker";
	waitUntil {f_var_JIP_state == 1};
	_grp = (player getVariable "f_var_JIP_grp");

	[player] joinSilent grpNull;
	nul = [_grp,_joinDistance] execVM "f\common\f_JIP_nearTargetGroupCheck.sqf";
};

f_leadGroup_broadcast = {
	if (local (_this select 0) then {
		player selectLeader (_this select 0); 
	} else {
		f_newGroupLeader = _this;
		if (isServer) then {
			_group = _this select 0;
			_owner = owner _group;
			_owner PublicVariableClient "f_newGroupLeader";
		} else {
			publicVariableServer "f_newGroupLeader";
		};
	};
};

if (isServer) then {
	"f_newGroupLeader" addPublicVariableEventHandler {
		_group = f_newGroupLeader select 0;
		_owner = owner _group;
		_owner PublicVariableClient "f_newGroupLeader";
	};
};

if (!isDedicated) then {
	waitUntil {player == player};

	"f_newGroupLeader" addPublicVariableEventHandler {
		_group = f_newGroupLeader select 0;
		_unit = f_newGroupLeader select 1;
		_group selectLeader _unit;
	};
	
	BIS_MENU_GroupCommunication = [
		["Group Management Menu",false],
		["Pick a new group", [2], "", -5, [["expression", "spawn f_joinGroup"]], "1", "1"]
		["Take lead of your group", [2], "", -5, [["expression", "[group player, player] spawn f_leadGroup_broadcast"]], "1", "1"]
	]; 
};