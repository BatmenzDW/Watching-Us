@icon("res://Assets/Icons/icon_character.png")
extends CharacterBody2D

class_name Player

@onready var child_ui: ChildUI = $ChildUI

@export var speed = 400

var target : Vector2 = position

var _delta_target = 10

@export_category("Stats")
@export var hunger = 1.0
@export var fun = 1.0
@export var happiness = 1.0
@export var paranoia = 0.0

@export_category("Stat Decay Rates")
@export var decay : Stats

@export var thresholds : Dictionary[Stats, Stats] = {}

func _ready() -> void:
	SignalBus.apply_stats.connect(_apply_stats)

func _physics_process(delta):
	velocity = position.direction_to(target) * speed * delta
	if position.distance_to(target) > _delta_target:
		#move_and_slide()
		pass
	else:
		velocity = Vector2.ZERO

func _update_stats():
	child_ui.set_target_hunger(hunger)
	child_ui.set_target_fun(fun)
	child_ui.set_target_happiness(happiness)

func set_target(pos: Vector2):
	target = pos

func map_transition(to: bool) -> void:
	child_ui.visible = !to

func _decay_stats(delta: float) -> void:
	hunger -= decay.hunger * delta
	fun -= decay.fun * delta
	var content = (1.0 - hunger) * (1.0 - fun)
	happiness -= content * decay.happiness * delta


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
		GameController.game_end(GameController.GameEndState.TANTRUM)
	elif paranoia >= 1:
		GameController.game_end(GameController.GameEndState.BREAKDOWN)
	
	_update_stats()

func _check_thresholds():
	for thresh in thresholds:
		if hunger <= thresh.hunger or fun <= thresh.fun or happiness <= thresh.happiness or paranoia >= thresh.paranoia:
			_apply_stats(thresholds[thresh])
