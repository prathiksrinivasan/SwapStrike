//Background
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, screen_width, screen_height, false);
draw_set_alpha(1);

draw_set_font(fnt_consolas);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

var _w = 256;
var _pad = 16;
var _text_w = _w - (_pad * 2);
var _choice_count = array_length(popup_choices);
var _h = _pad + string_height_ext(popup_prompt, _pad, _text_w) + _pad;
for (var i = 0; i < _choice_count; i++)
	{
	_h += string_height_ext(popup_choices[@ i], _pad, _text_w);
	}
var _x = (screen_width div 2);
var _y = (screen_height div 2);
var _half_w = _w div 2;
var _half_h = _h div 2;

//Background
draw_set_color(c_dkgray);
draw_rectangle(_x - _half_w, _y - _half_h, _x + _half_w, _y + _half_h, false);
draw_set_color(popup_color);
draw_rectangle(_x - _half_w, _y - _half_h, _x + _half_w, _y - _half_h + 2, false);

//Prompt
_y -= _half_h;
_y += _pad;
draw_set_color(c_white);
var _choice_h = string_height_ext(popup_prompt, _pad, _text_w);
draw_text_ext(_x, _y + (_choice_h div 2), popup_prompt, _pad, _text_w);
_y += _choice_h;
_y += _pad;

//Choices
for (var i = 0; i < _choice_count; i++)
	{
	var _choice_h = string_height_ext(popup_choices[@ i], _pad, _text_w);
	if (popup_current == i)
		{
		draw_set_color(c_ltgray);
		draw_rectangle(_x - _half_w, _y, _x + _half_w, _y + _choice_h, false);
		draw_set_color(c_black);
		}
	else
		{
		draw_set_color(c_white);
		}
	draw_text_ext(_x, _y + (_choice_h div 2), popup_choices[@ i], _pad, _text_w);
	_y += _choice_h;
	}
/* Copyright 2024 Springroll Games / Yosi */