///@category Settings
/*
This script contains all of the default engine-level settings.
It is automatically run at the start of the game.
*/
#region Constant
/*
- Cannot be changed during gameplay
*/
//Version
#macro game_name						"Platform Fighter Engine" //{string} The name of the game.
#macro version_string					"1.4.4" //{string} The current game version.
#macro web_export						(os_type == os_operagx || os_browser != browser_not_a_browser) //{bool} Whether the game is using one of the GameMaker web exports (HTML5 or Opera GX) or not.

//Server
#macro server_key_random_matchmaking	"--" //{string} The key used by the random matchmaking server to make sure the right game is connecting. Should be a long, randomly generated string.
#macro server_key_private_lobby			"HW3LXPtjvp" //{string} The key used by the private lobby server to make sure the right game is connecting. Should be a long, randomly generated string.
    
#macro server_ip_address				"52.1.57.82" //{string} The IP address of the matchmaking server.
#macro server_port						63567 //{int} The port on the matchmaking server to communicate through.

//Savefiles
#macro savefile_profiles				"profiles.sav" //{string} The filename to save profile data to.
#macro savefile_options					"options.sav" //{string} The filename to save options to.
#macro savefile_stats					"stats.txt" //{string} The filename to save stats to.
#macro savefile_replay_names			"replay_names.txt" //{string} The filename to save the names of replay files to. Please note: This is ONLY used for web exports.

//Profile Names
#macro profile_name_length_max			12 //{int} The maximum number of characters that can be in a profile name.

//Local
#macro match_stock_default				3 //{int} The number of stocks players have in matches by default.
#macro match_time_default				6 //{int} The amount of time players have in  matches by default.
#macro match_stamina_default			0 //{int} The amount of stamina players have in matches by default.
#macro match_team_mode_default			false //{bool} If teams are enabled in matches by default or not.
#macro match_team_attack_default		false //{bool} If team attack is enabled in matches by default or not.
#macro match_items_enable_default		false //{bool} If items are enabled in matches by default or not.
#macro match_items_frequency_default	0 //{int} The frequency of items spawning in matches by default.
#macro match_fs_meter_default			false //{bool} If the Final Smash meter is enabled in matches by default or not.
#macro match_screen_wrap_default		false //{bool} If screen wrapping is enabled in matches by default or not.
#macro match_ex_meter_default			false //{bool} If the EX meter is enabled in matches by default or not.

//Online
#macro online_connect_code_length_max	24 //{int} The maximum number of characters that can be in a connect code.
#macro online_win_screen_time_limit		4 //{int} The maximum number of seconds players can stay on the win scren after online matches.
#macro quickplay_match_stock			3 //{int} The number of stocks players have in Quickplay matches.
#macro quickplay_match_time				6 //{int} The amount of time players have in Quickplay matches.
#macro quickplay_match_stamina			0 //{int} The amount of stamina players have in Quickplay matches.
#macro quickplay_match_team_mode		false //{bool} Teams are not supported in Quickplay, since it is only 1v1.
#macro quickplay_match_team_attack		false //{bool} Team attack is not supported in Quickplay, since it is only 1v1.
#macro quickplay_match_items_enable		false //{bool} If items are enabled in Quickplay matches or not.
#macro quickplay_match_items_frequency	0 //{int} The frequency of items spawning in Quickplay matches.
#macro quickplay_match_fs_meter			false //{bool} If the Final Smash meter is enabled in Quickplay matches or not.
#macro quickplay_match_screen_wrap		false //{bool} Whether screen wrapping is enabled in Quickplay matches or not.
#macro quickplay_match_ex_meter			false //{bool} If the EX meter is enabled in Quickplay matches or not.

//Game State Saving & Loading
#macro character_static_properties		true //{bool} Whether characters' properties are constants or not. If this is set to true, <game_state_save> will not save character properties.
#macro character_static_states			true //{bool} Whether characters' states are constants or not. If this is set to true, <game_state_save> will not save character states.
#macro character_static_attacks			true //{bool} Whether characters' attacks are constants or not. If this is set to true, <game_state_save> will not save character attacks.
#macro character_static_sprites			true //{bool} Whether characters' sprites are constants or not. If this is set to true, <game_state_save> will not save character sprites.

//Input Buffer
#macro input_buffer_size				8 //{int} The size of the input buffer data structure, in bytes.

//Hitbox Groups
#macro hitbox_groups_max				4 //{int} The maximum number of hitbox groups that can be used.

//Pseudo Random Number Generator
#macro prng_range						10000 //{int} The maximum range of the generator.
#macro prng_multiplier					3 //{int} The multiplier to use.
#macro prng_increment					41 //{int} The increment value to use.
#macro prng_seed						37 //{int} The initial value to start the random generator with.
#macro prng_channels					15 //{int} The number of different generators running at once.
#macro prng_channel_difference			59 //{int} The difference in the seed number channels use.

