extends Node2D

class_name MapController

const TILEMAP_X_OFFSET = SingTravelMap.TILEMAP_X_OFFSET
const TILEMAP_Y_OFFSET = SingTravelMap.TILEMAP_Y_OFFSET

signal location_traversal(selected_location: String)

#This script will act sort of like an API from the rest of the program as everything is self contained where it can pass the active state to the Map Controller.
var map_controller_state: int = 1
var hovered_cell = Vector2i(0,0)
var hovered_initial = Vector2i(0,0)

#this will 
func _map_controller_gen_new_map():
	%TravelMap._gen_new_map()

#This will be in case we want the user to be able to view the upcoming map but not traverse it, if they are at a location
func map_controller_active_state_view():
	map_controller_state = 2
	self.visible = true
	%MapHud.visible = true

#This will be to traverse the map to a new location.
func map_controller_active_state():
	map_controller_state = 1
	self.visible = true
	%MapHud.visible = true

func _map_controller_end_active_state(selected_location : String):
	location_traversal.emit(selected_location)
	map_controller_state = 0
	self.visible = false
	%MapHud.visible = false

func _node_traversal(current_cell: Vector2i, selected_location : String):
	%CursorMap.clear()
	%CurrentPosition.clear()
	SingTravelMap.current_node_position = current_cell
	%CurrentPosition.set_cell(SingTravelMap.current_node_position,0,Vector2i(0,0))
	_map_controller_end_active_state(selected_location)

func _process(_delta):
	#----------------
	# Mouse Movement
	#----------------
	if(map_controller_state == 1 or map_controller_state == 2):
		var current_mouse_pos = get_global_mouse_position()
		current_mouse_pos.x -= TILEMAP_X_OFFSET
		current_mouse_pos.y -= TILEMAP_Y_OFFSET
		var current_cell = %TravelMap.local_to_map(current_mouse_pos)
		
		#if the currently hovered over cell is not the current hovered cell or the selected cell
		#then remove the highlighting over the previous highlighted cell
		if (hovered_cell != current_cell):
			# Mouse moved to a different cell or entered/exited the grid
			# Reset previous hovered cell's appearance (if any)
			%CursorMap.set_cell(hovered_cell, -1)
		#if the hovered_cell is not the current cell and we do a dictianry lookup and it is a location, then do a hover over effect.
		if (hovered_cell != current_cell and dict_tile.check_tile_dictionary(current_cell) != null):
			var location_source_id = dict_location.check_source_id(dict_tile.check_tile_dictionary(current_cell),current_cell)
			#print("location source id: ", location_source_id)
			%CursorMap.set_cell(current_cell,location_source_id, Vector2i(1,0))
		hovered_cell = current_cell

func _input(event):
	#----------------
	# Mouse click
	#----------------
	if(map_controller_state == 1 and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and InputState.allow_input(InputState.State.MAP)):
		#get mouse positon and change it to map coords
		var current_mouse_pos = get_global_mouse_position()
		current_mouse_pos.x -= TILEMAP_X_OFFSET
		current_mouse_pos.y -= TILEMAP_Y_OFFSET
		var current_cell = %TravelMap.local_to_map(current_mouse_pos)
		#check if the current node position is in the dictionary (it should be)
		var path_dictionary_exists = dict_path.check_path_dictionary(SingTravelMap.current_node_position)
		var selected_location = ""
		#loop through the results and see if the current clicked cell matches any of the legal paths from the current node
		if(path_dictionary_exists != null):
			for path_location in path_dictionary_exists:
				if(current_cell == path_location):
					selected_location = dict_tile.check_tile_dictionary(path_location)
					_node_traversal(current_cell, selected_location)
					#_map_controller_end_active_state(selected_location)
