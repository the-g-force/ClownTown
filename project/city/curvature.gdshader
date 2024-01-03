shader_type spatial;
render_mode world_vertex_coords, cull_disabled, vertex_lighting;

uniform float curvature = 5.0;
uniform float curvature_distance = 25.0;
uniform sampler2D base_texture;

void vertex() {
	NORMAL = (MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz;
	float dist = length(CAMERA_POSITION_WORLD.xyz - VERTEX) / curvature_distance;
	VERTEX.y -= pow(dist, curvature);
}

void fragment() {
	vec4 tex = texture(base_texture, UV);
	if (tex.a < 0.3) {
		discard;
	}
	ALBEDO = tex.rgb;
	ALPHA = tex.a;
}
