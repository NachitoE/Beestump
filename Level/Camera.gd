extends Camera2D

onready var player = get_tree().get_root().get_node("Level/Player")
var shake_amount = .5

func _process(delta):
	if player.speed > 600:
		shake()
	else:
		set_offset(Vector2(0, 0))

func shake():
	set_offset(Vector2( \
		rand_range(-1.0, 1.0) * shake_amount, \
		rand_range(-1.0, 1.0) * shake_amount \
	))
	
