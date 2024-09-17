///@description <Run by obj_game>

//Background Clear
background_clear_frame = max(--background_clear_frame, 0);
if (background_clear_frame == 0)
	{
	background_clear_amount = max(0, background_clear_amount - 0.1);
	}
else
	{
	background_clear_amount = min(1, background_clear_amount + background_clear_fade_speed);
	}
	
//Background & Foreground update
for (var i = 0; i < array_length(background); i++)
	{
	background_layer_update(background[@ i]);
	}
for (var i = 0; i < array_length(foreground); i++)
	{
	background_layer_update(foreground[@ i]);
	}

//Background fog
background_fog_alpha = lerp(background_fog_alpha, 0, 0.1);
if (background_fog_alpha < 0.01)
	{
	background_fog_alpha = 0;
	}
	
//Run the stage passive callback
callback_run(callback_stage_passive);

/* Copyright 2024 Springroll Games / Yosi */