function replays_ui_scan()
	{
	var _scan = replays_scan();
	replay_array = _scan.replay_array;
	replays_count = array_length(replay_array);
	replays_per_page = 10;
	replay_delete_time = 0;

	replay_clip_number = _scan.clip_number;
	replay_unknown_number = _scan.unknown_number;

	replay_metadata = undefined;
	replay_metadata_current = -1;
	}
/* Copyright 2024 Springroll Games / Yosi */