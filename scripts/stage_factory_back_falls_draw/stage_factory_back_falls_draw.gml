function stage_factory_back_falls_draw()
	{
	var _layer = argument[0];
	var _draw_x = argument[1];
	var _draw_y = argument[2];
	var _cam_dist_x = argument[3];
	var _cam_dist_y = argument[4];
	
	//Draw it with a shader applied
	var _sprite = _layer[@ BACK.sprite];
	var _sprite_tex = sprite_get_texture(_sprite, 0);
	var _sprite_tw = texture_get_texel_width(_sprite_tex);
	var _sprite_th = texture_get_texel_height(_sprite_tex);
	with (obj_stage_factory_filter)
		{
		if (!setting().performance_mode && !setting().disable_shaders)
			{
			shader_set(shd_stage_factory_lava);
			texture_set_stage(samp, lava_tex);
			shader_set_uniform_f(uni_t, lava_tw, lava_th);
			shader_set_uniform_f(uni_b, _sprite_tw, _sprite_th);
			shader_set_uniform_f(uni_i, time);
			shader_set_uniform_f(uni_f, background_get_clear_amount() * 0.5);
			}
		
		draw_sprite_ext
			(
			_sprite,
			_layer[BACK.frame],
			_draw_x + _layer[BACK.x] + (_cam_dist_x * _layer[BACK.parallax_x]),
			_draw_y + _layer[BACK.y] + (_cam_dist_y * _layer[BACK.parallax_y]),
			_layer[BACK.scale],
			_layer[BACK.scale],
			0,
			c_white,
			1
			);
		
		shader_reset();
				
		//Scrolling texture
		with (obj_stage_factory_falls)
			{
			var _w = sprite_width;
			var _h = sprite_height;
			if (!surface_exists(surf))
				{
				surf = surface_create(_w, _h);
				}

			surface_set_target(surf);

			var _time = obj_game.current_frame;
			draw_clear_alpha(c_white, 0);
			draw_sprite_ext(sprite_index, 0, 0, ((_time * 0.5) % _h), image_xscale, image_yscale, 0, c_white, 1);
			draw_sprite_ext(sprite_index, 0, 0, ((_time * 0.5) % _h) - _h, image_xscale, image_yscale, 0, c_white, 1);
			draw_sprite_ext(sprite_index, 1, 0, ((_time * 1) % _h), image_xscale, image_yscale, 0, c_white, 1);
			draw_sprite_ext(sprite_index, 1, 0, ((_time * 1) % _h) - _h, image_xscale, image_yscale, 0, c_white, 1);
			draw_sprite_ext(sprite_index, 2, 0, ((_time * 2) % _h), image_xscale, image_yscale, 0, c_white, 1);
			draw_sprite_ext(sprite_index, 2, 0, ((_time * 2) % _h) - _h, image_xscale, image_yscale, 0, c_white, 1);

			surface_reset_target();
			
			if (!setting().performance_mode && !setting().disable_shaders)
				{
				var _surf_tex = surface_get_texture(obj_stage_factory_falls.surf);
				var _surf_tw = texture_get_texel_width(_surf_tex);
				var _surf_th = texture_get_texel_height(_surf_tex);
			
				shader_set(shd_stage_factory_lava);
				texture_set_stage(other.samp, other.lava_tex);
				shader_set_uniform_f(other.uni_t, other.lava_tw, other.lava_th);
				shader_set_uniform_f(other.uni_b, _surf_tw, _surf_th);
				shader_set_uniform_f(other.uni_i, other.time);
				shader_set_uniform_f(other.uni_f, background_get_clear_amount() * 0.5);
				}
			
			draw_surface
				(
				surf,
				_draw_x + _layer[BACK.x] + (_cam_dist_x * _layer[BACK.parallax_x]) - 396,
				_draw_y + _layer[BACK.y] + (_cam_dist_y * _layer[BACK.parallax_y]) - 172,
				);
			draw_surface
				(
				surf,
				_draw_x + _layer[BACK.x] + (_cam_dist_x * _layer[BACK.parallax_x]) + 294,
				_draw_y + _layer[BACK.y] + (_cam_dist_y * _layer[BACK.parallax_y]) - 172,
				);
			
			shader_reset();
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */