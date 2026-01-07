ivec2 textureAtlasSIZE = textureSize(Sampler0, 0);
float y_offset = 1.0 / vec2(textureAtlasSIZE).y ;
float offset_mod = realTexSizeY / (realTexSizeY + 2.0);
float offset2 = texCoordStartY*(1-offset_mod);

vec2 texture_coord;
if (texCoordStartY < texCoord.y) {
    texture_coord = vec2(texCoord.x, (texCoord.y)*offset_mod + offset2 + y_offset);
} else {
    texture_coord = vec2(texCoord.x, (texCoord.y)*offset_mod + offset2 - y_offset);
}
color = mix(texture(Sampler0, texture_coord), texture(Sampler0, texCoord2), transition);
