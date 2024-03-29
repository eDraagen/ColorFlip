extends KinematicBody2D

export var move_speed = 0

var velocity := Vector2.ZERO

var can_move = true
var is_in_air = false
var can_rotate = true

export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var background = $background
var colordict = {
	"red" : Color(1, 0, 0, 0.5),
	"yellow" : Color(1, 1, 0, 0.5),
	"green" : Color(0, 1, 0, 0.5),
	"blue": Color(0, 0, 1, 0.5)
}

onready var timer = $Timer
onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _ready():
	pass

func _physics_process(delta):
	if can_move:
		_change_background_color()
		velocity.y += _get_gravity() * delta
		velocity.x = _move_right() * move_speed
		
		#check if in air, for rotating player.
		if is_on_floor():
			is_in_air = false
		if not is_on_floor():
			is_in_air = true
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			_jump()
			$"/root/EventsAutoload".emit_signal("play_jump_sound")
			
		if Input.is_action_just_released("jump"):
			_jump_cut()
			
		#Rotation forward and backward.
		if is_in_air:
			if can_rotate:
				if Input.is_action_just_pressed("a"):
					_rotate_tween_forward()
					can_rotate = false
					timer.start()
					#_get_rotation()

					
						
				if Input.is_action_just_pressed("d"):
					_rotate_tween_backwards()
					can_rotate = false
					timer.start()
					#_get_rotation()

		velocity = move_and_slide(velocity, Vector2.UP)

func _get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _jump():
	velocity.y = jump_velocity
	
func _jump_cut():
	if velocity.y < -100:
		velocity.y = -100

func _move_right() -> float:
	var move_right := 1.0
	return move_right

func _on_deathCollider_body_entered(_body):
	can_move = false
	$Explosion.emitting = true
	$Sprite.visible = false
	$"/root/EventsAutoload".emit_signal("play_death_sound")
	
func _camera_stop():
	can_move = false

func _rotate_tween_forward():
	var tween := create_tween()
	tween.tween_property(self, "rotation_degrees", rotation_degrees-90, 0.1)

func _rotate_tween_backwards():
	var tween := create_tween()
	tween.tween_property(self, "rotation_degrees", rotation_degrees+90, 0.1)

func _on_Timer_timeout():
	can_rotate = true

func _change_background_color():
	var g = rotation_degrees
	if g == 0:
		background.color = colordict.yellow
	if g == 90:
		background.color = colordict.red 
	if g == -180:
		background.color = colordict.blue 
	if g == -90:
		background.color = colordict.green 
