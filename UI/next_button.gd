extends VBoxContainer

class_name NextButton

signal go_next

const ICON_HAPPINESS = preload("uid://3lmprdb7cixs")
const COLOR_HAPPINESS = Color.YELLOW
const ICON_HUNGER = preload("uid://o4f0s68ak40w")
const COLOR_HUNGER = Color.SADDLE_BROWN
const ICON_FUN = preload("uid://jggrfqy3p63l")
const COLOR_FUN = Color.CHARTREUSE
const ICON_PARANOIA = preload("uid://ct77veo1p5ae")
const COLOR_PARANOIA = Color.RED

@onready var next_button: TextureButton = $TextureButton
@onready var progress_label: Label = $TextureButton/Label

@onready var mult_label: Label = $HBoxContainer/Label
@onready var mult_icon: TextureRect = $HBoxContainer/TextureRect

var mult : float = 1.0
var _type : Stats.Stat

func setup(mult_val : float, type : Stats.Stat) -> void:
	mult = mult_val
	match type:
		Stats.Stat.HAPPINESS:
			mult_icon.texture = ICON_HAPPINESS
			mult_icon.modulate = COLOR_HAPPINESS
		Stats.Stat.HUNGER:
			mult_icon.texture = ICON_HUNGER
			mult_icon.modulate = COLOR_HUNGER
		Stats.Stat.FUN:
			mult_icon.texture = ICON_FUN
			mult_icon.modulate = COLOR_FUN
		Stats.Stat.PARANOIA:
			mult_icon.texture = ICON_PARANOIA
			#mult_icon.modulate = COLOR_PARANOIA
	_type = type
	
	reset()

func reset() -> void:
	next_button.disabled = true
	progress_label.visible = true
	var times : float = mult * (1 - GameController.interacts_count*1.0/GameController.total_interactables)
	print("reset Times: ", times)
	if _type == Stats.Stat.PARANOIA:
		mult_label.text = "+".repeat(floor(times * 10))
	else:
		mult_label.text = "-".repeat(floor(times * 10))

func on_interactable_interact(new_count : int) -> void:
	var times : float = mult * (1 - new_count*1.0/GameController.total_interactables)
	print("on interact Times: ", times)
	if _type == Stats.Stat.PARANOIA:
		mult_label.text = "+".repeat(floor(times * 10))
	else:
		mult_label.text = "-".repeat(floor(times * 10))
	
	if new_count >= 1:
		next_button.disabled = false
		progress_label.visible = false

func _on_texture_button_pressed() -> void:
	if InputState.allow_input(InputState.State.LEVEL):
		var new_stats : Stats = Stats.new()
		var times : float = mult * (1 - GameController.interacts_count*1.0/GameController.total_interactables)
		print("go next Times: ", times)
		match _type:
			Stats.Stat.HAPPINESS:
				new_stats.happiness = -times
			Stats.Stat.HUNGER:
				new_stats.hunger = -times
			Stats.Stat.FUN:
				new_stats.fun = -times
			Stats.Stat.PARANOIA:
				new_stats.paranoia = times
		SignalBus.apply_stats.emit(new_stats)
		go_next.emit()
