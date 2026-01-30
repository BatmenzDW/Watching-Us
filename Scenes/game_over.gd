extends MarginContainer
@onready var label: Label = $VBoxContainer/Label2

func _ready() -> void:
	label.text = GameController.result
	SignalBus.set_music.emit("IceCreamTruck")
