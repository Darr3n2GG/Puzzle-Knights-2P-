extends AudioStreamPlayer2D


func _connect(door: bool):
	var audio: AudioStream = preload("res://Imports/Castle Door Open - QuickSounds.com.mp3")
	self.set_stream(audio)
	if door ==  true:
		play()


