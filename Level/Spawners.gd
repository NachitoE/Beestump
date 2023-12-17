extends Node2D

#Creamos el método random para generar números aleatorios más tarde
var random = RandomNumberGenerator.new()

#Prelodeamos la escena de mosquito y creamos la variable mosquitoSpeed
onready var mosquito = preload("res://Actors/Mosquito.tscn")
onready var icy_mosquito = preload("res://Actors/IcyMosquito.tscn")

var enemy_speed = 0
var extra_speed = 0
var points_difficulty_jump
var choose_spawn = 1

func _process(delta):
	_increase_difficulty()
		
func _ready():
	#Al ser spawner creado (En el mismo instante que inicia el juego), Spawntime irá llamándose cada X tiempo. Cuando el tiempo
	#Ya haya corrido, ejecutará la función on_timeout_spawn
	$SpawnTime.connect("timeout", self, "on_timeout_spawn")
	random.randomize()
	points_difficulty_jump = random.randi_range(25,50)
	
func _spawn(instance):
	enemy_speed = random.randi_range(30, 300) + extra_speed
	var rand_offset = random.randf_range(0,1)
	$SpawnerPath/SpawnerPoint.set_unit_offset(rand_offset)
	var mosquito_instance = instance
	mosquito_instance.position = $SpawnerPath/SpawnerPoint.position
	get_tree().get_root().get_node('Level').add_child(mosquito_instance)
	
func _increase_difficulty():
	$SpawnTime.set_wait_time(2 - (Global.points * 0.01))
	extra_speed = 50 + (Global.points * 0.5)
	

func on_timeout_spawn():
	choose_spawn = 1
	if Global.points >= points_difficulty_jump:
		choose_spawn = random.randi_range(1,2)
	if choose_spawn == 1:
		_spawn(mosquito.instance())
	if choose_spawn == 2:
		_spawn(icy_mosquito.instance())
	
	
