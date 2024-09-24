///@description
//Token
draw_sprite_ext(spr_css_token, 0, round(token.x), round(token.y), 1, 1, 0, c_white, 1);

//Cursor
var _cursor = 0;
var _frame = ui_cursor_held_time(_cursor) > 0 ? 1 : 0;
draw_sprite_ext(spr_menu_cursor, _frame, ui_cursor_x(_cursor), ui_cursor_y(_cursor), 1, 1, 0, c_white, 1);
/* Copyright 2024 Springroll Games / Yosi */