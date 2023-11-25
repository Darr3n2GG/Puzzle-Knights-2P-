extends AudioStreamPlayer
class_name ambience


func _ready() -> void:
	play()
	
func play_music() -> void:
	$music_transition.start()
	
func _on_music_transition_timeout() -> void:
	play()
	

func _on_finished() -> void:
	play_music()
