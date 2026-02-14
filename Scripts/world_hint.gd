extends Node2D
class_name WorldHint

@export var hint_text: String = "Default Hint"
@export var auto_show := false
@onready var hint_label: Label = $HintText

var float_speed := 2.0
var float_amount := 10.0
var start_y := 0.0

func _ready() -> void:
	hint_label.text = hint_text
	start_y = hint_label.position.y
	modulate.a = 0.0   # start invisible
	
	if auto_show:
		show_hint()

func _process(_delta: float) -> void:
	var offset: float = sin(Time.get_ticks_msec() / 500.0 * float_speed) * float_amount
	hint_label.position.y = start_y + offset


func show_hint() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.25)


func hide_hint() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.25)
