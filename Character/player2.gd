extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var player = $"."
var player_position = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	pass
	
@onready var parallax_background = $"../ParallaxBackground"
@onready var parallax_layers := [
	$"../ParallaxBackground/ParallaxLayer",
	$"../ParallaxBackground/ParallaxLayer2",
	$"../ParallaxBackground/ParallaxLayer3",
	$"../ParallaxBackground/ParallaxLayer4",
	$"../ParallaxBackground/ParallaxLayer5",
	$"../ParallaxBackground/ParallaxLayer6",
	$"../ParallaxBackground/ParallaxLayer7",
	$"../ParallaxBackground/ParallaxLayer8"
]

#func _ready():
	#var parallax_background = ParallaxBackground

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
 	
	player_position = player.position.x
	
	for parallax_layer in parallax_layers:
		if parallax_layer and parallax_layer is ParallaxLayer:
			parallax_layer.scroll_offset.x = player_position * 0.1

	move_and_slide()
