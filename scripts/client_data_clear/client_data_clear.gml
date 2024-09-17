///@category Client Engine Scripts
/*
Deletes all of the client data stored in engine().<client_data>, leaving it as an empty array.
Client data stores data for any clients connected on the network (both Players and Spectators).
*/
function client_data_clear()
	{
	engine().client_data = [];
	log("Reset all of the engine client data!");
	}
/* Copyright 2024 Springroll Games / Yosi */