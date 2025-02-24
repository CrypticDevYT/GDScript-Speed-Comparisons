extends Control

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func fib_recusrive_not_typed():
	pass

func fib_recusrive_typed():
	pass

func fib_iterative_not_typed(n):
	var seq_rtn = [0, 1]
	for i in range(n - 2):
		seq_rtn.append(seq_rtn[-1] + seq_rtn[-2])
	return seq_rtn

func fib_iterative_typed(n: int):
	var seq_rtn: PackedInt64Array = [0, 1]
	for i in range(n - 2):
		seq_rtn.append(seq_rtn[-1] + seq_rtn[-2])
	$VBoxContainer/HBoxContainer/VBoxContainer2/TextEdit.text += str(seq_rtn)


func _on_fibonacci_button_pressed() -> void:
	if not $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpinBox.value > 0:
		return
	if $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/StaticTypeCheck.pressed:
		fib_iterative_typed($VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpinBox.value)
