extends TileMapLayer
	
@export var map_current_node_position: Vector2i
const MAP_TILE_EMPTY = Vector2i(0, 0) # Atlas coordinates for the empty/background tile
const MAP_TILE_LOCATION = Vector2i(1, 0) # Atlas coordinates for the location tile
const SOURCE_ID: int = 0

#generates the new map when called.
func _gen_new_map():
	_clear_old_map()
	#adds the start and ending tile to the tile dictionary for later use
	dict_tile.addto_tile_dictionary(Vector2i(2,0),"end")
	dict_tile.addto_tile_dictionary(Vector2i(2,12),"start")
	set_cell(Vector2i(2,0),10,Vector2i(0,0))
	set_cell(Vector2i(2,12),9,Vector2i(0,0))
	#number of squares on the map
	var map_sizeX = 5
	var map_sizeY = 13
	#These are counters for the following loop
	var countX = 0
	var countY = 0
	#This will keep track of the X and Y as we traverse with the count in the loop and allow us 
	#to feed the current coords to other functions to process easier
	var map_coords = Vector2i(0,0)
	
	#generates 5 random nodes, one for each tier of progression
	var random_node_array = %GenRandom.gen_random_nodes()
	
	#loops through the Y values in the grid
	# at the end of each X row, it will reset X to 0 and increase Y by 1.
	while countY < map_sizeY:
		#Sets the map coords to the current loop iteration for Y, starting at 0 and increasing each loop
		map_coords.y = countY
		
		#Now this starts going through the inner loop, keeping Y(height), but going through each X value
		while countX < map_sizeX:
			#Sets the map coords to the current loop iteration for X, starting at 0 and increasing each loop
			map_coords.x = countX
			
			match countY:
				2, 4, 6, 8, 10:
					_gen_cell_check_node(map_coords,random_node_array)
			
			#end of the iteration of inner while loop, increase CountX by 1
			countX += 1
		
		#now done with the inner loop iterations, back in the outer loop, increase Y by 1 and reset X to advance the outer loop
		countY += 1
		countX = 0
	%genPath._gen_node_path(random_node_array)


#Generate the cell and check the node to see if it is a location
func _gen_cell_check_node(map_coords, random_node_array):
	#checks if it is the start or end
	if(map_coords.y == 0 or map_coords.y == 12):
		if(map_coords.x == 2):
			#print("start/end triggered")
			_gen_cell_random_node(map_coords)
	
	#checks the middle valid location values
	var array_tier_locations = [2, 4, 6, 8, 10]
	if(array_tier_locations.has(map_coords.y)):
		var node_array_index: int
		match map_coords.y:
			2:
				node_array_index = 0
			4:
				node_array_index = 1
			6:
				node_array_index = 2
			8:
				node_array_index = 3
			10:
				node_array_index = 4
		
		match map_coords.x:
			0,4:
				#if the value is 3, it means this should be a random node.
				if(random_node_array[node_array_index] == 3):
					_gen_cell_random_node(map_coords)
			1,3:
				#if the value is 2, it means this should be a random node.
				if(random_node_array[node_array_index] == 2):
					_gen_cell_random_node(map_coords)
			2:
				#if the value is 1 or 3, it means this should be a random node.
				if(random_node_array[node_array_index] == 3 or random_node_array[node_array_index] == 1):
					_gen_cell_random_node(map_coords)
	
	#if it isn't valid start, end, or middle where the locations could be, then generate and empty.
	#this shouldn't be used but is here as a catch all.
	if(!(array_tier_locations.has(map_coords.y) or map_coords.y == 0 or map_coords.y == 12 )):
		print("BUG ALERT: This shouldn't be used: map_coords= ", map_coords, " source_id= ")


#generates a random location in a node
func _gen_cell_random_node(map_coords):
	#set_cell(map_coords, -1)
	set_cell(map_coords, SOURCE_ID, MAP_TILE_LOCATION)
	var tile_info = %GenLocation.gen_location(map_coords)
	#print(tile_info)
	dict_tile.addto_tile_dictionary(map_coords,tile_info)

#clears the old map
func _clear_old_map():
	dict_tile._reset_tile_dictionary()
	%TravelMap.clear()
	%CursorMap.clear()
	%CurrentPosition.clear()
	SingTravelMap.current_node_position= Vector2i(2,12)
	%CurrentPosition.set_cell(SingTravelMap.current_node_position,0,Vector2i(0,0))
	#remove old pathLine nodes if there.
	var items = get_tree().get_nodes_in_group("line2d")
	for item in items:
		if is_instance_valid(item):
			item.queue_free()
