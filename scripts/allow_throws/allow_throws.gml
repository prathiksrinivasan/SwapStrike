///@category Attacking
/*
Allows a player to start a throw, and returns true if they do.
This function does not check if the player is actually grabbing an opponent.
*/
function allow_throws()
	{
	var _started = false;
	var _stick = Lstick;
	//Up Throw
	if (stick_get_value(_stick, DIR.up) > stick_tilt_amount)
		{
		_started = attack_start(my_attacks[$ "Uthrow"]);
		return _started;
		}
	else
	//Down Throw
	if (stick_get_value(_stick, DIR.down) > stick_tilt_amount)
		{
		_started = attack_start(my_attacks[$ "Dthrow"]);
		return _started;
		}
	else
	//Forward Throw / Backward Throw
		{
		//Is the control stick in the direction the player is facing?
		if (abs(stick_get_value(_stick, DIR.horizontal)) > stick_tilt_amount)
			{
			if (sign(stick_get_value(_stick, DIR.horizontal)) == sign(facing))
				{
				_started = attack_start(my_attacks[$ "Fthrow"]);
				return _started;
				}
			else
				{
				_started = attack_start(my_attacks[$ "Bthrow"]);
				return _started;
				}
			}
		}
	return false;
	}
/* Copyright 2024 Springroll Games / Yosi */