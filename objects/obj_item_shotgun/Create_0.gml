GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

//Variables
var _s = custom_entity_struct;
_s.item_type = ITEM_TYPE.projectile;
_s.item_actions = item_shotgun_actions;
_s.angle = 0;
_s.attack_script = item_shotgun_attack_default_script;
_s.ammo = 5;

var _ids = custom_ids_struct;
_ids.hitbox = noone;

image_xscale = item_sprite_scale_default * prng_choose(0, -1, 1);
image_speed = 0;
image_index = 4;
/* Copyright 2024 Springroll Games / Yosi */