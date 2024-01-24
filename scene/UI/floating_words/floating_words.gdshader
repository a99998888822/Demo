shader_type canvas_item;

uniform vec4 show_color: source_color = vec4(1.0);
uniform float show_opacity: hint_range(0.0, 1.0) = 1.0;

void fragment() {
	// Place fragment code here.
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, show_color.rgb, 1.0);
	COLOR = color;
}
