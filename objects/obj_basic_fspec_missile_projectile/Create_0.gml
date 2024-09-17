///@description
GAME_STATE_OBJECT

event_inherited();

overlay_sprite = spr_basic_fspec_missile_projectile;
destroy_on_blocks = true;

//Custom vars
var _s = custom_projectile_struct;

_s.turn_speed = 5;
_s.shoot_speed = 14;
/* Copyright 2024 Springroll Games / Yosi */