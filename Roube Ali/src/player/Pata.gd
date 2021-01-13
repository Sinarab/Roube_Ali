extends KinematicBody2D

onready var audio_win : AudioStreamPlayer = $AudioWin
onready var audio_lose : AudioStreamPlayer = $AudioLose

signal moved
signal stoped

var initpos: Vector2
var screen_size

var pegou = false
var my_body

var paw_speed = Vector2(0.0, 0.0)
var paw_dir : Vector2

var realJoystick = false

var pos : Vector2

func _ready() -> void:
	Socket.connect_to_server()
	Socket.connect("move", self, "move_by_realJoystick")
	screen_size = get_viewport().size
	pegou = false

func move_by_realJoystick (x_value, y_value) -> void:
	x_value = int(x_value)
	y_value = int(y_value)
	realJoystick = true
	if x_value == -1:
		paw_speed.x = 800.0
	elif x_value == 1:
		paw_speed.x = -800.0
	if y_value == -1:
		paw_speed.y = 800.0
	elif y_value == 1:
		paw_speed.y = -800.0
	if x_value == 0 and y_value == 0:
		paw_speed = Vector2(0.0, 0.0) 


#MOVIMENTAÇÃO JOYSTICK TELA
func _on_TouchJoyStick_joysctick_moved(pos: Vector2) -> void:
	realJoystick = false
	pos.x = pos.x/5
	pos.y = pos.y/5
	move_and_collide(pos)
	emit_signal("moved", global_position)

#MOVIMENTAÇÃO JOYTICK
func _on_TouchJoyStick_joysctick_stoped() -> void:
	position = self.position
	emit_signal("stoped", global_position)



func _on_CatchArea_body_entered(body: Node) -> void:
	print("pegou peixito")
	my_body = body
	pegou = true
	catched()

func catched() -> void:
	my_body.global_position = position

func _on_VisibilityNotifier2D_screen_exited() -> void:
	if pegou:
		PlayerData.peixitos += 1
		audio_win.play()
		pegou = false
		my_body.queue_free()
	print("saiu pata")

func _on_Pata_tree_exited() -> void:
	PlayerData.loses += 1
	audio_lose.play()
	print("perdeu: ", PlayerData.loses)
	pegou = false

func _process(delta: float) -> void:
	if pegou:
		catched()
	if realJoystick == true:
		move_and_collide(paw_speed*delta)

