draw_y = 0;

assert(plat != noone, "[obj_stage_islands_plat: Create] The plat variable must be set in the room editor");

x = plat.x;
y = plat.y;

plat_landed = 0;
sprite_index = spr_stage_islands_grass;
image_speed = 0;
image_index = (x / 128);

/* Copyright 2024 Springroll Games / Yosi */