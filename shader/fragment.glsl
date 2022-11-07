#version 150 core

out vec4 outColor;

in vec3 n;
in vec3 color;
in vec3 pos;
in vec2 TexCoords;
in vec2 origPos;

uniform sampler2D tex;
uniform vec3 triangleColor;
uniform vec3 lightPos;
uniform vec3 lightParams;
uniform vec3 camPos;

#define M_PI 3.141592653589793238462643383279

void main()
{
    vec3 col = color;
    vec3 normal = normalize(n);
    vec3 lightDir = normalize(lightPos - pos);
    vec2 newTexCoords = TexCoords;
    newTexCoords.x=atan(origPos.x, origPos.y) / (2. * M_PI) + 0.5;
    vec4 colorTex= texture(tex, newTexCoords);
    
    col = clamp( colorTex.xyz * lightParams.x + 
        colorTex.xyz * max(0.0, dot(normal, lightDir)) + 
        vec3(1.0) * pow(max(0.0, dot( normalize(camPos - pos), normalize( reflect(-lightDir, normal)))), lightParams.y),
        0.0, 1.0);
    
    outColor = vec4(col, 1.0);
   
}   
