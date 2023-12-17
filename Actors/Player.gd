extends KinematicBody2D


var speed = 600
var boost_use = true
var stop_distance = 20

onready var save_file = Global.game_data
onready var turbo_sprite =  $"../TurboSprite"
var beefly_sound = preload("res://SFX/beefly.wav")

var random = RandomNumberGenerator.new()

func _ready() -> void:
	$AnimatedSprite.play()
	var SFX_vol = save_file.SFX_vol
	$PlayerSFX.volume_db = linear2db(SFX_vol * 5)
	

func _physics_process(delta):
	#Hacer que mire hacia el mouse
	var mouse_position = get_global_mouse_position()
	look(mouse_position)
	mov(mouse_position)
	
	if(Input.is_action_just_pressed("left_click")):
		boost()
		
	
		
	
		
func look(t):
	look_at(t)
	rotation_degrees = rotation_degrees + 90
	
func mov(t):
	#Determinamos la dirección hacia donde se moverá
	var direction = t - position
	var direction_normalized = direction.normalized()
	#SOLO se mueve si la distancia entre el mouse y el jugador es mayor a 20
	if position.distance_to(t) > stop_distance:
		move_and_slide(direction_normalized * speed)

func boost():
	if boost_use == true:
		boost_use = false
		speed += 200
		$AnimatedSprite.speed_scale += 1.5
		$Particles2D.emitting = true
		turbo_sprite.modulate = Color(0.8, 0.3, 0.3)
		var pitch_change = random.randf_range(.25,-.25)
		$PlayerSFX.set_pitch_scale(1 + pitch_change)
		$PlayerSFX.play()
	
		yield(get_tree().create_timer(2), "timeout")
		speed -= 400
		$Particles2D.emitting = false
		$AnimatedSprite.speed_scale -= 2
		$PlayerSFX.stop()
		for i in range(3):
			modulate.a -= .5
			yield(get_tree().create_timer(.25), "timeout")
			modulate.a += .5
			yield(get_tree().create_timer(.25), "timeout")
		$AnimatedSprite.speed_scale += .5
		speed += 200
		boost_use = true
		turbo_sprite.modulate = Color(0.3, 0.8, 0.3)


func slow_down():
	speed -= 200
	modulate = Color(0.55, 0.80, 0.75)
	yield(get_tree().create_timer(.75), "timeout")
	speed += 200
	modulate = Color(1, 1, 1)
	
	
	

