extends AudioStreamPlayer2D

const lookup : Dictionary[String, AudioStreamMP3] = {
	"DogBark": preload("uid://cic5xtxgtoel5"),
	"IceCream": preload("uid://buj8akwj4egde"),
	"Menu_1" : preload("uid://bjei7mkkygoh3"),
	"Menu_2" : preload("uid://o37u7vko1rcf"),
	"Menu_Select": preload("uid://vaa2hynsgfg3")
}

@export var min_interval : float = 1.0

var last_timestamp : float = 0.0

func _ready() -> void:
	SignalBus.play_audio.connect(_play_audio)

func _play_audio(key : String) -> void:
	var current = Time.get_unix_time_from_system()
	if lookup.has(key) and not self.is_playing() and last_timestamp + min_interval >= current:
		stream = lookup[key]
		last_timestamp = current
		self.play()
	
	elif not lookup.has(key):
		print("Unknown audio key: ", key)
