///@description

//Menu Input System
mis_init();
mis_auto_connect_enable(true);

//Background animation
menu_background_color_set($E24AB5);

//Scan replay files
replays_ui_scan();

replay_current = 0;
replay_scroll = 0;
replay_delete = false;

active = true;
/* Copyright 2024 Springroll Games / Yosi */