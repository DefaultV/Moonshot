shader_type canvas_item;
//render_mode world_vertex_coords, unshaded, cull_disabled;

float random (vec2 uv)
{
    return fract(sin(dot(uv,vec2(12.9898,78.233)))*43758.5453123);
}
float dist(vec2 p0, vec2 pf){
	return sqrt((pf.x-p0.x)*(pf.x-p0.x)+(pf.y-p0.y)*(pf.y-p0.y));
}
uniform float wind_speed:hint_range(0.0, 31.0) = 1;
uniform float wind_strength:hint_range(0.0, 0.2) = 0.05;

uniform sampler2D gradient : hint_white;

uniform sampler2D vig : hint_white;

void vertex() {
	//float wind_offset = sin(wind_speed * TIME) * wind_strength;
	//float grad = texture(gradient, vec2(1.-UV.y, 0)).r;
	//VERTEX = VERTEX + (vec2(wind_offset * grad, 0));// * (texture(gradient, vec2(1.-UV.y, 0)).r));//(1.-(0.1+UV.y));
}

void fragment(){
	float grad = texture(gradient, vec2(1.-UV.y, 0)).r;
	vec2 uv_def = vec2(UV.x + pow((1.-UV.y) * grad, 2.) * sin(TIME * wind_speed) * wind_strength, UV.y);
	vec4 col = texture(TEXTURE, uv_def);
	//float d = min(dist((vec2(1.-SCREEN_UV.x, 0.5-SCREEN_UV.y*0.01)),SCREEN_UV)*4.,1);
	vec4 d = texture(vig, vec2(2.-SCREEN_UV.x*3., 1.5-SCREEN_UV.y*2.))*1.5;
	d = vec4(pow(d.a, 12.));
	//col.a = SCREEN_UV.x-0.5 + SCREEN_UV.y-0.5;
	//col.a = d;
	COLOR = col * min((d + 1.-grad),1);
}