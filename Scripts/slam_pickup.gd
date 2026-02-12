extends Area2D
class_name SlamPickup 

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.has_slam = true
		print("Slam ability unlocked!")
		queue_free()
