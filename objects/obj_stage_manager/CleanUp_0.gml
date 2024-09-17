///@description Particles
var _types = variable_struct_get_names(stage_particle_types);
for (var i = 0; i < array_length(_types); i++)
	{
	part_type_destroy(stage_particle_types[$ _types[@ i]]);
	}
/* Copyright 2024 Springroll Games / Yosi */