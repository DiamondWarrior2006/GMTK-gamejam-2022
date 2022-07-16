extends Control

signal rolled()

var rng = RandomNumberGenerator.new()

func _ready():
	pass


func _on_Button_pressed():
	rng.randomize()
	var rolled_number = rng.randf_range(1, 6)
	$Label.text = String(round(rolled_number))
	emit_signal("rolled")
