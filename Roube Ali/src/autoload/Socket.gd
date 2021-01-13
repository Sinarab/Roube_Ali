extends Node

var client
var wrapped_client
var connected = false

var text = ""
#
signal move(x_value, y_value)

func _ready():
	client = StreamPeerTCP.new()
	client.set_no_delay(true)
	
func _exit_tree():
	disconnect_from_server()

func connect_to_server():
	var ip = "192.168.0.2"
	var port = 80
	print("Connecting to server: %s : %s" % [ip, str(port)])
	var connect = client.connect_to_host(ip, port)
	if client.is_connected_to_host():
		connected = true
		print("Connected!")
	
func disconnect_from_server():
	connected = false
	client.disconnect_from_host()

func _process(delta):
	if not connected:
		pass
	if connected and not client.is_connected_to_host():
		connected = false
	if client.is_connected_to_host():
		poll_server()


func poll_server():
	while client.get_available_bytes() > 0:
		var msg = client.get_utf8_string(client.get_available_bytes())
		if msg == null:
			continue;
			
		if msg.length() > 0:
			for c in msg:
				if c == "\n":
					on_text_received(text)
					text = ""
				else:
					text+=c

func on_text_received(text):
	var command_array = text.split(" ", true)
	print(command_array)
	if command_array.size() < 1:
		return #checagem dos comandos
		
	if str(command_array[0]) == "Mover:":
		emit_signal("move", command_array[1], command_array[2])


func write_text(text):
	if connected and client.is_connected_to_host():
		print("Sending: %s" % text)
		client.put_data(text.to_ascii())
