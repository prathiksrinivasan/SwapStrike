// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function reshuffle_specials(){
	for (var i = 0; i < array_length(specials_list); i++)
	{
		ds_stack_push(special_deck, specials_list[i]);
	}
}