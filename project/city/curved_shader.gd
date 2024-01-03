extends MeshInstance3D

func _ready():
	for i in get_surface_override_material_count():
		var material := get_active_material(i)
		var new_material := ShaderMaterial.new()
		new_material.shader = preload("res://city/curvature.gdshader")
		set_surface_override_material(i, new_material)
		
		new_material.set_shader_parameter("color", material.albedo_color)
		new_material.set_shader_parameter("metallic", material.metallic)
		new_material.set_shader_parameter("roughness", material.roughness)
