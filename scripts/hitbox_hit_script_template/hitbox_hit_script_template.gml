///@category Hitboxes
///@param {id} hitbox		The attacking hitbox
///@param {id} hurtbox		The hurtbox being hit
/*
Template for making hitbox hit scripts (pre_hit_script or post_hit_script).
It is run from the owner of the hitbox that collided with a hurtbox.
*/
function hitbox_hit_script_template()
	{
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	if (instance_exists(_hitbox) && instance_exists(_hurtbox))
		{
		//Write any code here!
		}
	}
/* Copyright 2024 Springroll Games / Yosi */