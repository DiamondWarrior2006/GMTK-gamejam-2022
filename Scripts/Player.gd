extends Area2D

onready var tween = $Tween
onready var ray = $RayCast2D

export var move_amount = 0
export var speed = 5


var tile_size = 32
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}


func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	
func _process(delta):
# use this if you want to only move on keypress
# func _unhandled_input(event):
	if tween.is_active():
		return
	if move_amount != 0:
		for dir in inputs.keys():
				if Input.is_action_pressed(dir):
					move(dir)


func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(inputs[dir])
		

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + dir * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

