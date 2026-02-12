extends CenterContainer

@onready var coin_count: Label = $VBoxContainer/CoinCount
@onready var game_manager: GameManager = %GameManager


func _process(delta: float) -> void:
	coin_count.text = str(game_manager.score)
	
