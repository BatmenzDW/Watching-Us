extends AudioStreamPlayer2D

var lookup : Dictionary[String, AudioStreamMP3] = {
	"Dog_Bark": preload("uid://cic5xtxgtoel5"),
	"IceCream": preload("uid://buj8akwj4egde"),
	"Menu_1" : preload("uid://bjei7mkkygoh3"),
	"Menu_2" : preload("uid://o37u7vko1rcf"),
	"Menu_Select": preload("uid://vaa2hynsgfg3")
}

func _ready() -> void:
	SignalBus.play_audio.connect(_play_audio)

func _play_audio(key : String) -> void:
	if lookup.has(key) and not self.is_playing():
		stream = lookup[key]
		self.play()
	
	elif not lookup.has(key):
		print("Unknown audio key: ", key)
