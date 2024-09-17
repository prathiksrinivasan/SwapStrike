//Don't update during rollbacks
if (game_is_in_rollback()) then return;

x += hsp;
y += vsp;
anim_frame += anim_speed;
if (anim_frame > image_number)
	{
	instance_destroy();
	}
/* Copyright 2024 Springroll Games / Yosi */