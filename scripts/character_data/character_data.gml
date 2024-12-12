///@category Characters
/*
This script defines the data used for each character, including the character's init script, palette, portrait, texture page, etc.
*/
function character_data_get_all()
	{
	static _data =
		[
		character_define
			(
			"TestCharacter",
			character_test_init,
			spr_wizard_palette,
			spr_wiz_css,
			spr_wiz_css,
			spr_blocky_portrait,
			spr_blocky_stock,
			spr_wiz_win,
			song_default_victory,
			["wizard", "texture_character_basic"],
			blocky_cpu_script,
			),
		character_define
			(
			"Blocky",
			character_blocky_init,
			spr_blocky_palette,
			spr_blocky_css,
			spr_blocky_css,
			spr_blocky_portrait,
			spr_blocky_stock,
			spr_blocky_render,
			song_default_victory,
			["texture_character_blocky", "texture_character_basic"],
			blocky_cpu_script,
			),
		character_define
			(
			"Polygon",
			character_poly_init,
			spr_poly_palette,
			spr_poly_css,
			spr_poly_css,
			spr_poly_portrait,
			spr_poly_stock,
			spr_poly_render,
			song_default_victory,
			["texture_character_poly", "texture_character_basic"],
			poly_cpu_script,
			),
		character_define
			(
			"Vertex",
			character_vert_init,
			spr_vert_palette,
			spr_vert_css,
			spr_vert_css,
			spr_vert_portrait,
			spr_vert_stock,
			spr_vert_render,
			song_default_victory,
			["texture_character_vert", "texture_character_basic"],
			vert_cpu_script,
			),
		character_define
			(
			"Scalar",
			character_scalar_init,
			spr_scalar_palette,
			spr_scalar_css,
			spr_scalar_css,
			spr_scalar_portrait,
			spr_scalar_stock,
			spr_scalar_render,
			song_default_victory,
			["texture_character_scalar"],
			),
		character_define
			(
			"Radian",
			character_rad_init,
			spr_rad_palette,
			spr_rad_css,
			spr_rad_css,
			spr_rad_portrait,
			spr_rad_stock,
			spr_rad_render,
			song_default_victory,
			["texture_character_rad", "texture_character_basic"],
			rad_cpu_script,
			),
		character_define
			(
			"Random",
			-1,
			spr_palette_random,
			spr_css_random,
			spr_css_random,
			spr_css_random,
			spr_css_random,
			spr_css_random,
			song_default_victory,
			undefined,
			),
		];
	return _data;
	}
/* Copyright 2024 Springroll Games / Yosi */