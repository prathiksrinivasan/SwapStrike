///@category Gameplay
/*
Returns true if the game is an online match, and is currently in rollback.
*/
function game_is_in_rollback()
	{
	return engine().is_online && ggmr_session_is_in_rollback();
	}
/* Copyright 2024 Springroll Games / Yosi */