///@description Draw Foregrounds
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//Local vars
	var _shader = false;
	var _w = obj_game.cam_w;
	var _h = obj_game.cam_h;
	var _cam_center_x = obj_game.cam_x + (_w / 2);
	var _cam_center_y = obj_game.cam_y + (_h / 2);
	var _cam_dist_x = (obj_stage_manager.half_room_width - obj_game.cam_x - (_w / 2));
	var _cam_dist_y = (obj_stage_manager.half_room_height- obj_game.cam_y - (_h / 2));

	//Loop through the layers of the foreground and draw each
	for (var i = 0; i < array_length(obj_stage_manager.foreground); i++)
		{
		var _layer = obj_stage_manager.foreground[@ i];
	
		//Fade layers
		if (obj_stage_manager.background_clear_amount != 0 && !_shader && !setting().disable_shaders)
			{
			_shader = true;
			shader_set(shd_fade);
			shader_set_uniform_f(obj_stage_manager.uni_black, 1 - obj_stage_manager.background_clear_amount);
			}
		
		//If it has a special script, use that instead
		var _abs = _layer[@ BACK.absolute];
		var _draw_x = _abs ? 0 : _cam_center_x;
		var _draw_y = _abs ? 0 : _cam_center_y;
		if (_layer[@ BACK.script] != -1 && script_exists(_layer[@ BACK.script]))
			{
			script_execute(_layer[@ BACK.script], _layer, _draw_x, _draw_y, _cam_dist_x, _cam_dist_y);
			}
		else
			{
			//Draw according to properties
			draw_sprite_ext
				(
				_layer[@ BACK.sprite],
				_layer[@ BACK.frame],
				round(_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x])),
				round(_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y])),
				_layer[@ BACK.scale],
				_layer[@ BACK.scale],
				0,
				c_white,
				1
				);
			}
		}
	
	//Reset shader
	shader_reset();
		
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2024 Springroll Games / Yosi */