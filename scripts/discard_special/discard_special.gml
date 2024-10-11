// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function discard_special(){
	
	if(ds_stack_empty(special_deck))
	{
		for (var i = 0; i < array_length(specials_list); i++)
		{
			ds_stack_push(special_deck, specials_list[i]);
		}
	}
	curr_special = ds_stack_pop(special_deck);
	
	show_debug_message(curr_special);
	my_attacks[$ "Uspec"] = curr_special.neutral;
	my_attacks[$ "Fspec"] = curr_special.side;
	my_attacks[$ "Dspec"] = curr_special.down;
				 
	show_debug_message("here i am");
	 
}