extends Node

var location_travel_dictionary = {
									"Sidewalk": 5,
									"Police Station": 6,
									"Fire Station": 7,
									"Crossing Busy Street": 8
								}
var location_main_dictionary = {
									"Ice Cream Truck": 1,
									"Library": 2,
									"Park": 3,
									"Pharmacy": 4,
								}
var location_start_end_dictionary = {
									"start": 9,
									"end": 10,
								}

func check_source_id(searchterm,current_cell):
	match current_cell.y:
		2, 6, 10:
			#print("main location: ", current_cell.y)
			#print(location_main_dictionary[searchterm])
			return location_main_dictionary[searchterm]
		4, 8:
			#print("travel location: ", current_cell.y)
			#print(location_main_dictionary[searchterm])
			return location_travel_dictionary[searchterm]
		0,12:
			return location_start_end_dictionary[searchterm]

func gen_random_location(location_type):
	var location_name: String
	var location_source: int
	if(location_type == "main"):
		location_name = location_main_dictionary.keys().pick_random()
		location_source = location_main_dictionary[location_name]
	if(location_type == "travel"):
		location_name = location_travel_dictionary.keys().pick_random()
		location_source = location_travel_dictionary[location_name]
	print("Location Name: ", location_name)
	print("Location source: ", location_source)
	print("")
	return [location_name,location_source]

#get_count of locations of a certain type
#use that in a random number generator, applying -1 to the total to get the index
#Use that index file to randomly spawn a location.
#If the location is already listed on that tier, then rerandomize
