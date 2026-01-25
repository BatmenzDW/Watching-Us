extends Node2D

const TILE_SIZE = SingTravelMap.TILE_SIZE
const HALF_TILE_SIZE = SingTravelMap.HALF_TILE_SIZE
var start_local_pos = Vector2i(0,0)

#generates a path that goes from 2 to other node(s)
func _gen_path_2_to(node_number,node_y_coord):
	
	#getting arrays from the tile_dictionary to get the current previous tier and current tier of tiles.
	var from_node_coord_array = dict_tile.check_ycoord_tile_dictionary(node_y_coord - 2)
	var to_node_coord_array = dict_tile.check_ycoord_tile_dictionary(node_y_coord)
	
	#start tile coord and local position
	var origin_tile = Vector2i(0,0)
	start_local_pos.y = ((origin_tile.y * TILE_SIZE) + TILE_SIZE)
	start_local_pos.x = ((origin_tile.x * TILE_SIZE) + HALF_TILE_SIZE)
	
	var con_cross: int = 0
	
	#if 2, into 1, bothw ill have an output to one
	if(node_number == 1):
		#for each from lcoation
		for from_node_coords in from_node_coord_array:
			start_local_pos.y = ((from_node_coords.y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coords.x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[0])
	
	
	#if 2 into 2, both will have an output to one on each side, and one may cross paths
	if(node_number == 2):
		#we are going to set the first item in the "FROM" array to the first item in the "TO" array
		start_local_pos.y = ((from_node_coord_array[0].y * TILE_SIZE) + TILE_SIZE)
		start_local_pos.x = ((from_node_coord_array[0].x * TILE_SIZE) + HALF_TILE_SIZE)
		%genPath._gen_path_line(start_local_pos,to_node_coord_array[0])
		#we are going to set the last item in the "FROM" array to the last item in the "TO" array
		start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
		start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
		%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
		
		#now we are going to take a random chance to also cross branch to another location, but only one cross branch is allowed
		if(randi_range(1, 2) == 2):
			start_local_pos.y = ((from_node_coord_array[0].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[0].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[randi_range(0, 1)])
			con_cross = 1
		if(con_cross != 1 and randi_range(1, 2) == 2):
			start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[randi_range(0, 1)])
		con_cross = 0
	
	#if 2 into 2, both will have an output to one on each side, and one may cross paths
	if(node_number == 3):
		#we are going to set the first item in the "FROM" array to the first item in the "TO" array
		start_local_pos.y = ((from_node_coord_array[0].y * TILE_SIZE) + TILE_SIZE)
		start_local_pos.x = ((from_node_coord_array[0].x * TILE_SIZE) + HALF_TILE_SIZE)
		%genPath._gen_path_line(start_local_pos,to_node_coord_array[0])
		#we are going to set the lsast item in the "FROM" array to the first item in the "TO" array
		start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
		start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
		%genPath._gen_path_line(start_local_pos,to_node_coord_array[2])
		
		#now we are going to take a random chance to also cross branch to the center. one or both of them can cross to the center, but one must cross to the center.
		#50% chance to draw from item 1 to middle item in next row
		if(randi_range(1, 2) == 2):
			start_local_pos.y = ((from_node_coord_array[0].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[0].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
			con_cross = 1
		#if it did previously cross to the center, give the second item a 50% chance to connect to the center as well.
		if(con_cross == 1 and randi_range(1, 2) == 2):
			start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
		#if it did not cross to the center, the second node must connect to the center, otherwise it can't be moved to.
		if(con_cross != 1):
			start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
		con_cross = 0
