extends Node2D

const TILE_SIZE = SingTravelMap.TILE_SIZE
const HALF_TILE_SIZE = SingTravelMap.HALF_TILE_SIZE

var line_scene: PackedScene = preload("res://Scenes/Map_Controller/pathLine.tscn")

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
	new_line.default_color = Color(1, 0, 0, 1)
	add_child(new_line)
