///@description
GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

vsp = 0;

var _s = custom_entity_struct;

_s.grav = 0;
_s.max_fall_speed = 9;
_s.grounded = false;
_s.explosion_time = -1;
_s.auto_explode_timer = 120;
show_debug_message(_s.auto_explode_timer)

image_speed = 0
image_xscale = 2;
image_yscale = 2;
/* Copyright 2024 Springroll Games / Yosi */