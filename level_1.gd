extends Node2D

@onready var camera = $Player/Camera2D

var game_started:bool = true 
var color_bound = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.zoom.x = 1.2
	camera.zoom.y = 1.2
	GameManager.game_start.connect(game_has_started)
	GameManager.game_started()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_started == true:
		get_pixel_color()
	
func get_pixel_color():
	var image = get_viewport().get_texture().get_image()
	var viewport_size = get_viewport_rect().size
	var viewport_middle = Vector2(viewport_size.x / 2, viewport_size.y / 2)
	
	var pixel_color0 = image.get_pixelv($Player/SampleSpot0.position * 0.8 + viewport_middle)
	var pixel_color1 = image.get_pixelv($Player/SampleSpot1.position * 0.8 + viewport_middle)
	var pixel_color2 = image.get_pixelv($Player/SampleSpot2.position * 0.9 + viewport_middle)
	var pixel_color3 = image.get_pixelv($Player/SampleSpot3.position * 0.9 + viewport_middle)
	
	#If the color is too bright for player
	if pixel_color0.r > color_bound or pixel_color1.r > color_bound or pixel_color2.r > color_bound or pixel_color3.r > color_bound:
		in_sun()
	else:
		$Player/Label.visible = false
		not_int_sun()
		
func in_sun():
	$Player/Label.visible = true
	HealthManager.player_in_sun()
	ShakeBus.trigger_shake()
	
func not_int_sun():
	HealthManager.player_not_in_sun()
	
func game_has_started():
	game_started = true
