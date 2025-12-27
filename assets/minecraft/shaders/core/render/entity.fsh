#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform vec3 ChunkOffset;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightColor;
in vec4 overlayColor;
in vec2 texCoord;
in vec2 texCoord2;
in vec3 Pos;
in vec3 ModelViewMatrix;
in float transition;


flat in int isCustom;
flat in int isGUI;
flat in int isHand;
flat in int noshadow;
flat in int isMCrapCustom;

out vec4 fragColor;

uniform float GameTime;

void main() {
    vec4 color = mix(texture(Sampler0, texCoord), texture(Sampler0, texCoord2), transition);

    //custom lighting
    #define ENTITY
    #moj_import<objmc_light.glsl>

    if (isMCrapCustom != 0) {

        if (isMCrapCustom == 1) {
            color = vec4(mod(Pos,vec3(1,1,1)),1);
        } else if (isMCrapCustom == 2) {
            vec4 orig_color = color;
            float pos2 = mod((Pos.x+Pos.z+Pos.y)*0.5,7);
            if ( pos2 > 4 ) {
                color = vec4(vec3(pos2),(1-abs(pos2-5))*orig_color.a/1.5);
            }
            else {
                color = vec4(0,0,0,0);
            }
            //2
            pos2 = pos2 = mod((Pos.x+Pos.z+Pos.y),7);
            if ( pos2 > 4 ) {
                color.a += (1-abs(pos2-5))*orig_color.a/4 ;
            }
            color.a *= pow(lightColor.r, 2) ;
        }
        else if (isMCrapCustom == 3) {
            color = vec4(255,255,255,255);
        }
        else if (isMCrapCustom == 4) {
            color = vec4(sin(fract(GameTime * 100) * 12) * (0.5 + cos(fract(Pos.y) * 20 + sin(fract(GameTime * 200) * 12) * 4)), sin(fract(GameTime * 200) * 3), 1.0 - sin(fract(GameTime * 200) * 3), 5.0);
        }
        else if (isMCrapCustom == 5) {
            color = vec4(sin(fract(GameTime * 100) * 12) * (0.5 + cos(1 * 20 + sin(fract(GameTime * 200) * 12) * 4)), sin(fract(GameTime * 200) * 3), 1.0 - sin(fract(GameTime * 200) * 3), 5.0);
        }
        else if (isMCrapCustom == 6) {
            float timeT = abs(1+sin(fract(GameTime * 66) * 12))/3;
            color = vec4( vec3(1), abs(timeT - color.r) );
        }
        else if (isMCrapCustom == 7) {
            color = vec4(FogColor.rgb, clamp((vertexDistance-17)/7,  0.0,1.0));
        }
    }

    if (color.a < 0.01) discard;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}