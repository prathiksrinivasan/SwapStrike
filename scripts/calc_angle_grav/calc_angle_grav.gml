// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function calc_angle_grav(){
	with obj_hitbox_projectile{
		var mag = sqrt(sqr(vsp)+sqr(hsp));
		overlay_angle = sin(vsp/mag) + cos(hsp/mag);
		return;
	}
}