function ui_button_draw()
	{
	//Outline
	if (outline)
		{
		draw_set_color(c_white);
		draw_set_alpha(outline_alpha);
		draw_rectangle(bbox_left - 4, bbox_top - 4, (bbox_right - 1) + 4, (bbox_bottom - 1) + 4, false);
		draw_set_alpha(1);
		}
	
	//Button
	draw_sprite_ext(spr_ui_button, 0, x, y, sprite_width / 32, sprite_height / 32, image_angle, image_blend, image_alpha);

	//Text
	if (text != "")
		{
		draw_set_halign(fa_center);
		if (font != -1) then draw_set_font(font);
		else draw_set_font(fnt_consolas);
		draw_text(x + (sprite_width / 2), y + (sprite_height / 2), text);
		draw_set_font(fnt_consolas);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */