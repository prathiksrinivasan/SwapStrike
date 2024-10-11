// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_shuffle()
{
	var array = argument[0];
	var currentIndex = array_length(array);

  // While there remain elements to shuffle...
  while (currentIndex != 0) {

	    // Pick a remaining element...
	    var randomIndex = (prng_number(0, currentIndex - 1));
	    currentIndex--;

	    // And swap it with the current element.
		var temp = array[currentIndex];
		array[currentIndex] = array[randomIndex];
		array[randomIndex] = temp;
	  
	}
	return array;
}