///@category Custom Controls
///@param {int} special_control_setting			The SCS to get the name of
/*
Returns the name of the given special control setting.
*/
function scs_name_get()
	{
	switch (argument[0])
		{
		case SCS.AB_smash:			return "A+B Smash";
		case SCS.auto_walk:			return "Auto Walk";
		case SCS.double_tap:		return "Double Tap";
		case SCS.short_hop_aerial:	return "SH Aerial";
		case SCS.smash_stick:		return "Smash Stick";
		case SCS.switch_sticks:		return "Swap Sticks";
		case SCS.tap_jump:			return "Tap Jump";
		case SCS.jumpsquat_attacks: return "JS Attacks";
		default: crash("[scs_name_get] Invalid SCS number (", argument[0], "). Did you add a value to SCS without adding it to this script?");
		}
	}
/* Copyright 2024 Springroll Games / Yosi */