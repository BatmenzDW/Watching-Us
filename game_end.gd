extends Node2D

func end_win():
	%EndWin.visible = true
	await get_tree().create_timer(2.0).timeout
	%EndWin2.visible = true
	%EndWin.visible = false
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
