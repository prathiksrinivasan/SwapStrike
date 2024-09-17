function scalar_passive()
	{
	//You can only use scalar_fspec once before touching the ground again!
	if (!(state == PLAYER_STATE.attacking && attack_script == scalar_fspec))
		{
		if (on_ground() || state == PLAYER_STATE.ledge_snap)
			{
			attack_uses_set(1, scalar_fspec);
			}
		}
	
	//Down Special color change
	if (!variable_struct_exists(custom_attack_struct, "scalar_dspec_color_change"))
		{
		custom_attack_struct.scalar_dspec_color_change = false;
		}
	if (variable_struct_exists(custom_attack_struct, "scalar_dspec_cancel"))
		{
		var _charged = (custom_attack_struct.scalar_dspec_charge >= 3);
		if (custom_attack_struct.scalar_dspec_color_change != _charged)
			{
			custom_attack_struct.scalar_dspec_color_change = _charged;
			if (_charged)
				{
				player_palette_change_color(0, palette_color_get(palette_data, 2));
				}
			else
				{
				player_palette_reset();
				}
			}
		}
	
	//Lose Down Special charge when KO'ed
	if (is_knocked_out())
		{
		attack_uses_set(1, scalar_fspec);
		custom_attack_struct.scalar_dspec_cancel = false;
		custom_attack_struct.scalar_dspec_charge = 0;
		custom_attack_struct.scalar_dspec_color_change = false;
		player_palette_reset();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */