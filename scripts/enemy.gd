extends CharacterBody2D

@export var custom_sprite_frames: SpriteFrames


func _ready() -> void:
	if custom_sprite_frames:
		$AnimatedSprite2D.sprite_frames = custom_sprite_frames
	$AnimatedSprite2D.play()


func stop():
	$AnimatedSprite2D.stop()
