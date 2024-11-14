#Basic movement from https://www.thiscodeworks.com/player-code/657df2007373ec00142ea2bd 
#Player sprite from Escpae on Itch.io (https://escape-pixel.itch.io/shadow-series-the-obesidian-shadow)

extends CharacterBody2D

var prev: String
var camera: Camera2D

@export var SPEED : int = 200
@export var JUMP_FORCE : int = 300
@export var GRAVITY : int = 900

func _ready() -> void:
	camera = get_tree().get_root().get_node('/root/Main/Player/Camera2D')

func _physics_process(delta):
	var direction = Input.get_axis("left","right")

	if direction:
		velocity.x = SPEED * direction
		if is_on_floor():
			if velocity.x < 0:
				$AnimationPlayer.play("Walk_left")
				prev = "left"
			elif velocity.x > 0:
				$AnimationPlayer.play("Walk_right")
				prev = "right"
	else:
		velocity.x = 0
		if is_on_floor():	
			$AnimationPlayer.play("Idle")

	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Jump
	if is_on_floor():
		if Input.is_action_just_pressed("up"):
			direction = Input.get_axis("left","right")
			velocity.y -= JUMP_FORCE
			if prev == "left":
				$AnimationPlayer.play("JumpLeft")
			elif prev == "right":
				$AnimationPlayer.play("JumpRight")
	
	move_and_slide()

	
