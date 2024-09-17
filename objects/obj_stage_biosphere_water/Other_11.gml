var _w = sprite_width;
var _h = sprite_height;
if (!surface_exists(surf))
	{
	surf = surface_create(_w, _h);
	}

surface_set_target(surf);

var _time = obj_game.current_frame * time_scale;
draw_sprite_ext(sprite_index, 0, 0, ((_time * 2) % _h), image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 0, 0, ((_time * 2) % _h) - _h, image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 1, 0, ((_time * 5) % _h), image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 1, 0, ((_time * 5) % _h) - _h, image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 2, 0, ((_time * 7) % _h), image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 2, 0, ((_time * 7) % _h) - _h, image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 3, 0, ((_time * 9) % _h), image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 3, 0, ((_time * 9) % _h) - _h, image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 4, 0, ((_time * 6) % _h), image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 4, 0, ((_time * 6) % _h) - _h, image_xscale, image_yscale, 0, c_white, 1);

surface_reset_target();

draw_surface(surf, x, y);
/* Copyright 2024 Springroll Games / Yosi */