extends Node2D

func end_win():
	%EndWin.visible = true
	await get_tree().create_timer(3.0).timeout
	end_win2()

func end_win2():
	await get_tree().create_timer(5.0).timeout
	%GameController.transition_state("mainmenu")
	
func end_tantrum():
	%EndTantrum.visible = true
	await get_tree().create_timer(5.0).timeout
	%GameController.transition_state("mainmenu")

func end_breakdown():
	%EndBreakdown.visible = true
	await get_tree().create_timer(5.0).timeout
	%GameController.transition_state("mainmenu")
