_unit = _this select 1;

waitUntil{!isNil "acre_sys_radio_currentRadioList"};				// Wait until radio list has been initialised.
waitUntil{(count acre_sys_radio_currentRadioList) > 0};				// Wait until radio list is 1 or higher.

{ _isRadio = [_x] call acre_api_fnc_isRadio; 						// Remove ItemRadios that haven't been turned into 343s (just in case).
if(_isRadio) then {_unit removeWeapon _x};
} foreach weapons _unit;	

{_unit removeWeapon _x;} foreach acre_sys_radio_currentRadioList;	// Remove all radios.

waitUntil {count acre_sys_radio_currentRadioList < 1};				// Wait until radio list updated.

_setFreqsHandle = _this execVM "f\common\fa_ACRE_setFrequencies.sqf";

waitUntil{scriptDone _setFreqsHandle};											// Wait until the custom frequencies per side are set before handing out radios.
