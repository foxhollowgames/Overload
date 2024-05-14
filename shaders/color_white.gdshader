shader_type canvas_item;

uniform vec4 flash_color: source_color = vec4(1.0);
uniform float flash_percent: hint_range(0.0, 1.0) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	
	COLOR = mix(original_color, flash_color, flash_percent);
	COLOR.a *= original_color.a;
}
