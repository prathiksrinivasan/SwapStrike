function special_define()
	{
	assert((argument_count == 4), "Wrong number of arguments");
	
	_new_move = {
		name: argument[0],
		neutral: argument[1],
		side: argument[2],
		down: argument[3]
	}
	return _new_move;
	}