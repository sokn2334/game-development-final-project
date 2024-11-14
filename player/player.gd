#Basic movement from KobeDev on Youtube (https://www.youtube.com/watch?v=YJuWIFzXeaY)
#Player sprite from Escpae on Itch.io (https://escape-pixel.itch.io/shadow-series-the-obesidian-shadow)

extends CharacterBody2D

var prev: String
var camera: Camera2D

@export var speed = 200
@export var jump_speed = -800
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25


func _ready() -> void:
	camera = get_tree().get_root().get_node('/root/Main/Player/Camera2D')
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	if velocity.x < 0:
		$AnimationPlayer.play("Walk_left")
		prev = "left"
	elif velocity.x > 0:
		$AnimationPlayer.play("Walk_right")
		prev = "right"

	else:
		$AnimationPlayer.play("Idle")
		
	move_and_slide()
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_speed
	
