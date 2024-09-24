function online_css_ui_quit_button_step()
	{
	ui_button_step();
	
	if (ui_clicked)
		{
		with (obj_online_css_ui)
			{
			//Create & send the disconnect packet
			var _overall_struct = 
				{
				packet_type : "disconnect",
				};
			buffer_reset(packet, false);
			buffer_write(packet, buffer_string, json_stringify(_overall_struct));
			buffer_resize(packet, buffer_tell(packet));
		
			//Send packets to every client
			for (var i = 0; i < array_length(engine().client_data); i++)
				{
				var _client = engine().client_data[@ i];
				var _location = _client[@ CLIENT_DATA.location];
				var _connection_id = _client[@ CLIENT_DATA.connection];
				
				//Don't send packets to yourself
				if (_location != GGMR_LOCATION_TYPE.local)
					{
					ggmr_net_send(GGMR_PACKET_TYPE.custom_data, packet, _connection_id);
					log("Sent a disconnect packet to connection number ", _connection_id);
					}
				}
			
			menu_sound_play(snd_menu_back);
			engine().private_lobby_resume = false;
			room_goto(rm_main_menu);
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */