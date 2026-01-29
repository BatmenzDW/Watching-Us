extends Node

var path_dictionary = {}

#check for key
func check_path_dictionary(searchterm):
	var has_searchterm = path_dictionary.has(searchterm)
	#print(has_searchterm)
	if has_searchterm:
		return path_dictionary[searchterm]
	else:
		return null

#check for key
func check_bool_tile_dictionary(searchterm):
	if path_dictionary.has(searchterm):
		#print(tile_dictionary[searchterm])
		return 1
	else:
		return 0

#add key
func _addto_path_dictionary(key,value):
	if key != null and value != null:
		path_dictionary[key] = value

#remove key
func erasefrom_tile_dictionary(key):
	if key != null && key != "":
		path_dictionary.erase(key)
		return 1
	return null

#checks the keys with a specific y coord
func check_ycoord_path_dictionary(ycoord):
	var return_dictionary_array = []
	for key in path_dictionary:
		if(key.y == ycoord):
			return_dictionary_array.append(key)
	return return_dictionary_array

func _reset_path_dictionary():
	path_dictionary.clear()
