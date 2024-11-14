extends Node2D
var color_bound = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_pixel_color()
	
func get_pixel_color():
	var image = get_viewport().get_texture().get_image()
	var viewport_size = get_viewport_rect().size
	var viewport_middle = Vector2(viewport_size.x / 2, viewport_size.y / 2)
	
	var pixel_color0 = image.get_pixelv($Player/SampleSpot0.position * 0.8 + viewport_middle)
	var pixel_color1 = image.get_pixelv($Player/SampleSpot1.position * 0.8 + viewport_middle)
	var pixel_color2 = image.get_pixelv($Player/SampleSpot2.position * 0.9 + viewport_middle)
	var pixel_color3 = image.get_pixelv($Player/SampleSpot3.position * 0.9 + viewport_middle)

	#$CanvasLayer/DebugSpot0.position = $Player/SampleSpot0.position * 0.8 + viewport_middle
	#$CanvasLayer/DebugSpot1.position = $Player/SampleSpot1.position * 0.8 + viewport_middle
	#$CanvasLayer/DebugSpot2.position = $Player/SampleSpot2.position * 0.9 + viewport_middle
	#$CanvasLayer/DebugSpot3.position = $Player/SampleSpot3.position * 0.9 + viewport_middle
	#$Player/ColorRect.color = pixel_color0
	#print(pixel_color1)
	
	#If the color is too bright
	if pixel_color0.r > color_bound or pixel_color1.r > color_bound or pixel_color2.r > color_bound or pixel_color3.r > color_bound:
		in_sun()
	else:
		$Player/Label.visible = false

func in_sun():
	$Player/Label.visible = true
	#ShakeBus.trigger_shake()
