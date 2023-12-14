# Main.gd

extends Node2D

var enemy_spawn_timer = 2.0
var enemy_spawn_interval = 2.0

func _process(delta):
	enemy_spawn_timer -= delta
	if enemy_spawn_timer <= 0:
		spawn_enemy()
		enemy_spawn_timer = enemy_spawn_interval

func spawn_enemy():
	var enemy = Enemy.new()
	add_child(enemy)
	enemy.position = Vector2(rand_range(100, 700), rand_range(100, 500))

# Enemy.gd

extends Area2D

var speed = 100.0

func _process(delta):
	var target = get_parent().get_node("PlayerBase")
	var direction = (target.position - position).normalized()
	position += direction * speed * delta

func _on_Area2D_body_entered(body):
	if body.name == "PlayerBase":
		queue_free()

# PlayerBase.gd

extends Area2D

var health = 100

func _on_PlayerBase_body_entered(body):
	if body.name == "Enemy":
		health -= 10
		print("PlayerBase health:", health)
		if health <= 0:
			print("Game Over")

# Tower.gd

extends Area2D

var shoot_timer = 0.5
var shoot_interval = 0.5

func _process(delta):
	shoot_timer -= delta
	if shoot_timer <= 0:
		shoot()
		shoot_timer = shoot_interval

func shoot():
	var target = get_parent().get_node("Enemy")
	if target:
		var bullet = Bullet.new()
		get_parent().add_child(bullet)
		bullet.position = position
		bullet.target = target

# Bullet.gd

extends Area2D

var speed = 500.0
var target = null

func _process(delta):
	if target:
		var direction = (target.position - position).normalized()
		position += direction * speed * delta

	if position.distance_to(target.position) < 10:
		target.queue_free()
		queue_free()
