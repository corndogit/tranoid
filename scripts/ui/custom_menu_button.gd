extends HBoxContainer


@export var button_text: String = "BUTTON"
@onready var icon_texture = $Icon/Texture
@onready var button = $Button

signal clicked

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon_texture.visibility_layer = 0
	button.text = button_text


func _on_button_focus_entered() -> void:
	icon_texture.visibility_layer = 1


func _on_button_focus_exited() -> void:
	icon_texture.visibility_layer = 0


func _on_button_pressed() -> void:
	clicked.emit()
