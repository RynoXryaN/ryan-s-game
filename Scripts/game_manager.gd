extends Node
class_name GameManager


@onready var death_system: DeathSystem = $"../DeathSystem"

signal score_changed(new_score: int)

var score : int = 0
var total_coins : int = 0
var collected_coins : int = 0

func register_coin() -> void:
	total_coins += 1

func add_points(points: int) -> void:
	score += points
	collected_coins += 1
	emit_signal("score_changed", score)
	
	if collected_coins >= total_coins:
		win_game()

func win_game() -> void:
	print("YOU WIN!!!")
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

func player_died(player : Player) -> void:
	print("GameManager: received player death")
	
	if player.is_dead:
		return
		
	player.die()
	death_system.start_death_sequence()
