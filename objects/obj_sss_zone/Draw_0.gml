///@description
//Selected animation
selected_animation_time = lerp(selected_animation_time, 0, 0.1);
draw_set_color(c_white);
draw_set_alpha(selected_animation_time);
draw_rectangle(bbox_left - 4, bbox_top - 4, (bbox_right - 1) + 4, (bbox_bottom - 1) + 4, false);
draw_set_alpha(1);

if (stage != noone)
	{
	var _sprite = stage_data_get(stage, STAGE_DATA.sprite);
	var _frame = stage_data_get(stage, STAGE_DATA.frame);
	draw_sprite(_sprite, _frame, x + (sprite_width / 2), y + (sprite_height / 2));
	}
else
	{
	draw_sprite(spr_stage_random_button, 0, x + (sprite_width / 2), y + (sprite_height / 2));
	}
/* Copyright 2024 Springroll Games / Yosi */