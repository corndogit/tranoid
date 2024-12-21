extends CharacterBody2D


signal died
var has_died = false
const MOVE_SPEED = 15000.0

func _ready() -> void:
	$AnimatedSprite2D.play()


func _process(delta: float) -> void:
	if has_died:
		return
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * MOVE_SPEED * delta
	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		get_tree().call_group("enemies", "stop")
		die()


func die():
	has_died = true
	died.emit()
	$AnimatedSprite2D.modulate = Color(1.0, 0.0, 0.0)
	$AnimatedSprite2D.stop()
