///@description Called by obj_game
//Down Spike activation

var _s = custom_entity_struct;

if (_s.explosion_time > 0)
	{
	_s.explosion_time--;
	if (_s.explosion_time <= 0)
		{
		instance_destroy();
		exit;
		}
	}
else        
	{
	//Follow the player, unless it is already exploding
		
	//Auto exploding
	_s.auto_explode_timer -= 1;
	if (_s.auto_explode_timer == 15)
		{
		game_sound_play(snd_snake_dspec_c4);
		}
		
	if (_s.auto_explode_timer <= 0)
		{
		_s.explosion_time = 10;
						
		//Sweetspot
		var _hitbox = hitbox_create_melee(0, 0, 2, 2, 11, 7, 0.6, 11, 60, 10, SHAPE.circle, 0);
		_hitbox.hit_sfx = snd_hit_explosion3;
		_hitbox.hit_vfx_style = HIT_VFX.explosion;
		var _hitbox = hitbox_create_melee(0, -64, 1.5, 1.8, 11, 7, 0.6, 11, 60, 10, SHAPE.circle, 0);
		_hitbox.hit_sfx = snd_hit_explosion3;
		_hitbox.hit_vfx_style = HIT_VFX.explosion;
		var _hitbox = hitbox_create_melee(0, -128, 1.25, 1.5, 11, 7, 0.6, 11, 60, 10, SHAPE.circle, 0);
		_hitbox.hit_sfx = snd_hit_explosion3;
		_hitbox.hit_vfx_style = HIT_VFX.explosion;	
		var _hitbox = hitbox_create_melee(0, -164, 1, 1.25, 11, 7, 0.6, 11, 60, 10, SHAPE.circle, 0);
		_hitbox.hit_sfx = snd_hit_explosion3;
		_hitbox.hit_vfx_style = HIT_VFX.explosion;	
		//Weak hitbox
		//var _hitbox = hitbox_create_melee(0, 0, 2.5, 2.5, 3, 6, 0.5, 3, 90, 5, SHAPE.circle, 0);
		//_hitbox.hit_sfx = snd_hit_explosion3;
		//_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
		//_hitbox.custom_hitstun = 20;
						
		//Explosion VFX
		var _vfx = vfx_create(spr_snake_dspec_c4_explosion, 1, 0, 34, x, y, 2, 0);
		_vfx.important = true;
		game_sound_play(snd_hit_explosion1);
		camera_shake(3);
		}
	}
	
//Animation
if (_s.explosion_time > 0)
	{
	visible = false;
	}
else if (_s.grounded)
	{
	image_index += 0.1;
	if (image_index >= 4 || image_index < 2) then image_index = 2;
	}
else
	{
	image_index += 0.1;
	if (image_index >= 2) then image_index = 0;
	
	if (_s.auto_explode_timer <= 120)
		{
		image_index = 4;
		}
	}
	
//Destroy if the owner is dead or the attached player is dead
with (owner)
	{
	if (is_knocked_out())
		{
		instance_destroy(other);
		exit;
		}
	}
	
//Destroy if it falls under the stage
if (bbox_top > room_height)
	{
	instance_destroy();
	exit;
	}
/* Copyright 2024 Springroll Games / Yosi */