extends AudioStreamPlayer2D


func _connect(door: bool):
	var audio: AudioStream = preload("res://Music/SFX/Castle Door Open - QuickSounds.com.mp3")
	self.set_stream(audio)
	if door ==  true:
		play()


