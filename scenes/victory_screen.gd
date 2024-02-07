extends CenterContainer

@onready var menu_button = %MenuButton
signal open_start_menu()

func _on_menu_button_pressed():
	open_start_menu.emit()
