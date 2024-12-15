extends CanvasLayer

@onready var animation = $HealthBar/AnimationPlayer
@onready var light = $EndScreen/PointLight2D
@onready var current_scene = get_tree().get_current_scene().get_name()
var timerOn = false
var start_screen_on = true
var end_screen_on = false
var start_screen_light:int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HealthManager.in_sun.connect(in_sun)
	HealthManager.not_in_sun.connect(not_in_sun)
	GameManager.game_over.connect(game_is_over)
	GameManager.win.connect(game_is_won)
	GameManager.new_level.connect(going_new_level)
	$AudioStreamPlayer.play(AudioManager.musicProgress)  
	if current_scene == "Main":
		$StartScreen.visible = true
		$EndScreen.visible = false
	else:
		$StartScreen.visible = false
		$EndScreen.visible = false
	$HealthBar.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.get_death_count() > 1:
		GameManager.game_started()
		$StartScreen.visible = false
		$HealthBar.visible = true
	if animation.is_playing() and end_screen_on == false:
		var new_health = int(100 - (100 * $HealthBar/AnimationPlayer.get_current_animation_position()-1))
		$HealthBar/Label.text = str(new_health)
		HealthManager.set_health(new_health)
		if new_health <= 1:
			GameManager.game_ended()
	if start_screen_on == true:
		$StartScreen/AnimationPlayer.play("idle")
		if $StartScreen/PointLight2D.position.x > 1100:
			start_screen_light = -1
		elif $StartScreen/PointLight2D.position.x < 0:
			start_screen_light = 1
		$StartScreen/PointLight2D.position.x += 1 * start_screen_light
		$StartScreen/PointLight2D.rotate(0.0015 * start_screen_light)
func in_sun():
	animation.play("in_sun")
	#If you go back in the sun before the timer is done
	if timerOn == true:
		timerOn = false
		$HealthBar/TimeBeforeHeal.stop()
	if animation.get_current_animation_position() > 1.9:
		animation.stop()
	
	if not $Sizzle.playing and end_screen_on == false:
		$Sizzle.play()
	if end_screen_on == true:
		$Sizzle.stop()
func not_in_sun():
	if animation.get_current_animation() == "in_sun":
		if animation.get_current_animation_position() > 0 and timerOn == false:
			animation.pause()
			$HealthBar/TimeBeforeHeal.start()
			timerOn = true
	$Sizzle.stop()

func _on_time_before_heal_timeout() -> void:
	animation.play("in_sun", -1, -1, false)
	await animation.animation_finished
	timerOn = false

func _on_button_mouse_entered() -> void: 
	$ButtonHover.play()
	if start_screen_on:
		var white = Color(0.0,0.0,0.0,1.0)
		$StartScreen/Start.set("theme_override_colors/font_color",white)
		$StartScreen/Start_Color.visible = true
	if end_screen_on:
		var white = Color(0.0,0.0,0.0,1.0)
		$EndScreen/Restart.set("theme_override_colors/font_color",white)
		$EndScreen/Restart_Color.visible = true
func _on_button_mouse_exited() -> void:
	if start_screen_on:
		var black = Color(1.0,1.0,1.0,1.0)
		$StartScreen/Start.set("theme_override_colors/font_color",black)
		$StartScreen/Start_Color.visible = false
	if end_screen_on:
		var black = Color(1.0,1.0,1.0,1.0)
		$EndScreen/Restart.set("theme_override_colors/font_color",black)
		$EndScreen/Restart_Color.visible = false

#If the start button is pressed
func _on_button_pressed() -> void:
	GameManager.game_started()
	$StartScreen.visible = false
	$HealthBar.visible = true
	
func _on_re_button_pressed() -> void:
	AudioManager.musicProgress = $AudioStreamPlayer.get_playback_position()   
	get_tree().reload_current_scene()
	
func game_is_over():
	$EndScreen.visible = true
	GameManager.game_over_screen_is_on()
	
	light.scale = Vector2(0.1, 0.1)
	var tween = get_tree().create_tween().set_loops(-1)
	tween.tween_property(light, "scale", Vector2(0.55, 0.55), 2).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(light, "scale", Vector2(0.0, 0.0), 2).set_trans(Tween.TRANS_EXPO)


	var deaths = GameManager.get_death_count()
	if deaths == 1:
		$EndScreen/Deaths.text = "You died " + str(deaths) + " time"
	else:
		$EndScreen/Deaths.text = "You died " + str(deaths) + " times"
	end_screen_on = true
	
func game_is_won():
	var deaths = GameManager.get_death_count()
	$WinScreen/Deaths.text = "You only died " + str(deaths) + " times"
	$WinScreen.visible = true
	$StartScreen.visible = false
	$EndScreen.visible = false
	$HealthBar.visible = false
	GameManager.game_over_screen_is_on()
	$WinScreen/AnimationPlayer.play("idle")

func going_new_level():
	AudioManager.musicProgress = $AudioStreamPlayer.get_playback_position()   

	
