extends Label

func _ready() -> void:
	var tween: Tween = create_tween()

	# Move upward
	tween.tween_property(self, "position:y", position.y - 25, 0.6)

	# Fade out
	tween.tween_property(self, "modulate:a", 0.0, 0.6)

	tween.finished.connect(queue_free)
