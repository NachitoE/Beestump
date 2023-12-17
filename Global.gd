extends Node

const SAVE_FILE = 'user://save.sav'
var game_data = {}

var points = 0

func _ready():
	load_data()

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()
	
func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		game_data = {
			"music_vol": .5,
			"SFX_vol": .5,
			"max_score": 0
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
