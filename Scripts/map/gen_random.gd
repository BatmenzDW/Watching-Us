extends Node2D

#generates random nodes, but adds some order to chaos at the same time.
func gen_random_nodes():
	var previous_number: int = 1
	var max_in_a_row: int = 0
	var return_array = [null,null,null,null,null]
	var random_number: int
	var max_trigger: int = 0
	var next_previous_number = 0
	
	#go through a random number loop 5 times
	for i in range(5):
		print("Previous Number: ",previous_number)
		#if last number was 1, it can't be 1, pick 2 or 3 instead
		if(previous_number == 1):
			random_number = randi_range(2, 3)
			return_array[i] = random_number
			next_previous_number = random_number
			max_in_a_row = 2
			max_trigger = 0
			
		#if max in a row is not 1, go ahead and set a random number,then check if max number needs to trigger.
		if(max_in_a_row != 1 and previous_number != 1):
			random_number = randi_range(1, 3)
			return_array[i] = random_number
			if(previous_number == random_number):
				max_trigger = 1
			next_previous_number = random_number
		
		#if max in a row is 1, choose a different number, choose a different number
		if(max_in_a_row == 1):
			#if previous number was 2, 2's in a row, generate a non 2 number
			if(previous_number == 2):
				random_number = randi_range(1, 2)
				if(random_number == 1):
					return_array[i] = 1
					next_previous_number = 1
				if(random_number == 2):
					return_array[i] = 3
					next_previous_number = 3
			#if previous number was 2, 3's in a row, generate a non 3 number
			if(previous_number == 3):
				random_number = randi_range(1, 2)
				return_array[i] = random_number
				next_previous_number = random_number
			max_trigger = 0
		if(i == 4 and return_array[i] == 1):
			return_array[i] = randi_range(2, 3)
		if(max_trigger == 1):
			max_in_a_row = 1
		if(max_trigger == 0):
			max_in_a_row = 0
		previous_number = next_previous_number
		print("Current_Number: ",return_array[i])
		print("")
	print(return_array)
	return return_array
