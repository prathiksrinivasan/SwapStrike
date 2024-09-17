///@category Stages
///@param {asset/string} stage		The stage room, name, or index (if the index argument is true)
///@param {int} data_enum			The data to get, from the STAGE_DATA enum
///@param {bool} [index]			If the first argument should be treated as the index of the stage in the <stage_data> array
/*
Returns data from a certain stage's values in the <stage_data> script.
Normally the first argument will be a room index or the stage name, but if you set the "index" argument to true, the first argument will be treated as the index of the stage in the <stage_data> array.
This is useful if you want to loop through every stage, for example.
*/
function stage_data_get()
	{
	var _stage = argument[0];
	var _data = argument[1];
	var _index = argument_count > 2 ? argument[2] : false;
	var _total = stage_count();
	
	//Find the stage with the correct room or name, if the direct index was not given
	if (!_index)
		{
		var _found = false;
		var _stage_data = stage_data_get_all();
		for (var i = 0; i < _total; i++)
			{
			if (is_string(_stage) && _stage_data[@ i][@ STAGE_DATA.name] == _stage)
				{
				_stage = i;
				_found = true;
				break;
				}
			if (is_real(_stage) && _stage_data[@ i][@ STAGE_DATA.room] == _stage)
				{
				_stage = i;
				_found = true;
				break;
				}
			}
		if (!_found)
			{
			crash("[stage_data_get] No stage in stage_data exists with the given name or room: ", room_get_name(_stage), " (", _stage, ")\n",
				"\tIf you got this error, there's a high chance you're not using the LTS branch of GameMaker.\n",
				"\tCheck the PFE website for a tutorial on how to switch to the LTS branch, or revert to a previous version of GameMaker.");
			}
		}
	
	return stage_data_get_all()[@ _stage][@ _data];
	}
/* Copyright 2024 Springroll Games / Yosi */