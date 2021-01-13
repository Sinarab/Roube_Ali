tool
extends Button

export (String, FILE) var next_scene_path = ""



func _on_CallSceneBtn_button_up() -> void:
	get_tree().change_scene(next_scene_path)
	PlayerData.peixitos = 0

func _get_configuration_warning() -> String:
	return "PRÓXIMA CENA NÃO DEFINIDA" if next_scene_path == "" else ""
