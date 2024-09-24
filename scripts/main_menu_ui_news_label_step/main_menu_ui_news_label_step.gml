function main_menu_ui_news_label_step()
	{
	if (engine().main_menu_fetched_news)
		{
		if (engine().main_menu_news == "")
			{
			text = "No news or announcements have been returned from the server yet...";
			}
		else
			{
			text = engine().main_menu_news;
			}
		}
	else
		{
		text = "News and announcements were not requested from the server.";
		}
	}
/* Copyright 2024 Springroll Games / Yosi */