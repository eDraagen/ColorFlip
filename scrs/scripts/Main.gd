extends Node

onready var manu = $Manu
onready var signal_bus = $"/root/EventsAutoload"

onready var manuStartButton = $Manu/main_menu/startButton
onready var manuQuitButton = $Manu/main_menu/quitButton

onready var screenTransition = $screenTransitionRect
onready var screenTransitionAnimPlayer = $screenTransitionRect/AnimationPlayer

onready var anim_timer = $anim_timer
onready var scene_timer = $scene_timer



func _ready():
	
	$"/root/EventsAutoload".emit_signal("fade_to_trans")
	#<--- Buttons connect signal --->
	manuQuitButton.connect("pressed", self, "_quit_button")
	manuStartButton.connect("pressed", self, "_start_button")
	
	
	#Timer connect signal
	anim_timer.connect("timeout", self, "_on_animation_timer_timeout")
	scene_timer.connect("timeout", self, "_on_next_scene_timer_timeout")
	
	
#<--- BUTTONS --->
func _quit_button():
	get_tree().quit()
	
func _start_button():
	$"/root/EventsAutoload".emit_signal("fade_to_black")
	anim_timer.start(0.5)
	scene_timer.start(1)
	manu.hide()


#<--- ON timeout change scene, when start button pressed --->
func _on_next_scene_timer_timeout():
	_next_scene()	
	
func _next_scene():
	get_tree().change_scene("res://scrs/levels/Level1.tscn")

func _on_animation_timer_timeout():
	$"/root/EventsAutoload".emit_signal("fade_to_trans")
