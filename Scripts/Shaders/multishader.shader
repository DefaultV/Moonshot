shader_type canvas_item;

uniform bool apply_ca = true;
uniform bool apply_fog = true;
uniform bool apply_vig = true;
uniform bool apply_glow = true;
uniform bool apply_desert = true;
uniform float white_fade:hint_range(0.0, 1.0) = 0.0;
uniform float ca_amount:hint_range(0.0, 0.5) = 0.1;
uniform float fog_amount:hint_range(0.0, 1.0) = 0.5;
uniform float vig_amount:hint_range(0.0, 1.0) = 0.5;
uniform float glow_amount:hint_range(0.0, 1.0) = 0.5;
uniform float glow_threshold:hint_range(0.0, 1.0) = 0.5;
uniform float desert_amount:hint_range(0.0, 0.5) = 0.5;
uniform sampler2D offset_texture : hint_white;
uniform sampler2D desert_weather : hint_white;

vec4 sample_glow_pixel(sampler2D tex, vec2 uv) {
    return max(textureLod(tex, uv, 2.0) - glow_threshold, vec4(0.0));
}

vec4 pow_vec4(vec4 vec, float pw){
	return vec4(pow(vec.r, pw), pow(vec.g, pw), pow(vec.b, pw), pow(vec.a, pw));
}

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))
                 * 43758.5453123);
}

float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
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
	if (apply_desert){
		vec2 uv = SCREEN_UV;
		//uv += (texture(desert_weather, vec2(TIME, 0.0)).rb-vec2(.53))*50.0;
		vec4 lay1 = texture(desert_weather, (vec2(uv.x*2., uv.y)*7.)+vec2(-TIME*1.8, TIME*0.4))*1.;
		lay1.b *= 0.4;
		//vec4 lay2 = texture(desert_weather, (vec2(uv.x*2., uv.y)*2.5)+vec2(-TIME, sin(TIME*0.4)))*0.7;
		vec4 lay3 = texture(desert_weather, (vec2(uv.x*2., uv.y)*5.)+vec2(-TIME*2.9, TIME*0.35))*1.;
		//vec4 rnd_noise = vec4(noise((SCREEN_UV*10.)))*max(sin(TIME*2.)*2.0, 0.0);
		color = color*(1.-desert_amount) + (((lay1 + lay3))*texture(offset_texture, SCREEN_UV)*desert_amount);
		//color = rnd_noise;
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