extends Node2D

#This script will act sort of like an API from the rest of the program as everything is self contained where it can pass the active state to the Map Controller.
var map_controller_state: int = 1
var hovered_cell = Vector2i(0,0)
var hovered_initial = Vector2i(0,0)
var HOVERED_CELL_IMAGE = SingTravelMap.HOVERED_CELL_IMAGE

#this will 
func _map_controller_gen_new_map():
	%TravelMap._gen_new_map()

#This will be in case we want the user to be able to view the upcoming map but not traverse it, if they are at a location
func _map_controller_active_state_view():
	pass

#This will be to traverse the map to a new location.
func _map_controller_active_state():
	pass

func _map_controller_end_active_state():
	pass

func _process(_delta):
	#----------------
	# Mouse Movement
	#----------------
	if(map_controller_state == 1):
		var current_mouse_pos = get_global_mouse_position()
		var current_cell = %CursorMap.local_to_map(current_mouse_pos)
		#if the currently hovered over cell is not the current hovered cell or the selected cell
		#then remove the highlighting over the previous highlighted cell
		
		if (current_cell != hovered_cell):
			# Mouse moved to a different cell or entered/exited the grid
			# Reset previous hovered cell's appearance (if any)
			%CursorMap.set_cell(hovered_cell, -1)
		if (dict_tile.check_bool_tile_dictionary(current_cell) == 1):
			hovered_cell = current_cell
			%CursorMap.set_cell(current_cell, 0, HOVERED_CELL_IMAGE)
		
