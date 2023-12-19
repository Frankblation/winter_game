extends Sprite2D

@export var layer = 1
var speed_offset = 0.2
@onready var player = $"/res://Character/Player"

func _process(_delta):
	position = -player.position * layer * speed_offset
