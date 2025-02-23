extends Control

var rnd_arr = []
var text = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var button = get_node("VBoxContainer/HBoxContainer/TextEdit/clearButton")
	var bubblesort_button = get_node("VBoxContainer/HBoxContainer/VBoxContainer/BubbleSortButton")
	var quicksort_button = get_node("VBoxContainer/HBoxContainer/VBoxContainer/QuickSortButton")
	button.connect("pressed", self, "_on_clear_button_pressed")
	bubblesort_button.connect("pressed", self, "_on_BubbleSortButton_pressed")
	quicksort_button.connect("pressed", self, "_on_QuickSortButton_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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

func button_event(num, avg_type, type, amt):
	if not amt > 1:
		return
	if num == 0:
		var times = []
		if avg_type:
			for i in range(0, 5):
				rnd_arr = []
				for j in range(0, amt):
					rnd_arr.append(randi() % 1000)
				#check if statically type test
				if type:
					var start = OS.get_ticks_msec()
					var end = OS.get_ticks_msec()
					times.append(end - start)
				else:
					var start = OS.get_ticks_msec()
					bubblesort_not_typed(rnd_arr)
					var end = OS.get_ticks_msec()
					times.append(end - start)
			if type:
				text += "Bubble sort Average of 5 to sort " + str(amt) + " elements: " + str(get_avg_int_arr(times)) + " ms\n"
				get_node("VBoxContainer/HBoxContainer/TextEdit").set_text(text)
			else:
				text += "Bubble sort (not typed) Average of 5 to sort " + str(amt) + " elements: " + str(get_avg_int_arr(times)) + " ms\n"
				get_node("VBoxContainer/HBoxContainer/TextEdit").set_text(text)
		else:
			rnd_arr = []
			for j in range(0, amt):
				rnd_arr.append(randi() % 1000)
			
			if type:
				var start = OS.get_ticks_msec()
				var end = OS.get_ticks_msec()
				text += "Bubble sort took: " + str(end - start) + " ms to sort " + str(amt) + " elements.\n"
				get_node("VBoxContainer/HBoxContainer/TextEdit").set_text(text)
			else:
				var start = OS.get_ticks_msec()
				bubblesort_not_typed(rnd_arr)
				var end = OS.get_ticks_msec()
				text += "Bubble sort (not typed) took: " + str(end - start) + " ms to sort " + str(amt) + " elements.\n"
				get_node("VBoxContainer/HBoxContainer/TextEdit").set_text(text)
			
	if num == 1:
		var times = []
		if avg_type:
			for i in range(0, 5):
				rnd_arr = []
				for j in range(0, amt):
					rnd_arr.append(randi() % 1000)
				#check if statically type test
				if type:
					var start = OS.get_ticks_msec()
					var end = OS.get_ticks_msec()
					times.append(end - start)
				else:
					var start = OS.get_ticks_msec()
					quicksort_not_typed(rnd_arr)
					var end = OS.get_ticks_msec()
					times.append(end - start)
			if type:
				text += "Quick sort Average of 5 to sort " + str(amt) + " elements: " + str(get_avg_int_arr(times)) + " ms\n"
				get_node("VBoxContainer/HBoxContainer/TextEdit").set_text(text)
			else:
				text += "Quick sort (not typed) Average of 5 to sort " + str(amt) + " elements: " + str(get_avg_int_arr(times)) + " ms\n"
				get_node("VBoxContainer/HBoxContainer/TextEdit").set_text(text)
		else:
			rnd_arr = []
			for j in range(0, amt):
				rnd_arr.append(randi() % 1000)
			
			if type:
				var start = OS.get_ticks_msec()
				var end = OS.get_ticks_msec()
				text += "Quick sort took: " + str(end - start) + " ms to sort " + str(amt) + " elements.\n"
				get_node("VBoxContainer/HBoxContainer/TextEdit").set_text(text)
			else:
				var start = OS.get_ticks_msec()
				quicksort_not_typed(rnd_arr)
				var end = OS.get_ticks_msec()
				text += "Quick sort (not typed) took: " + str(end - start) + " ms to sort " + str(amt) + " elements.\n"
				get_node("VBoxContainer/HBoxContainer/TextEdit").set_text(text)
			

func get_avg_int_arr(array):
	var sum = 0
	for i in array:
		sum += i
	
	return sum / array.size()



func _on_clear_button_pressed():
	get_node("VBoxContainer/HBoxContainer/TextEdit").set_text("")
	text = ""

func _on_BubbleSortButton_pressed():
	var take_avg_pressed = get_node("VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer3/TakeAvgCheck").is_pressed
	var static_type_pressed= false
	var amt = get_node("VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpinBox").get_value()
	button_event(0, take_avg_pressed, static_type_pressed, amt)


func _on_QuickSortButton_pressed():
	var take_avg_pressed = get_node("VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer3/TakeAvgCheck").is_pressed
	var static_type_pressed = false
	var amt = get_node("VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpinBox").get_value()
	button_event(1, take_avg_pressed, static_type_pressed, amt)

