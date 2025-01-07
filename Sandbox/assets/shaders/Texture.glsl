#type vertex
#version 330 core
layout (location = 0) in vec3 a_Pos;
layout (location = 0) in vec4 a_Color;
layout (location = 1) in vec2 a_TexCoord;

out vec2 v_TexCoord;
out vec4 v_Color;

uniform mat4 u_View;
uniform mat4 u_Projection;

void main(){
	v_TexCoord = a_TexCoord;
	v_Color = a_Color;
	gl_Position = u_Projection * u_View * vec4(a_Pos, 1.0);
}

#type fragment
#version 330 core

layout(location = 0) out vec4 FragColor;

in vec2 v_TexCoord;
in vec4 v_Color;

uniform vec4 u_Color;
uniform float u_TilingFactor;
uniform sampler2D u_Texture;

void main(){
	// FragColor = vec4(v_TexCoord.x, v_TexCoord.x, v_TexCoord.x, 1.0);
	FragColor = v_Color;
}