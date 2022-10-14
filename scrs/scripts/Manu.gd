extends Control

onready var signal_bus = $"/root/EventsAutoload"



func _on_music_controller_bar_value_changed(value:float):
	AudioServer.set_bus_volume_db(0, -value)
	


func _on_jump_sound_checkbox_toggled(button_pressed:bool):
	
	if button_pressed == true:
		AudioServer.set_bus_mute(1, false)
	
	if button_pressed == false:
		AudioServer.set_bus_mute(1, true)
