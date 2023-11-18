extends AudioStreamPlayer
class_name ambience

var music : AudioStreamPlayer

func _ready() -> void:
	play_music()

func play_music() -> void:
	music = get_child(randf_range(0,2))
	stream = music.stream
	play()
	
func _on_finished() -> void:
	play_music()
