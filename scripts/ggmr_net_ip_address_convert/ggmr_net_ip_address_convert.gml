///@category GGMR
///@param {string} ip_address		The IP address to convert if needed
/*
If the given IP address is in the IPv6 format, it will be converted to the IPv4 format (when possible).
The new address is returned as a string.
*/
function ggmr_net_ip_address_convert()
	{
	var _ip = string(argument[0]);
	if (string_pos("::ffff:", _ip) > 0)
		{
		return string_replace(_ip, "::ffff:", "");
		}
	return _ip;
	}
/* Copyright 2024 Springroll Games / Yosi */