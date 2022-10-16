extends Area2D

onready var scene_timer = $scene_timer
onready var current_scene = get_tree().get_current_scene().get_name()


func _ready():
	connect("body_entered", self, "_player_collide_with_flag")
	$"/root/EventsAutoload".connect("finish_flag_change_level", self, "_change_level")
	scene_timer.connect("timeout", self, "_on_timeout")
	

	
func _player_collide_with_flag(_body):
	$AnimationPlayer.play("victory_anim")
	$"/root/EventsAutoload".emit_signal("finish_flag_collide_with_player") #emit signal to player, stopping camera movement.
	scene_timer.start(2)

func _change_level():
	# get_tree().change_scene("res://scrs/levels/Level2.tscn")

	get_tree().change_scene("res://scrs/levels/Level"+str(int(get_tree().current_scene.filename[-6])+1)+".tscn")
	
	

func _on_timeout():
	$"/root/EventsAutoload".emit_signal("finish_flag_change_level")
	

