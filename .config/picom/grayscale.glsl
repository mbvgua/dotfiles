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


//NOTE: left dark patches after one too many switches, hence
//needed to turn off redhsift to stop the interference, thus went
//for the above one
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


// NOTE: doesnt work for some reason
// #version 330
// in vec2 texcoord;             // Texture coordinates
// uniform sampler2D tex;        // The screen texture
// uniform float opacity;        // Window opacity
//
// vec4 window_shader() {
//     // 1. Get the original color of the pixel
//     vec2 texsize = textureSize(tex, 0);
//     vec4 color = texture2D(tex, texcoord / texsize, 0);
//
//     // 2. Convert to Grayscale using the Luminosity Method
//     // These weights (0.2126, 0.7152, 0.0722) match human eye perception
//     float gray = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
//
//     // 3. Return the new color (Gray, Gray, Gray) while preserving Alpha
//     return vec4(vec3(gray) * opacity, color.a * opacity);
// }

