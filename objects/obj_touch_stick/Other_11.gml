///@description Draw

//Relative
if (engine().touch_stick_type == TOUCH_STICK_TYPE.relative)
	{
	if (abs(draw_x) >= 0.1 || abs(draw_y) >= 0.1)
		{
		draw_sprite_ext(spr_touch_stick, 0, mouse_x_initial, mouse_y_initial, image_xscale, image_yscale, 0, c_white, 0.5);
		draw_sprite_ext(spr_touch_stick, 1, mouse_x_initial + draw_x, mouse_y_initial + draw_y, 1, 1, 0, c_white, 1.0);
		}
	}
//Absolute
else
	{
	if (abs(draw_x) < 0.1 && abs(draw_y) < 0.1)
		{
		draw_sprite_ext(spr_touch_stick, 0, anchor_x, anchor_y, image_xscale, image_yscale, 0, c_white, 1.0);
		draw_sprite_ext(spr_touch_stick, 1, anchor_x + draw_x, anchor_y + draw_y, 1, 1, 0, c_white, 0.5);
		}
	else
		{
		draw_sprite_ext(spr_touch_stick, 0, anchor_x, anchor_y, image_xscale, image_yscale, 0, c_white, 0.5);
		draw_sprite_ext(spr_touch_stick, 1, anchor_x + draw_x, anchor_y + draw_y, 1, 1, 0, c_white, 1.0);
		}
	}

/* Copyright 2024 Springroll Games / Yosi */