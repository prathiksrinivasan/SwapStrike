///@category Spectator Engine Scripts
///@param {int} spectator_number		The spectator to get data from
///@param {int} data					The data to get, from the SPECTATOR_DATA enum
/*
Gets data for the given spectator.
*/
function spectator_data_get()
	{
	var _spectator = engine().spectator_data[argument[0]];
	return _spectator[@ argument[1]];
	}
/* Copyright 2024 Springroll Games / Yosi */