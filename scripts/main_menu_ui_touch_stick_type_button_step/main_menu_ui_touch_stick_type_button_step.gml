function main_menu_ui_touch_stick_type_button_step()
	{
	ui_button_step();
	
	if (ui_clicked)
		{
		menu_sound_play(snd_menu_alert);
		if (engine().touch_stick_type == TOUCH_STICK_TYPE.absolute)
			{
			engine().touch_stick_type = TOUCH_STICK_TYPE.relative;
			}
		else
			{
			engine().touch_stick_type = TOUCH_STICK_TYPE.absolute;
			}
		}
	
	//Mouse support
	if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom))
		{
		image_blend = color_hover;
		if (mouse_check_button_pressed(mb_left))
			{
			image_blend = color_clicked;
			menu_sound_play(snd_menu_alert);
			if (engine().touch_stick_type == TOUCH_STICK_TYPE.absolute)
				{
				engine().touch_stick_type = TOUCH_STICK_TYPE.relative;
				}
			else
				{
				engine().touch_stick_type = TOUCH_STICK_TYPE.absolute;
				}
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */