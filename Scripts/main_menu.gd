extends Node2D

#Play button pressed
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	pass # Replace with function body.

#options button pressed
func _on_options_button_pressed() -> void:
	pass # Replace with function body.

#credits button pressed
func _on_credits_button_pressed() -> void:
	pass # Replace with function body.

#quit button pressed
func _on_quit_button_pressed() -> void:
	get_tree().quit()
