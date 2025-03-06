extends Node


@onready var menu_vbox = $CenterContainer/MenuVBox
@onready var logo = menu_vbox.get_node("Tranoid/Logo")
@onready var press_start_label = menu_vbox.get_node("PressStartLabel")
@onready var menu_options = menu_vbox.get_node("MarginContainer/MenuOptions")
@onready var one_player_option = menu_options.get_node("Player1/CustomMenuButton")
@onready var two_player_option = menu_options.get_node("Player2/CustomMenuButton")
@onready var intro_timer = $IntroTimer

var level_scene = preload("res://scenes/level.tscn")
var intro_scene = preload("res://scenes/intro.tscn")


func _ready() -> void:
	IntroSceneManager.connect("intro_finished", _on_intro_scene_finished)
	if IntroSceneManager.has_intro_shown_once:
		_on_intro_scene_finished()
	else:
		play_intro()
	$MenuMusic.play()


func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		intro_timer.stop()
		intro_timer.start(10.0)


func play_intro() -> void:
	add_child(intro_scene.instantiate())


func _on_toggle_visibility_timeout() -> void:
	var current_visibility = press_start_label.visibility_layer
	if current_visibility == 1:
		press_start_label.visibility_layer = 0
	else:
		press_start_label.visibility_layer = 1


func _on_one_player_button_clicked() -> void:
	get_tree().change_scene_to_packed(level_scene)


func _on_two_player_button_clicked() -> void:
	menu_options.get_node("Player2/DisabledSound").play()


func _on_intro_scene_finished() -> void:
	await get_tree().create_timer(0.5).timeout
	one_player_option.get_node("Button").grab_focus()
	intro_timer.start(15.0)


func _on_intro_timer_timeout() -> void:
	one_player_option.get_node("Button").release_focus()
	two_player_option.get_node("Button").release_focus()
	play_intro()
