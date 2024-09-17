///@description
//States
var _percent = (state_timer / state_timer_max);

//Winner
var _winner = engine().win_screen_order[@ win_screen_last_index];
var _character = _winner[@ WIN_SCREEN_DATA.character];
var _color = _winner[@ WIN_SCREEN_DATA.color];
var _palette_base = character_data_get(_character, CHARACTER_DATA.palette_column_arrays)[@ 0];
var _palette_swap = character_data_get(_character, CHARACTER_DATA.palette_column_arrays)[@ _color];
var _render = character_data_get(_character, CHARACTER_DATA.win_render);
var _value = (state_phase == 0 ? _percent : 0);

//Alpha
draw_set_alpha(1 - _value);

//Large player render
var _scale = win_screen_winner_render_scale;
if (!setting().disable_shaders)
	{
	palette_shader_simple_set(_palette_base, _palette_swap);
	draw_sprite_ext(_render, 0, (_value * -100) + (screen_width / 1.5), (screen_height / 2) - 20, _scale, _scale, 0, c_white, 1);
	shader_reset();
	}
else
	{
	var _blend = palette_color_get(character_data_get(_character, CHARACTER_DATA.palette_data), 0, _color);
	draw_sprite_ext(_render, 0, (_value * -100) + (screen_width / 1.5), (screen_height / 2) - 20, _scale, _scale, 0, _blend, 1);
	}

//Text Transformations
if (!setting().disable_shaders) then shader_set(shd_win_screen_text);

//Large character name
draw_set_font(fnt_win);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(50 + (_value * 100), (screen_height / 3) - 60, win_name);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(55 + (_value * 100), (screen_height / 3) - 64, win_name);

//Large player name
if (state_phase >= 1)
	{
	var _player_name = _winner[@ WIN_SCREEN_DATA.player_name];
	var _value = (state_phase == 1 ? _percent : 0);
	draw_set_alpha(1 - _value);
	draw_set_font(fnt_win_subtitle);
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(120 + (_value * 100), (screen_height / 3) + 60, _player_name);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(123 + (_value * 100), (screen_height / 3) + 58, _player_name);
	}

shader_reset();

//Reset
draw_set_alpha(1);

//Data
if (state_phase >= 2)
	{
	var _m = replay_metadata;
	
	assert(!is_undefined(_m) && is_struct(_m), "[obj_win_screen: Draw GUI] The replay_metadata is not a valid value (", replay_metadata, ")");
	
	//Drawing the background fade
	var _value = (state_phase == 2 ? _percent : 0);
	draw_set_alpha((1 - _value) * 0.9);
	draw_rectangle_color(0, 0, screen_width, screen_height, c_black, c_black, c_black, c_black, false);
	
	//Variables
	var _x = screen_width - 80;
	var _y = 172 + 48;
	
	//Stage
	_x -= 88;
	var _sprite = stage_data_get(_m[$ "match_stage"], STAGE_DATA.sprite);
	var _frame = stage_data_get(_m[$ "match_stage"], STAGE_DATA.frame);
	if (_sprite != -1)
		{
		draw_sprite_ext(_sprite, _frame, _x, _y, 1, 1, 0, c_white, 1);
		}
	_x -= 88;
	
	//Variables
	var _center = _x - 128 - 16;
	var _left = _center - 64;
	var _right = _center + 64;
	_y = 172;
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_set_valign(fa_top);
	
	//Replay Length
	draw_set_font(fnt_consolas);
	draw_set_halign(fa_left);
	draw_text(_left, _y, "Length");
	draw_set_halign(fa_right);
	var _game_frames = _m[$ "replay_total_frames"] - (countdown_start_time * 3);
	var _total_seconds = _game_frames / 60;
	var _minutes = _total_seconds div 60;
	var _seconds = floor(_total_seconds mod 60);
	draw_text(_right, _y, string(_minutes) + ":" + string_replace(string_format(_seconds, 2, 0), " ", "0"));
	
	//Match Settings
	_y += 24;
	draw_sprite(spr_icon_stock, 0, _left + 8, _y + 8);
	draw_text(_right, _y, _m[$ "match_stock"] != 0 ? _m[$ "match_stock"] : "---");
	_y += 16;
	draw_sprite(spr_icon_time, 0, _left + 8, _y + 8);
	draw_text(_right, _y, _m[$ "match_time"] != 0 ? _m[$ "match_time"] : "---");
	_y += 16;
	draw_sprite(spr_icon_stamina, 0, _left + 8, _y + 8);
	draw_text(_right, _y, _m[$ "match_stamina"] != 0 ? _m[$ "match_stamina"] : "---");
	_y += 16;
	draw_sprite(spr_icon_items, 0, _left + 8, _y + 8);
	draw_text(_right, _y, _m[$ "match_items_enable"] ? string(_m[$ "match_items_frequency"]) + "%" : "OFF");
	_y += 16;
	var _x = _left + 8;
	if (_m[$ "match_screen_wrap"])
		{
		draw_sprite(spr_icon_screen_wrap, 0, _x, _y + 8);
		_x += 24;
		}
	if (_m[$ "match_ex_meter"])
		{
		draw_sprite(spr_icon_ex_meter, 0, _x, _y + 8);
		_x += 24;
		}
	if (_m[$ "match_fs_meter"])
		{
		draw_sprite(spr_icon_fs_meter, 0, _x, _y + 8);
		_x += 24;
		}
	
	//Replay KO data
	var _x = _left;
	var _y = 328;
	var _w = 376;
	var _h = 8;
	var _pad = 2;
	var _kos = array_length(_m.replay_player_ko_frames);
	draw_set_color(c_white);
	draw_rectangle(_x, _y, _x + _w, _y + _h, false);
	
	for (var i = 0; i < _kos; i++)
		{
		var _data = _m.replay_player_ko_frames[@ i];
		var _p = (_data.frame / _m.replay_total_frames);
		var _palette_column_arrays = character_data_get(_data.character, CHARACTER_DATA.palette_column_arrays);
		palette_shader_simple_set(_palette_column_arrays[@ 0], _palette_column_arrays[@ _data.color]);
		draw_sprite_ext(character_data_get(_data.character, CHARACTER_DATA.stock_sprite), 0, _x + (_w * _p), _y - (_pad * _data.number), 2, 2, 0, c_white, 1);
		shader_reset();
		}
	
	//Variables
	var _x = 80;
	var _y = 172 + 16;
	
	//Replay name
	draw_set_font(fnt_window);
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(_x, _y, replay_name);
	
	draw_set_font(fnt_consolas);
		
	//Replay renaming prompt
	var _text = [];
	if (can_save_replay)
		{
		_text = 
			[
			"Press ",
			[spr_icon_input_button_universal, gamepad_button_number(menu_select_button)],
			" / ",
			key_to_string(menu_select_key, true),
			" to Rename",
			];
		}
	else
		{
		_text = ["Replay Saved!"];
		}
	draw_text_and_sprites(_x, _y + 48, _text);
		
	//Replay saving prompt
	if (state_phase > 0 && can_save_replay)
		{
		var _text = 
			[
			"Press ",
			[spr_icon_input_button_universal, gamepad_button_number(menu_option_button)],
			" / ",
			key_to_string(menu_option_key, true),
			" to Save",
			];
		draw_text_and_sprites(_x, _y + 72, _text);
		}
	
	draw_set_alpha(1);
	}

