class_name EnemyProjectile
extends Area2D

@onready var life_timer: Timer = $LifeTimer
@export var speed: float = 125.0
@export var damage: int = 100

var direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	print("Projectile spawned at ", global_position)
	life_timer.start()


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.take_damage(damage)

	queue_free()


func _on_life_timer_timeout() -> void:
	print("Projectile Died")
	queue_free()
