///@category Attacking
/*
Overrides a player's attack if their held item can be used as an attack.
Warning: This is only intended to be used within <attack_start>.
*/
function override_item_attacks()
	{
	//The player must be holding an item
	if (item_held == noone || !instance_exists(item_held)) then return false;
	
	//Item weapon types
	var _type = item_held.custom_entity_struct.item_type;
	var _atk = attack_script;
	var _started = false;
	
	switch (_type)
		{
		case ITEM_TYPE.melee:
			//Melee weapons can override Jab, Ftilt, or Fsmash 
			if (_atk == my_attacks[$ "Jab"] ||
				_atk == my_attacks[$ "Ftilt"] ||
				_atk == my_attacks[$ "Fsmash"])
				{
				_started = attack_start(my_attacks[$ "Item_Attack"]);
				}
			break;
		case ITEM_TYPE.projectile:
			//Melee weapons can override Jab or Nair
			if (_atk == my_attacks[$ "Jab"] ||
				_atk == my_attacks[$ "Nair"])
				{
				_started = attack_start(my_attacks[$ "Item_Attack"]);
				}
			break;
		}
	
	return _started;
	}
/* Copyright 2024 Springroll Games / Yosi */