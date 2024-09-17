///@category Custom Controls
///@param {int} advanced_controller_setting			The ACS to get the name of
/*
Returns the name of the given advanced controller setting.
*/
function acs_name_get()
	{
	switch (argument[0])
		{
		case ACS.deadzone_l:	return "L Deadzone";
		case ACS.deadzone_r:	return "R Deadzone";
		case ACS.invert_x_l:	return "L Inv X";
		case ACS.invert_x_r:	return "R Inv X";
		case ACS.invert_y_l:	return "L Inv Y";
		case ACS.invert_y_r:	return "R Inv Y";
		case ACS.maximum_l:		return "L Max";
		case ACS.maximum_r:		return "R Max";
		case ACS.rotate_l:		return "L Rotate";
		case ACS.rotate_r:		return "R Rotate";
		case ACS.speed_l:		return "L Speed";
		case ACS.speed_r:		return "R Speed";
		default: crash("[acs_name_get] Invalid ACS number (", argument[0], "). Did you add a value to ACS without adding it to this script?");
		}
	}
/* Copyright 2024 Springroll Games / Yosi */