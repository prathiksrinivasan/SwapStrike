//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

void main()
	{
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	}

/* Copyright 2024 Springroll Games / Yosi */