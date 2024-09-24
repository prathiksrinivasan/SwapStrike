///@category Gameplay
/*
Returns true if the game is an online match.
*/
function game_is_online()
	{
	assert(instance_exists(obj_game), "[game_is_online] obj_game does not exist");
	return engine().is_online;
	}
/* Copyright 2024 Springroll Games / Yosi */