shader_type canvas_item;

uniform float crescent_size : hint_range(0.0, 1.0) = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
vec2 uv = (UV - vec2(0.5)) * 2.0;  // Centraliza as coordenadas
    float dist_from_center = length(uv);
    float outer_circle = step(dist_from_center, 0.5);
    float inner_circle = step(dist_from_center, crescent_size);
    float crescent = outer_circle * (1.0 - inner_circle);
    
    COLOR = vec4(1.0, 0.0, 0.0, 0.3 * crescent);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
