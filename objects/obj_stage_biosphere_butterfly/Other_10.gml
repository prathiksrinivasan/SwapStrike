//Don't update during rollbacks
if (game_is_in_rollback()) then return;

var _dir = point_direction(x, y, x_goal, y_goal);
var _len = 0.1;
hsp += lengthdir_x(_len, _dir);
vsp += lengthdir_y(_len, _dir);

var _dir = point_direction(0, 0, hsp, vsp);
var _dist = min(point_distance(0, 0, hsp, vsp), 2);
hsp = lengthdir_x(_dist, _dir);
vsp = lengthdir_y(_dist, _dir);

x += hsp;
y += vsp;

if (point_distance(x, y, x_goal, y_goal) < 20)
	{
	var _bound = 320;
	x_goal = random_range(_bound, room_width - _bound);
	y_goal = random_range(_bound, room_height - _bound);
	}

image_index += 0.3;

/* Copyright 2024 Springroll Games / Yosi */