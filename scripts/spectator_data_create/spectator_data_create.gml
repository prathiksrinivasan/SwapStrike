///@category Spectator Engine Scripts
///@param {int} device				The device port
///@param {int} device_type			The device type, from the DEVICE enum
///@param {struct} [custom]			A struct with any values in it
/*
Creates a new spectator data array with the given properties, and adds it to the engine().<spectator_data> array.
*/
function spectator_data_create()
	{
	assert(argument_count > 1, "[spectator_data_create] Not enough arguments (", argument_count, ")");
	var _new = [];
	_new[@ SPECTATOR_DATA.device		] = argument[0];
	_new[@ SPECTATOR_DATA.device_type	] = argument[1];
	_new[@ SPECTATOR_DATA.custom		] = argument_count > 2 ? argument[2] : {};
	array_push(engine().spectator_data, _new);
	return _new;
	}
/* Copyright 2024 Springroll Games / Yosi */