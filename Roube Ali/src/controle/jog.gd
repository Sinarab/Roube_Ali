extends Sprite
class_name Joysctick

signal jog_moved
signal jog_stoped
var touchInside = false
var baseLength 

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		if touchInside == true:
			position.x = position.x + event.relative.x
			position.y = position.y + event.relative.y
			if position.length() > baseLength:
				var angle = position.angle()
				position.x = cos(angle) * baseLength
				position.y = sin(angle) * baseLength
			emit_signal("jog_moved", position)
	if event is InputEventScreenTouch:
		if !event.is_pressed():
			position.x = 0
			position.y = 0
			emit_signal("jog_stoped")
		if event.is_pressed():
			touchInside = (event.position - global_position).length() <= baseLength

func _ready() -> void:
	baseLength = get_node("../base").texture.get_size().x/2
#	print(baseLength)


