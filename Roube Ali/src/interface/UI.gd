extends Control

onready var scene_tree = get_tree()
onready var overlay : ColorRect = $Overlay
onready var peixitoLabel : Label = $ScoreLabel
onready var mainLabel : Label = $Overlay/PauseLabel

var lose_msg = ""
var paused = false setget set_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and mainLabel.text != lose_msg:
		self.paused = true
		scene_tree.set_input_as_handled()
	if event.is_action_pressed("quit"):
		get_tree().quit()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	overlay.visible = not overlay.visible

func _ready() -> void:
	PlayerData.connect("update_peixitos", self, "update_interface")
	PlayerData.connect("player_loses", self, "player_died")

func update_interface() -> void:
	peixitoLabel.text = " %s  -  Peixitos" %PlayerData.peixitos

func player_died() -> void:
	self.paused = true
	mainLabel.text = "PERDEU!"
