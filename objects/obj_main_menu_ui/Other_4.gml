///@description

//Offline
engine().is_online = false;
ggmr_destroy_all();

//News / Annoucements
if (!engine().main_menu_fetched_news && !web_export)
	{
	engine().main_menu_fetched_news = true;
	
	//Go online
	engine().is_online = true;
	engine().online_mode = ONLINE_MODE.none;
	ggmr_net_init();
	var _b = buffer_create(1, buffer_grow, 1);
	server_send_packet(obj_ggmr_net.net_socket, _b, "fetch_news", version_string);
	buffer_delete(_b);
	
	log("Requested news from the server");
	}

//Menu Input System
mis_init();
mis_auto_connect_enable(true);
mis_device_disconnect_all();
mis_device_connect_callback_set
	(
	function(_device_id) 
		{
		//Add the UI cursor
		ui_cursor_add(mis_devices_count() - 1, room_width div 2, room_height div 2);
		}
	);
	
//Clean profiles
profile_clean_auto();

/* Copyright 2024 Springroll Games / Yosi */