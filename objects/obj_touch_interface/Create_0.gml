///@category Touch Controls
/*
This persistent object manages the touch interfact, including the <obj_touch_button> and <obj_touch_stick> instances.
It will only be created if <touch_controls_enable> is true.
*/
///@description Create instances
assert(room == rm_touch_interface, "[obj_touch_interface: Create] This object can only be placed in rm_touch_interface");
only_one();
disable = true;
mis_device_number = -1;

//Automatically turn on when on GX mobile target
var _mobile = (os_type == os_operagx && display_get_height() > display_get_width());
if (_mobile) then disable = false;

//Go to the room after rm_init
room_goto(room_next(rm_init));

/* Copyright 2024 Springroll Games / Yosi */