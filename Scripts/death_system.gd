extends Node2D
class_name DeathSystem

@onready var death_timer : Timer = $Death_Timer

# Called when the node enters the scene tree for the first time.
func start_death_sequence() ->void:
	print("DeathSystem: starting death sequence")
	Engine.time_scale = 0.5
	visible = true
		
	death_timer.start()
	print("Timer Started:", death_timer.time_left)
	Engine.time_scale = 0.5


func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
