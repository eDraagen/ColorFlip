extends Node

onready var signal_bus = $"/root/EventsAutoload"

func _ready():
	pass

func _process(_delta):
	_get_input()

func _get_input():
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("esc"):
		get_tree().change_scene("res://scrs/main/Main.tscn")

func _on_Timer_timeout():
	signal_bus.emit_signal("start_background_music")