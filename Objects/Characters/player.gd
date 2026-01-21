extends CharacterBody2D

@export var speed = 400

var target : Vector2 = position

var _delta_target = 10

func _physics_process(delta):
	velocity = position.direction_to(target) * speed * delta
	if position.distance_to(target) > _delta_target:
		move_and_slide()

func set_target(pos: Vector2):
	target = pos
