extends Button

func _ready() -> void:
	mouse_entered.connect(_hover)
	mouse_exited.connect(_exit)

func _hover() -> void:
	create_tween().tween_property(self, "scale", Vector2(1.03, 1.03), 0.08)

func _exit() -> void:
	create_tween().tween_property(self, "scale", Vector2(1.0, 1.0), 0.08)

func _pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
