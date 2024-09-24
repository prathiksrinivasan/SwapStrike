function online_css_ui_player_name_label_step()
	{
	var _profile = css_player_get(obj_online_css_ui.local_player_id, CSS_PLAYER.profile);
	text = profile_get(_profile, PROFILE.name);
	}
/* Copyright 2024 Springroll Games / Yosi */