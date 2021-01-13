extends Control

onready var audio_level : AudioStreamPlayer = $Audio_Level
onready var anim_chance_scene : AnimationPlayer = $ChangeScene
onready var peixito = $Peixito
export var next_scene: PackedScene
export var num_peixitos = 0

func _ready() -> void:
	audio_level.play()
	audio_level.volume_db = -20
	

func _on_Levels_tree_entered() -> void:
	get_tree().paused = false
	PlayerData.peixitos = 0

func _get_configuration_warning() -> String:
	return "The next SCENE can't be empty" if not next_scene else ""

func _process(delta: float) -> void:
	if num_peixitos == PlayerData.peixitos:
		PlayerData.peixitos = 0
		get_tree().change_scene_to(next_scene)
