extends Area2D

var speed = 200
var player_pos
var fade_out = false
var velocity = Vector2()

onready var player = get_tree().get_root().get_node("Level/Player")
onready var player_script = preload("res://Actors/Player.gd")

func _ready():
	player_pos = player.global_position
	velocity = global_position.direction_to(player_pos)
	$AnimatedSprite.play()

func _physics_process(delta):
	global_position += velocity * delta * speed
	if fade_out == true:
		_fade_out(delta)


func _on_Bullet_body_entered(body):
	if body == player:
		player.slow_down()
		queue_free()

func _on_Timer_timeout():
	fade_out = true

func _fade_out(delta):
	modulate.a -= delta * 1.5
	if modulate.a <= 0:
		queue_free()
