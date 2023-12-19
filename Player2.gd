extends CharacterBody2D


@export var SPEED = 300.0
@export var  JUMP_VELOCITY = -400.0
@onready var anim = get_node("AnimationPlayer")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var respawn_position : Vector2 = Vector2(225, 350)
var respawn_timer_duration : float = 0.4
var respawn_timer_elapsed : float = 0.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("Sprite").flip_h = true
	elif direction == 1:
		get_node("Sprite").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
		if velocity.y > 0:
			anim.play("Fall")
	
	#check if respawn timer is active
	if respawn_timer_elapsed > 0.0:
		respawn_timer_elapsed -= 0.01
		
		#check if timer elapsed
		if respawn_timer_elapsed <= 0.0:
			respawn_timer_elapsed = 0.0
			respawn()
			
	move_and_slide()

	#func _on_Lava_area_entered(area):
		#if area.is_in_group("Enemy"):
			#$Player.position.x = "Position X"
			#$Player.position.y = "Position Y"
			
func player():
	pass
	
func die():
	anim.play("Disappear")
	respawn_timer_elapsed = respawn_timer_duration
	
func respawn():
	#reset position to spawn point
	#play respawn animation
	position = respawn_position