//String input
#macro valid_string_characters			["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "_", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"] //{array} An array of single character strings that are allowed in names and connect codes.
#macro valid_string_numbers				["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"] //{array} An array of single character strings that are allowed for number inputs.
#macro valid_string_auto_characters		["C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "9"] //{array} An array of single character strings that are allowed in autogenerated codes.
#macro valid_string_ip_address			["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."] //{array} An array of single character strings that are allowed for IP addresses.
#macro valid_string_replay_name			["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " ", "-", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "[", "]"] //{array} An array of single character strings that are allowed in replay names.

//Match settings
#macro stock_value_limit				99 //{int} The maximum amount of stocks each player in a match can have
#macro time_value_limit					60 //{int} The maximum amount of minutes a match can have
#macro stamina_valid_values				[0, 1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 150, 200, 250, 300, 400, 500, 600, 700, 800, 900, 999] //{array} An array of HP integers that can be selected for stamina matches. The maximum value cannot be higher than <damage_max>.
#macro items_frequency_valid_values		[0, 25, 50, 75, 100] //{array} An array of integers that can be selected for the item spawn frequency.

//Online Chat
#macro online_chat_messages_stored		12 //{int} The maximum number of chat messages that are stored.

//Touch Controls
#macro touch_controls_enable			false //{bool} Whether touch controls are enabled for the entire game or not.
#macro touch_devices_limit				5 //{int} The number of mouse/touch devices to check.
#macro touch_stick_sensitivity			2.0 //{real} The multiplier used for the touch control stick.

//Command Line
#macro cli_enable						false //{bool} Whether the command line interface is enabled or not.
#macro cli_key_toggle					192 //{int} The key to toggle the command line. By default, this is the ` key.
#macro cli_key_enter					vk_enter //{int} The key to run a command on the command line.

//Game Window
#macro game_window_bar_enable			false //{bool} If the custom <obj_game_window> bar should be enabled. Turn this on if you want to use the Borderless Window setting.

//Palettes
#macro palette_size_max					48 //{int} The maximum number of colors that can be in each column of a character's palette. If you want to increase this number, you will also need to change the array size in each palette shader.

#macro debug_training					true //{bool) If true, will send the game directly into a testing room at initialization

//Global Object Surface - Used to draw cropped sprites with the outline shader.
function object_surface_get()
	{
	static _surf = surface_create(object_surface_size, object_surface_size);
	if (!surface_exists(_surf))
		{
		_surf = surface_create(object_surface_size, object_surface_size);
		}
	return _surf;
	}

//Global Collision List - Used in multiple collision functions.
function temp_list_get()
	{
	static _list = ds_list_create();
	return _list;
	}

//Global Priority Queue - Used by hitboxes to sort hurtboxes by priority.
function temp_priority_get()
	{
	static _priority = ds_priority_create();
	return _priority;
	}

//Global Replay Data - Used to store replay data during matches.
function replay_data_get()
	{
	static _properties =
		{
		buffer : undefined,
		time : "",
		};
	return _properties;
	}

//Global Game Camera - The camera used during matches.
function game_camera_get()
	{
	static _cam = camera_create_view(0, 0, camera_width_start, camera_height_start);
	return _cam;
	}

//Palette Shader Uniforms - Cached at the start of the game and used in the palette shader functions.
function palette_shader_uniforms()
	{
	static _uniforms =
		{
		uni_pb : shader_get_uniform(shd_palette, "palette_base"),
		uni_ps : shader_get_uniform(shd_palette, "palette_swap"),
		uni_c : shader_get_uniform(shd_palette, "count"),
		uni_f : shader_get_uniform(shd_palette, "fade_value"),
		uni_l : shader_get_uniform(shd_palette, "light_value"),
		uni_a : shader_get_uniform(shd_palette, "alpha_value"),
		uni_o : shader_get_uniform(shd_palette, "outline"),
		uni_ot : shader_get_uniform(shd_palette, "outline_texel"),
		uni_oc : shader_get_uniform(shd_palette, "outline_color"),
		uni_ti : shader_get_uniform(shd_palette, "tint"),
		uni_fl : shader_get_uniform(shd_palette, "flash"),
		};
	return _uniforms;
	}
function palette_shader_simple_uniforms()
	{
	static _uniforms =
		{
		uni_pb : shader_get_uniform(shd_palette_simple, "palette_base"),
		uni_ps : shader_get_uniform(shd_palette_simple, "palette_swap"),
		uni_c : shader_get_uniform(shd_palette_simple, "count"),
		};
	return _uniforms;
	}

//Getpixel Buffer - Used as an alternative to surface_getpixel().
function getpixel_buffer()
	{
	static _buffer = buffer_create(1, buffer_grow, 1);
	return _buffer;
	}

//Live Values - Data that can be loaded from a file while the game is running.
function live_values_stored_data()
	{
	static _data =
		{
		struct : {},
		reloaded_time : "",
		size : 0,
		filename : "",
		};
	return _data;
	}

//Server Keys
function server_keys()
	{
	static _keys =
		{
		random_matchmaking : server_key_random_matchmaking,
		private_lobby : server_key_private_lobby,
		};
	return _keys;
	}

