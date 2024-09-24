///@category GGMR
///@param {int} [relative_frame]		The relative frame to predict inputs for
/*
Predicts input for all local players who don't have inputs yet.
This will only be used if the session is in Local Mode, which can be enabled from <ggmr_session_local_mode_enable>.
The exact specifics of the prediction vary based on the "session_input_prediction_type".
Does NOT mark the inputs as being received or the frames as being confirmed.
*/
function ggmr_session_input_predict_local_mode()
	{
	with (obj_ggmr_session) 
		{
		var _relative_frame = argument_count > 0 ? argument[0] : GGMR_RELATIVE_FRAME;
		var _absolute_frame = ggmr_session_frame_absolute(_relative_frame);
	
		//Loop through all of the players
		for (var i = 0; i < session_number_of_clients; i++) 
			{
			//If the input has not been received yet
			if (!session_frames[@ _relative_frame][@ GGMR_FRAME.received][@ i]) 
				{
				if (session_input_prediction_type == GGMR_PREDICTION_TYPE.template)	
					{
					//Do nothing
					} 
				else if (session_input_prediction_type == GGMR_PREDICTION_TYPE.copy) 
					{
					//Copy over the inputs from the last confirmed frame
					var _last_confirmed_frame = ggmr_session_frame_absolute(session_last_confirmed_frame);
					var _prev = ggmr_session_input_buffer_get(i, _last_confirmed_frame);
					var _current = ggmr_session_input_buffer_get(i, _absolute_frame);
				
					//On 0 frame delay, there's an edge case where the last confirmed frame and the current frame will be the same on frame 0
					if (_prev != _current)
						{
						buffer_copy(_prev, 0, session_input_template_size, _current, 0);
						ggmr_log("Predicted inputs for frame ", _absolute_frame, " from frame ", _last_confirmed_frame);
						}
					
					//The frame has new inputs, so it has not run yet
					session_frames[@ _relative_frame][@ GGMR_FRAME.times_ran] = 0;
					}
				}
			}
		return;
		}
	ggmr_crash("obj_ggmr_session did not exist when ggmr_session_input_predict_local_mode was called");
	}

/* Copyright 2024 Springroll Games / Yosi */