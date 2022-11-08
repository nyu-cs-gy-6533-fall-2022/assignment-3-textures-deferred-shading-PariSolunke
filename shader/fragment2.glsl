#version 330 core

in vec2 UV;

out vec4 outColor;

uniform sampler2D renderedTexture;

void main(){
	outColor = vec4(texture(renderedTexture, UV).xyz, 1.0) ;
}