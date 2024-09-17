///@category Stages
///@param {string} name						The name of the stage
///@param {asset} script					The stage init script, or -1 for no script
///@param {asset} room						The room for the stage
///@param {asset} sprite					The thumbnail sprite for the stage, or -1 for no thumbnail
///@param {array} texture_groups			An array containing the names of all the texture groups the stage uses sprites from
///@param {int} [frame]						The frame of the sprite to use for the thumbnail
/*
Creates an array that stores all of the metadata for a single stage.
Warning: This function should only be used in <stage_data>!
*/
function stage_define()
	{
	assert(room_exists(argument[2]), "[stage_define] Room does not exist! (", argument[2], ")");
	assert(sprite_exists(argument[3] || argument[3] == -1), "[stage_define] Thumbnail sprite does not exist! (", argument[3], ")");
	assert(!is_undefined(argument[1]), "[stage_define] Stage init script's value is undefined. Did you put parentheses after the script name?");
	assert(script_exists(argument[1]) || argument[1] == -1, "[stage_define] Stage init script does not exist! (", argument[1], ")");
		
	var _new = [];
	_new[@ STAGE_DATA.name				] = argument[0];
	_new[@ STAGE_DATA.script			] = argument[1];
	_new[@ STAGE_DATA.room				] = argument[2];
	_new[@ STAGE_DATA.sprite			] = argument[3];
	_new[@ STAGE_DATA.texture_groups	] = argument[4];
	_new[@ STAGE_DATA.frame				] = argument_count > 5 ? argument[5] : 0;
	return _new;
	}
/* Copyright 2024 Springroll Games / Yosi */