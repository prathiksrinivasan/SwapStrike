///@description Initialize

//GGMR
ggmr_session_init
	(
	game_local_input_online,
	game_advance_frame,
	game_state_save,
	game_state_load,
	game_finish,
	game_ggmr_event,
	game_input_template(),
	);

//Add session players FIRST based on the player data
//Adding players before spectators is important, so that the player_number will line up for <game_local_input_online>.
var _count = player_count();
for (var i = 0; i < _count; i++)
	{
	var _player = engine().player_data[@ i];
	var _custom = _player[@ PLAYER_DATA.custom];
	ggmr_session_client_add
		(
		_custom.connection,
		_custom.name,
		_custom.location,
		_custom.client_type,
		);
	}

for (var i = 0; i < array_length(engine().spectator_data); i++)
	{
	var _spectator = engine().spectator_data[@ i];
	var _custom = _spectator[@ SPECTATOR_DATA.custom];
	ggmr_session_client_add
		(
		_custom.connection,
		_custom.name,
		_custom.location,
		_custom.client_type,
		);
	}

ggmr_session_input_delay_set(engine().online_input_delay);

ggmr_session_finalize();

//Normal Setup (must be called after the GGMR setup!)
game_object_setup();

//Player inputs (initialized as undefined because the GGMR session should create the buffers)
player_inputs = array_create(number_of_players, undefined);

/* Copyright 2024 Springroll Games / Yosi */