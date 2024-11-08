// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function start_debug_game(){
	//Set to offline mode
	engine().is_online = false;
	ggmr_destroy_all();
	
	mis_init();
	mis_auto_connect_enable(true);
	mis_device_connect(MIS_DEVICE_TYPE.keyboard, 0)
	var _device = mis_devices_get_array()[0];
	
	player_data_clear();
	//Add player
	player_data_create
	(
		0,
		0,
		_device,
		mis_device_convert_to_game_device(mis_device_get(_device,MIS_DEVICE_PROPERTY.device_type)),
		profile_create
		(
			"TEST",
			custom_controls_create(),
			true,
		),
		false,
		false,
		CPU_TYPE.attack,
		0
	);
	//Add dummy
	player_data_create
	(
		0,
		1,
		-1,
		DEVICE.none,
		profile_create
		(
			"DUMMY",
			custom_controls_create(),
			true,
		),
		false,
		true,
		CPU_TYPE.idle,
		1
	);
	
	//Set Stage
	setting().match_stage = rm_stage_clouds;
	//Debug and Match Settings
	setting().debug_mode_enable = true;
	setting().show_hurtboxes = true;
	setting().show_hitboxes = false;
	setting().match_stock = 0;
	setting().match_stamina = 999;
	setting().match_time = 0;
	
	//Start game
	game_begin(rm_css, false, false);
	
	
	
}