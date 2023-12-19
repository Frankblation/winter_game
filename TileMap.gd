extends TileMap

var player

func _process (delta):
	if player:
		var parallax_offset = Vector2(100, 0)
	# Adjust these values based on your parallax effect
		var player_position = $PlayerNode.position

		var new_position = player_position - parallax_offset

		set_position(new_position)
