function spiderman_fspec_chokeslam_draw()
	{
	//Forward Special - Draw
	if (attack_phase == 3 || attack_phase == 4)
		{
		var _s = custom_attack_struct;
		if (is_undefined(_s.chokeslam_anchor_x) || is_undefined(_s.chokeslam_anchor_y)) then return;
		
		var _hand_x = 0;
		var _hand_y = 0;
		if (anim_frame == 12)
			{
			_hand_x = 13;
			_hand_y = 0;
			}
		if (anim_frame == 13)
			{
			_hand_x = 23;
			_hand_y = 5;
			}
		if (anim_frame == 14)
			{
			_hand_x = 29;
			_hand_y = 10;
			}
		if (anim_frame == 15)
			{
			_hand_x = 19;
			_hand_y = 9;
			}
		if (anim_frame == 16)
			{
			_hand_x = 15;
			_hand_y = 14;
			}
		if (anim_frame == 17)
			{
			_hand_x = 9;
			_hand_y = 0;
			}
		if (anim_frame == 18)
			{
			_hand_x = 9;
			_hand_y = 0;
			}
		
		var _c = palette_color_get(palette_data, 1);
		draw_line_width_color(x + _hand_x * facing, y + _hand_y, _s.chokeslam_anchor_x, _s.chokeslam_anchor_y, 3, _c, _c);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */