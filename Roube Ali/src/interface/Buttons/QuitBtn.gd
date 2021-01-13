extends Button

func _on_QuitBtn_button_up() -> void:
	Socket.connect_to_server()
	Socket.write_text("Desligar\n")
	get_tree().quit()
