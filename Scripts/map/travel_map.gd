extends TileMapLayer
	
@export var map_current_node_position: Vector2i
const MAP_TILE_EMPTY = Vector2i(0, 0) # Atlas coordinates for the empty/background tile
const MAP_TILE_LOCATION = Vector2i(1, 0) # Atlas coordinates for the location tile
const SOURCE_ID: int = 0

func _ready():
	_gen_new_map()

#generates the new map when called.
func _gen_new_map():
	#adds the start and ending tile to the tile dictionary for later use
	dict_tile.addto_tile_dictionary(Vector2i(2,0),[])
	dict_tile.addto_tile_dictionary(Vector2i(2,12),[])
	
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
	var random_node_array = gen_random_nodes()
	
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
				1, 3, 5, 7, 9, 11:
					_gen_cell_empty_node(map_coords)
				0, 2, 4, 6, 8, 10, 12:
					_gen_cell_check_node(map_coords,random_node_array)
			
			#end of the iteration of inner while loop, increase CountX by 1
			countX += 1
		
		#now done with the inner loop iterations, back in the outer loop, increase Y by 1 and reset X to advance the outer loop
		countY += 1
		countX = 0
	%genPath._gen_node_path(random_node_array)
	#%Control_Movement.initialize_grid()
	#%Camera.set_map_limits()


func gen_random_nodes():
	var return_array = [randi_range(1, 3),randi_range(1, 3),randi_range(1, 3),randi_range(1, 3),randi_range(1, 3)]
	return return_array
	
func _gen_cell_check_node(map_coords, random_node_array):
	#checks if it is the start or end
	if(map_coords.y == 0 or map_coords.y == 12):
		if(map_coords.x == 2):
			#print("start/end triggered")
			_gen_cell_random_node(map_coords)
		if(map_coords.x != 2):
			_gen_cell_empty_node(map_coords)
	
	#checks the middle valid location values
	var array_tier_locations = [2, 4, 6, 8, 10]
	if(array_tier_locations.has(map_coords.y)):
		var node_array_index: int = 200
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
				if(!(random_node_array[node_array_index] == 3)):
					_gen_cell_empty_node(map_coords)
			1,3:
				#if the value is 2, it means this should be a random node.
				if(random_node_array[node_array_index] == 2):
					_gen_cell_random_node(map_coords)
				if(!(random_node_array[node_array_index] == 2)):
					_gen_cell_empty_node(map_coords)
			2:
				#if the value is 1 or 3, it means this should be a random node.
				if(random_node_array[node_array_index] == 3 or random_node_array[node_array_index] == 1):
					_gen_cell_random_node(map_coords)
				if(!(random_node_array[node_array_index] == 3 or random_node_array[node_array_index] == 1)):
					_gen_cell_empty_node(map_coords)
	
	#if it isn't valid start, end, or middle where the locations could be, then generate and empty.
	#this shouldn't be used but is here as a catch all.
	if(!(array_tier_locations.has(map_coords.y) or map_coords.y == 0 or map_coords.y == 12 )):
		print("BUG ALERT: This shouldn't be used: map_coords= ", map_coords, " source_id= ")
		_gen_cell_empty_node(map_coords)

func _gen_cell_empty_node(map_coords):
	#set_cell(map_coords, -1)
	set_cell(map_coords, SOURCE_ID, MAP_TILE_EMPTY)
	#var tile_info = "empty"
	#dict_tile.addto_tile_dictionary(map_coords,tile_info)

#generates a random node
func _gen_cell_random_node(map_coords):
	#set_cell(map_coords, -1)
	set_cell(map_coords, SOURCE_ID, MAP_TILE_LOCATION)
	var tile_info = []
	dict_tile.addto_tile_dictionary(map_coords,tile_info)
