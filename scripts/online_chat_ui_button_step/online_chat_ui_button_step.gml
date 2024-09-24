///@category Menus
/*
This is a UI button step script that can be assigned to any <obj_ui_button> to make it open and close the online chat.
Warning: There must be an instance of <obj_online_chat> in the room, otherwise this script will crash.
*/
function online_chat_ui_button_step()
	{
	ui_button_step();
	
	//Open the chat
	if (ui_clicked)
		{
		online_chat_open();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */