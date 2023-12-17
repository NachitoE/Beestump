extends Control

var options = preload("res://Menu/Options.tscn")
var optionsInstance = options.instance()


var instructions = preload("res://Menu/Instructions.tscn")
var instructionsInstance = instructions.instance()

var MusicMenu = preload("res://SFX/MusicMenu.mp3")

onready var save_file = Global.game_data


func _ready():
	get_tree().current_scene.add_child(optionsInstance)
	get_tree().current_scene.add_child(instructionsInstance)
	$MusicMenu.stream = MusicMenu
	$MusicMenu.play()

func _physics_process(delta):
	$MusicMenu.volume_db = linear2db(save_file.music_vol)
	if (Input.is_action_just_pressed("toggle_fullscreen")):
		OS.window_fullscreen = !OS.window_fullscreen

func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://Level/Level.tscn")


func _on_InstructionsButton_pressed() -> void:
	instructionsInstance.show()
	$Notebook.visible = false


func _on_OptionsButton_pressed() -> void:
	optionsInstance.show()
	$Notebook.visible = false
	
func _on_ExitButton_pressed() -> void:
	get_tree().quit()
	
