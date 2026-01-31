extends AudioStreamPlayer2D

var lookup : Dictionary[String, AudioStreamMP3] = {
	"None": null,
	"MainTheme": preload("uid://cjhu8ci5fbsrl"),
	"IceCreamTruck": preload("uid://cb8vt3h0yndya")
}

func _ready() -> void:
	bus = &"Music"
	SignalBus.set_music.connect(_play_audio)
	_play_audio("MainTheme")

func _play_audio(key : String) -> void:
	print("music signal with key: " + key)
	if lookup.has(key) and not self.is_playing():
		stream = lookup[key]
		self.play()
	
	elif not lookup.has(key):
		print("Unknown audio key: ", key)
