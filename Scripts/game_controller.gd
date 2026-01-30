extends Node2D

class_name GameController

@export var location_index: Location_Index

@onready var map: MapController = $MapController
@onready var location: Location = $Location
@onready var next_button: NextButton = $NextButton

var interacts_count : int = 0

enum GameEndState {
	WIN,
	TANTRUM,
	BREAKDOWN
}

# TODO
static func game_end(state: GameEndState) -> void:
	match state:
		GameEndState.WIN:
			pass
		GameEndState.TANTRUM:
			pass
		GameEndState.BREAKDOWN:
			pass

func _ready() -> void:
	location.visible = false
	next_button.visible = false
	InputState.set_state(InputState.State.MAP)
	SignalBus.interact.connect(_on_interact)

func transition_state(new_state,variable: String):
	if(new_state == "location"):
		transition_to_location(variable)
	if(new_state == "map"):
		transition_to_map()
	if(new_state == "mainmenu"):
		transition_to_main_menu()

# move to new location
func transition_to_location(selected_location: String) -> void:
	dict_location.check_location_exists(selected_location)
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

func transition_to_map():
	%MapController._map_controller_active_state()
	
func transition_to_main_menu():
	%MainMenu._map_controller_active_state()

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
