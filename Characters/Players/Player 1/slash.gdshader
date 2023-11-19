shader_type canvas_item;

uniform sampler2D lifetime_gradient;
uniform sampler2D tone_mapping;

void fragment() {
	float particle_life = COLOR.r;
	vec4 base_color = texture(TEXTURE,UV);
	base_color += texture(tone_mapping, base_color.rr);
	float appearance_state = particle_life * 2.0 - UV.x * 0.3;
	if (appearance_state > 0.0){
		COLOR = texture(lifetime_gradient, vec2(appearance_state)) * base_color;
	}
	else {
		COLOR.a = 0.0;
	}
}
