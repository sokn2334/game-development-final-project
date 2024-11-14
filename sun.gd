extends CharacterBody2D

const SPEEDLR = 100.0
const SPEEDFB = 3000.0
const ACCEL = 10.0

var input: Vector2
@onready var sun_path = $Path2D/PathFollow2D
@onready var sun = $Path2D/PathFollow2D/PointLight2D

func _ready():
	sun.scale = Vector2(5, 5)
	sun_path.progress_ratio = 0.3

func get_input():
	input.x = Input.get_action_strength("sun_right") - Input.get_action_strength("sun_left")
	input.y = Input.get_action_strength("sun_back") - Input.get_action_strength("sun_forward")
	return input.normalized()
	
func _process(delta: float) -> void:
	var playerInput = get_input()
	var direction = Input.get_vector("sun_left","sun_right","sun_back","sun_forward")
	
	#Left and Right Sun Movement
	velocity = lerp(velocity, playerInput * SPEEDLR, delta * ACCEL)
	var moveX = remap(velocity.x, -500, 500, -0.001, 0.001)
	if direction.x != 0:
		sun_path.progress_ratio += moveX
		
	#Forward and Backward Sun Movement
	velocity = lerp(velocity, playerInput * SPEEDFB, delta * ACCEL)
	#var moveY = remap(velocity.y, -700, 700, -0.005, 0.005)
	#if direction.y != 0 and sun.scale.x >= 1 and sun.scale.x <= 5:
	#	sun.scale += Vector2(moveY, moveY)
	#elif direction.y != 0 and sun.scale.x > 5:
	#	sun.scale = Vector2(5, 5)
	#elif direction.y != 0 and sun.scale.x < 1:
	#	sun.scale = Vector2(1, 1)
