//vec4 sample_1 = textureLod(Sampler0, vec2(UV0.x + x_offset*2, UV0.y), 0);
//realTexSizeY = 256*(sample_1.r);

//third pixel is texture height marker.
//realTexSizeY = R + G*256 + B*65536
float getYsize(float x_offset) {
    vec4 sample_1 = textureLod(Sampler0, vec2(UV0.x + x_offset*2, UV0.y), 0);
    return 256*(sample_1.r);
}