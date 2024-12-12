///@description
//MIS
mis_init();

//Background animation
menu_background_color_set($7FB252);

//Universal Cursor
ui_cursor_add(0, room_width div 2, room_height div 2);

//Important instances (you can get instance names from the room editor!)
stage_name_label = inst_11F30612;
stage_preview_image = inst_785D2540;

setting().match_stage = stage_choose_random();
game_begin(rm_css, false, false);

/* Copyright 2024 Springroll Games / Yosi */