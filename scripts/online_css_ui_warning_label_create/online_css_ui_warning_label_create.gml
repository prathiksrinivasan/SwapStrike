function online_css_ui_warning_label_create()
	{
	if (profile_exists(profile_find(engine().online_default_name), true))
		{
		instance_destroy();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */