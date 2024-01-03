extends MeshInstance3D

func _ready():
	for i in get_surface_override_material_count():
		var material := get_active_material(i)
		var new_material := ShaderMaterial.new()
		new_material.shader = preload("res://city/curvature.gdshader")
		set_surface_override_material(i, new_material)
		
		var image := Image.create(1,1,false, Image.FORMAT_RGB8)
		image.fill(material.albedo_color)
		var texture := ImageTexture.create_from_image(image)
		new_material.set_shader_parameter("base_texture", texture)
