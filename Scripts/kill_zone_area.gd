extends Area2D
class_name KillZoneArea

@onready var death_timer : Timer = $Death_Timer
@onready var game_manager : GameManager = %GameManager

func _on_body_entered (body: Node2D) -> void:
	print("Death Zone Triggered")
	
	if body is Player:
		var player : Player = body
		print("Player detected")
		game_manager.player_died(player)
