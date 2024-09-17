///@category Menus
///@param {string} prompt			The message prompt to display
///@param {array} choices			The choices on the popup
///@param {color} [color]			The color at the top of the popup
///@param {function} [callback]		The function to run when the player picks a choice
///@param {any} [custom]			Any value that will be passed into the callback function as the second argument
/*
Creates the <obj_popup> and initializes it based on the given arguments.
A popup displays a prompt and possible choices, which players can select with the control stick.
The last choice will be chosen if the player presses the "back" button.
The instance id of the popup is returned.
The callback function takes two arguments:
	- {any} choice			The choice the player picked
	- {any} [custom]		Any custom value that was passed to the function
*/
function popup_create()
	{
	var _id = instance_create_depth(0, 0, 0, obj_popup);
	with (_id)
		{
		popup_prompt = argument[0];
		popup_choices = argument[1];
		popup_color = argument_count > 2 ? argument[2] : c_white;
		popup_callback = argument_count > 3 ? argument[3] : undefined;
		popup_custom = argument_count > 4 ? argument[4] : undefined;
		}
	return _id;
	}
/* Copyright 2024 Springroll Games / Yosi */