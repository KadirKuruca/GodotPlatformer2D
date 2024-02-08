extends CenterContainer

@onready var audio_level_completed = $AudioLevelCompleted
@onready var menu_button = %MenuButton
signal open_start_menu()

func _on_menu_button_pressed():
	open_start_menu.emit()


func _on_visibility_changed():
	if visible:
		audio_level_completed.play()
