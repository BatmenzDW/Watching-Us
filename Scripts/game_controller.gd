extends Node2D

@export var location_index : Location_Index

@onready var map: MapController = $MapController
@onready var location: Location = $Location
@onready var next_button: NextButton = $NextButton

var interacts_count : int = 0

func _ready() -> void:
	location.visible = false
	next_button.visible = false
	InputState.set_state(InputState.State.MAP)
	SignalBus.interact.connect(_on_interact)

# move to new location
func _on_map_controller_location_traversal(selected_location: String) -> void:
	if not location_index.contains(selected_location):
		print("Could not find location: ", selected_location)
		selected_location = location_index.keys()[0]
	
	var data : Location_Data = location_index.get_(selected_location)
	var inters : Array[Interactable_Data] = data.interactables
	for inte in inters:
		location.load_data(inte)
	
	next_button.setup(data.mult_factor, data.mult_type)
	
	SignalBus.set_music.emit(data.music_key)
	
	interacts_count = 0
	location.visible = true
	next_button.visible = true
	InputState.set_state(InputState.State.LEVEL)

func _on_interact() -> void:
	interacts_count += 1
	next_button.on_interactable_interact(interacts_count)

func _leave_location() -> void:
	if interacts_count < 1: 
		return
	
	location.unload()
	next_button.visible = false
	location.visible = false
	map.map_controller_active_state()
	InputState.set_state(InputState.State.MAP)
