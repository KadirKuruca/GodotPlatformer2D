extends Node2D

@export var next_level: PackedScene

var level_time = 0.0
var start_level_msec = 0.0

@onready var level_completed = $CanvasLayer/LevelCompleted
@onready var start_in_label = %StartInLabel
@onready var start_in_color_rect = %StartInColorRect
@onready var animation_player = $AnimationPlayer
@onready var level_time_label = %LevelTimeLabel
@onready var victory_screen = $CanvasLayer/VictoryScreen
@onready var audio_collect_coin = $AudioCollectCoin
@onready var audio_game = $AudioGame

func _ready():
	Events.level_completed.connect(show_level_completed)
	Events.coin_collected.connect(on_coin_collected)
	get_tree().paused = true
	start_in_color_rect.visible = true
	LevelTransition.fade_from_black()
	animation_player.play("countdown")
	await animation_player.animation_finished
	get_tree().paused = false
	start_in_color_rect.visible = false
	start_level_msec = Time.get_ticks_msec()

func _process(delta):
	level_time = Time.get_ticks_msec() - start_level_msec
	level_time_label.text = str(level_time / 1000.0)
	
func retry_level():
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_file_path)
	
func go_to_next_level():
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	
func show_level_completed():
	if not next_level is PackedScene:
		get_tree().paused = true
		victory_screen.show()
		victory_screen.menu_button.grab_focus()
	else:
		get_tree().paused = true
		level_completed.show()
		level_completed.retry_button.grab_focus()

func _on_level_completed_next_level():
	go_to_next_level()

func _on_level_completed_retry():
	retry_level()

func _on_victory_screen_open_start_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	
func on_coin_collected():
	audio_collect_coin.play()
