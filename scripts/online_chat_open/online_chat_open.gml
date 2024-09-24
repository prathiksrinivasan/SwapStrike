///@category Menus
/*
Opens the online chat. 
Warning: There must be an instance of <obj_online_chat> in the room already.
*/
function online_chat_open()
	{
	if (!popup_is_open() && !main_menu_sidebar_is_open())
		{
		with (obj_online_chat)
			{
			display_chat = true;
			redraw = true;
			return true;
			}
		crash("[online_chat_open] There must be an instance of obj_online_chat in the room for this script to work");
		}
	else
		{
		return false;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */