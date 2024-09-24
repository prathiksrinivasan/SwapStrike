///@description
if (engine().online_is_leader)
	{
	var _cursor = 0;
	var _frame = ui_cursor_held_time(_cursor) > 0 ? 1 : 0;
	draw_sprite_ext(spr_menu_cursor, _frame, ui_cursor_x(_cursor), ui_cursor_y(_cursor), 1, 1, 0, c_white, 1);
	}
else
	{
	draw_set_font(fnt_consolas);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(room_width div 2, room_height div 2, "The leader is picking a stage...");
	}
/* Copyright 2024 Springroll Games / Yosi */