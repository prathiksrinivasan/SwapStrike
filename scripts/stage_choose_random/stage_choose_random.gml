///@category Stages
///@param {array} [banned_stages]		An array of stage names, or room indexes, that cannot be chosen
/*
Chooses a random stage from the list defined in this script.
*/
function stage_choose_random()
	{
	//Create an array of all stages that are not banned
	var _banned = argument_count > 0 ? argument[0] : [];
	var _possible = [];
	var _total = stage_count();
	for (var i = 0; i < _total; i++)
		{
		var _name = stage_data_get(i, STAGE_DATA.name, true);
		var _room = stage_data_get(i, STAGE_DATA.room, true);
		//Check if the stage is banned
		if (!array_contains(_banned, _name) && !array_contains(_banned, _room))
			{
			array_push(_possible, _room);
			}
		}
	assert(array_length(_possible) > 0, "[stage_choose_random] Either there are no stages in stage_data, or every stage has been banned.");
	return _possible[@ irandom(array_length(_possible) - 1)];
	}
/* Copyright 2024 Springroll Games / Yosi */