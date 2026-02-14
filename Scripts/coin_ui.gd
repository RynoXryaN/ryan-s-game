extends CanvasLayer

@onready var coin_count: Label = $FullScreen/TopLeftMargin/CoinRow/CoinCount
@onready var game_manager: GameManager = %GameManager
@onready var coin_gain_scene: PackedScene = preload("res://Scenes/coin_gain.tscn")


func _ready() -> void:
	game_manager.score_changed.connect(_on_score_changed)

func _on_score_changed(new_score: int) -> void:
	coin_count.text = str(new_score)
	play_score_pop()
	spawn_coin_gain("+5")

func play_score_pop() -> void :
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.tween_property(coin_count, "scale", Vector2(1.3, 1.3), 0.08)
	tween.tween_property(coin_count, "scale", Vector2(1, 1), 0.1)

func spawn_coin_gain(text: String) -> void:
	var floating: Label = coin_gain_scene.instantiate()
	floating.text = text

	# Position near coin UI
	floating.position = coin_count.global_position

	get_parent().add_child(floating)
