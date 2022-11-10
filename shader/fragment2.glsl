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

	//DEPTH FOR CONTOURING
	mat3 yFilter = mat3( 1.0, 0.0, -1.0,		2.0, 0.0, -2.0,		1.0, 0.0, -1.0 );
	mat3 xFilter = mat3( 1.0, 2.0, 1.0,		0.0, 0.0, 0.0,		-1.0, -2.0, -1.0);
	float near=0.1;
	float far= 15.0;
	mat3 depthMatrix;

	for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
			vec2 neighbouringFragLocation= vec2( (i-1)/800.0f , (j-1)/600.0f ) + UV;
            float depthFloat = texture( depth, neighbouringFragLocation).r;
			float linearDepth= (2.0 * near) / (far + near - depthFloat * (far - near));  
            depthMatrix[i][j] = linearDepth; 
        }
    }
	
	float xDepthFactor = dot(xFilter[0], depthMatrix[0]) + dot(xFilter[1], depthMatrix[1]) + dot(xFilter[2], depthMatrix[2]); 
    float yDepthFactor = dot(yFilter[0], depthMatrix[0]) + dot(yFilter[1], depthMatrix[1]) + dot(yFilter[2], depthMatrix[2]);
    float combinedDepthFactor = sqrt(pow(xDepthFactor, 2.0)+pow(yDepthFactor, 2.0));

	vec3 lightDir = normalize(lightPos - posTex);
	vec3 col = clamp( colorTex.xyz * lightParams.x + 
	colorTex.xyz * max(0.0, dot(norTex, lightDir)) + 
	vec3(1.0) * pow(max(0.0, dot( normalize(camPos - posTex), normalize( reflect(-lightDir, norTex)))), lightParams.y),
	0.0, 1.0);

	//outColor = vec4(col, 1.0) ;

	outColor = vec4(col-vec3(combinedDepthFactor, combinedDepthFactor, combinedDepthFactor), 1.0) ;
}