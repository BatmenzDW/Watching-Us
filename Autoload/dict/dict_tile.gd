extends Node

var tile_dictionary = {}

#check for key
func check_tile_dictionary(searchterm):
	if tile_dictionary.has(searchterm):
		#print(tile_dictionary[searchterm])
		return tile_dictionary[searchterm]
	else:
		return null

#check for key
func check_bool_tile_dictionary(searchterm):
	if tile_dictionary.has(searchterm):
		#print(tile_dictionary[searchterm])
		return 1
	else:
		return 0
	
#add key
func addto_tile_dictionary(key,value):
	if key != null && value != null && check_tile_dictionary(key) == null:
		tile_dictionary[key] = value
		#print(key," ",tile_dictionary[key])
		return 1
	return null

#remove key
func erasefrom_tile_dictionary(key):
	if key != null && key != "":
		tile_dictionary.erase(key)
		return 1
	return null

#checks the keys with a specific y coord
func check_ycoord_tile_dictionary(ycoord):
	var return_dictionary_array = []
	for key in tile_dictionary:
		if(key.y == ycoord):
			return_dictionary_array.append(key)
	return return_dictionary_array

#updates a key's input
func updatevalue_tile_dictionary(key,value):
	pass

func _reset_tile_dictionary():
	tile_dictionary.clear()
