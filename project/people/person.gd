extends Area3D

enum {MALE, FEMALE}

const MALE_CLOWNS := [
	"res://people/man_clown.tscn"
]
const FEMALE_CLOWNS := [
	"res://people/woman_clown.tscn"
]
const MALE_PEOPLE := [
	"res://people/man_not_clown.tscn"
]
const FEMALE_PEOPLE := [
	"res://people/woman_not_clown.tscn"
]

var _is_clown := false

@onready var _model : Node3D = $Node3D/man_clown
@onready var _got_hit_sound : AudioStreamPlayer3D = $GotHitSound
@onready var _gender := MALE if randi() % 2 == 0 else FEMALE
@onready var _animation_player : AnimationPlayer = $AnimationPlayer


func _ready()->void:
	if _gender == MALE:
		_make_model(MALE_PEOPLE.pick_random())
	else:
		_make_model(FEMALE_PEOPLE.pick_random())


func _make_model(path:String)->void:
	if is_instance_valid(_model):
		_model.queue_free()
	_model = load(path).instantiate()
	$Node3D.add_child(_model)
	_model.position = $CollisionShape3D.position


func _on_body_entered(body:PhysicsBody3D)->void:
	if body is Projectile and not _is_clown:
		_make_clown()
		body.resolve_made_clown()


func _make_clown()->void:
	_is_clown = true
	_got_hit_sound.play()
	_animation_player.play("bob")
	if _gender == MALE:
		_make_model(MALE_CLOWNS.pick_random())
	else:
		_make_model(FEMALE_CLOWNS.pick_random())


func _on_visible_on_screen_notifier_3d_screen_exited()->void:
	queue_free()
