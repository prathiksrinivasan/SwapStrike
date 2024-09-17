/*
This shader spreads the texture smoothly over an area defined by 4 corners.
*/
uniform vec4 sprite_uvs;

varying vec4 v_vColor;
varying vec2 v_vTexcoord;
varying vec2 v_vA;
varying vec2 v_vE;
varying vec2 v_vF;
varying vec2 v_vG;
varying float v_vk2;

void main()
	{
	//Calculate the remaining constants
	vec2 uv = vec2(0.0, 0.0);
	vec2 E = v_vE;
	vec2 F = v_vF;
	vec2 G = v_vG;
	vec2 H = (gl_FragCoord.xy - v_vA);
	float k2 = v_vk2;
	float k1 = ((E.x * F.y) - (E.y * F.x)) + ((H.x * G.y) - (H.y * G.x));
	float k0 = (H.x * E.y) - (H.y * E.x);
	
	//Check if the edges are parallel (gets rid of the squared term)
	if (abs(k2) < 0.00001)
		{
		uv.x = ((H.x * k1) + (F.x * k0)) / ((E.x * k1) - (G.x * k0));
		uv.y = -(k0 / k1);
		}
	else
		{
		//Use the quadratic formula to solve
		float intermediate = (k1 * k1) - (4.0 * k0 * k2);
		
		//Avoid doing a negative square root (from invalid coordinates)
		if (intermediate >= 0.0)
			{
			//Finish solving for y
			intermediate = sqrt(intermediate);
			float bottom = (0.5 / k2);
			uv.y = (-k1 + intermediate) * bottom;
			
			//Find x
			uv.x = (H.x - (F.x * uv.y)) / (E.x + (G.x * uv.y));
			
			//Get the negative square root instead of the positive one if the percentages aren't in range
			if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0)
				{
				uv.y = (-k1 - intermediate) * bottom;
				uv.x = (H.x - (F.x * uv.y)) / (E.x + (G.x * uv.y));
				}
			}
		}
	
	//Get the color sample
	gl_FragColor = v_vColor * texture2D(gm_BaseTexture, sprite_uvs.xy + ((sprite_uvs.zw - sprite_uvs.xy) * uv));
	}
/* Copyright 2024 Springroll Games / Yosi */