//NOTE: version with bluelight filter inbuilt
#version 330

in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture2D(tex, texcoord / texsize, 0);

    // 1. Standard Grayscale conversion
    float gray = (color.r * 0.299) + (color.g * 0.587) + (color.b * 0.114);

    vec3 grayscale = vec3(gray);

    return vec4(grayscale * opacity, color.a * opacity);
}
