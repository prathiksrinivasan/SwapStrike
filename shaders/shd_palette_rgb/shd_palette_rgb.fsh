/*
Replaces colors in the texture based on the given palette arrays. Ignores alpha values when replacing colors.
Additionally, there are uniforms for fading the texture, brightening the texture, changing the alpha, and adding an outline.
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 palette_base[48];
uniform vec4 palette_swap[48];
uniform int count;

uniform float fade_value;
uniform float light_value;
uniform float alpha_value;
uniform int outline;
uniform vec2 outline_texel;
uniform vec4 outline_color;
uniform vec3 tint;
uniform vec4 flash;

const float tolerance = 0.1;

void main()
	{
	//Check if the color is any of the base colors
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	for (int i = 0; i < 48; i++)
		{
		if (i >= count) break;
		if (gl_FragColor.a != 0. && abs(distance(gl_FragColor.rgb, palette_base[i].rgb)) <= tolerance)
			{
			//Replace it with the correct color
			gl_FragColor.rgb = v_vColour.rgb * (palette_swap[i].rgb + (gl_FragColor.rgb - palette_base[i].rgb));
			break;
			}
		}
		
	//Tint / Flash
	gl_FragColor.rgb += tint;
	gl_FragColor.rgb = mix(gl_FragColor.rgb, flash.rgb, flash.a);
		
	//Outline
	if (outline == 1 && gl_FragColor.a == 0.)
		{
		if (texture2D(gm_BaseTexture, v_vTexcoord + vec2( outline_texel.x, 0.)).a > 0. ||
			texture2D(gm_BaseTexture, v_vTexcoord + vec2(-outline_texel.x, 0.)).a > 0. ||
			texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.,  outline_texel.y)).a > 0. ||
			texture2D(gm_BaseTexture, v_vTexcoord + vec2(0., -outline_texel.y)).a > 0.)
			{
			gl_FragColor = outline_color;
			}
		}
		
	//Values
	gl_FragColor.rgb += light_value;
	gl_FragColor.rgb *= fade_value;
	gl_FragColor.a	 *= alpha_value;
	}
/* Copyright 2024 Springroll Games / Yosi */