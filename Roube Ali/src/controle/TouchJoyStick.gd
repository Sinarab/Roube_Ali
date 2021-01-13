extends Node2D

signal joysctick_moved
signal joysctick_stoped

func _on_jog_jog_moved(pos : Vector2) -> void:
	emit_signal("joysctick_moved", pos)


func _on_jog_jog_stoped() -> void:
	emit_signal("joysctick_stoped")
