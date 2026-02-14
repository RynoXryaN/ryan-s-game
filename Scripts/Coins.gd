extends Area2D

@onready var game_manager: GameManager = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coin_bling: AudioStreamPlayer2D = $CoinBling

func _ready() -> void:
	game_manager.register_coin()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		game_manager.add_points(5)
		coin_bling.pitch_scale = randf_range(0.95, 1.05)
		coin_bling.play()
		animation_player.play("Pickup")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Pickup":
		queue_free()
