extends "res://Actors//enemy_base_script.gd"

onready var bullet = preload("res://Actors/Bullet.tscn")

func _ready():
	speed = 300
	
func _on_body_entered(body):
	_on_body_entered_signal(body)

func _on_Timer_Shoot_timeout():
	var bullet_instance = bullet.instance()
	bullet_instance.position = global_position
	get_tree().get_root().get_node('Level').add_child(bullet_instance)
	
