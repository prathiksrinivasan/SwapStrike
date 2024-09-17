function ui_label_draw()
	{
	if (text != "")
		{
		if (font != -1) then draw_set_font(font);
		else draw_set_font(fnt_consolas);
		var _col = draw_get_color();
		draw_set_color(image_blend);
		draw_set_alpha(1);
		draw_set_valign(fa_middle);
		switch (halign)
			{
			case 0: 
				draw_set_halign(fa_center);
				if (wrap_text)
					{
					draw_text_ext(x + (sprite_width / 2), y + (sprite_height / 2), text, string_height(text), sprite_width);
					}
				else
					{
					draw_text(x + (sprite_width / 2), y + (sprite_height / 2), text);
					}
				break;
			case 1: 
				draw_set_halign(fa_right);
				if (wrap_text)
					{
					draw_text_ext(x + sprite_width, y + (sprite_height / 2), text, string_height(text), sprite_width);
					}
				else
					{
					draw_text(x + sprite_width, y + (sprite_height / 2), text);
					}
				break;
			case -1: 
				draw_set_halign(fa_left);
				if (wrap_text)
					{
					draw_text_ext(x, y + (sprite_height / 2), text, string_height(text), sprite_width);
					}
				else
					{
					draw_text(x, y + (sprite_height / 2), text);
					}
				break;
			default: crash("[ui_label_draw] Invalid halign (", halign, ")"); break;
			}
		draw_set_halign(fa_center);
		draw_set_color(_col);
		draw_set_font(fnt_consolas);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */