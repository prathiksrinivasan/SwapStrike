///@category Collisions
/*
Moves a player based on their previously set speeds.
Players cannot move horizontally off the ground with this function. If they are already in the air, they will not move horizontally at all.
*/
function move_grounded()
	{
	speed_fraction();
	move_x_grounded(sprite_get_bbox_right(mask_index) - sprite_get_bbox_left(mask_index), hsp);
	move_y();
	}
/* Copyright 2024 Springroll Games / Yosi */