///@category Collisions
/*
This object is the parent object of all nonmoving "block" objects - <obj_solid>, <obj_slope>, <obj_platform>, and <obj_platform_blinker>.
It is a child of <obj_collidable>.
Warning: It should never be directly put in rooms.
*/
event_inherited();
collision_flag_set(id, FLAG.block, true);
/* Copyright 2024 Springroll Games / Yosi */