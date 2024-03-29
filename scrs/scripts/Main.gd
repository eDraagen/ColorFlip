extends Node

onready var manu = $Manu
onready var signal_bus = $"/root/EventsAutoload"
onready var manuStartButton = $Manu/main_menu/startButton
onready var manuQuitButton = $Manu/main_menu/quitButton

onready var scene_timer = $scene_timer



func _ready():
	
	#<--- Buttons connect signal --->
	manuQuitButton.connect("pressed", self, "_quit_button")
	manuStartButton.connect("pressed", self, "_start_button")
	
	
	#Timer connect signal
	scene_timer.connect("timeout", self, "_on_next_scene_timer_timeout")
	
	
#<--- BUTTONS --->
func _quit_button():
	get_tree().quit()
	
func _start_button():
	scene_timer.start(1)
	var tween := create_tween()
	tween.tween_property($Manu, "modulate", Color(1, 1, 1, 0), 0.5)
	
#<--- ON timeout change scene, when start button pressed --->
func _on_next_scene_timer_timeout():
	_next_scene()
	
func _next_scene():
	get_tree().change_scene("res://scrs/levels/Level1.tscn")


