function stage_islands_script()
	{
	//Random wind objects - not tied to rollback or synced
	if (obj_game.current_frame % 11 == 0)
		{
		var _back = instance_create_layer(0, 0, "Player_Back", obj_stage_islands_wind);
		_back.front = false;
		}
	if (obj_game.current_frame % 17 == 0)
		{
		var _front = instance_create_layer(0, 0, "Stage_Foreground", obj_stage_islands_wind);
		_front.front = true;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */