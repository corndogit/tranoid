extends Control

const TEXTURES = [
	preload("res://assets/sprites/intro/0.png"),
	preload("res://assets/sprites/intro/1.png"),
	preload("res://assets/sprites/intro/2.png")
]
const STORY_LABEL_TEXTS = [
	"TRAN IS A SPACE ALIEN GIRL WHO CAME FROM THE TRANSTAR.",
	"SHE WANDERS AROUND LOOKING FOR TRANOID SPREAD TO THE BIRTHPLACE.",
	"DODGE THE ADVANCE OF THE EVIL SPACE ALIENS AND APPROACH THE MISTERY OF TRANOID."
]
const AUTO_PROGRESS_TIMEOUT = 4.0

var current_index: int = 0
var text_finished = false
@onready var image = $AspectRatioContainer/CenterContainer/VBoxContainer/CenterContainer/IntroImage
@onready var story_label = $AspectRatioContainer/CenterContainer/VBoxContainer/MarginContainer/StoryLabel
@onready var press_start_label = $AspectRatioContainer/CenterContainer/VBoxContainer/PressStartLabel
@onready var auto_progress = $AutoProgressTimer


func _ready() -> void:
	image.texture = TEXTURES[current_index]
	_set_story_label(STORY_LABEL_TEXTS[current_index])


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		queue_free()


func _progress_intro() -> void:
	if not text_finished:
		story_label.text = STORY_LABEL_TEXTS[current_index]
		text_finished = true
		auto_progress.start(AUTO_PROGRESS_TIMEOUT)
		return

	auto_progress.stop()
	var new_index = current_index + 1
	if new_index < len(TEXTURES):
		image.texture = TEXTURES[new_index]
		_set_story_label(STORY_LABEL_TEXTS[new_index])
		current_index = new_index
	else:
		queue_free()


func _set_story_label(text: String):
	var new_text = ""
	text_finished = false
	story_label.text = new_text
	for character in text:
		if not text_finished:
			new_text += character
			story_label.text = new_text
			await get_tree().create_timer(0.0825).timeout
	text_finished = true
	auto_progress.start(AUTO_PROGRESS_TIMEOUT)


func _on_toggle_visibility_timeout() -> void:
	var current_visibility = press_start_label.visibility_layer
	if current_visibility == 1:
		press_start_label.visibility_layer = 0
	else:
		press_start_label.visibility_layer = 1


func _on_auto_progress_timer_timeout() -> void:
	_progress_intro()
