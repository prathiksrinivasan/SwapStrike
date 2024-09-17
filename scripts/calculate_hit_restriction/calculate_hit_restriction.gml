///@category Attacking
///@param {id} hitbox				The hitbox being checked
///@param {id} hurtbox				The hurtbox being checked
/*
Returns true if the given hitbox can hit the given player hurtbox, with whatever hit restriction the hitbox has currently.
By default, there are 11 hit restrictions:
	- HIT_RESTRICTION.none: The hitbox can hit any hurtboxes as normal
	- HIT_RESTRICTION.grounded_only: The hitbox can only hit hurtboxes whose owners are grounded
	- HIT_RESTRICTION.aerial_only: The hitbox can only hit hurtboxes whose owners are aerial
	- HIT_RESTRICTION.ledge_only: The hitbox can only hit hurtboxes whose owners are snapping to ledge, tethering to ledge, or hanging on the ledge
	- HIT_RESTRICTION.combo_only: The hitbox can only hit hurtboxes whose owners are "launched", grabbed, or magnetized
	- HIT_RESTRICTION.not_ledge: The hitbox cannot hit hurtboxes whose owners are on the ledge
	- HIT_RESTRICTION.not_crouching: The hitbox cannot hit hurtboxes whose owners are crouching
	- HIT_RESTRICTION.not_grabbed: The hitbox cannot hit hurtboxes whose owners are grabbed
	- HIT_RESTRICTION.not_launched: The hitbox cannot hit hurtboxes whose owners are in a "launched" state
	- HIT_RESTRICTION.not_combo: The hitbox cannot hit hurtboxes whose owners are "launched", grabbed, or magnetized
	- HIT_RESTRICTION.cannot_hit_anything: The hitbox cannot hit any hurtboxes

Please note: This function ONLY works against player-owned hurtboxes, which is why it isn't run in the hitbox object, and is instead in the hurtbox scripts.
*/
function calculate_hit_restriction()
	{
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	
	switch (_hitbox.hit_restriction)
		{
		case HIT_RESTRICTION.none:
			return true;
		case HIT_RESTRICTION.grounded_only:
			with (_hurtbox.owner)
				{
				if (on_ground()) then return true;
				}
			return false;
		case HIT_RESTRICTION.aerial_only:
			with (_hurtbox.owner)
				{
				if (!on_ground()) then return true;
				}
			return false;
		case HIT_RESTRICTION.combo_only:
			with (_hurtbox.owner)
				{
				if (state == PLAYER_STATE.balloon ||
					state == PLAYER_STATE.flinch ||
					state == PLAYER_STATE.hitlag ||
					state == PLAYER_STATE.hitstun ||
					state == PLAYER_STATE.grabbed ||
					state == PLAYER_STATE.knockdown ||
					state == PLAYER_STATE.magnetized)
					{
					return true;
					}
				}
			return false;
		case HIT_RESTRICTION.ledge_only:
			with (_hurtbox.owner)
				{
				if (state == PLAYER_STATE.ledge_snap ||
					state == PLAYER_STATE.ledge_hang ||
					state == PLAYER_STATE.ledge_tether)
					{
					return true;
					}
				}
			return false;
		case HIT_RESTRICTION.not_ledge:
			with (_hurtbox.owner)
				{
				if (state != PLAYER_STATE.ledge_snap &&
					state != PLAYER_STATE.ledge_hang &&
					state != PLAYER_STATE.ledge_tether)
					{
					return true;
					}
				}
			return false;
		case HIT_RESTRICTION.not_crouching:
			with (_hurtbox.owner)
				{
				if (state != PLAYER_STATE.crouching) then return true;
				}
			return false;
		case HIT_RESTRICTION.not_grabbed:
			with (_hurtbox.owner)
				{
				if (state != PLAYER_STATE.grabbed) then return true;
				}
			return false;
		case HIT_RESTRICTION.not_launched:
			with (_hurtbox.owner)
				{
				if (!is_launched()) then return true;
				}
			return false;
		case HIT_RESTRICTION.not_combo:
			with (_hurtbox.owner)
				{
				if (state != PLAYER_STATE.balloon &&
					state != PLAYER_STATE.flinch &&
					state != PLAYER_STATE.hitlag &&
					state != PLAYER_STATE.hitstun &&
					state != PLAYER_STATE.grabbed &&
					state != PLAYER_STATE.knockdown &&
					state != PLAYER_STATE.magnetized)
					{
					return true;
					}
				}
			return false;
		case HIT_RESTRICTION.cannot_hit_anything:
			return false;
		default: crash("[calculate_hit_restriction] Invalid hit restriction (", _hitbox.hit_restriction, ")");
		}
	}
/* Copyright 2024 Springroll Games / Yosi */