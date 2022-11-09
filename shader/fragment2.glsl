#version 330 core

in vec2 UV;

out vec4 outColor;

uniform sampler2D position;
uniform sampler2D color;
uniform sampler2D normal;
uniform sampler2D depth;

uniform vec3 lightPos;
uniform vec3 lightParams;
uniform vec3 camPos;


void main(){
	vec3 posTex = texture(position, UV).rgb;
    vec3 norTex = texture(normal, UV).rgb;
	vec3 colorTex = texture(color, UV).rgb;
	vec3 depthTex = texture(depth, UV).rgb;

	if(norTex==vec3(0.0f, 0.0f, 0.0f)){
		outColor= vec4(0.5f, 0.5f, 0.5f,1.0f);
		return;
	}
	
	vec3 lightDir = normalize(lightPos - posTex);
	vec3 col = clamp( colorTex.xyz * lightParams.x + 
	colorTex.xyz * max(0.0, dot(norTex, lightDir)) + 
	vec3(1.0) * pow(max(0.0, dot( normalize(camPos - posTex), normalize( reflect(-lightDir, norTex)))), lightParams.y),
	0.0, 1.0);

	outColor = vec4(col, 1.0) ;
}