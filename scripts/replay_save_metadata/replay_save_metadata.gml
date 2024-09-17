///@category Replays
///@param {buffer} replay			The buffer to save game metadata to
/*
Saves game metadata to a replay buffer. The function <replay_metadata_struct> determines what is in the struct.
Used in <replay_save>, and should not be called independently.
*/
function replay_save_metadata()
	{
	var _b = argument[0];
	
	//Struct
	var _meta = replay_metadata_struct();
	buffer_write(_b, buffer_string, json_stringify(_meta));
	}
/* Copyright 2024 Springroll Games / Yosi */