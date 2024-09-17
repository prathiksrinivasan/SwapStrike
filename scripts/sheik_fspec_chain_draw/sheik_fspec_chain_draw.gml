function sheik_fspec_chain_draw()
	{
	//Forward Special
	if (attack_phase == 1)
		{
		var _col = palette_color_get(palette_data, 1);
		var _len = array_length(custom_attack_struct.segments);
		if (_len > 0)
			{
			var _px = custom_attack_struct.segments[@ 0][@ 0];
			var _py = custom_attack_struct.segments[@ 0][@ 1];
			for (var i = 1; i < _len; i++)
				{
				var _seg = custom_attack_struct.segments[@ i];
				var _x = _seg[@ 0];
				var _y = _seg[@ 1];
				draw_line_width_color(_px, _py, _x, _y, 2, _col, _col);
				_px = _x;
				_py = _y;
				}
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */