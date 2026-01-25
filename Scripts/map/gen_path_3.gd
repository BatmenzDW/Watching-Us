extends Node2D

const TILE_SIZE = SingTravelMap.TILE_SIZE
const HALF_TILE_SIZE = SingTravelMap.HALF_TILE_SIZE

#generates a path that goes from 2 to other node(s)
func _gen_path_3_to(node_number,node_y_coord):
	
	#getting arrays from the tile_dictionary to get the current previous tier and current tier of tiles.
	var from_node_coord_array = dict_tile.check_ycoord_tile_dictionary(node_y_coord - 2)
	var to_node_coord_array = dict_tile.check_ycoord_tile_dictionary(node_y_coord)
	
	#start tile coord and local position
	var origin_tile = Vector2i(2,node_y_coord - 2)
	var start_local_pos = Vector2i(0,0)
	start_local_pos.y = ((origin_tile.y * TILE_SIZE) + TILE_SIZE)
	start_local_pos.x = ((origin_tile.x * TILE_SIZE) + HALF_TILE_SIZE)
	
	#if 3 to 1 all must go to 1, Loop throught the start position of each and send it to the single "to" position
	if(node_number == 1):
		#for each from lcoation
		for from_node_coords in from_node_coord_array:
			start_local_pos.y = ((from_node_coords.y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coords.x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[0])
		
	
	
	
	if(node_number == 2):
		#a variable used later to see if there was a cross or not, so we don't have the paths cross in the middle.
		var con_middle: int = 0
		
		start_local_pos.y = ((from_node_coord_array[0].y * TILE_SIZE) + TILE_SIZE)
		start_local_pos.x = ((from_node_coord_array[0].x * TILE_SIZE) + HALF_TILE_SIZE)
		%genPath._gen_path_line(start_local_pos,to_node_coord_array[0])
		#we are going to set the last item in the "FROM" array to the last item in the "TO" array
		start_local_pos.y = ((from_node_coord_array[2].y * TILE_SIZE) + TILE_SIZE)
		start_local_pos.x = ((from_node_coord_array[2].x * TILE_SIZE) + HALF_TILE_SIZE)
		%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
		
		#now we are going to take a random chance the middle node can branch to each location.
		#it must branch to at least one of the 2.
		if(randi_range(1, 2) == 2):
			start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[0])
			con_middle = 1
		if(con_middle != 1 or (con_middle == 1 and randi_range(1, 2) == 2)):
			start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
		con_middle = 0
	
	
	if(node_number == 3):
		var con_middle: int = 0
		var middle_connection: int = 0
		var left_cross: int = 0
		var right_cross: int = 0
		
		#if 3 to 3, far left and far right have to go to each of them.
		#the middle can go to one or both of them
		#we are going to set the first item in the "FROM" array to the first item in the "TO" array
		
		#we are going to set the first item in the "FROM" array to the first item in the "TO" array
		start_local_pos.y = ((from_node_coord_array[0].y * TILE_SIZE) + TILE_SIZE)
		start_local_pos.x = ((from_node_coord_array[0].x * TILE_SIZE) + HALF_TILE_SIZE)
		%genPath._gen_path_line(start_local_pos,to_node_coord_array[0])
		#we are going to set the last item in the "FROM" array to the last item in the "TO" array
		start_local_pos.y = ((from_node_coord_array[2].y * TILE_SIZE) + TILE_SIZE)
		start_local_pos.x = ((from_node_coord_array[2].x * TILE_SIZE) + HALF_TILE_SIZE)
		%genPath._gen_path_line(start_local_pos,to_node_coord_array[2])
		
		#we then check if the far left will also connect to the middle, giving it a 30% chance
		if(randi_range(1, 3) == 3):
			start_local_pos.y = ((from_node_coord_array[0].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[0].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
			left_cross = 1
			middle_connection = 1
		
		#we then check if the far right will also connect to the middle, giving it a 30% chance
		if(randi_range(1, 3) == 3):
			start_local_pos.y = ((from_node_coord_array[2].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[2].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
			right_cross = 1
			middle_connection = 1
		
		#now we are going to take a random chance the middle node can branch to each location.
		#it must branch to at least one of the 2.
		if(randi_range(1, 2) == 2 and left_cross != 1):
			start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
			con_middle = 1
		if(randi_range(1, 2) == 2) and right_cross != 1:
			start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
			con_middle = 1
		#if the middle FROM node hasn't connected to the left or the right OR if the middle TO node doesn't have a connection, force the middle connection, otherwise make it random.
		if(con_middle != 1 or middle_connection != 1 or randi_range(1, 2) == 2):
			start_local_pos.y = ((from_node_coord_array[1].y * TILE_SIZE) + TILE_SIZE)
			start_local_pos.x = ((from_node_coord_array[1].x * TILE_SIZE) + HALF_TILE_SIZE)
			%genPath._gen_path_line(start_local_pos,to_node_coord_array[1])
			
