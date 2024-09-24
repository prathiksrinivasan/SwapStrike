function sonic_fspec_spin_dash_draw_end()
	{
	//Charging
	if (attack_phase == 0)
		{
		draw_sprite_ext(spr_sonic_fspec_spin_dash_spin, state_time div 2, x, y, sprite_scale * facing, sprite_scale, 0, c_white, 1.0);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */