///@category Startup
/*
Initializes the particle system.
This function is automatically called once in <engine_init>.
*/
function part_system_init()
	{
	part_system_automatic_update(Particle_System(), false);
	part_system_automatic_draw(Particle_System(), false);
	}

/* SYSTEM */
function Particle_System()
	{
	static _system = part_system_create();
	return _system;
	}

/* Copyright 2024 Springroll Games / Yosi */