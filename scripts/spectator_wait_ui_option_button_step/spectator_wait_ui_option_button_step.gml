function spectator_wait_ui_option_button_step()
	{
	ui_button_step();
	
	var _on_normal = $7FB252;
	var _on_hover = $8FA262;
	var _off_normal = $4E4EE5;
	var _off_hover = $5E5EF5;
	
	switch (name)
		{
		case "Show Hitboxes & Hurtboxes":
			if (ui_clicked)
				{
				setting().show_hitboxes ^= 1;
				setting().show_hurtboxes = setting().show_hitboxes;
				}
			if (setting().show_hitboxes && setting().show_hurtboxes)
				{
				text = "ON";
				color_normal = _on_normal;
				color_hover = _on_hover;
				color_clicked = _on_hover;
				}
			else
				{
				text = "OFF";
				color_normal = _off_normal;;
				color_hover = _off_hover;
				color_clicked = _off_hover;
				}
			break;
		case "Show Trajectories":
			if (ui_clicked)
				{
				setting().show_launch_trajectories ^= 1;
				}
			if (setting().show_launch_trajectories)
				{
				text = "ON";
				color_normal = _on_normal;
				color_hover = _on_hover;
				color_clicked = _on_hover;
				}
			else
				{
				text = "OFF";
				color_normal = _off_normal;
				color_hover = _off_hover;
				color_clicked = _off_hover;
				}
			break;
		case "Overhead Names":
			if (ui_clicked)
				{
				setting().show_overhead_name ^= 1;
				}
			if (setting().show_overhead_name)
				{
				text = "ON";
				color_normal = _on_normal;
				color_hover = _on_hover;
				color_clicked = _on_hover;
				}
			else
				{
				text = "OFF";
				color_normal = _off_normal;
				color_hover = _off_hover;
				color_clicked = _off_hover;
				}
			break;
		case "Overhead Damage":
			if (ui_clicked)
				{
				setting().show_overhead_damage ^= 1;
				}
			if (setting().show_overhead_damage)
				{
				text = "ON";
				color_normal = _on_normal;
				color_hover = _on_hover;
				color_clicked = _on_hover;
				}
			else
				{
				text = "OFF";
				color_normal = _off_normal;
				color_hover = _off_hover;
				color_clicked = _off_hover;
				}
			break;
		case "Overhead Arrows":
			if (ui_clicked)
				{
				setting().show_overhead_arrow ^= 1;
				}
			if (setting().show_overhead_arrow)
				{
				text = "ON";
				color_normal = _on_normal;
				color_hover = _on_hover;
				color_clicked = _on_hover;
				}
			else
				{
				text = "OFF";
				color_normal = _off_normal;
				color_hover = _off_hover;
				color_clicked = _off_hover;
				}
			break;
		case "Show HUD":
			if (ui_clicked)
				{
				setting().show_hud ^= 1;
				}
			if (setting().show_hud)
				{
				text = "ON";
				color_normal = _on_normal;
				color_hover = _on_hover;
				color_clicked = _on_hover;
				}
			else
				{
				text = "OFF";
				color_normal = _off_normal;
				color_hover = _off_hover;
				color_clicked = _off_hover;
				}
			break;
		case "Show Combos":
			if (ui_clicked)
				{
				setting().show_combos ^= 1;
				}
			if (setting().show_combos)
				{
				text = "ON";
				color_normal = _on_normal;
				color_hover = _on_hover;
				color_clicked = _on_hover;
				}
			else
				{
				text = "OFF";
				color_normal = _off_normal;
				color_hover = _off_hover;
				color_clicked = _off_hover;
				}
			break;
		case "Green Screen":
			if (ui_clicked)
				{
				if (setting().green_screen_color > 0) then setting().green_screen_color = 0;
				else setting().green_screen_color = 1;
				}
			if (setting().green_screen_color > 0)
				{
				text = "ON";
				color_normal = _on_normal;
				color_hover = _on_hover;
				color_clicked = _on_hover;
				}
			else
				{
				text = "OFF";
				color_normal = _off_normal;
				color_hover = _off_hover;
				color_clicked = _off_hover;
				}
			break;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */