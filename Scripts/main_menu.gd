extends Node2D

#Play button pressed
func _on_play_button_pressed() -> void:
	%GameController.transition_state("map","start")
	%MenuBackground.visible = false
	%MainMenuLayer.visible = false

#credits button pressed
func _on_credits_button_pressed() -> void:
	%GameController.transition_state("credits", "")
	%MenuBackground.visible = false
	%MainMenuLayer.visible = false

#quit button pressed
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _mainmenu_active_state():
	%MenuBackground.visible = true
	%MainMenuLayer.visible = true