//Simple Attacks
function simple_attack_data()
	{
	static _data = {};
	return _data;
	}

#endregion

#region Variable
/*
- Can be changed during gameplay
- Values here are the DEFAULT values ONLY
- Access using engine().property syntax
*/
function engine()
	{
	static _properties = 
		{
		//Profiles
		profiles :						[], //{array} The array profile data is stored in.
		
		//Stats
		stats :							{}, //{struct} The struct the game stats are stored in.
		
		//Character Select Data
		css_player_data :				[], //{array} The array CSS player data is stored in.
		load_css_data :					false, //{bool} Whether the CSS needs to load in player data or not. This is usually only set to true after a match ends.
		css_index_current :				0, //{int} The index counter used for CSS elements.
		
		//Menu Input System
		mis_json :						"", //{string} The string used to store MIS data.
		
		//Players data
		player_data :					[], //{array} The array player data is stored in.
		
		//Singeplayer
		singleplayer_mode :				false, //{bool} Whether the <game_advance_frame> ends the game when one player is left or not.
		
		//Replay-specific data
		replay_total_frames :			0, //{int} The total number of frames that last match took, to be saved in the replay metadata.
		replay_player_ko_frames :		[], //{array} An array that stores which frames players lost stocks on, to be saved in the replay metadata.
		
		//Win Screen
		win_screen_order :				[], //{array} An array of win screen data, in the order of when players were eliminated or by total points. The last index contains the player that won.
		win_screen_team :				-1, //{int} The number of the team that won, if team mode is on.
		win_screen_next_room :			rm_css, //{asset} The room to switch to after the win screen.
		win_screen_time_limit :			-1, //{int} The maximum number of seconds players can spend on the win screen. Setting this to -1 means there is no enforced time limit.
		
		//Online
		is_online :						false, //{bool} Whether the current match is online or not.
		online_mode :					ONLINE_MODE.quickplay, //{int} The online mode the game is currently in, from the enum ONLINE_MODE.
		online_is_leader :				false, //{bool} Whether the player is the leader in an online lobby or not.
		online_leader_connection :		-1, //{int} The connection number to the online leader, if the player is not the leader.
		online_name :					"PLAYER", //{string} The name used in online lobbies / quickplay. This is not used in-game, since the profile name is used instead.
		online_show_names :				true, //{bool} Whether the names of players in quickplay are shown or not. This does not affect private lobbies.
		online_show_connect_codes :		true, //{bool} Whether connect codes for private lobbies are shown or not.
		online_show_matchmaking :		true, //{bool} Whether the random matchmaking progress is shown or not.
		online_show_ping :				true, //{bool} Whether to show the ping and input delay in the bottom left corner during online matches or not.
		online_input_delay :			GGMR_INPUT_DELAY_DEFAULT, //{int} The number of frames of input delay you have online.
		online_connect_code :			"41", //{string} The default connect code used for private lobbies.
		online_default_name :			"", //{string} The name of the default profile the player will have in online matches.
		
		//Private Lobby
		private_lobby_json :			"", //{string} The string used to store private lobby data.
		private_lobby_resume :			false, //{bool} Whether the stored private lobby data should be loaded or not.
		private_lobby_spectator_ready :	false, //{bool} Whether to automatically ready up if you are a spectator or not.
		
		//Random Matchmaking
		random_match_connection :		-1, //{int} The connection number to the other player in a random match.
		
		//Spectators Data
		spectator_data :				[], //{array} The array spectator data is stored in.
		
		//Client Data
		client_data :					[], //{array} An array of network data for all clients you are connected to. This is essentially a combination of <player_data> and <spectator_data>, but with different properties.
		
		//Main Menu News / Annoucements
		main_menu_fetched_news :		false, //{bool} Whether the main menu has fetched news from the server yet or not. If <web_export> is true, news will never be fetched.
		main_menu_news :				"", //{string} The news or announcements returned from the server.
		
		//Touch Controls
		touch_stick_type :				TOUCH_STICK_TYPE.absolute, //{int} The type of touch control stick to use, from the TOUCH_STICK_TYPE enum.
		};
	return _properties;
	}

#endregion

#region (DO NOT CHANGE)
/*
- There should be no reason to change these values
*/
//Background
#macro back_clear						[-1] //{array} The value used to determine which layer the background fade effect happens on in <obj_stage_manager>.

//Control Stick
#macro Lstick							0 //{int} The left control stick.
#macro Rstick							1 //{int} The right control stick.

//Events
#macro Game_Event_Step					0 //{int} The user event number to use as a Step event.
#macro Game_Event_Draw					1 //{int} The user event number to use as a Draw event.

//Game State
#macro GAME_STATE_OBJECT if (obj_game.is_loading) { exit; } //{snippet} Code ran by objects that are marked as part of the game state to prevent initialization from happening when loaded from <game_state_load>.

#endregion
/* Copyright 2024 Springroll Games / Yosi */