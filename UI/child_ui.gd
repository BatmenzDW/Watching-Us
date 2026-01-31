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

var _target_hunger = 1.0
var _target_fun = 1.0
var _target_hapiness = 1.0

func set_target_hunger(val: float) -> void:
	_target_hunger = val

func set_target_fun(val: float) -> void:
	_target_fun = val

func set_target_happiness(val: float) -> void:
	_target_hapiness = val

func _set_bar_size(percent: float, bar: MarginContainer):
	#max_size = hunger.size.x - min_size
	
	var val : float = 1 - percent
	val *= max_size - min_size
	val += min_size
	bar.add_theme_constant_override("margin_right", val as int)

func _process(delta: float) -> void:
	# set hunger bar
	if abs(_current_hunger - _target_hunger) > target_delta and _current_hunger > 0:
		_set_bar_size(_current_hunger, hunger)
	
		var dif = (_current_hunger - _target_hunger)
		_current_hunger += speed * delta * (dif/abs(dif))
	
	# set fun bar
	if abs(_current_fun - _target_fun) > target_delta and _current_fun > 0:
		#print("Fun: ", _current_fun, " : ", _target_fun)
		_set_bar_size(_current_fun, fun)
	
		var dif = (_current_fun - _target_fun)
		_current_fun += speed * delta * (dif/abs(dif))

	# set happiness bar
	if abs(_current_happiness - _target_hapiness) > target_delta and _current_happiness > 0:
		_set_bar_size(_current_happiness, happiness)
	
		var dif = (_current_happiness - _target_hapiness)
		_current_happiness += speed * delta * (dif/abs(dif))
