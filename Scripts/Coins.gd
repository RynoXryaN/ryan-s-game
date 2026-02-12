extends Area2D
@onready var game_manager: GameManager = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func BlingAndDing(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	game_manager.add_points(5)
	animation_player.play()
	
	

	
