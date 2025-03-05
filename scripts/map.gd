extends StaticBody2D


@export var scroll_speed = 120.0

var game_over_scene = preload("res://scenes/ui/game_over.tscn")
var you_win_scene = preload("res://scenes/ui/you_win.tscn")


func _process(delta: float) -> void:
	position.x -= scroll_speed * delta


func _on_player_died() -> void:
	$Sounds/Music.stop()
	$Sounds/Die.play()
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_packed(game_over_scene)


func _on_win_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().call_deferred("change_scene_to_packed", you_win_scene)
