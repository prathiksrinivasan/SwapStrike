///@category Gameplay
/*
Returns true if the current frame is "confirmed", meaning input for every local and remote player has been received.
In local matches, this function always returns true.
*/
function rollback_frame_is_confirmed()
	{
	if (game_is_online())
		{
		return false;
		}
	else return true;
	}
/* Copyright 2024 Springroll Games / Yosi */