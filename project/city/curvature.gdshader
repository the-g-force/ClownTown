// Inspired by https://github.com/NovemberDev/godot_curvature_shader/blob/master/curvature_shader.shader
shader_type spatial;
render_mode world_vertex_coords, cull_disabled, depth_prepass_alpha, vertex_lighting;

uniform float curvature = 5.0;
uniform float curvature_distance = 25.0;
uniform float metallic = 0.0;
uniform float roughness = 1.0;
uniform vec3 color : source_color = vec3(0.0, 0.0, 0.0);

void vertex() {
	NORMAL = (MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz;
	float dist = length(CAMERA_POSITION_WORLD.xyz - VERTEX) / curvature_distance;
	VERTEX.y -= pow(dist, curvature);
}

void fragment() {
	ALBEDO = color;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	SPECULAR = 0.5;
}
