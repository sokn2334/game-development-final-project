extends CharacterBody2D
@onready var animation = $AnimationPlayer
@export var SPEED : int = 100
@export var GRAVITY : int = 900
@export var TIME : float = 1
var direction: String
var game_ended:bool = false 
var did_squeak:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = 'right'
	game_ended = false 
	GameManager.game_over_screen_on.connect(game_has_ended)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	if $Timer.is_stopped():
		$Timer.wait_time = TIME
		$Timer.start()
	if direction == 'left':
		velocity.x = -SPEED 
		animation.play("rat_walk_left")
	elif direction == 'right':
		velocity.x = SPEED
		animation.play("rat_walk_right")
	move_and_slide()

func _on_timer_timeout() -> void:
	if direction == 'right':
		direction = 'left'
	else:
		direction = 'right'
	pass # Replace with function body.

func _on_hurt_body_entered(body: Node2D) -> void:
	if (game_ended == false):
		GameManager.game_ended()

func game_has_ended():
	game_ended = true


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if did_squeak == false:
		$Squeak.play()
	did_squeak = true
