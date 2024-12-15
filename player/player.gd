#Basic movement from https://www.thiscodeworks.com/player-code/657df2007373ec00142ea2bd 
#Player sprite from Escpae on Itch.io (https://escape-pixel.itch.io/shadow-series-the-obesidian-shadow)

extends CharacterBody2D

var prev: String

var SPEED : int = 250
var JUMP_FORCE : int = -350
var GRAVITY : int = 900

var max_jumps: int = 2
var jump_count: int = 0

var is_game_started:bool = false

func _ready() -> void:
	GameManager.game_start.connect(game_has_started)
	
func _physics_process(delta):
	if is_game_started:
		var direction = Input.get_axis("left","right")
		
		#Walk
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

		#Jump
		if Input.is_action_just_pressed("up") and jump_count == 1:
				velocity.y = JUMP_FORCE
				jump_count = 2
		if Input.is_action_just_pressed("up") and is_on_floor():
				velocity.y = JUMP_FORCE
				jump_count = 1
		if !Input.is_action_just_pressed("up") and is_on_floor():
				jump_count = 0
		
		if not is_on_floor():
			if velocity.x < 0:
				$AnimationPlayer.play("JumpLeft")
			elif velocity.x > 0:
				$AnimationPlayer.play("JumpRight")
			else:
				if prev == "left":
					$AnimationPlayer.play("JumpLeft")
				else:
					$AnimationPlayer.play("JumpRight")
		move_and_slide()

func game_has_started():
	is_game_started = true
