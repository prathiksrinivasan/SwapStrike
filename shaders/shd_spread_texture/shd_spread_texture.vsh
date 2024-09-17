/*
This shader spreads the texture smoothly over an area defined by 4 corners.
*/
attribute vec2 in_Position;

uniform vec4 corners_AB;
uniform vec4 corners_CD;

varying vec2 v_vA;
varying vec2 v_vE;
varying vec2 v_vF;
varying vec2 v_vG;
varying float v_vk2;

void main()
	{
	//Default shader stuff
	vec4 object_space_pos = vec4(in_Position.x, in_Position.y, 1.0, 1.0);
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	//Get the corners from the uniforms
	vec2 A = corners_AB.xy;
	vec2 B = corners_AB.zw;
	vec2 C = corners_CD.xy;
	vec2 D = corners_CD.zw;
	
	//Calculate the constants for the formula
	vec2 E = (B - A);
	vec2 F = (D - A);
	vec2 G = (A - B) + (C - D);
	
	//Calculate as many of the constants as possible without having the x and y
	float k2 = (G.x * F.y) - (G.y * F.x);
	
	//Pass the constants to the fragment shader
	v_vE = E;
	v_vF = F;
	v_vG = G;
	v_vk2 = k2;
	
	//Pass the A corner, because GameMaker doesn't allow using uniforms in both parts of the shader
	v_vA = A;
	}
/* Copyright 2024 Springroll Games / Yosi */