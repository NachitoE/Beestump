extends Control


func _ready() -> void:
	hide()


func _on_CloseInstButton_pressed() -> void:
	hide()
	get_tree().get_root().get_node("MainMenu").get_node("Notebook").visible = true
