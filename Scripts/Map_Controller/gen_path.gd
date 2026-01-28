extends Node2D

const TILE_SIZE = SingTravelMap.TILE_SIZE
const HALF_TILE_SIZE = SingTravelMap.HALF_TILE_SIZE

var line_scene: PackedScene = preload("res://Scenes/Map_Controller/pathLine.tscn")
var line_texture: Texture2D = load("res://Assets/tileset/path.png")

#generates the node pathing between nodes
func _gen_node_path(random_node_array):
	random_node_array.append(1)
	
	#initial number of nodes at the top (finish/goal)
	var previous_node_count:int = 1

	#y coordinate for the tier
	var node_y_coord = 2
	#print(random_node_array)
	
	#go throught the tiers and get the number of locations
	for node_number in random_node_array:
		#node_number is the number of locations present at this tier.
		
		if(previous_node_count == 1):
			%genPath1._gen_path_1_to(node_y_coord)
		if(previous_node_count == 2):
			%genPath2._gen_path_2_to(node_number,node_y_coord)
		if(previous_node_count == 3):
			%genPath3._gen_path_3_to(node_number,node_y_coord)
		#print(previous_node_count)
		
		#get ready for the next loop
		previous_node_count = node_number
		node_y_coord += 2
	


# Add the points to the Line2D node
func _gen_path_line(start_local_pos,node_coords):
	var end_local_pos = Vector2i(0,0)
	var new_line: Line2D = line_scene.instantiate()
	var path_dictionary_exists = dict_path.check_path_dictionary(node_coords)
	if path_dictionary_exists != null:
		var path_dict_insert_array: Array
		for path_location in path_dictionary_exists:
			path_dict_insert_array.append(path_location)
		path_dict_insert_array.append(start_local_pos)
		dict_path._addto_path_dictionary(node_coords,path_dict_insert_array)
		#print(path_dict_insert_array)
	if path_dictionary_exists == null:
		dict_path._addto_path_dictionary(node_coords,[start_local_pos])
		#print("You've got mail")
	start_local_pos.y = ((start_local_pos.y * TILE_SIZE) + TILE_SIZE)
	start_local_pos.x = ((start_local_pos.x * TILE_SIZE) + 32)
	new_line.add_point(start_local_pos)
	end_local_pos.y = ((node_coords.y * TILE_SIZE))
	end_local_pos.x = ((node_coords.x * TILE_SIZE) + HALF_TILE_SIZE)
	#debug
	#print("start_local_pos: ", start_local_pos)
	#print("origin_tile: ", origin_tile)
	#print("node_coords: ", node_coords)
	#print("end_local_pos: ", end_local_pos)
	#print("------")
	new_line.add_point(end_local_pos)
	#new_line.default_color = Color(1, 0, 0, 1)
	new_line.texture = line_texture
	new_line.texture_mode = Line2D.LINE_TEXTURE_TILE
	new_line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	new_line.end_cap_mode = Line2D.LINE_CAP_ROUND
	add_child(new_line)
