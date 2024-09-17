///@description
sync_id_release();

//Destroy hitboxes
hitbox_destroy_attached_all();

hitbox_owner_cleanup();

//Destroy hurtboxes
with (obj_hurtbox)
	{
	if (owner == other.id)
		{
		instance_destroy();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */