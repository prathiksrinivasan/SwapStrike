///@category Stages
/*
This object controls most things related to stages during gameplay.
This includes parallax background layers, layer fading, music looping, the day/night cycle, etc.
Foreground layers are drawn by <obj_stage_foreground>.
*/
///@description Stage Features
only_one();

//Instance variable defaults
background = [back_clear];
foreground = [];
callback_stage_passive = [];
stage_tint = [0.0, 0.0, 0.0];
music = -1;
music_intro_pos = 0;
music_loop_pos = 0;
custom_stage_struct = {};
custom_ids_struct = {};
half_room_width = room_width / 2;
half_room_height = room_height / 2;
stage_particle_types = {};

//Stage settings
setting().daynight_cycle_enable = false;
setting().stage_background_color = c_white;
setting().slope_collisions_enable = true;
setting().background_is_static = false;
setting().screen_shader_script = -1;

//Music
audio_stop_all();

//Blastzones
blastzones = 
	{
	left : 0, 
	top : 0, 
	right : room_width, 
	bottom : room_height,
	};

//CPU Values
cpu_up_b_distance = 400;
cpu_main_stage_distance = 200;

//Special Effects
background_clear_frame = 0;
background_clear_amount = 0;
background_clear_fade_speed = 1;
background_clear_color = c_white;
background_clear_direction = 90;

uni_black = shader_get_uniform(shd_fade, "fade_amount");

background_fog_color = c_black;
background_fog_alpha = 0;

//Layer fade for all layers that start with "Asset"
var _lay = layer_get_all();
for (var i = 0; i < array_length(_lay); i++)
	{
	if (string_count("Asset", layer_get_name(_lay[@ i])) > 0)
		{
		layer_script_begin(_lay[@ i], layer_fade_begin);
		layer_script_end(_lay[@ i], layer_fade_end);
		}
	}

//Stage init script
var _script = stage_data_get(room, STAGE_DATA.script);
if (_script != -1 && script_exists(_script))
	{
	script_execute(_script);
	}
else
	{
	log("[obj_stage_manager] The current stage (", room_get_name(room), ") does not have a stage init script in stage_data.");
	}

/* Copyright 2024 Springroll Games / Yosi */