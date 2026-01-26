extends Node2D

#generates a path that goes from 1 to other node(s)
func _gen_path_1_to(node_y_coord):
	
	#getting arrays from the tile_dictionary to get the current previous tier and current tier of tiles.
	var node_coord_array = dict_tile.check_ycoord_tile_dictionary(node_y_coord)
	
	#start tile coord and local position
	var start_local_pos = Vector2i(2,node_y_coord - 2)
	
	#with one base node, it will go to each of the next node tiers locations
	#this runs the command to send a line to each lcoation.
	for node_coords in node_coord_array:
		%genPath._gen_path_line(start_local_pos,node_coords)
