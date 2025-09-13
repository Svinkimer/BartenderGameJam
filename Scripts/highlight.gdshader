shader_type canvas_item;
uniform float intensity = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	
	
	if (COLOR.a != 0.0) {
		COLOR = pixel_color + vec4(intensity);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
