@icon("res://Assets/Icons/icon_character.png")
extends CharacterBody2D

class_name Player

@onready var child_ui: ChildUI = $ChildUI

@export var speed = 400

@export_category("Stats")
@export var hunger = 1.0
@export var fun = 1.0
@export var happiness = 1.0
@export var paranoia = 0.0

func _ready() -> void:
	SignalBus.apply_stats.connect(_apply_stats)
	
	SignalBus.apply_stats.emit(Stats.new(hunger, fun, happiness, paranoia), true)

func _update_stats():
	child_ui.set_target_hunger(hunger)
	child_ui.set_target_fun(fun)
	child_ui.set_target_happiness(happiness)

func map_transition(to: bool) -> void:
	child_ui.visible = !to

func _apply_stats(stats : Stats, _is_mult : bool = false) -> void:
	hunger += stats.hunger
	fun += stats.fun
	happiness += stats.happiness
	paranoia += stats.paranoia
	
	# put overfill reaction here
	
	hunger = clampf(hunger, 0.0, 1.0)
	fun = clampf(fun, 0.0, 1.0)
	happiness = clampf(happiness, 0.0, 1.0)
	paranoia = clampf(paranoia, 0.0, 1.0)
	
	if hunger <= 0 or fun <= 0 or happiness <= 0:
		GameController.transition_to_state("tantrum","")
	elif paranoia >= 1:
		GameController.transition_to_state("breakdown","")
	
	_update_stats()
