///Final Smash for Polygon - Draw
function poly_final_smash_draw()
	{
	var _accent = palette_color_get(palette_data, 1);
	draw_sprite_ext(spr_poly_final_smash_reticle, 0 + ((attack_frame / 6) % 3), custom_attack_struct.final_smash_x, custom_attack_struct.final_smash_y, 2, 2, 0, _accent, 1);
	for (var i = 0; i < array_length(custom_ids_struct.final_smash_targets); i++)
		{
		var _target = custom_ids_struct.final_smash_targets[@ i];
		if (_target.state != PLAYER_STATE.lost)
			{
			draw_sprite_ext(spr_poly_final_smash_reticle, 3 + ((attack_frame / 6) % 3), _target.x, _target.y, 2, 2, 0, _accent, 1);
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */