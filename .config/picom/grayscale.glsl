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

    // 2. Apply "Warmth" (Blue Light Filter)
    // For 3400K: R=1.0, G=0.82, B=0.59
    // (For 5700K: R=1.0, G=0.96, B=0.91)
    vec3 warm_gray = vec3(
        gray * 1.20,  // Slight boost to red
        gray * 0.80, // Neutral green
        gray * 0.50   // Significantly reduced blue
    );

    return vec4(warm_gray * opacity, color.a * opacity);
}
