extends Control

onready var save_file = Global.game_data
onready var music_bar = $VBoxContainer/MusicVolumeBar
onready var SFX_bar =  $VBoxContainer/SFXVolumeBar

func _ready():
	hide()
	music_bar.value = save_file.music_vol
	SFX_bar.value = save_file.SFX_vol
	

func _on_MusicVolumeBar_value_changed(value: float):
	save_file.music_vol = value
	print(value)


func _on_SFXVolumeBar_value_changed(value: float) -> void:
	save_file.SFX_vol = value
	print(value)

func _on_CloseOptionsButton_pressed() -> void:
	hide()
	Global.save_data()
	get_tree().get_root().get_node("MainMenu").get_node("Notebook").visible = true
	
