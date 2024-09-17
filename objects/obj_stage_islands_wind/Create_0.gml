x = obj_game.cam_x + irandom(obj_game.cam_w);
y = obj_game.cam_y + irandom(obj_game.cam_h);
anim_frame = 0;
anim_speed = random_range(0.5, 1.0);
hsp = random_range(-1, 2);
vsp = random_range(-1, 1);
image_xscale = random_range(1.25, 2.75);
image_yscale = image_xscale;
image_angle = vsp * -3;
front = true;

/* Copyright 2024 Springroll Games / Yosi */