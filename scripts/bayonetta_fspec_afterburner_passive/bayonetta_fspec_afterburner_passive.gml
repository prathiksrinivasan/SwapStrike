function bayonetta_fspec_afterburner_passive()
	{
	//Limits the number of uses of afterburner kick.
	if (!(state == PLAYER_STATE.attacking && attack_script == bayonetta_fspec_afterburner))
		{
		if (on_ground())
			{
			attack_uses_set(2, bayonetta_fspec_afterburner);
			attack_cooldown_set(0, bayonetta_fspec_afterburner);
			}
		}
	if (is_knocked_out())
		{
		attack_uses_set(2, bayonetta_fspec_afterburner);
		attack_cooldown_set(0, bayonetta_fspec_afterburner);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */