extends StaticBody2D
class_name BreakBlock

@onready var break_sfx: AudioStreamPlayer2D = $BreakSound
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@export var tutorial_hint_path: NodePath
@export var stomp_hint: NodePath


var tutorial_hint: WorldHint

func _ready() -> void:
	if tutorial_hint_path:
		tutorial_hint = get_node(tutorial_hint_path) as WorldHint


func break_block() -> void:
	# Disable collision immediately
	collision.disabled = true
	
	# Hide sprite immediately
	sprite.visible = false
	
	# Play sound (no await)
	if break_sfx:
		break_sfx.play()
	
	if tutorial_hint:
		tutorial_hint.hide_hint()
		
	if stomp_hint:
		var stomp_node: WorldHint = get_node(stomp_hint)
		stomp_node.show_hint()

	
	# Remove after short delay
	await get_tree().create_timer(0.2).timeout
	queue_free()
