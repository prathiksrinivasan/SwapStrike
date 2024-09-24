///@description Initialize

//GGMR
ggmr_session_init
	(
	game_local_input_online_with_cpu,
	game_advance_frame,
	game_state_save,
	game_state_load,
	game_finish,
	game_ggmr_event,
	game_input_template(),
	);
	
//Add session players based on the player data
var _count = player_count();
for (var i = 0; i < _count; i++)
	{
	ggmr_session_client_add
		(
		-1,
		"",
		GGMR_LOCATION_TYPE.local,
		GGMR_CLIENT_TYPE.player,
		);
	}
	
ggmr_session_local_mode_enable(true);
ggmr_session_input_delay_set(-abs(setting().negative_input_delay));

ggmr_session_finalize();

//Normal Setup (must be called after the GGMR setup!)
game_object_setup();

//Player inputs (initialized as undefined because the GGMR session should create the buffers)
player_inputs = array_create(number_of_players, undefined);

//Menu Input System
mis_init();
mis_auto_connect_enable(false);

/* Copyright 2024 Springroll Games / Yosi */