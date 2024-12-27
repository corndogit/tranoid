extends CharacterBody2D


signal died
var has_died = false
const MOVE_SPEED = 175.0

func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _process(_delta: float) -> void:
	if has_died:
		return
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * MOVE_SPEED
	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		die()


func die():
	has_died = true
	died.emit()
	$AnimatedSprite2D.play("die")
	$Collider.call_deferred("queue_free")
	$Hitbox/CollisionShape2D.call_deferred("queue_free")
