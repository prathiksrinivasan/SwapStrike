///@category Gameplay
///@param {buffer} buffer			The buffer to write the input data to
///@param {int} player_number		The number of the player to get inputs for
/*
Gets the input for a single local player, and writes the data to the given buffer.
If the player is a CPU, then <cpu_script_base> is called.
Uses <game_local_input_write>.
Warning: This function is only intended to be used for the negative input delay implementation!
*/
function game_local_input_online_with_cpu()
	{
	//Buffers
	var _b = argument[0];
	var _num = argument[1];
	buffer_seek(_b, buffer_seek_start, 0);
	
	//Device / Custom Control specifications
	var _player = noone;
	with (obj_player)
		{
		if (player_number == _num)
			{
			var _cc = custom_controls;
			var _d = device;
			var _dt = device_type;
			var _cpu = is_cpu;
			_player = id;
			break;
			}
		}
		
	//Read existing input data from buffer
	/*
	This allows the game to accumulate inputs over a few frames before using them, 
	which is useful if the game needs to drop frames while online to correct the rift.
	If the existing data in the buffer was NOT read, then dropped frames would also
	discard any player inputs that happened.
	
	Stick values are not accumulated, because the control stick cannot be in multiple
	positions at the same time.
	*/
	var _flag = buffer_read(_b, buffer_u32);
	buffer_seek(_b, buffer_seek_start, 0);
	
	if (_cpu)
		{
		with (_player) 
			{
			cpu_script_base(_b);
			}
		}
	else
		{
		game_local_input_write(_b, _d, _dt, _cc, _flag);
		}
	
	return;
	}
/* Copyright 2024 Springroll Games / Yosi */