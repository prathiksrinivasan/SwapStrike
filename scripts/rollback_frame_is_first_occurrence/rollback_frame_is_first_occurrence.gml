///@category Gameplay
/*
Returns true if the current frame is running for the first time by checking <ggmr_session_frame_is_first_occurrence>.
In local matches, this function always returns true.
*/
function rollback_frame_is_first_occurrence()
	{
	if (game_is_online())
		{
		return ggmr_session_frame_is_first_occurrence(obj_ggmr_session.session_running_relative_frame);
		}
	else return true;
	}
/* Copyright 2024 Springroll Games / Yosi */