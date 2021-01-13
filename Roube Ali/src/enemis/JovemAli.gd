extends KinematicBody2D

var flag = 0
var send = 0
var entered : bool
var pata_moving_pos : Vector2
var pata_stoped_pos : Vector2
export var tempo_min = 5.0
export var tempo_max = 8.0

func _ready() -> void:
	randomize_timer()
	Socket.connect_to_server()
	pass

func _on_VigilanceArea_body_entered(body: Node) -> void:
	entered = true

func _on_VigilanceArea_body_exited(body: Node) -> void:
	entered = false

#INTERVALO DE TEMPO RAND
func randomize_timer():
	$LookTimer.set_wait_time(rand_range(tempo_min, tempo_max))

func _on_LookTimer_timeout() -> void:
	randomize_timer()
	flag += 1

func _on_Pata_moved(pos : Vector2) -> void:
	pata_moving_pos = pos

func _on_Pata_stoped(pos : Vector2) -> void:
	pata_stoped_pos = pos

#OLHARES E DETECTA A PATA
func _process(delta: float) -> void:
	if flag == 0:
		$ali0.visible = true
		$ali1.visible = false
		$ali_looking.visible = false
		$ali_looking/CanvasLayer/ColorRect.visible = false
		$VigilanceArea.monitorable = false
#		send = 0
		if send == 0:
			Socket.write_text("Ok\n")
			send = 1

	if flag == 1:
		$ali0.visible = false
		$ali1.visible = true
		$ali_looking.visible = false
		$ali_looking/CanvasLayer/ColorRect.visible = false
		$VigilanceArea.monitorable = false
#		print("não olhando")
#		send = 0
		if send == 1:
			Socket.write_text("Ok\n")
			send = 0

	if flag == 2:
		$ali0.visible = false
		$ali1.visible = false
		$ali_looking.visible = true
		$ali_looking/CanvasLayer/ColorRect.visible = true
		$VigilanceArea.monitorable = true

		if send == 0:
			Socket.write_text("Olhando\n")
			send = 1

	if flag == 3:
		flag = 0
		send = 0

	if entered == true and pata_moving_pos != pata_stoped_pos and flag == 2:
		get_parent().get_node("Pata").queue_free()
#		print(pata_moving_pos, pata_stoped_pos)
	elif entered == true and get_parent().get_node("Pata").paw_speed != Vector2(0.0,0.0) and flag == 2:
		get_parent().get_node("Pata").queue_free()



