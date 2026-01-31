extends Node2D

func end():
	SignalBus.set_music.emit("IceCreamTruck")
	match GameController.result:
		"Tantrum":
			end_tantrum()
		"Breakdown":
			end_breakdown()
		"Win":
			end_win()

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
