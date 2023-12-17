extends Control

onready var save_file = Global.game_data

func _ready() -> void:
	get_tree().paused = true
	get_node("VBoxContainer").get_node("Score").text = "Score: " + Global.points as String
	if save_file.max_score < Global.points:
		save_file.max_score = Global.points
		Global.save_data()
	get_node("VBoxContainer").get_node("MaxScore").text = "Max Score: " + save_file.max_score as String
	Global.points = 0
	
	

func _on_RetryButton_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://Level/Level.tscn")


func _on_GoMenuButton_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://Menu/MainMenu.tscn")
