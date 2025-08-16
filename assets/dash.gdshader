shader_type canvas_item;

// Shader parameters to control flipping
uniform bool flip_h = false;  // Flip horizontally
uniform bool flip_v = false;  // Flip vertically

void fragment() {
    // Get the UV coordinates
    vec2 uv = UV;
    
    // Flip horizontally if enabled
    if (flip_h) {
        uv.x = 1.0 - uv.x;
    }
    
    if (flip_v) {
        uv.y = 1.0 - uv.y;
    }
    
    vec4 tex = texture(TEXTURE, uv);
    
    COLOR.rgb = mix(tex.rgb, vec3(0.0, 0.0, 0.0), 0.5);
    COLOR.a = tex.a;
}