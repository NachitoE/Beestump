extends StaticBody2D

var HP = 250
onready var mosquito = get_tree().get_root().get_node("Level/mosquito")
onready var GameOverInstance = load("res://Menu/GameOver.tscn").instance()

func _ready():
	pass
	
func _physics_process(delta):
	$ProgressBar.value = HP
	
	if HP <= 0:
		get_tree().get_root().get_node('Level').add_child(GameOverInstance)
