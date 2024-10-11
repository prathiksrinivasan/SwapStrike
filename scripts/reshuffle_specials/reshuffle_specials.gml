// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function reshuffle_specials(){
	
	//this uses my own array_shuffle function, i do not know if it works :(. Gives wrong number of arguments error?
	var specials_shuffled = array_shuffle(specials_list); 
	
	
	
	for (var i = 0; i < array_length(specials_shuffled); i++)
	{
		ds_stack_push(special_deck, specials_list[i]);
	}
}

