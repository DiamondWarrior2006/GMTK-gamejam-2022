extends Area2D


var speed = 5
var direction = 1
var tile_size = 32


func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2



func _process(delta):
	position.x += speed * direction


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
