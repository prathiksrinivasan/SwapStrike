///@description Draw the chat & presets
if (display_chat)
	{
	//Surface
	if (!surface_exists(chat_surface))
		{
		chat_surface = surface_create(room_width, room_height);
		redraw = true;
		}

	if (redraw || obj_ggmr_chat.chat_was_updated)
		{
		redraw = false;
		surface_set_target(chat_surface);
		draw_clear_alpha(c_black, 0.6);
		
		//Divider
		var _h = 32;
		var _v = 24;
		draw_set_color(c_white);
		draw_line_width
			(
			round(room_width div 2),
			round((room_height div 2) + (((online_chat_messages_stored / 2) * _v) - (_v / 2))),
			round(room_width div 2),
			round((room_height div 2) - (((online_chat_messages_stored / 2) * _v) - (_v / 2))),
			2,
			);
		
		//Chat messages
		var _history = ggmr_chat_history();
		var _length = array_length(_history);
		var _x = round((room_width div 2) + _h);
		var _y = round((room_height div 2) + (((online_chat_messages_stored / 2) * _v) - (_v / 2)));
		draw_set_font(fnt_consolas_larger);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(c_white);
		for (var i = _length - 1; i >= 0; i--)
			{
			var _entry = _history[@ i];
			var _string = to_string(_entry.name, "   ", _entry.message);
			draw_text(_x, _y, _string);
			_y -= _v;
			}
			
		//Preset messages
		var _presets = obj_ggmr_chat.chat_preset_messages;
		var _length = array_length(_presets);
		var _x = round((room_width div 2) - _h);
		var _y = round((room_height div 2) - (((_length / 2) * _v) - (_v / 2)));
		var _pad = 11;
		var _w = 300;
		var _c = c_white;
		draw_set_halign(fa_right);
		for (var i = 0; i < _length; i++)
			{
			//Drawing text
			if (is_undefined(presets_text))
				{
				var _text = online_chat_preset_script(_presets[@ i]);
				if (current_preset == i)
					{
					draw_rectangle_color(_x + _pad, _y - _pad, _x - _w, _y + _pad, _c, _c, _c, _c, false);
					draw_set_color(c_black);
					draw_text(_x, _y, _text);
					}
				else
					{
					draw_set_color(c_white);
					draw_text(_x, _y, _text);
					}
				}
			//Drawing text + sprites
			else
				{
				var _text = presets_text[@ i];
				if (current_preset == i)
					{
					draw_rectangle_color(_x + _pad, _y - _pad, _x - _w, _y + _pad, _c, _c, _c, _c, false);
					draw_set_color(c_black);
					draw_text_and_sprites(_x, _y, _text, 4, true);
					}
				else
					{
					draw_set_color(c_white);
					draw_text_and_sprites(_x, _y, _text, 4, true);
					}
				}
			_y += _v;
			}
		
		surface_reset_target();
		}
	
	//Draw the surface
	draw_surface(chat_surface, 0, 0);
	}
/* Copyright 2024 Springroll Games / Yosi */