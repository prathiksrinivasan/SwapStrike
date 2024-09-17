///@category Characters
///@param {array} [banned_characters]		An array of character names that cannot be chosen
/*
Chooses a random character from all of the characters defined in <character_data>.
You can optionally pass an array of strings, and the characters with those names cannot be chosen.
Please note: The function will crash if there are no characters to choose from after taking bans into account.
Warning: This function cannot be used in gameplay, since it isn't deterministic.
*/
function character_choose_random()
	{
    //Create an array of all characters that are NOT the random button, and choose one
    var _banned = argument_count > 0 ? argument[0] : [];
	var _possible = [];
	var _total = character_count();
	for (var i = 0; i < _total; i++)
		{
		var _name = character_data_get(i, CHARACTER_DATA.name);
		if (_name != "Random")
			{
			//Check if the character is banned
			if (!array_contains(_banned, _name))
				{
				array_push(_possible, i);
				}
			}
		}
	assert(array_length(_possible) > 0, "[character_choose_random] Either there are no characters besides Random in character_data, or every other character has been banned.");
	return _possible[@ irandom(array_length(_possible) - 1)];
	}
/* Copyright 2024 Springroll Games / Yosi */