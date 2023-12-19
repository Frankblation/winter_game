extends CharacterBody2D

var speed = 100
var player_chase = false
var player = null

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var respawn_position : Vector2 = Vector2(400, 200)

func _ready():
	add_to_group("enemies")
	## Add the gravity.

func _physics_process(_delta):
	#if not is_on_floor():
		#velocity.y += gravity * delta

	if player_chase:
		position += (player.position - position)/speed
		$AnimationPlayer.play("Attack")
		
		# Access the Sprite node to set flip_h
		var sprite = $Sprite2D  # Adjust the node path based on your scene structure

		if (player.position.x - position.x) < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		$AnimationPlayer.play("Idle")

#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

func _on_bat_detect_body_entered(body):
	player = body
	player_chase = true

func _on_bat_detect_body_exited(_body):
	player = null
	player_chase = false
	
func bat():
	pass

func respawn():
	position = respawn_position

func _on_bat_attack_body_entered(body):
	if body.has_method("player"):
		body.die()
		respawn()

func _on_bat_attack_body_exited(_body):
	pass # Replace with function body.
