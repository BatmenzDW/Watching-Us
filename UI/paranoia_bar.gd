extends CanvasLayer

@onready var margin: MarginContainer = $MarginContainer

@export var max_size = 500
@export var min_size = 10

var current_val = 0
var target_val = 1
@export var speed = -0.2

var target_delta = 0.05

func set_target_val(val: float):
	target_val = val

func _set_size(percent: float):
	var val = 1 - percent
	val *= max_size - min_size
	val += min_size
	margin.add_theme_constant_override("margin_left", val)
	margin.add_theme_constant_override("margin_right", val)

func _process(delta: float) -> void:
	if abs(current_val - target_val) > target_delta:
		_set_size(current_val)
	
	current_val += speed * delta * (current_val - target_val)
