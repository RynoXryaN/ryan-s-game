class_name Enemy
extends Node2D

@onready var life_timer: Timer = $LifeTimer
@export var fire_rate: float = 1.5
@export var projectile_scene: PackedScene
@export var stomp_hint: NodePath
@export var double_jump_pickup_hint: NodePath


@onready var shoot_timer: Timer = $ShootTimer
@onready var muzzle: Marker2D = $Muzzle


func _ready() -> void:
	print("Enemy Ready")
	shoot()
	shoot_timer.wait_time = fire_rate
	shoot_timer.start()


func _on_shoot_timer_timeout() -> void:
	print("Timer Fired")
	shoot()
	

func shoot() -> void:
	if projectile_scene == null:
		return

	var projectile: EnemyProjectile = projectile_scene.instantiate()
	projectile.global_position = muzzle.global_position
	projectile.direction = Vector2.LEFT # 🔁 change later if needed

	get_parent().add_child(projectile)

func _on_life_timer_timeout() -> void:
	print("Projectile Died")
	queue_free()

func die() -> void:
	print("Enemy died.")
	queue_free()

#func _on_shoot_timer_timeout() -> void:
	pass # Replace with function body.


func _on_head_hitbox_body_entered(body: Node2D) -> void:
	print("Something enter head hitbox")
	if body is Player:
		var player: Player = body
		
		if player.has_slam and (player.is_slamming or player.slam_cooldown and player.velocity.y > 0):
			print("Enemy stomped!")
			
			if stomp_hint:
				var stomp_node: WorldHint = get_node(stomp_hint)
				stomp_node.hide_hint()

			if double_jump_pickup_hint:
				var pickup_node: WorldHint = get_node(double_jump_pickup_hint)
				pickup_node.show_hint()

			
			player.call_deferred("end_slam")
			die()
			
