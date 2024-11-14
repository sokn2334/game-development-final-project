shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform vec4 light_color : source_color;
uniform float strength : hint_range(0.0, 1.0, 0.1) = 0.5;

void fragment() {
	//Modulate Example
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR.rgb = vec3(COLOR.r, COLOR.g, COLOR.b) / 3.0;
	//COLOR = light_color * strength * (1.0 - UV.y) * 1.0;
	//COLOR.a = texture(TEXTURE, UV).a;
}
