///@category Gameplay
///@param {int} id_map				The index of the original id map
///@param {int} new_id_map			The index of the new id map
/*
Prints a list of all id changes due to a <game_state_load>.
Please note: For debug use ONLY.
*/
function game_state_print_id_debug()
	{
	var _ids = argument[0];
	var _new_ids = argument[1];
	
	for (var k = ds_map_find_first(_ids); k != undefined; k = ds_map_find_next(_ids, k))
		{
		log(k, " -> ", _new_ids[? string(_ids[? k])]);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */