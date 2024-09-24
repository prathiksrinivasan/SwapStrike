if (state == PRIVATE_LOBBY_STATE.match_settings)
	{
	draw_set_valign(fa_middle);
	draw_set_font(fnt_consolas);
	draw_set_color(c_white);
	draw_set_alpha(1);
	
	//Draw all choices
	var _accent = $3E3ED5;
	var _c = c_white;
	var _x = room_width div 2;
	var _y = match_settings_y + 48;
	var _pad = 24;
	
	for (var i = 0; i < array_length(match_settings_choices); i++)
		{
		//Current choice
		if (i == match_settings_current)
			{
			draw_set_color(c_dkgray);
			_c = c_dkgray;
			draw_rectangle_color(_x - 160, _y + (-12), _x + 160 + (-1), _y + 12, _accent, _accent, _accent, _accent, false);
			draw_sprite_ext(spr_icon_arrows, 0, _x + 50, _y, 1, 1, 0, _c, 1);
			draw_sprite_ext(spr_icon_arrows, 1, _x + 110, _y, 1, 1, 0, _c, 1);
			}
		else
			{
			draw_set_color(c_white);
			_c = c_white;
			}
			
		//Draw the choice name
		draw_set_halign(fa_left);
		var _choice = match_settings_choices[@ i];
		draw_text(_x - 94, _y, _choice);
		
		//Choice value
		draw_set_halign(fa_center);
		switch (_choice)
			{
			case "Stock":
				if (setting().match_stock == 0)
					{
					draw_sprite_ext(spr_icon_infinite, 0, _x + 80, _y, 1, 1, 0, _c, 1);
					}
				else
					{
					draw_text(_x + 80, _y, setting().match_stock);
					}
				draw_sprite_ext(spr_icon_stock, 0, _x - 124, _y, 1, 1, 0, _c, 1);
				break;
			case "Time":
				if (setting().match_time == 0)
					{
					draw_sprite_ext(spr_icon_infinite, 0, _x + 80, _y, 1, 1, 0, _c, 1);
					}
				else
					{
					draw_text(_x + 80, _y, setting().match_time);
					}
				draw_sprite_ext(spr_icon_time, 0, _x - 124, _y, 1, 1, 0, _c, 1);
				break;
			case "Stamina":
				draw_text(_x + 80, _y, setting().match_stamina != 0 ? setting().match_stamina : "OFF");
				draw_sprite_ext(spr_icon_stamina, 0, _x - 124, _y, 1, 1, 0, _c, 1);
				break;
			case "Teams":
				draw_text(_x + 80, _y, setting().match_team_mode ? "ON" : "OFF");
				draw_sprite_ext(spr_icon_teams, 0, _x - 124, _y, 1, 1, 0, _c, 1);
				break;
			case "Team Attack":
				draw_text(_x + 80, _y, setting().match_team_attack ? "ON" : "OFF");
				draw_sprite_ext(spr_icon_team_attack, 0, _x - 124, _y, 1, 1, 0, _c, 1);
				break;
			case "Items":
				draw_text(_x + 80, _y, setting().match_items_enable ? string(setting().match_items_frequency) + "%" : "OFF");
				draw_sprite_ext(spr_icon_items, 0, _x - 124, _y, 1, 1, 0, _c, 1);
				break;
			case "Final Smash Meter":
				draw_text(_x + 80, _y, setting().match_fs_meter ? "ON" : "OFF");
				draw_sprite_ext(spr_icon_fs_meter, 0, _x - 124, _y, 1, 1, 0, _c, 1);
				break;
			case "Screen Wrap":
				draw_text(_x + 80, _y, setting().match_screen_wrap ? "ON" : "OFF");
				draw_sprite_ext(spr_icon_screen_wrap, 0, _x - 124, _y, 1, 1, 0, _c, 1);
				break;
			case "EX Meter":
				draw_text(_x + 80, _y, setting().match_ex_meter ? "ON" : "OFF");
				draw_sprite_ext(spr_icon_ex_meter, 0, _x - 124, _y, 1, 1, 0, _c, 1);
				break;
			default: crash("[obj_private_lobby_ui: Draw End] Unrecognized match settings choice (", _choice, ")"); break;
			}
			
		_y += _pad;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */