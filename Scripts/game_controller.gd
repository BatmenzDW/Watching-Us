extends Node2D

class_name GameController

@export var location_index: Dictionary[String, Location_Data]

@onready var map: MapController = $MapController
@onready var location: Location = $Location
@onready var next_button: NextButton = $NextButton

static var total_interactables : int = 0
static var interacts_count : int = 0

static var Instance : GameController

func _ready() -> void:
	Instance = self
	location.visible = false
	location.player.set_child_ui_visible(false)
	next_button.visible = false
	InputState.set_state(InputState.State.MAP)
	SignalBus.interact.connect(_on_interact)

static func transition_to_state(new_state,variable: String):
	Instance.transition_state(new_state, variable)

func transition_state(new_state,variable: String=""):
	if(new_state == "win" or variable == "end"):
		transition_to_win()
	if(new_state == "location"):
		transition_to_location(variable)
	if(new_state == "map"):
		transition_to_map(variable)
	if(new_state == "mainmenu"):
		transition_to_main_menu()
	if(new_state == "credits"):
		transition_to_credits()
	if(new_state == "tantrum"):
		transition_to_tantrum()
	if(new_state == "breakdown"):
		transition_to_breakdown()

# move to new location
func transition_to_location(selected_location: String) -> void:
	if selected_location == "end":
		%MapController.hide()
		return
	var exists : bool = dict_location.check_location_exists(selected_location)
	if not location_index.has(selected_location) or not exists:
		print("Could not find location: ", selected_location)
		selected_location = location_index.keys()[0]
	
	total_interactables = 0
	%MapController.hide()
	var data : Location_Data = location_index[selected_location]
	var inters : Array[Interactable_Data] = data.interactables
	for inte in inters:
		if location.load_data(inte):
			total_interactables += 1
	
	next_button.setup(data.mult_factor, data.mult_type)
	
	SignalBus.set_music.emit(data.music_key)
	
	interacts_count = 0
	location.visible = true
	location.player.set_child_ui_visible(true)
	next_button.visible = true
	InputState.set_state(InputState.State.LEVEL)
	#await get_tree().physics_frame
	location.player.setup_stats()

func transition_to_map(variable: String = ""):
	if variable == "start":
		%MapController.map_new_game()
	if variable != "start":
		%MapController.map_controller_active_state()

func transition_to_credits():
	%CreditsController.roll_credits()

func transition_to_main_menu():
	GameController.result = ""
	location.player.reset_stats()
	SignalBus.set_music.emit("MainTheme")
	%MainMenu._mainmenu_active_state()

static var result : String = ""

func _end_game() -> void:
	location.player.set_child_ui_visible(false)
	location.unload()
	%GameEnd.end()

func transition_to_tantrum():
	if result == "":
		result = "Tantrum"
		_end_game()

func transition_to_breakdown():
	if result == "":
		result = "Breakdown"
		_end_game()

func transition_to_win():
	if result == "":
		result = "Win"
		_end_game()

func _on_interact() -> void:
	interacts_count += 1
	next_button.on_interactable_interact(interacts_count)

func _leave_location() -> void:
	if interacts_count < 1: 
		return
	
	print("Leaving Location")
	location.unload()
	next_button.visible = false
	location.player.set_child_ui_visible(false)
	location.visible = false
	location.text_box.display_text("")
	transition_to_map()
	InputState.set_state(InputState.State.MAP)
