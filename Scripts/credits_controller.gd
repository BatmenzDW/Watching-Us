extends Node2D

func roll_credits():
	%BackgroundCredits.visible = true
	%PauperTim.visible = true
	await get_tree().create_timer(4.0).timeout
	%PauperTim.visible = false
	%BatmenzDW.visible = true
	await get_tree().create_timer(4.0).timeout
	%BatmenzDW.visible = false
	%Datlett.visible = true
	await get_tree().create_timer(4.0).timeout
	%Datlett.visible = false
	%Freckles_Art.visible = true
	await get_tree().create_timer(4.0).timeout
	%Freckles_Art.visible = false
	%PrinceofWinners.visible = true
	await get_tree().create_timer(4.0).timeout
	%PrinceofWinners.visible = false
	%ThirdParty1.visible = true
	await get_tree().create_timer(2.0).timeout
	%ThirdParty1.visible = false
	%ThirdParty2.visible = true
	await get_tree().create_timer(2.0).timeout
	%ThirdParty2.visible = false
	%ThirdParty3.visible = true
	await get_tree().create_timer(2.0).timeout
	%ThirdParty3.visible = false
	%ThirdParty4.visible = true
	await get_tree().create_timer(2.0).timeout
	%ThirdParty4.visible = false
	%ThirdParty5.visible = true
	await get_tree().create_timer(2.0).timeout
	%ThirdParty5.visible = false
	%ThirdParty6.visible = true
	await get_tree().create_timer(2.0).timeout
	%ThirdParty6.visible = false
	%BackgroundCredits.visible = false
	
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
