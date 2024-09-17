GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

//Variables
var _s = custom_entity_struct;
_s.item_type = ITEM_TYPE.melee;
_s.item_actions = item_bat_actions;
_s.angle = 0;
_s.attack_script = item_bat_attack_default_script;

var _ids = custom_ids_struct;
_ids.hitbox = noone;
_ids.hurtbox = noone;
/* Copyright 2024 Springroll Games / Yosi */