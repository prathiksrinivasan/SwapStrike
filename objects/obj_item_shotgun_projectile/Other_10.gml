//Change damage and knockback based on the lifetime
if (lifetime == 6)
	{
	hit_vfx_style = HIT_VFX.normal_medium;
	hit_sfx = snd_hit_weak1;
	base_knockback = 5;
	damage = 3;
	knockback_state = PLAYER_STATE.hitstun;
	}
else if (lifetime == 3)
	{
	base_knockback = 4;
	damage = 2;
	}

event_inherited();
/* Copyright 2024 Springroll Games / Yosi */