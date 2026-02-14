extends Area2D
class_name DoubleJump

@onready var pick_up_sfx: AudioStreamPlayer2D = $PickUpSFX

@export var pickup_hint: NodePath
@export var tutorial_hint: NodePath

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.has_double_jump = true
		pick_up_sfx.play()
		
		if pickup_hint:
			var pickup_node: WorldHint = get_node(pickup_hint)
			pickup_node.hide_hint()

		if tutorial_hint:
			var tutorial_node: WorldHint = get_node(tutorial_hint)
			tutorial_node.show_hint()

		
		await get_tree().create_timer(0.5).timeout
		queue_free()
