///@category Menus
/*
This is a UI label step script that can be assigned to any <obj_ui_label> to make it display the latest chat message.
Warning: There must be an instance of <obj_online_chat> in the room, otherwise this script will crash.
*/
function online_chat_ui_label_step()
	{
	//Display the latest message
	if (obj_ggmr_chat.chat_was_updated || obj_online_chat.redraw)
		{
		var _history = ggmr_chat_history(1);
		if (array_length(_history) > 0)
			{
			var _entry = _history[@ 0];
			text = to_string(_entry.name, "   ", online_chat_preset_script(_entry.message));
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */