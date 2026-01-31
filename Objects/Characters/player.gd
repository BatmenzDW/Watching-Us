@icon("res://Assets/Icons/icon_character.png")
extends CharacterBody2D

class_name Player

@onready var child_ui: ChildUI = $CanvasLayer/ChildUI

@export var speed = 400

@export_category("Stats")
@export var hunger = 1.0
@export var fun = 1.0
@export var happiness = 1.0
@export var paranoia = 0.0

var hunger_init : float
var fun_int : float
var happiness_init : float
var paranoia_init : float

func _ready() -> void:
	SignalBus.apply_stats.connect(_apply_stats)
	hunger_init = hunger
	fun_int = fun
	happiness_init = happiness
	paranoia_init = paranoia
	setup_stats()

func _update_stats():
	child_ui.set_target_hunger(hunger)
	child_ui.set_target_fun(fun)
	child_ui.set_target_happiness(happiness)

func map_transition(to: bool) -> void:
	child_ui.visible = !to

func setup_stats() -> void:
	print("Setup Stats: ", hunger, " : ", fun, " : ", happiness, " : ", paranoia)
	_update_stats()
	SignalBus.set_paranoia.emit(paranoia)

func reset_stats() -> void:
	hunger = hunger_init
	fun = fun_int
	happiness = happiness_init
	paranoia = paranoia_init
	setup_stats()

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

func set_child_ui_visible(vis : bool) -> void:
	child_ui.visible = vis
