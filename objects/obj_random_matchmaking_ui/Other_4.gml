///@description

//Online
engine().is_online = true;
engine().online_mode = ONLINE_MODE.quickplay;
engine().private_lobby_resume = false;
ggmr_net_init();

//Menu Input System
mis_init();
mis_device_disconnect_all();
mis_auto_connect_enable(true);

//Background animation
menu_background_color_set($FFAC30);

active = true;

timer = 0
time_since_last_packet = 0;
fail_timeout = 6 * 60; //Switch to the "Failed" state if no packets are received from the server for 6 seconds.

state = RANDOM_MATCHMAKING_STATE.idle;
state_frame = 0;
state_message = "";

match_id = undefined;
holepunching_ip = undefined;
holepunching_port = undefined;

progress = -1;

packet = buffer_create(1, buffer_grow, 1);

/* Copyright 2024 Springroll Games / Yosi */