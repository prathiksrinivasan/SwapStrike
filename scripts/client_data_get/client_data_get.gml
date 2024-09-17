///@category Client Engine Scripts
///@param {int} client_number			The client to get data from
///@param {int} data					The data to get, from the CLIENT_DATA enum
/*
Gets data for the given client.
*/
function client_data_get()
	{
	var _client = engine().client_data[argument[0]];
	return _client[@ argument[1]];
	}
/* Copyright 2024 Springroll Games / Yosi */