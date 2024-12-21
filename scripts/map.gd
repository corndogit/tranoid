extends StaticBody2D


@export var scroll_speed = 120.0


func _process(delta: float) -> void:
	position.x -= scroll_speed * delta


func _on_player_died() -> void:
	scroll_speed = 0
