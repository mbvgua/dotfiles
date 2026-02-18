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
    // We reduce Blue and slightly increase Red to mimic a 3500K-4500K temperature
    vec3 warm_gray = vec3(
        gray * 1.1,  // Slight boost to red
        gray * 0.95, // Neutral green
        gray * 0.7   // Significantly reduced blue
    );

    return vec4(warm_gray * opacity, color.a * opacity);
}


// no inbuilt bluelight filter yet redshift is deactivated hence used above one
// #version 330
//
// in vec2 texcoord;             
// uniform sampler2D tex;        
// uniform float opacity;        
//
// vec4 window_shader() {
//     vec2 texsize = textureSize(tex, 0);
//     vec4 color = texture2D(tex, texcoord / texsize, 0);
//
//     // Using a simpler conversion math that handles float precision better
//     float gray = (color.r * 0.299) + (color.g * 0.587) + (color.b * 0.114);
//
//     // Construct the output carefully
//     vec3 grayscale = vec3(gray);
//
//     return vec4(grayscale * opacity, color.a * opacity);
// }
