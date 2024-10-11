// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function discard_special(){
	
	if(ds_stack_empty(special_deck))
	{
		reshuffle_specials();
	}
	curr_special = ds_stack_pop(special_deck);
	
	show_debug_message(curr_special);
	my_attacks[$ "Uspec"] = curr_special.neutral;
	my_attacks[$ "NSpec"] = curr_special.neutral;
	my_attacks[$ "Fspec"] = curr_special.side;
	my_attacks[$ "Dspec"] = curr_special.down;
				 
	show_debug_message("here i am");
	 
}