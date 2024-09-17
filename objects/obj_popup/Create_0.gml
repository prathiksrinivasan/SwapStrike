///@category Menus
/*
This object displays a popup that covers the screen
You can use the function <popup_create> to create an instance, and <popup_is_open> to check if one already exists.
*/
popup_timer = 15;
popup_prompt = "Surprise!";
popup_choices = ["Ok"];
popup_current = 0;
popup_callback = undefined;
popup_custom = undefined;
popup_color = c_white;

//Menu input system
mis_init();
/* Copyright 2024 Springroll Games / Yosi */