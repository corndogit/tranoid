extends Control

const TEXTURES = [
	preload("res://assets/sprites/intro/0.png"),
	preload("res://assets/sprites/intro/1.png"),
	preload("res://assets/sprites/intro/2.png"),
	preload("res://assets/sprites/ui/logo.png")
]
const STORY_LABEL_TEXTS = [
	"TRAN IS A SPACE ALIEN GIRL WHO CAME FROM THE TRANSTAR.",
	"SHE WANDERS AROUND LOOKING FOR TRANOID SPREAD TO THE BIRTHPLACE.",
	"DODGE THE ADVANCE OF THE EVIL SPACE ALIENS AND APPROACH THE MISTERY OF TRANOID.",
	""
]
const AUTO_PROGRESS_TIMEOUT = 4.0

var current_index: int = 0
var text_finished = false
var logo_scrolling = false
var trigger_scroll = false
const SCROLL_SPEED = 25.0
@onready var image_container = $AspectRatioContainer/CenterContainer/VBoxContainer/CenterContainer
@onready var image = image_container.get_node("IntroImage")
@onready var story_label = $AspectRatioContainer/CenterContainer/VBoxContainer/MarginContainer/StoryLabel
@onready var auto_progress = $AutoProgressTimer


func _ready() -> void:
	image.texture = TEXTURES[current_index]
	_set_story_label(STORY_LABEL_TEXTS[current_index])


func _process(delta) -> void:
	if logo_scrolling:
		if not trigger_scroll:
			image_container.set_position(Vector2(0, -100))
			trigger_scroll = true
		if image_container.position.y < -15.0:
			image_container.position.y += delta * SCROLL_SPEED
	if Input.is_action_just_pressed("ui_accept"):
		_end_scene()


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
		if new_index == len(TEXTURES) - 1:
			_begin_logo_transition()
	else:
		_end_scene()


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
	

func _begin_logo_transition() -> void:
	print("begin scroll")
	logo_scrolling = true

func _end_scene():
	IntroSceneManager.has_intro_shown_once = true
	IntroSceneManager.intro_finished.emit()
	queue_free()


func _on_auto_progress_timer_timeout() -> void:
	_progress_intro()
