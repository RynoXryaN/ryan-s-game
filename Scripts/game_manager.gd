extends Node
class_name GameManager


@onready var death_system: DeathSystem = $"../DeathSystem"

var score : int = 0

func add_points(points : int ) ->void:
		score += points
		#score = score + 1
		print(score)
		
func player_died(player : Player) -> void:
	print("GameManager: received player death")
	
	if player.is_dead:
		return
		
	player.die()
	death_system.start_death_sequence()
