// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function shuffle(){
	
	show_debug_message(script_get_name(uspec));
	uspec = mario_uspec;
	my_attacks[$ "Nspec"		] = -1;
	my_attacks[$ "Fspec"		] = -1;
	my_attacks[$ "Uspec"		] = uspec;
	my_attacks[$ "Dspec"		] = -1;
	show_debug_message("here i am");
	show_debug_message(script_get_name(uspec));
	 
}