extends CharacterBody2D

class_name Player

@onready var child_ui: ChildUI = $ChildUI

@export var speed = 400

var target : Vector2 = position

var _delta_target = 10

@export var hunger = 1.0
@export var fun = 1.0
@export var happiness = 1.0
@export var paranoia = 0.0

@export var hunger_decay = 0.1
@export var fun_decay = 0.1
@export var happiness_decay = 0.1
@export var paranoia_gain = 0.1

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
	hunger -= hunger_decay * delta
	fun -= fun_decay * delta
	var content = (1.0 - hunger) * (1.0 - fun)
	happiness -= content * happiness_decay * delta


func _apply_stats(_hunger: float, _fun: float, _happiness: float, _paranoia: float) -> void:
	print("Apply Stats")
	hunger += _hunger
	fun += _fun
	happiness += _happiness
	# paranoia is handled in paranoia bar
	
	_update_stats()
