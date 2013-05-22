/* 

  Radio Frequencies - v1
  
  Alters radio frequencies per side, so that both teams have seperate radio channels.
  
 */


if (!isDedicated) then {

  if (isNull player) then {			// JIP check.
  	waitUntil {!isNull player};		
  };
  
	_longRangeChannels  = ["ACRE_PRC148"] call acre_api_fnc_getDefaultChannels;
	_shortRangeChannels = ["ACRE_PRC343"] call acre_api_fnc_getDefaultChannels;
  	
  	// Create array of frequencies for all long-range radios.
	_lrBaseFreq = 30;
	_freq = 0;
	switch (side player) do 
	{ 
	  case west: {{_longRangeChannels set [_forEachIndex,_lrBaseFreq + 0.2]; _lrBaseFreq = _lrBaseFreq + 2;}foreach _longRangeChannels;}; 
	  case east: {{_longRangeChannels set [_forEachIndex,_lrBaseFreq + 0.4]; _lrBaseFreq = _lrBaseFreq + 2;}foreach _longRangeChannels;}; 
	  case resistance: {{_longRangeChannels set [_forEachIndex,_lrBaseFreq + 0.6]; _lrBaseFreq = _lrBaseFreq + 2;}foreach _longRangeChannels;}
	};
	
	// Repeat process, with 343 frequencies this time.
	_srBaseFreq = 2400;
	_freq = 0;
	switch (side player) do 
	{ 
	  case west: {{_shortRangeChannels set [_forEachIndex,_srBaseFreq + 0.2]; _srBaseFreq = _srBaseFreq + 2;}foreach _shortRangeChannels;}; 
	  case east: {{_shortRangeChannels set [_forEachIndex,_srBaseFreq + 0.4]; _srBaseFreq = _srBaseFreq + 2;}foreach _shortRangeChannels;}; 
	  case resistance: {{_shortRangeChannels set [_forEachIndex,_srBaseFreq + 0.6]; _srBaseFreq = _srBaseFreq + 2;}foreach _shortRangeChannels};
	};
	
	// Set the radio defaults.
	_ret = ["ACRE_PRC148", _longRangeChannels ] call acre_api_fnc_setDefaultChannels;
	_ret = ["ACRE_PRC148_UHF", _longRangeChannels ] call acre_api_fnc_setDefaultChannels;
	_ret = ["ACRE_PRC117F", _longRangeChannels ] call acre_api_fnc_setDefaultChannels;	
	_ret = ["ACRE_PRC119", _longRangeChannels ] call acre_api_fnc_setDefaultChannels;
	_ret = ["ACRE_PRC152", _longRangeChannels ] call acre_api_fnc_setDefaultChannels;
	
	_ret = ["ACRE_PRC343", _shortRangeChannels ] call acre_api_fnc_setDefaultChannels;
	
	// Continue onto radio assignation.

 };