//All players
if (state_phase >= 1)
	{
	var _value = (state_phase == 1 ? _percent : 0);
	draw_set_alpha(1 - _value);
	draw_set_font(fnt_podium);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	//Screen width divided by the number of players in the match
	var _spacing = screen_width / (win_screen_last_index + 2);
	var _vspace = (32 / max_players);
		
	for (var i = win_screen_last_index; i >= 0; i--)
		{
		var _place = (win_screen_last_index - i);
		var _x = (_spacing * _place) + _spacing;
		var _y = lerp(screen_height - 96, screen_height, _value) + (_vspace * _place);
		var _player = engine().win_screen_order[@ i];
		var _character = _player[@ WIN_SCREEN_DATA.character];
		var _color = _player[@ WIN_SCREEN_DATA.color];
		var _palette_base = character_data_get(_character, CHARACTER_DATA.palette_column_arrays)[@ 0];
		var _palette_swap = character_data_get(_character, CHARACTER_DATA.palette_column_arrays)[@ _color];
		var _portrait = character_data_get(_character, CHARACTER_DATA.hud_portrait);
		var _name = _player[@ WIN_SCREEN_DATA.player_name];

		//Podiums
		if (setting().match_team_mode)
			{
			var _team = _player[@ WIN_SCREEN_DATA.team];
			draw_sprite_ext(spr_win_screen_podium, 4, _x, _y, 2, 2, 0, player_color_get(_team), 1);
			}
		else
			{
			draw_sprite_ext(spr_win_screen_podium, min(_place, 3), _x, _y, 2, 2, 0, c_white, 1);
			}
	
		//Player portrait outline
		var _scale = win_screen_losers_portrait_scale;
		draw_sprite_ext(_portrait, 0, _x + 2, _y, _scale, _scale, 0, c_black, 1);
		draw_sprite_ext(_portrait, 0, _x - 2, _y, _scale, _scale, 0, c_black, 1);
		draw_sprite_ext(_portrait, 0, _x, _y + 2, _scale, _scale, 0, c_black, 1);
		draw_sprite_ext(_portrait, 0, _x, _y - 2, _scale, _scale, 0, c_black, 1);
		
		if (!setting().disable_shaders)
			{
			palette_shader_simple_set(_palette_base, _palette_swap);
			draw_sprite_ext(_portrait, 0, _x, _y, _scale, _scale, 0, c_white, 1);
			shader_reset();
			}
		else
			{
			var _blend = palette_color_get(character_data_get(_character, CHARACTER_DATA.palette_data), 0, _color);
			draw_sprite_ext(_portrait, 0, _x, _y, _scale, _scale, 0, _blend, 1);
			}
			
		//Name
		draw_text_outline(_x, _y + 52, _name, c_black, c_white);
		}
		
	draw_set_alpha(1);
	}

//Continue prompt
if ((state_phase == 0 && state_timer == 0) || state_phase >= 1)
	{
	draw_set_font(fnt_podium);
	draw_set_color(c_white);
	draw_text_and_sprites
		(
		screen_width - 24,
		24,
			[
			"Press ",
			[spr_icon_input_button_universal, gamepad_button_number(menu_confirm_button)],
			" or ",
			key_to_string(menu_confirm_key, true),
			" to continue...",
			],
		0,
		true,
		);
	}

/* Copyright 2024 Springroll Games / Yosi */