extends Control

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func pi_approx_typed(decimal_terms: int) -> float:
	var pi_approx: float = 0.0
	var i: int = 0
	var error:float = pow(10, -decimal_terms)
	var truncated_pi: float = 0.0
	while true:
		var term: float = 1.0 / (2 * i + 1)
		if i % 2 == 0:
			pi_approx += term
		else:
			pi_approx -= term
			
		var current_pi:float = pi_approx * 4
		truncated_pi = snapped(current_pi, error)  # Ensure truncation, not rounding
		
		if truncated_pi == snapped(PI, error):  
			break  # Stop as soon as we reach the exact decimal places without overshooting
		
		i += 1  # Move to the next term
	return truncated_pi

func pi_approx_not_typed(decimal_terms):
	var pi_approx = 0.0
	var i = 0
	var error = pow(10, -decimal_terms)
	var truncated_pi = 0.0
	while true:
		var term = 1.0 / (2 * i + 1)
		if i % 2 == 0:
			pi_approx += term
		else:
			pi_approx -= term
			
		var current_pi = pi_approx * 4
		truncated_pi = snapped(current_pi, error)  # Ensure truncation, not rounding
		
		if truncated_pi == snapped(PI, error):  
			break  # Stop as soon as we reach the exact decimal places without overshooting
		
		i += 1  # Move to the next term
	return truncated_pi

func _on_Pi_approx_button_pressed() -> void:
	var terms: int = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpinBox.value
	if not terms > 0:
		return
	if $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/StaticTypeCheck.button_pressed:
		var approx: float = pi_approx_typed(terms)
		var fmt = snapped(approx, pow(10, -terms))
		$VBoxContainer/HBoxContainer/VBoxContainer2/TextEdit2.text += str(fmt) + "\n"
