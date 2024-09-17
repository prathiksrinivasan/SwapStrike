///@description
GAME_STATE_OBJECT

event_inherited();

image_speed = 0;

custom_entity_struct.phase = 0;
custom_entity_struct.type = 0;

//Detectbox
hitbox_create_detectbox(0, 0, 0.4, 0.4, -1, SHAPE.circle, 0, ryu_nspec_hadoken_detect_script);
/* Copyright 2024 Springroll Games / Yosi */