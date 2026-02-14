extends Area2D
class_name SlamPickup 

@onready var pick_up_sfx: AudioStreamPlayer2D = $PickUpSFX
@export var unlock_hint: NodePath
@export var break_block_hint: NodePath

var unlock_hint_node: WorldHint
var break_block_hint_node: WorldHint

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.has_slam = true

		pick_up_sfx.play()

	# Hide the "Unlock Here" hint
	if unlock_hint:
		var unlock_node: WorldHint = get_node(unlock_hint)
		unlock_node.hide_hint()

	# Show the tutorial hint
	if break_block_hint:
		var tutorial_node: WorldHint = get_node(break_block_hint)
		tutorial_node.show_hint()
		
		await get_tree().create_timer(0.5).timeout
		queue_free()
