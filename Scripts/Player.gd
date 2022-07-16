extends Area2D


var tile_size = 64


func _unhandled_input(event):
	if event.is_action_pressed("move"):
		var mouse_pos: Vector2 = get_global_mouse_position()
		
		position = Vector2(stepify(mouse_pos.x, tile_size), stepify(mouse_pos.y, tile_size))
