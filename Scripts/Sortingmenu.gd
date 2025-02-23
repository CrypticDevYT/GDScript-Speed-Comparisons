extends Control

var rnd_arr: Array = []
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func bubblesort_static_typed(array: Array) -> void:
	var length: int = array.size()
	for i in range(0, length):
		var swapped:bool = false
		for j in range(0, length - i - 1):
			if array[j] > array[j+1]:
				var tmp: int = array[j]
				array[j] = array[j+1]
				array[j+1] = tmp
				swapped = true
		if not swapped:
			break

func bubblesort_not_typed(array):
	var length = array.size()
	for i in range(0, length):
		var swapped = false
		for j in range(0, length - i - 1):
			if array[j] > array[j+1]:
				var tmp = array[j]
				array[j] = array[j+1]
				array[j+1] = tmp
				swapped = true
		if not swapped:
			break

func quicksort_static_typed(array: Array) -> void:
	var stack: Array = []
	
	stack.push_back(0)
	stack.push_back(array.size() - 1)
	
	while not stack.empty():
		var high: int = stack[stack.size() - 1]
		stack.remove(stack.size() - 1)
		var low: int = stack[stack.size() - 1]
		stack.remove(stack.size() - 1)
		
		var pivot_ind: int = partition_static_typed(array, low, high)
		
		if pivot_ind - 1 > low:
			stack.push_back(low)
			stack.push_back(pivot_ind - 1)
		
		if pivot_ind + 1 < high:
			stack.push_back(pivot_ind + 1)
			stack.push_back(high)

func partition_static_typed(array: Array, low: int, high: int) -> int:
	var pivot: int = array[high]
	var i: int = low - 1
	
	for j in range(low, high):
		if array[j] < pivot:
			i += 1
			var tmp: int = array[i]
			array[i] = array[j]
			array[j] = tmp
	var tmp: int = array[i + 1]
	array[i + 1] = array[high]
	array[high] = tmp
	return i + 1

func quicksort_not_typed(array):
	var stack = []
	
	stack.push_back(0)
	stack.push_back(array.size() - 1)
	
	while not stack.empty():
		var high = stack[stack.size() - 1]
		stack.remove(stack.size() - 1)
		var low = stack[stack.size() - 1]
		stack.remove(stack.size() - 1)
		
		var pivot_ind= partition_not_typed(array, low, high)
		
		if pivot_ind - 1 > low:
			stack.push_back(low)
			stack.push_back(pivot_ind - 1)
		
		if pivot_ind + 1 < high:
			stack.push_back(pivot_ind + 1)
			stack.push_back(high)

func partition_not_typed(array, low, high):
	var pivot = array[high]
	var i = low - 1
	
	for j in range(low, high):
		if array[j] < pivot:
			i += 1
			var tmp = array[i]
			array[i] = array[j]
			array[j] = tmp
	var tmp = array[i + 1]
	array[i + 1] = array[high]
	array[high] = tmp
	return i + 1

func button_event(num: int, avg_type: bool, type: bool,amt: int) -> void:
	if not amt > 1:
		return
	if num == 0:
		var times: Array = []
		if avg_type:
			for i in range(0, 5):
				rnd_arr = []
				for j in range(0, amt):
					rnd_arr.append(rng.randi_range(0, 999))
				#check if statically type test
				if type:
					var start: int = Time.get_ticks_msec()
					bubblesort_static_typed(rnd_arr)
					var end: int = Time.get_ticks_msec()
					times.append(end - start)
				else:
					var start: int = Time.get_ticks_msec()
					bubblesort_not_typed(rnd_arr)
					var end: int = Time.get_ticks_msec()
					times.append(end - start)
			if type:
				$VBoxContainer/HBoxContainer/TextEdit.text += "Bubble sort Average of 5 to sort " + str(amt) + " elements: " + str(get_avg_int_arr(times)) + " ms\n"
			else:
				$VBoxContainer/HBoxContainer/TextEdit.text += "Bubble sort (not typed) Average of 5 to sort " + str(amt) + " elements: " + str(get_avg_int_arr(times)) + " ms\n"
		else:
			rnd_arr = []
			for j in range(0, amt):
				rnd_arr.append(rng.randi_range(0, 999))
			
			if type:
				var start: int = Time.get_ticks_msec()
				bubblesort_static_typed(rnd_arr)
				var end: int = Time.get_ticks_msec()
				$VBoxContainer/HBoxContainer/TextEdit.text += "Bubble sort took: " + str(end - start) + " ms to sort " + str(amt) + " elements.\n"
			else:
				var start: int = Time.get_ticks_msec()
				bubblesort_not_typed(rnd_arr)
				var end: int = Time.get_ticks_msec()
				$VBoxContainer/HBoxContainer/TextEdit.text += "Bubble sort (not typed) took: " + str(end - start) + " ms to sort " + str(amt) + " elements.\n"
			
	if num == 1:
		var times: Array = []
		if avg_type:
			for i in range(0, 5):
				rnd_arr = []
				for j in range(0, amt):
					rnd_arr.append(rng.randi_range(0, 999))
				#check if statically type test
				if type:
					var start: int = Time.get_ticks_msec()
					quicksort_static_typed(rnd_arr)
					var end: int = Time.get_ticks_msec()
					times.append(end - start)
				else:
					var start: int = Time.get_ticks_msec()
					quicksort_not_typed(rnd_arr)
					var end: int = Time.get_ticks_msec()
					times.append(end - start)
			if type:
				$VBoxContainer/HBoxContainer/TextEdit.text += "Quick sort Average of 5 to sort " + str(amt) + " elements: " + str(get_avg_int_arr(times)) + " ms\n"
			else:
				$VBoxContainer/HBoxContainer/TextEdit.text += "Quick sort (not typed) Average of 5 to sort " + str(amt) + " elements: " + str(get_avg_int_arr(times)) + " ms\n"
		else:
			rnd_arr = []
			for j in range(0, amt):
				rnd_arr.append(rng.randi_range(0, 999))
			
			if type:
				var start: int = Time.get_ticks_msec()
				quicksort_static_typed(rnd_arr)
				var end: int = Time.get_ticks_msec()
				$VBoxContainer/HBoxContainer/TextEdit.text += "Quick sort took: " + str(end - start) + " ms to sort " + str(amt) + " elements.\n"
			else:
				var start: int = Time.get_ticks_msec()
				quicksort_not_typed(rnd_arr)
				var end: int = Time.get_ticks_msec()
				$VBoxContainer/HBoxContainer/TextEdit.text += "Quick sort (not typed) took: " + str(end - start) + " ms to sort " + str(amt) + " elements.\n"
			

func get_avg_int_arr(array: Array) -> int:
	var sum: int = 0
	for i in array:
		sum += i
	
	return sum / array.size()



func _on_clear_button_pressed() -> void:
	$VBoxContainer/HBoxContainer/TextEdit.text = ""

func _on_BubbleSortButton_pressed():
	var take_avg_pressed:bool = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer3/TakeAvgCheck.pressed
	var static_type_pressed:bool = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/StaticTypeCheck.pressed
	var amt: int = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpinBox.value
	button_event(0, take_avg_pressed, static_type_pressed, amt)


func _on_QuickSortButton_pressed():
	var take_avg_pressed:bool = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer3/TakeAvgCheck.pressed
	var static_type_pressed:bool = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/StaticTypeCheck.pressed
	var amt: int = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpinBox.value
	button_event(1, take_avg_pressed, static_type_pressed, amt)
