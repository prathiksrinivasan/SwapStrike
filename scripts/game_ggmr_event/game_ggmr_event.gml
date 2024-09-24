///@category Gameplay
///@param {int} event			The GGMR event that was triggered, from the enum GGMR_EVENT
///@param {any} [extra]			Any extra arguments that might be included for specific events
/*
A callback function used in GGMR for online play.
It handles any GGMR event value.
*/
function game_ggmr_event()
	{
	switch (argument[0])
		{
		case GGMR_EVENT.desync_detected:
			//When a desync occurs online, end the game and return to the main menu
			var _msg = argument_count > 1 ? argument[1] : "(No additional details)";
			show_message("A desync has occurred\n" + _msg);
			game_finish(rm_main_menu);
			break;
		case GGMR_EVENT.desync_check:
			return game_state_hash();
			break;
		case GGMR_EVENT.prediction_limit_reached:
			//Do nothing
			break;
		case GGMR_EVENT.disconnect:
			popup_create("Disconnected from opponent (Trigger: GGMR Event)", [], c_red);
			//Return to the main menu
			game_finish(rm_main_menu);
			break;
		case GGMR_EVENT.input_check_blank:
			assert(buffer_exists(argument[1]), "[game_ggmr_event] The passed argument was not a buffer");
			return game_input_is_blank(argument[1]);
			break;
		default: crash("[game_ggmr_event] Invalid GGMR event number (", argument[0], ")"); break;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */