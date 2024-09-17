///@category Client Engine Scripts
///@param {string} name					The name of the client
///@param {int} connection				The connection number
///@param {int} location				The location, from the GGMR_LOCATION_TYPE enum
///@param {int} client_type				The player type, from the GGMR_CLIENT_TYPE enum
///@param {struct} [custom]				A struct with any values in it
/*
Creates a new client data array with the given properties, and adds it to the engine().<client_data> array.
*/
function client_data_create()
	{
	assert(argument_count > 3, "[client_data_create] Not enough arguments (", argument_count, ")");
	var _new = [];
	_new[@ CLIENT_DATA.name			] = argument[0];
	_new[@ CLIENT_DATA.connection	] = argument[1];
	_new[@ CLIENT_DATA.location		] = argument[2];
	_new[@ CLIENT_DATA.client_type	] = argument[3];
	_new[@ CLIENT_DATA.custom		] = argument_count > 4 ? argument[4] : {};
	array_push(engine().client_data, _new);
	return _new;
	}
/* Copyright 2024 Springroll Games / Yosi */