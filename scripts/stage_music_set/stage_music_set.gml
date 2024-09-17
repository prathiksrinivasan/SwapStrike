///@category Stages
///@param {asset/array} song			The song to play, or an array with all of the information as specified
///@param {real} [intro_length]			The length of the "intro" of the song, in seconds
///@param {real} [loop_length]			The position in the song that should loop back to the end of the intro, in seconds
/*
Sets the music for the current stage.
If intro and loop positions are given, the song will play until it gets to the loop position, and then jump back to the intro position.

You can also pass a single array as the first argument with the song name, and optionally the intro length and loop length.
For example, the following two calls would be identical:
	stage_music_set(song_campground_remix, 144.0, 281.1);
	stage_music_set([song_campground_remix, 144.0, 281.1]);

Warning: If the loop position is exactly at the end of the song there may be some issues with looping. Please add 1-2 extra seconds onto the end of the song to ensure it always loops properly.
*/
function stage_music_set()
	{
	var _song = argument[0];
	var _intro = argument_count > 1 ? argument[1] : 0;
	var _loop = argument_count > 2 ? argument[2] : 0;

	with (obj_stage_manager)
		{
		if (is_array(_song))
			{
			var _len = array_length(_song);
			music = audio_play_sound_adjusted(_song[@ 0], 0, true, audiogroup_music);
			music_intro_pos = _len > 1 ? _song[@ 1] : 0;
			music_loop_pos = _len > 2 ? _song[@ 2] : 0;
			}
		else
			{
			music = audio_play_sound_adjusted(_song, 0, true, audiogroup_music);
			music_intro_pos = _intro;
			music_loop_pos = _loop;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */