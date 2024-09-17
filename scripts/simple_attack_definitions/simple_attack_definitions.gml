///@category Attacking
/*
This script contains any simple attacks that are predefined for the game, meaning they are always available to use and will never be removed from memory.
*/
function simple_attack_definitions()
	{
	//Shulk's Forward Aerial
	simple_attack_define
		(
		"shulk_fair_sim",
			{
			sprite : spr_shulk_fair,
			type : "air",
			movement : "all",
			preset : SIMPLE_ATTACK_PRESET.aerial,
			state_end : PLAYER_STATE.aerial,
			vars : { landing_lag : 10 },
			windows:
				[
				//Startup
				{ length : 6, anim_start : 0, anim_end : 1 },
				//Active
					{
					length : 6,
					hitboxes : 
						[
							{
							anim_frame : 2,
							type : "melee",
							args : [38, -32, 1.4, 0.8, 10, 6, 0.8, 6, 48, 2, SHAPE.circle, 0],
							frame : 0,
							vars : { hit_vfx_style : HIT_VFX.slash_medium, shieldstun_scaling : 0.5, knockback_state : PLAYER_STATE.balloon },
							},
							{
							anim_frame : 3,
							type : "melee",
							args : [62, 8, 1.2, 1.6, 10, 6, 0.8, 6, 48, 3, SHAPE.circle, 0],
							frame : 1,
							vars : { hit_vfx_style : HIT_VFX.slash_medium, shieldstun_scaling : 0.5, knockback_state : PLAYER_STATE.balloon },
							},
							{
							anim_frame : 4,
							type : "melee",
							args : [32, 36, 1.4, 0.8, 10, 6, 0.8, 6, 48, 2, SHAPE.circle, 0],
							frame : 3,
							vars : { hit_vfx_style : HIT_VFX.slash_medium, shieldstun_scaling : 0.5, knockback_state : PLAYER_STATE.balloon },
							},	
							{
							anim_frame : 5,
							type : "melee",
							args : [-20, 36, 0.5, 0.6, 10, 6, 0.7, 6, 48, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal],
							frame : 5,
							vars : { hit_vfx_style : HIT_VFX.slash_medium, shieldstun_scaling : 0.5 },
							},
						],
					},
				//Endlag
				{ length : 12, whiff_lag : 8, anim_start : 5, anim_end : 6 },
				],
			},
		true,
		);
	//Roy's Forward Smash
	simple_attack_define
		(
		"fsmash_roy_sim",
			{
			sprite : spr_chrom_fsmash,
			type : "ground",
			movement : "ground",
			state_end : PLAYER_STATE.idle,
			windows:
				[
				//Charging
				{ length : 6, anim_start : 0, anim_end : 3, charge : smash_attack_charge_max },
				//Startup
				{ length : 6, anim_start : 3, anim_end : 6 },
				//Active
					{
					length : 2,
					hitboxes : 
						[
							//First Hitboxes
							{
							anim_frame : 7,
							type : "smash",
							args : [43, -15, 0.7, 0.9, 20, 7, 1, 20, 40, 1, SHAPE.circle, 0],
							frame : 0,
							vars : { hit_vfx_style : [HIT_VFX.slash_strong, HIT_VFX.normal_strong], hit_sfx : snd_hit_strong2, hitstun_scaling : 0.5, 
								knockback_state : PLAYER_STATE.balloon, knockback_formula : KNOCKBACK_FORMULA.stronger },
							},
							{
							type : "smash",
							args : [66, -22, 1.3, 0.9, 10, 6, 0.9, 5, 45, 1, SHAPE.circle, 0],
							frame : 0,
							vars : { hit_vfx_style : [HIT_VFX.slash_weak, HIT_VFX.normal_weak], hit_sfx : snd_hit_weak1, shieldstun_scaling : 0.1, 
								hitstun_scaling : 0.5 },
							},
							//Second Hitboxes
							{
							anim_frame : 8,
							type : "smash",
							args : [44, 2, 0.7, 0.5, 20, 7, 1, 20, 40, 1, SHAPE.circle, 0],
							frame : 1,
							vars : { hit_vfx_style : [HIT_VFX.slash_strong, HIT_VFX.normal_strong], hit_sfx : snd_hit_strong2, hitstun_scaling : 0.5, 
								knockback_state : PLAYER_STATE.balloon, knockback_formula : KNOCKBACK_FORMULA.stronger },
							},	
							{
							type : "smash",
							args : [66, -22, 1.3, 0.9, 10, 6, 0.9, 5, 45, 1, SHAPE.circle, 0],
							frame : 1,
							vars : { hit_vfx_style : [HIT_VFX.slash_weak, HIT_VFX.normal_weak], hit_sfx : snd_hit_weak1, shieldstun_scaling : 0.1, 
								hitstun_scaling : 0.5 },
							},
						],
					},
				//Active
				{ length : 7, anim_start : 9, anim_end : 11 },
				//Endlag
				{ length : 20, whiff_lag : 10, anim_start : 11, anim_end : 13 },
				],
			},
		true,
		);
	//Neutral Special Hadoken
	simple_attack_define
		(
		"ryu_nspec_hadoken_sim",
			{
			sprite : spr_ryu_nspec_hadoken,
			type : "both",
			preset : SIMPLE_ATTACK_PRESET.special,
			movement : "hit_platforms",
			windows:
				[
				//Startup
				{ length : 12, anim_start : 0, anim_end : 4 },
				//Active
					{
					length : 32,
					anim_start : 5,
					anim_end : 9,
					speed : [-2, -1, true, false],
					hitboxes : 
						[
							{
							type : "projectile",
							args : [48, 0, 0.4, 0.4, 5, 6, 0.1, 45, 90, SHAPE.circle, 4, 0],
							vars : { hit_vfx_style : [HIT_VFX.magic, HIT_VFX.normal_weak], destroy_on_blocks : true },
							overlay_sprite : spr_ryu_nspec_hadoken_projectile,
							},
						],
					},
				],
			},
		true,
		);
	//Character 0's Grab
	simple_attack_define
		(
		"basic_grab_sim",
			{
			sprite : spr_basic_grab,
			type : "ground",
			movement : "ground",
			state_end : PLAYER_STATE.idle,
			windows:
				[
				//Startup
				{ length : 5, anim_start : 0, anim_end : 1 },
				//Active
					{
					length : 41,
					anim_start : 2,
					anim_end : 5,
					hitboxes : 
						[
							{
							type : "grab",
							args : [20, 4, 0.6, 0.6, 35, 0, 3, SHAPE.square],
							vars : { hit_restriction : HIT_RESTRICTION.not_ledge },
							},
						],
					},
				],
			},
		true,
		);
	//Character 0's Pummel
	simple_attack_define
		(
		"basic_pummel_sim",
			{
			sprite : spr_basic_pummel,
			preset : SIMPLE_ATTACK_PRESET.pummel,
			type : "ground",
			movement : "ground",
			windows:
				[
				//Startup
				{ length : 2, anim_start : 0, anim_end : 1 },
				//Active
					{
					length : 5,
					anim_start : 2,
					anim_end : 4,
					hitboxes : 
						[
							{
							type : "pummel",
							args : [32, 0, 1, 1, 1, 5, 0, 6, 75, 1, SHAPE.circle, 0],
							vars : { hit_sfx : snd_hit_weak1 },
							},
						],
					},
				],
			},
		true,
		);
	//Character 0's Back Throw
	simple_attack_define
		(
		"blocky_bthrow_sim",
			{
			sprite : spr_blocky_bthrow,
			preset : SIMPLE_ATTACK_PRESET.a_throw,
			type : "ground",
			movement : "ground",
			state_end : PLAYER_STATE.idle,
			windows:
				[
				//Startup
				{ length : 9, anim_start : 0, speed : [0, 0, false, false], throw_position : [-60, 0] },
				//Active
					{
					length : 16,
					anim_start : 1,
					anim_end : 5,
					hitboxes : 
						[
							{
							type : "throw",
							args : [-32, -2, 1, 0.6, 9, 7, 1.4, 11, 145, 5, SHAPE.circle, 0],
							vars : { hit_vfx_style : HIT_VFX.slash_medium, hit_sfx : snd_hit_weak1, knockback_state : PLAYER_STATE.balloon },
							},
						],
					},
				],
			},
		true,
		);
	//Forward Special Wind
	simple_attack_define
		(
		"basic_fspec_wind_sim",
			{
			sprite : spr_basic_fspec_wind,
			preset : SIMPLE_ATTACK_PRESET.aerial,
			windows:
				[
				//Startup
				{ length : 16, anim_start : 0, anim_end : 1 },
				//Active
					{
					length : 21,
					anim_start : 2,
					anim_end : 6,
					speed : [0, -3, false, false],
					hitboxes : 
						[
							{
							type : "windbox",
							args : [84, -2, 1.7, 0.7, 0, 8, 20, 10, SHAPE.circle, 0, FLIPPER.standard, true, true, false, 10, false],
							},
						],
					},
				],
			},
		true,
		);
	//Character 3's Up Tilt
	simple_attack_define
		(
		"scalar_utilt_sim",
			{
			sprite : spr_scalar_utilt,
			type : "ground",
			movement : "ground",
			hurtbox : spr_scalar_utilt_hurtbox,
			state_end : PLAYER_STATE.idle,
			windows:
				[
				//Startup
				{ length : 8, anim_start : 0, anim_end : 2 },
				//Active
					{
					length : 3,
					hitboxes : 
						[
							//Hit 1
							{
							frame : 0,
							anim_frame : 3,
							type : "magnetbox",
							args : [57, -20, 0.8, 1, 3, 6, 22, -68, 10, 1, SHAPE.circle, 0, true],
							vars : { hit_vfx_style : HIT_VFX.normal_weak, hit_sfx : snd_hit_weak1 },
							},
							{
							frame : 0,
							type : "magnetbox",
							args : [29, 6, 0.6, 0.8, 3, 6, 22, -68, 10, 1, SHAPE.circle, 0, true],
							vars : { hit_vfx_style : HIT_VFX.normal_weak, hit_sfx : snd_hit_weak0 },
							},
							{
							frame : 1,
							anim_frame : 4,
							type : "magnetbox",
							args : [50, -54, 0.6, 0.6, 3, 6, 22, -68, 8, 1, SHAPE.circle, 0, true],
							vars : { hit_vfx_style : HIT_VFX.normal_weak, hit_sfx : snd_hit_weak0 },
							},
							//Hit 2
							{
							frame : 2,
							anim_frame : 5,
							type : "melee",
							args : [22, -68, 0.75, 0.75, 6, 10, 0.9, 11, 90, 4, SHAPE.circle, 1],
							vars : { hit_vfx_style : HIT_VFX.normal_medium, hit_sfx : snd_hit_strong2, knockback_state : PLAYER_STATE.balloon },
							},
						],
					},
				{ length : 8, anim_start : 6, anim_end : 7 },
				//Endlag
				{ length : 14, whiff_lag : 9, anim_start : 7, anim_end : 10 },
				],
			},
		true,
		);
	//Cloud's Back Air
	simple_attack_define
		(
		"cloud_bair_sim",
			{
			sprite : spr_cloud_bair,
			type : "air",
			movement : "all",
			preset : SIMPLE_ATTACK_PRESET.aerial,
			state_end : PLAYER_STATE.aerial,
			vars : { landing_lag : 8 },
			windows:
				[
				//Startup
				{ length : 11, anim_start : 0, anim_end : 5 },
				//Active
					{
					length : 2,
					sound : snd_swing2,
					hitboxes : 
						[
							{
							anim_frame : 6,
							type : "melee",
							args : [-71, 9, 1.3, 0.7, 13, 4, 0.9, 10, 135, 1, SHAPE.circle, 0, FLIPPER.sakurai_reverse],
							frame : 0,
							vars : { hit_vfx_style : HIT_VFX.slash_medium, hit_sfx : snd_hit_strong1, knockback_state : PLAYER_STATE.balloon },
							},
							{
							anim_frame : 7,
							type : "melee",
							args : [-63, -16, 1.3, 0.8, 13, 4, 0.9, 10, 135, 1, SHAPE.circle, 0, FLIPPER.sakurai_reverse],
							frame : 1,
							vars : { hit_vfx_style : HIT_VFX.slash_medium, hit_sfx : snd_hit_strong1, knockback_state : PLAYER_STATE.balloon },
							},
						],
					},
				//Endlag
				{ length : 2, anim_start : 8 },
				{ length : 18, whiff_lag : 9, anim_start : 9, anim_end : 11 },
				],
			},
		true,
		);
	}
/* Copyright 2024 Springroll Games / Yosi */