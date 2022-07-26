extends Area2D

onready var tween = $Tween
onready var ray = $RayCast2D
onready var state_machine = $AnimationTree.get("parameters/playback")

export var speed = 5


var tile_size = 32
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}
var bullet = preload("res://Scenes/Bullet.tscn")


func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2


func _process(delta):
# use this if you want to only move on keypress
# func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
			if Input.is_action_pressed(dir):
				move(dir)


func move(dir):
	$Position2D.position = inputs[dir] * tile_size
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(inputs[dir])
		process_animations()
		print($Position2D.position)


func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + dir * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()


func process_animations():
	if Input.is_action_just_pressed("right"):
		state_machine.travel("right")
		
	elif Input.is_action_just_pressed("down"):
		state_machine.travel("down")
		
	elif Input.is_action_just_pressed("up"):
		state_machine.travel("up")
		
	elif Input.is_action_just_pressed("left"):
		state_machine.travel("left")

func shoot(dir):
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = bullet.instance()
		bullet_instance.direction = inputs[dir]
		bullet_instance.position = $Position2D.global_position
		get_parent().add_child(bullet_instance)
