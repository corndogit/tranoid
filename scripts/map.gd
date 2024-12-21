extends StaticBody2D


@export var scroll_speed = 120.0


func _process(delta: float) -> void:
	position.x -= scroll_speed * delta


func _on_player_died() -> void:
	$Sounds/Music.stop()
	$Sounds/Die.play()
	await get_tree().create_timer(1.5).timeout
	scroll_speed = 0


func _on_win_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Win") # Replace with function body.
