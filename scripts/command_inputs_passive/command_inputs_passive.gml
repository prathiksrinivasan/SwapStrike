///The passive script for adding command inputs
function command_inputs_passive()
	{
	//Allow command inputs to be used in the following states, including the starting frames of any attack
	if ((state == PLAYER_STATE.attacking && state_time < 5) ||
		state == PLAYER_STATE.crouching ||
		state == PLAYER_STATE.dashing ||
		state == PLAYER_STATE.idle ||
		state == PLAYER_STATE.jumpsquat ||
		state == PLAYER_STATE.run_stop ||
		state == PLAYER_STATE.run_turnaround ||
		state == PLAYER_STATE.running ||
		state == PLAYER_STATE.walk_turnaround ||
		state == PLAYER_STATE.walking ||
		state == PLAYER_STATE.wavelanding)
		{
		//Make sure you aren't grabbing anyone
		if (grabbed_id == noone || 
			grabbed_id.grab_hold_id != id || 
			(grabbed_id.state != PLAYER_STATE.grabbed && 
			grabbed_id.state != PLAYER_STATE.hitlag))
			{
			if (on_ground())
				{
				//Buster wolf
				/*
				if (attack_script != terry_buster_wolf)
					{
					if (input_pressed(INPUT.special, buffer_time_standard, false))
						{
						//You can do the input in either direction, and it will turn you around
						if (input_motion([6, [1, 2], [3, 6]], Lstick))
							{
							input_reset(INPUT.special);
							attack_start(terry_buster_wolf);
							}
						else if (input_motion([4, [2, 3], [1, 4]], Lstick))
							{
							facing *= -1;
							input_reset(INPUT.special);
							attack_start(terry_buster_wolf);
							}
						}
					}
				*/
				
				//Chokeslam
				/*
				if (attack_script != spiderman_fspec_chokeslam)
					{
					if (input_pressed(INPUT.special, buffer_time_standard, false))
						{
						//You can do the input in either direction, and it will turn you around
						if (input_motion([4, [7, 8, 9], 6], Lstick))
							{
							input_reset(INPUT.special);
							attack_start(spiderman_fspec_chokeslam);
							}
						else if (input_motion([6, [7, 8, 9], 4], Lstick))
							{
							facing *= -1;
							input_reset(INPUT.special);
							attack_start(spiderman_fspec_chokeslam);
							}
						}
					}
				*/
				
				//Power Geyser
				if (attack_script != terry_power_geyser)
					{
					if (input_pressed(INPUT.special, buffer_time_standard, false))
						{
						//You can do the input in either direction, and it will turn you around
						if (input_motion([7, 3], Lstick))
							{
							input_reset(INPUT.special);
							attack_start(terry_power_geyser);
							}
						else if (input_motion([9, 1], Lstick))
							{
							facing *= -1;
							input_reset(INPUT.special);
							attack_start(terry_power_geyser);
							}
						}
					}
				}
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */