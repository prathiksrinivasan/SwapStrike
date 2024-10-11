function special_define()
	{
	assert((argument_count == 3), "Wrong number of arguments");
	
	_new_move = {
		neutral: argument[0],
		side: argument[1],
		down: argument[2]
	}
	return _new_move;
	}