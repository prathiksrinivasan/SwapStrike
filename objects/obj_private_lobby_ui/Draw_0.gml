///@description

//Cursor
if (obj_ggmr_lobby.lobby_state != GGMR_LOBBY_STATE.joining && connect_code_state == "normal")
	{
	var _cursor = 0;
	var _frame = ui_cursor_held_time(_cursor) > 0 ? 1 : 0;
	draw_sprite_ext(spr_menu_cursor, _frame, ui_cursor_x(_cursor), ui_cursor_y(_cursor), 1, 1, 0, c_white, 1);
	}

//Join Requests
var _list = obj_ggmr_lobby.lobby_join_requests;
var _length = ds_list_size(_list);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(fnt_consolas);
draw_set_color(c_white);
draw_set_alpha(1);
for (var i = 0; i < min(join_request_list_display_size, _length); i++)
	{
	var _request = (i + join_request_scroll);
	if (join_request_current == _request)
		{
		var _c = $7FB252;
		draw_rectangle_color(join_request_list_x, 68 + (24 * i), room_width, 92 + (24 * i), _c, _c, _c, _c, false);
		}
	draw_text(join_request_list_x + 8, 80 + (24 * i), string(_request + 1) + ": " + _list[| _request][@ GGMR_LOBBY_JOIN_REQUEST.name]);
	}
		
//Scroll bar
var _c = $444444;
draw_rectangle_color(join_request_list_x + 336, 64, join_request_list_x + 352, 527, _c, _c, _c, _c, false);
var _c = $666666;
var _percent = (join_request_scroll / min(_length - join_request_list_display_size, _length));
var _bar_y = 64 + 16 + (432 * _percent);
draw_rectangle_color(join_request_list_x + 336, _bar_y - 16, join_request_list_x + 352, _bar_y + 15, _c, _c, _c, _c, false);
	
//Lobby Joining
if (obj_ggmr_lobby.lobby_state == GGMR_LOBBY_STATE.joining)
	{
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(room_width div 2, room_height div 2, "Joining Lobby...");
	}
	
//Connect codes
if (connect_code_state != "normal")
	{
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(room_width div 2, room_height div 2, connect_code_message);
	}
/* Copyright 2024 Springroll Games / Yosi */