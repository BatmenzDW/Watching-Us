extends CharacterBody2D

@onready var child_ui: ChildUI = $ChildUI

@export var speed = 400

var target : Vector2 = position

var _delta_target = 10

@export var hunger = 1.0
@export var fun = 1.0
@export var happiness = 1.0

func _physics_process(delta):
	velocity = position.direction_to(target) * speed * delta
	if position.distance_to(target) > _delta_target:
		move_and_slide()
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
