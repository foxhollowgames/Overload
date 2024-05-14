shader_type canvas_item;

uniform float mix_percent: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform vec4 symbol_color: source_color;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	float grayscale = (original_color.r + original_color.g + original_color.b) / 3.0;
	
	vec4 sample_coords = vec4(vec3(grayscale), 1.0);
	
	vec4 colorized = mix(symbol_color, sample_coords, mix_percent);
	colorized.a = original_color.a;
	
	COLOR = colorized; 
}
