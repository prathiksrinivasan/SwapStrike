///@category Stages
///@param {array} songs			The array of songs to play, along with their loop points and probability, or an array of arrays
/*
Sets the music for the current stage to a randomly chosen song from the given array.
The array should be in the format:
	[song, intro_length, loop_length, probability]
You can either give a single array with this information for all songs, or give an array of smaller arrays with the information each invidual songs.
For example, the following two calls would be identical:
	stage_music_random_set([song_islands, 56.0, 120.0, 20, song_library, 166.4, 332.8, 5]);
	stage_music_random_set([[song_islands, 56.0, 120.0, 20], [song_library, 166.4, 332.8, 5]]);

Please note: If you don't want a song to have custom loop points, set both to 0.
Warning: If the loop position is exactly at the end of the song there may be some issues with looping. Please add 1-2 extra seconds onto the end of the song to ensure it always loops properly.
*/
function stage_music_random_set()
	{
	//Get the array from the arguments
	var _tracklist = argument[0];
	
	//Convert an array of arrays into a single array
	if (is_array(_tracklist[@ 0]))
		{
		var _single = [];
		var _position = 0;
		for (var i = 0; i < array_length(_tracklist); i++)
			{
			array_copy(_single, _position, _tracklist[@ i], 0, 4);
			_position += 4;
			}
		_tracklist = _single;
		}
	
	//Make sure the array is the correct length
	var _length = array_length(_tracklist);
	assert(_length % 4 == 0, "[stage_music_random_set] The given array is not in a valid format (", _length, ")");
	
	//Calculate the sum of all weights
	var _sum = 0;
	for (var i = 3; i < _length; i += 4)
		{
		_sum += _tracklist[@ i];
		}

	//Generate the random number
	var _random_number = random(_sum);

	//Choose the value based on the random number and the weights
	var _sum = 0;
	var _song = 0;
	var _intro = 0;
	var _loop = 0;

	for (var i = 3; i < _length; i += 4)
		{
		_sum += _tracklist[@ i];
		if (_sum >= _random_number)
			{
			_song = _tracklist[@ i - 3];
			_intro = _tracklist[@ i - 2];
			_loop = _tracklist[@ i - 1];

			//Stop the loop
			break;
			}
		}

	//Play the chosen track
	with (obj_stage_manager)
		{
		music = audio_play_sound_adjusted(_song, 0, true, audiogroup_music);
		music_intro_pos = _intro;
		music_loop_pos = _loop;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */