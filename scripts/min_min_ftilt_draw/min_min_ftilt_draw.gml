function min_min_ftilt_draw()
	{
	//Forward Tilt - Draw
	if (attack_phase == 1)
		{
		//Line
		var _c = palette_color_get(palette_data, 0);
		draw_line_width_color(x + (16 * facing), y - 100, x + custom_attack_struct.arm_x, y + custom_attack_struct.arm_y, 4, _c, _c);
	
		palette_shader_set(palette_base, palette_swap, 0.0, 1.0, fade_value, false);
		draw_sprite_ext(spr_min_min_ftilt_end, 0, x + custom_attack_struct.arm_x, y + custom_attack_struct.arm_y, 2 * facing, 2, 0, c_white, 1);
		shader_reset();
		}
	else if (attack_phase == 2)
		{
		//Line
		var _c = palette_color_get(palette_data, 0);
		draw_line_width_color(x + (16 * facing), y - 100, x + custom_attack_struct.arm_x, y + custom_attack_struct.arm_y, 4, _c, _c);
	
		palette_shader_set(palette_base, palette_swap, 0.0, 1.0, fade_value, false);
		draw_sprite_ext(spr_min_min_ftilt_end, 0, x + custom_attack_struct.arm_x, y + custom_attack_struct.arm_y, 2 * facing, 2, 0, c_white, 1);
		shader_reset();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */