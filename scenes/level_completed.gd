extends ColorRect

signal retry()
signal next_level()

@onready var retry_button = %RetryButton
@onready var audio_level_completed = $AudioLevelCompleted

func _on_retry_button_pressed():
	retry.emit()

func _on_next_level_button_pressed():
	next_level.emit()


func _on_visibility_changed():
	if visible:
		audio_level_completed.play()
