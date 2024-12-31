shader_type canvas_item;

// 0 -> normal
// 1 -> pressed
// 2 -> disabled
uniform int button_state : hint_range(0, 2);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	 if (button_state == 1) {
        COLOR.rgb *= vec3(0.8, 0.8, 1.0);
    } else if (button_state == 2) {
        vec3 color = texture(TEXTURE, UV).rgb;
    	float gray = dot(color, vec3(0.299, 0.587, 0.114));// Grayscale formula
    	COLOR = vec4(vec3(gray), texture(TEXTURE, UV).a);    // Preserve alpha
    }
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
