extends VBoxContainer

class_name NextButton

signal go_next

const ICON_HAPPINESS = preload("uid://dy3humxav1cu0")
const ICON_HUNGER = preload("uid://bc5ejm3n8hd17")
const ICON_FUN = preload("uid://5c386rwed2jm")
const ICON_PARANOIA = preload("uid://buqm8llj1pqrm")

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
		Stats.Stat.HUNGER:
			mult_icon.texture = ICON_HUNGER
		Stats.Stat.FUN:
			mult_icon.texture = ICON_FUN
		Stats.Stat.PARANOIA:
			mult_icon.texture = ICON_PARANOIA
	_type = type
	
	reset()

func reset() -> void:
	next_button.disabled = true
	progress_label.visible = true
	mult_label.text = "1.0x - "

func on_interactable_interact(new_count : int) -> void:
	var times : float = mult * new_count
	mult_label.text = "%.1fx - " % times
	
	if new_count >= 1:
		next_button.disabled = false
		progress_label.visible = false

func _on_texture_button_pressed() -> void:
	if InputState.allow_input(InputState.State.LEVEL):
		go_next.emit()

func _ready() -> void:
	SignalBus.apply_stats.connect(_on_apply_stats)

func _on_apply_stats(stats: Stats, is_mult : bool = false) -> void:
	# if recursive call
	if is_mult:
		return
	
	var times = mult - 1.0
	var new_stats : Stats = Stats.new()
	match _type:
		Stats.Stat.HAPPINESS:
			new_stats.happiness = stats.happiness * times
		Stats.Stat.HUNGER:
			new_stats.hunger = stats.hunger * times
		Stats.Stat.FUN:
			new_stats.fun = stats.fun * times
		Stats.Stat.PARANOIA:
			new_stats.paranoia = stats.paranoia * times

	SignalBus.apply_stats.emit(new_stats, true)
