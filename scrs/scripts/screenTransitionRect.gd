extends ColorRect


func _ready():
	$"/root/EventsAutoload".connect("fade_to_black", self, "_fade_to_black")
	$"/root/EventsAutoload".connect("fade_to_trans", self, "_fade_to_trans")

func _fade_to_black():
	$AnimationPlayer.play("fade_to_black")

	
func _fade_to_trans():
	$AnimationPlayer.play("fade_to_transparent")
	
