shader_type canvas_item;

uniform vec4 room_color: source_color = vec4(1.0);

void fragment() {
	// Place fragment code here.
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, room_color.rgb, 1.0);
	COLOR = color;
}
