///@category Gameplay
/*
Creates a string value that represents the current game state for the purpose of desync checking.
By default, this only includes the position and state of each player object, and the position and type of each hitbox.
*/
function game_state_hash()
	{
	var _hash = "";
	var _values = [];
	with (obj_player)
		{
		_values[@ player_number] = 
			"(" + 
			string(x) + "," + 
			string(y) + "," + 
			string(player_state_name_get(state)) + "," + 
			string(damage) + 
			") ";
		}
	with_synced_object
		(
		obj_hitbox, 
		function(_array)
			{
			array_push(_array, "(" + object_get_name(object_index) + "," + string(x) + "," + string(y) + ")");
			},
		_values,
		);
	for (var i = 0; i < array_length(_values); i++)
		{
		_hash += _values[@ i];
		}
	return _hash;
	}
/* Copyright 2024 Springroll Games / Yosi */