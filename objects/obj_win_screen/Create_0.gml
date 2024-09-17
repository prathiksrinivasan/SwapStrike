///@category Menus
/*
This object controls everything that happens on the win screen.
This includes drawing the winning player, saving replays, and going to another room when players press the confirm button.
The room that the win screen transitions to is stored in engine().<win_screen_next_room>.
*/
///@description
only_one();

mis_init();

state_phase = 0;
state_timer_max = 100;
state_timer = state_timer_max;

win_screen_last_index = array_length(engine().win_screen_order) - 1;
assert(win_screen_last_index > 0, "[obj_win_screen: Create] The engine().win_screen_order array is too small! (", array_length(engine().win_screen_order), ")");
var _winner = engine().win_screen_order[@ win_screen_last_index];
var _character = _winner[@ WIN_SCREEN_DATA.character];
var _color_actual = player_color_get(_winner[@ WIN_SCREEN_DATA.player_number]);

//Winning name
if (setting().match_team_mode)
	{
	win_name = "Team " + string(engine().win_screen_team + 1);
	_color_actual = player_color_get(engine().win_screen_team);
	}
else
	{
	win_name = character_data_get(_character, CHARACTER_DATA.name);
	}

//Replays
can_save_replay = setting().replay_record;
replay_metadata = replay_metadata_struct();
replay_name = "Replay " + string(replay_data_get().time);

//Background animation
menu_background_color_set(_color_actual);

//Play the victory theme
audio_stop_all();
var _music = character_data_get(_character, CHARACTER_DATA.music);
if (audio_exists(_music))
	{
	audio_play_sound_adjusted(_music, 0, false, audiogroup_music);
	}

//Time Limit
time_left = (engine().win_screen_time_limit * 60);
/* Copyright 2024 Springroll Games / Yosi */