function basic_item_attack()
	{
	//Item Attack
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Start a different attack based on what item you're holding
				var _obj = item_held.object_index;
				switch (_obj)
					{
					case obj_item_bat:
						attack_start(basic_item_bat_attack);
						break;
					default:
						//Use the default attack
						attack_start(item_held.custom_entity_struct.attack_script);
						break;
					}
				return;
				}
			//Throw an error if no item attack was started
			case 0:
				{
				crash("[basic_item_attack] No item attack was started");
				break;
				}
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */