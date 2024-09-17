//Don't update during rollbacks
if (game_is_in_rollback()) then return;

if (plat != noone)
	{
	if (plat_landed == 0)
		{
		draw_y = lerp(draw_y, (dcos((obj_game.current_frame + x) * 3) * 2) - 3, 0.1);
		//Check if any player landed on the plat (does not need to be synced)
		with (obj_player)
			{
			if (place_meeting(x, y + 1, other.plat) && on_ground())
				{
				other.plat_landed = 1;
				break;
				}
			}
		}
	else if (plat_landed == 1)
		{
		plat_landed = 2;
		}
	else if (plat_landed == 2)
		{
		draw_y = lerp(draw_y, 2, 0.3);
		//Check if no players are on the plat
		var _any_on_plat = false;
		with (obj_player)
			{
			if (place_meeting(x, y + 1, other.plat) && on_ground())
				{
				_any_on_plat = true;
				break;
				}
			}
		if (!_any_on_plat)
			{
			plat_landed = 0;
			}
		}
	}
	
//Animation
image_index += 0.1;
/* Copyright 2024 Springroll Games / Yosi */