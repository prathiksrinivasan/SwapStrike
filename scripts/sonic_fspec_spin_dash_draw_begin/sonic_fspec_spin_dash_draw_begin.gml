function sonic_fspec_spin_dash_draw_begin()
	{
	var _charge_threshold = 60;
	
	palette_shader_set(palette_base, palette_swap, 0.0, 1.0, fade_value, false);
	
	//Charging / Rolling / Jumping
	if (attack_phase == 0)
		{
		if (charge >= _charge_threshold)
			{
			draw_sprite_ext(spr_sonic_fspec_spin_dash_aura, state_time div 2, x, y, sprite_scale * facing, sprite_scale, 0, c_white, 1.0);
			}
		}
	
	//Rolling / Jumping
	if (attack_phase == 1 || attack_phase == 3)
		{
		if (charge >= _charge_threshold)
			{
			draw_sprite_ext(spr_sonic_fspec_spin_dash_aura, state_time div 2, x, y, sprite_scale * facing, sprite_scale, 0, c_white, 1.0);
			}
		}
	
	shader_reset();
	}
/* Copyright 2024 Springroll Games / Yosi */