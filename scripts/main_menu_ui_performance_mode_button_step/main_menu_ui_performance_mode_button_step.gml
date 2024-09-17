function main_menu_ui_performance_mode_button_step()
	{
	ui_button_step();
	
	if (ui_clicked)
		{
		menu_sound_play(snd_menu_alert);
		if (!setting().performance_mode)
			{
			setting().performance_mode = true;
			setting().disable_shaders = true;
			setting().knockback_trails_enable = false;
			setting().show_hud = true;
			setting().show_overhead_name = false;
			setting().show_overhead_arrow = false;
			setting().show_overhead_damage = false;
			setting().show_offscreen_radar = false;
			setting().clip_record = false;
			}
		else
			{
			setting().performance_mode = false;
			setting().disable_shaders = false;
			setting().knockback_trails_enable = true;
			setting().show_offscreen_radar = true;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */