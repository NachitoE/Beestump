extends KinematicBody2D


export (float) var speed
onready var target = get_tree().get_root().get_node("Level/ProtectArea")
var blood = load("res://Actors/Blood.tscn")

onready var player = get_tree().get_root().get_node("Level/Player")
onready var Spawners = get_tree().get_root().get_node("Level/Spawners")

var fade_out = false
var velocity = Vector2()


func _ready():
	#La speed del mosquito equivale al valor dado para cada uno en el script de Spawners
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.play()
	speed = Spawners.enemy_speed
	
	

func _physics_process(delta):
	look(target)
	mov(target, delta)
	if fade_out == true:
		_fade_out(delta)

func look(t):
	look_at(t.position)
	rotation_degrees = rotation_degrees + 90

func mov(t, delta):
	velocity = global_position.direction_to(t.global_position)
	global_position += velocity * speed * delta
	
func kill():
	var blood_instance = blood.instance()
	get_tree().current_scene.add_child(blood_instance)
	blood_instance.position = global_position
	blood_instance.rotation = global_position.angle_to_point(player.global_position)
	queue_free()
	Global.points += 1

func _on_body_entered_signal(body):
	#Si el cuerpo con el que colisiona es el jugador y su velocidad es mayor a 600, se borrará el mosquito en cuestión
	if body == player && player.speed > 600:
		kill()
	if body == target:
		speed = 0
		for i in range(3):
			yield(get_tree().create_timer(2), "timeout")
			if speed == 0:
				target.HP -= 10 + Global.points * 0.2 #dmg
			if i == 2:
				fade_out = true
				
				
			

func _fade_out(delta):
	modulate.a -= delta * 1.5
	if modulate.a <= 0:
		queue_free()
	
