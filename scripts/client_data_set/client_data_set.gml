///@category Client Engine Scripts
///@param {int} client_number			The client to set data for
///@param {int} data					The data to set, from the CLIENT_DATA enum
///@param {any} value					The value to set the data to
/*
Sets data for the given client.
*/
function client_data_set()
	{
	var _client = engine().client_data[argument[0]];
	_client[@ argument[1]] = argument[2];
	}
/* Copyright 2024 Springroll Games / Yosi */