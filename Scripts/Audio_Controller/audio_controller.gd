extends AudioStreamPlayer2D

const lookup : Dictionary[String, AudioStreamMP3] = {
	"DogBark": preload("uid://cic5xtxgtoel5"),
	"IceCream": preload("uid://buj8akwj4egde"),
	"IceCreamEat": preload("uid://c8iygwjq5jvtg"),
	"Menu": preload("uid://dhphvwk4lgrnu"),
	"Menu_1" : preload("uid://bjei7mkkygoh3"),
	"Menu_2" : preload("uid://o37u7vko1rcf"),
	"MenuSelect": preload("uid://vaa2hynsgfg3"),
	"MapSelect": preload("uid://cfo4ch284fl7g"),
	"DadEnter": preload("uid://7fbqodpb4clv"),
	"PillBottle": preload("uid://5vo4n6fq2avl"),
	"Swallow": preload("uid://cvmpf683gl6k5"),
	"Walk": preload("uid://clie8c6jn2vlj"),
	"WhichOne": preload("uid://hp2qj3i01d7c")
}

@export var min_interval : float = 0.1

var last_timestamp : float = 0.0

func _ready() -> void:
	SignalBus.play_audio.connect(_play_audio)

func _play_audio(key : String) -> void:
	print("audio signal with key: " + key)
	var current = Time.get_unix_time_from_system()
	if lookup.has(key) and not self.is_playing() and last_timestamp + min_interval <= current:
		stream = lookup[key]
		last_timestamp = current
		self.play()
	
	elif not lookup.has(key):
		print("Unknown audio key: ", key)
	
	else:
		print("Not enough time since last sfx play: ", last_timestamp, " : ", current)
