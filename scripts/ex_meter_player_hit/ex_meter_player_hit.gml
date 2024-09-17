function ex_meter_player_hit()
	{
	var _args = argument[0];
	var _hitbox = _args[@ 0];
	var _hurtbox = _args[@ 1];
	
	if (!instance_exists(_hitbox) || !instance_exists(_hurtbox)) then return;
	
	//Increase whenever you hit with a non-EX move
	var _p = custom_passive_struct;
	if (!_p.ex_move)
		{
		_p.ex_meter = clamp(_p.ex_meter + (_hitbox.damage * 4.5), 0, _p.ex_max);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */