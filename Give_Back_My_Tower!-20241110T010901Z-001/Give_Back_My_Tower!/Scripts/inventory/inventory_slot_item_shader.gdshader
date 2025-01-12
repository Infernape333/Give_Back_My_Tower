shader_type canvas_item;

// 0 -> normal
// 1 -> pressed
// 2 -> disabled
uniform int button_state : hint_range(0, 2);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	 vec4 tex_color = texture(TEXTURE, UV);  // Fetch the texture color

    if (button_state == 1) {
        // Apply blue tint for pressed state
        COLOR = tex_color * vec4(0.8, 0.8, 1.0, 1.0);
    } else if (button_state == 2) {
        float gray = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));  // Grayscale formula
        COLOR = vec4(vec3(gray), tex_color.a);  // Preserve alpha
    } else {
        COLOR = tex_color;
    }
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
