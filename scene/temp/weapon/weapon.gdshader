shader_type canvas_item;

// 着色
uniform vec4 line_color : source_color = vec4(0,0,0,1);
// 描边的厚度
uniform float line_thickness : hint_range(0.0, 10, 0.1) = 1.0;
// 八个方向的偏移值,利用这八个方向，将颜色扩张
const vec2 OFFSET[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), 
	vec2(0, 1), vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	// Place fragment code here.
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	float outline = 0.0;
	
	for(int i=0; i< OFFSET.length(); i++){
		outline += texture(TEXTURE, UV + size * OFFSET[i]).a;
	}
	
	outline = min(outline, 1.0);
	
	vec4 color = texture(TEXTURE, UV);
	// 注意要将原图的透明值减掉
	COLOR = mix(color, line_color, outline - color.a);
}
