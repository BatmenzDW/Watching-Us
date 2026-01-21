extends FoldableContainer
class_name ChildUI

@onready var hunger: MarginContainer = $VBoxContainer/HBoxContainer/Hunger
@onready var fun: MarginContainer = $VBoxContainer/HBoxContainer2/Fun
@onready var happiness: MarginContainer = $VBoxContainer/HBoxContainer3/Happiness

@export var max_size = 95
@export var min_size = 5

@export var speed = -0.2

var target_delta = 0.05

var _current_hunger = 1.0
var _current_fun = 1.0
var _current_happiness = 1.0

var _target_hunger = 0.0
var _target_fun = 0.0
var _target_hapiness = 0.0

func set_target_hunger(val: float) -> void:
	_target_hunger = val

func set_target_fun(val: float) -> void:
	_target_fun = val

func set_target_happiness(val: float) -> void:
	_target_hapiness = val

func _set_bar_size(percent: float, bar: MarginContainer):
	var val = 1 - percent
	val *= max_size - min_size
	val += min_size
	bar.add_theme_constant_override("margin_right", val)

func _process(delta: float) -> void:
	# set hunger bar
	if abs(_current_hunger - _target_hunger) > target_delta and _current_hunger > 0:
		_set_bar_size(_current_hunger, hunger)
	
	_current_hunger += speed * delta * (_current_hunger - _target_hunger)
	
	# set fun bar
	if abs(_current_fun - _target_fun) > target_delta and _current_fun > 0:
		_set_bar_size(_current_fun, fun)
	
	_current_fun += speed * delta * (_current_fun - _target_fun)

	# set happiness bar
	if abs(_current_happiness - _target_hapiness) > target_delta and _current_happiness > 0:
		_set_bar_size(_current_happiness, happiness)
	
	_current_happiness += speed * delta * (_current_happiness - _target_hapiness)
