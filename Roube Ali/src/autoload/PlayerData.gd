extends Node2D

signal update_peixitos
signal player_loses
signal player_won

var peixitos: = 0 setget set_peixitos
var wons: = 0 setget set_wons
var loses: = 0 setget set_lose

func set_peixitos(value: int) -> void:
	peixitos = value
	emit_signal("update_peixitos")

func set_wons(value: int) -> void:
	wons = value
	emit_signal("player_won")

func set_lose(value: int) -> void:
	loses = value
	emit_signal("player_loses")

