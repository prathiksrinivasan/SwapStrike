///@category Menus
/*
Returns true if there is an instance of <obj_online_chat> in the room, and it is currently displaying messages.
*/
function online_chat_is_open()
	{
	return (instance_number(obj_online_chat) > 0 && obj_online_chat.display_chat);
	}
/* Copyright 2024 Springroll Games / Yosi */