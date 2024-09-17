///@category Player Standard States
/*
This script contains the default Landing Lag state characters are given.

The Landing Lag state is for players who are in momentary lag after touching the ground.
*/
function standard_landing_lag()
	{
	//Contains the standard actions for the lag state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch (_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Sound
			game_sound_play(snd_landing);
			
			//Animation
			anim_set(my_sprites[$ "Landing_Lag"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//No vertical movement
			speed_set(0, 0, true, false);

			//Friction / Gravity
			friction_gravity(hard_landing_friction, grav, max_fall_speed);

			//Aerial
			if (run && check_aerial()) then run = false;

			//Buffer Jumpsquat (optional)
			if (run && landing_buffer_jumpsquat && state_frame <= 1)
				{
				if (check_jump())
					{
					//Only allow canceling into jumpsquat on the last frame of landing lag, so players can't waveland early
					state_frame = 1;
					run = false;
					}
				}

			//When the lag is done
			if (run && state_frame == 0)
				{
				//Return to idle state
				state_set(PLAYER_STATE.idle);
				run = false;
				}

			move();
			break;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */