extends Node2D

#generates random locations
func gen_location(map_coords):
	if map_coords.y % 4 == 0:
		return gen_location_type(map_coords, "travel")
	else:
		return gen_location_type(map_coords,"main")	

func gen_location_type(map_coords,location_category):
	#removes any tile if present
	%TravelMap.set_cell(map_coords,-1)
	var return_array = dict_location.gen_random_location(location_category)
	var location_name: String = return_array[0]
	var location_source: int = return_array[1]
	%TravelMap.set_cell(map_coords,location_source,Vector2i(0,0))
	return location_name
