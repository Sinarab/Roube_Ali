extends Control

func _ready() -> void:
	$Level1.disabled = true

func _process(delta: float) -> void:
	if PlayerData.peixitos == 1:
		$Level1.disabled = false
		$Level1.visible = true
