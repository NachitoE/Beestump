extends Node2D

onready var save_file = Global.game_data

var song1 = preload("res://SFX/Song1.mp3")
var song2 = preload("res://SFX/Song2.mp3")
var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	var randomSongNumber = random.randi_range(1, 2)
	var randomSongNumberString = randomSongNumber as String
	var music_vol = save_file.music_vol
	$Music.volume_db = linear2db(music_vol)
	if randomSongNumber == 1:
		$Music.stream = song1
	if randomSongNumber == 2:
		$Music.stream = song2
	$Music.play()

func _physics_process(delta):
	var points = Global.points
	$Points.text = points as String
	
	if (Input.is_action_just_pressed("toggle_fullscreen")):
		OS.window_fullscreen = !OS.window_fullscreen
	




