function scalar_item_attack()
	{
	//Item Attack for Scalar
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
					default:
						//Use the default attack, because Scalar doesn't have unique attacks for any items
						attack_start(item_held.custom_entity_struct.attack_script);
						break;
					}
				return;
				}
			//Throw an error if no item attack was started
			case 0:
				{
				crash("[scalar_item_attack] No item attack was started");
				break;
				}
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */