extends Area3D

enum {MALE, FEMALE}

const MALE_CLOWNS := [
	"res://people/models/man_clown.glb"
]
const FEMALE_CLOWNS := [
	"res://people/models/woman_clown.glb"
]
const MALE_PEOPLE := [
	"res://people/models/man_not_clown.glb"
]
const FEMALE_PEOPLE := [
	"res://people/models/woman_not_clown.glb"
]

var _is_clown := false

@onready var _model : Node3D = $man_clown
@onready var _gender := MALE if randi() % 2 == 0 else FEMALE


func _ready()->void:
	if _gender == MALE:
		_make_model(MALE_PEOPLE.pick_random())
	else:
		_make_model(FEMALE_PEOPLE.pick_random())


func _make_model(path:String)->void:
	if is_instance_valid(_model):
		_model.queue_free()
	_model = load(path).instantiate()
	add_child(_model)
	_model.position = $CollisionShape3D.position


func _on_body_entered(body:PhysicsBody3D)->void:
	if body is Projectile and not _is_clown:
		_make_clown()
		body.queue_free()


func _make_clown()->void:
	_is_clown = true
	if _gender == MALE:
		_make_model(MALE_CLOWNS.pick_random())
	else:
		_make_model(FEMALE_CLOWNS.pick_random())
