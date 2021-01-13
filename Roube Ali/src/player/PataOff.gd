extends KinematicBody2D

var size
var paw_speed = Vector2(0.0, 0.0)

func _ready() -> void:
	Socket.connect_to_server()
	size = $PataSprite.texture.get_size().x/2
	Socket.connect("move", self, "move_by_realJoystick")

func move_by_realJoystick (x_value, y_value) -> void:
	x_value = int(x_value)
	y_value = int(y_value)

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

func _process(delta: float) -> void:
	if  (get_global_mouse_position() - global_position).length() <= size:
		if Input.is_action_pressed("click") or InputEventScreenDrag:
			self.position = get_global_mouse_position()

	move_and_collide(paw_speed*delta)
#	print(paw_speed)
