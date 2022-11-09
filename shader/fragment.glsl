#version 330 core

out vec4 outPos;
out vec4 outColor;
out vec4 outNorm;


in vec3 n;
in vec3 color;
in vec3 pos;
in vec2 TexCoords;
in vec2 origPos;

uniform sampler2D tex;

#define M_PI 3.141592653589793238462643383279

void main()
{
    vec3 col = color;
    vec3 normal = normalize(n);
    
    vec2 newTexCoords = TexCoords;
    newTexCoords.x=atan(origPos.x, origPos.y) / (2. * M_PI) + 0.5;
    vec4 colorTex= texture(tex, newTexCoords);


    outPos= vec4(pos, 1.0);
    outColor = vec4(colorTex.xyz,1.0);
    outNorm= vec4(normal,1.0);
}   
