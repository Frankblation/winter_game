extends ParallaxBackground

var player
var ground_layer_speed = 0.5  # Adjust as needed

func _process(delta):
	if player:
		var parallax_offset = Vector2(100, 0)  # Adjust as needed
		set_offset(-(player.position / ground_layer_speed) + parallax_offset)
