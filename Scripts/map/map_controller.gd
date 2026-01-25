extends Node2D

#This script will act sort of like an API from the rest of the program as everything is self contained where it can pass the active state to the Map Controller.

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
