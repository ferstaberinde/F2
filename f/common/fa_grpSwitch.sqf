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
	f_newGroupLeader = _this;
	publicVariable "f_newGroupLeader";
	_group = f_newGroupLeader select 0;
	_unit = f_newGroupLeader select 1;
	_group selectLeader _unit;
};

"f_newGroupLeader" addPublicVariableEventHandler {
		_group = f_newGroupLeader select 0;
		_unit = f_newGroupLeader select 1;
		_group selectLeader _unit;
	};

if (!isDedicated) then {
	waitUntil {player == player};
	
	BIS_MENU_GroupCommunication = [
		["Group Management Menu",false],
		["Pick a new group", [2], "", -5, [["expression", "[] spawn f_joinGroup"]], "1", "1"],
		["Take lead of your group", [2], "", -5, [["expression", "[group player, player] spawn f_leadGroup_broadcast"]], "1", "1"]
	]; 
};
