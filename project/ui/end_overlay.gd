extends Control

var pies_thrown := 0
var converts := 0

@onready var _report_label : Label = $ReportLabel


func _ready():
	get_tree().paused = true
	_report_label.text = "You threw %s pies and \n converted %s people to CLOWNDOM!" % [pies_thrown, converts]


func _on_play_again_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world.tscn")
