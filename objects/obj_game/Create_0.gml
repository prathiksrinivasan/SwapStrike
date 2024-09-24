///@category Gameplay
/*
This object is the main controller object for all gameplay-related objects.
It handles everything from spawning players to running game frames and drawing the HUD.
<obj_game_online> is a child of obj_game that replaces it during online matches.
*/
///@description Sync ID Init
only_one();

is_loading = false; //Ensures that GAME_STATE_OBJECTS created on room start won't crash the game

sync_id_system_init([obj_player, obj_entity, obj_vfx, obj_block_moving, obj_hitbox, obj_hurtbox]);

//Online mode
if (engine().is_online)
	{
	instance_change(obj_game_online, false);
	}
//Replay mode
else if (setting().replay_mode)
	{
	instance_change(obj_game_replay, false);
	}
//Negative input delay
else if (setting().negative_input_delay != 0)
	{
	instance_change(obj_game_negative, false);
	}
/* Copyright 2024 Springroll Games / Yosi */