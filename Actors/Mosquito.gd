extends "res://Actors//enemy_base_script.gd"

func _ready():
	speed = Spawners.enemy_speed


func _on_body_entered(body):
	_on_body_entered_signal(body)
