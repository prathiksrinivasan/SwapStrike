GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

//Variables
var _s = custom_entity_struct;
_s.item_type = ITEM_TYPE.throwing;
_s.item_actions = item_diddy_dspec_banana_actions;
_s.lifetime = 360;
_s.angle = 0;
_s.trips = 2;

var _ids = custom_ids_struct;
_ids.hitbox = noone;
_ids.player_original = noone;

/* Copyright 2024 Springroll Games / Yosi */