extends KinematicBody2D

export var peixito_speed = Vector2(50.0,0.0)
export var free_space = 100.0
var init_pos : Vector2

var paused = false
var catched = false

func _ready() -> void:
	init_pos = position
	catched = false

func _process(delta: float) -> void:
	if !catched:
		$AnimationPlayer.play("bounce")
		$AnimatedSpritePeixito.play("idle")
		var pos = abs (init_pos.x - position.x)
		if pos > free_space:
			peixito_speed *= -1
			$AnimatedSpritePeixito.scale.x *= -1
		move_and_collide(-peixito_speed*delta)
	if catched:
		$AnimatedSpritePeixito.play("idle")
	if paused:
		$AnimationPlayer.play("bounce")
		$AnimatedSpritePeixito.play("smile")

func _on_UI_ready() -> void:
	paused = true

func _on_Catched_body_entered(body: Node) -> void:
	catched = true

func _on_VisibilityNotifier2D_screen_exited() -> void:
	print("saiu peixito")
