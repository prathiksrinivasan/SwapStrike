function hit_script_template()
	{
	var _args = argument[0];
	var _hitbox = _args[@ 0];
	var _hurtbox = _args[@ 1];
	
	if (instance_exists(_hitbox) && instance_exists(_hurtbox))
		{
		//Script template for player hit scripts
		//Can be assigned to players with the code: callback_add(callback_hit, hit_script_template, CALLBACK_TYPE.permanent);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */