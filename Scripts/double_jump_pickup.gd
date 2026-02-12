extends Area2D
class_name DoubleJump

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.has_double_jump = true
		print("Double Jump Unlocked!")
		queue_free()
