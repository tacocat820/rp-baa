#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightColor;
in vec4 overlayColor;
in vec2 texCoord;
in vec2 texCoord2;
in vec3 Pos;
in float transition;

flat in int isCustom;
flat in int isGUI;
flat in int isHand;
flat in int noshadow;
flat in int isMCrapCustom;

out vec4 fragColor;

void main() {
    vec4 color = mix(texture(Sampler0, texCoord), texture(Sampler0, texCoord2), transition);

    //custom lighting
    #define ENTITY
    #moj_import<objmc_light.glsl>

    if (isMCrapCustom == 1) {
        color = vec4(mod(Pos,vec3(1,1,1)),1);
    } else if (isMCrapCustom == 2) {
        float pos2 = mod(Pos.x+Pos.z+Pos.y*0.5,6);
        if ( pos2 > 4 ) {
            color = vec4(vec3(pos2),(1-abs(pos2-5))/3);
        } else {
            color = vec4(0,0,0,0);
        }
    } else if (isMCrapCustom == 3) {
        color = vec4(255,255,255,255);
    }

    if (color.a < 0.01) discard;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}