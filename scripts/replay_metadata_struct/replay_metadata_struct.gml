///@category Replays
/*
Returns a struct with all of the replay metadata in it for the last completed match. Used in <replay_save_metadata>.
Please note: This function is intended to be used on the win screen, and may not work on later menu screens.
*/
function replay_metadata_struct()
	{
	//Struct
	var _meta = {};
	
	//Match settings
	match_settings_save(_meta);
	
	//Replay-specific data
	_meta.replay_total_frames = engine().replay_total_frames;
	_meta.replay_player_ko_frames = engine().replay_player_ko_frames;
	
	//Player metadata
	var _player_data = [];
	var _num_of_players = player_count();
	for (var i = 0; i < _num_of_players; i++)
		{
		var _p = player_data_get(i, PLAYER_DATA.profile);
		var _data = {};
		_data.name = profile_get(_p, PROFILE.name);
		_data.character = player_data_get(i, PLAYER_DATA.character);
		_data.color = player_data_get(i, PLAYER_DATA.color);
		_data.team = player_data_get(i, PLAYER_DATA.team);
		array_push(_player_data, _data);
		}
	_meta.player_data = _player_data;
	
	return _meta;
	}
/* Copyright 2024 Springroll Games / Yosi */