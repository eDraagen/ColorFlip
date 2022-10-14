extends Node2D

onready var signal_bus = $"/root/EventsAutoload"
func _ready():
	signal_bus.connect("play_death_sound", self, "_play_death_sound")
	signal_bus.connect("play_jump_sound", self, "_play_jump_sound")
	signal_bus.connect("start_background_music", self, "_start_background_music")
	

func _play_death_sound():
	$death_sound.play()

func _play_jump_sound():
	$jump_sound.play()

func _start_background_music():
	$game_music.play()