shader_type canvas_item;

uniform bool apply_ca = true;
uniform bool apply_fog = true;
uniform bool apply_vig = true;
uniform bool apply_glow = true;
uniform float white_fade:hint_range(0.0, 1.0) = 0.0;
uniform float ca_amount:hint_range(0.0, 0.5) = 0.1;
uniform float fog_amount:hint_range(0.0, 1.0) = 0.5;
uniform float vig_amount:hint_range(0.0, 1.0) = 0.5;
uniform float glow_amount:hint_range(0.0, 1.0) = 0.5;
uniform float glow_threshold:hint_range(0.0, 1.0) = 0.5;
uniform sampler2D offset_texture : hint_white;

vec4 sample_glow_pixel(sampler2D tex, vec2 uv) {
    return max(textureLod(tex, uv, 2.0) - glow_threshold, vec4(0.0));
}

vec4 pow_vec4(vec4 vec, float pw){
	return vec4(pow(vec.r, pw), pow(vec.g, pw), pow(vec.b, pw), pow(vec.a, pw));
}

void fragment() {
	vec4 texture_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 color = texture_color;
	
	if (apply_ca) {
		float adjusted_amount = ca_amount * texture(offset_texture, SCREEN_UV).r / 100.0;
		color.r = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x + adjusted_amount, SCREEN_UV.y)).r;
		color.g = texture(SCREEN_TEXTURE, SCREEN_UV).g;
		color.b = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x - adjusted_amount, SCREEN_UV.y)).b;
		color = color * texture(offset_texture, SCREEN_UV);
		//color = mix(color, texture(offset_texture, SCREEN_UV));
	}
	if (apply_fog){
		vec3 col = texture(SCREEN_TEXTURE, SCREEN_UV).xyz * 0.16;
    	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, SCREEN_PIXEL_SIZE.y)).xyz * 0.15;
	    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, -SCREEN_PIXEL_SIZE.y)).xyz * 0.15;
	    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, 2.0 * SCREEN_PIXEL_SIZE.y)).xyz * 0.12;
	    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, 2.0 * -SCREEN_PIXEL_SIZE.y)).xyz * 0.12;
	    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, 3.0 * SCREEN_PIXEL_SIZE.y)).xyz * 0.09;
	    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, 3.0 * -SCREEN_PIXEL_SIZE.y)).xyz * 0.09;
	    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, 4.0 * SCREEN_PIXEL_SIZE.y)).xyz * 0.05;
	    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, 4.0 * -SCREEN_PIXEL_SIZE.y)).xyz * 0.05;
		vec4 newcol = (vec4(col, 1.0) * texture(offset_texture, SCREEN_UV));
		color = (1.-fog_amount)*color + (fog_amount)*newcol;
	}
	if (apply_vig){
		color = vig_amount*color + (1.-vig_amount)*texture(offset_texture, SCREEN_UV);
	}
	if (apply_glow){
		vec2 ps = SCREEN_PIXEL_SIZE;
	    vec4 col0 = sample_glow_pixel(SCREEN_TEXTURE, SCREEN_UV + vec2(-ps.x, 0));
	    vec4 col1 = sample_glow_pixel(SCREEN_TEXTURE, SCREEN_UV + vec2(ps.x, 0));
	    vec4 col2 = sample_glow_pixel(SCREEN_TEXTURE, SCREEN_UV + vec2(0, -ps.y));
	    vec4 col3 = sample_glow_pixel(SCREEN_TEXTURE, SCREEN_UV + vec2(0, ps.y));

	    vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
	    vec4 glowing_col = 0.25 * (col0 + col1 + col2 + col3);
	    color = (1.-glow_amount)*color + (glow_amount)*vec4(col.rgb + glowing_col.rgb, col.a);
		//COLOR = color;
	}
	//offset_texture.a *= 0.2;
	COLOR = color + (vec4(white_fade));
	//COLOR = COLOR * color;
}