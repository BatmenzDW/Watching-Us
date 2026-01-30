extends CanvasLayer

@onready var margin: MarginContainer = $MarginContainer

@export var max_size = 500
@export var min_size = 10

var current_val = 0
var target_val = 0
@export var speed = -0.70

var target_delta = 0.05

func _ready() -> void:
	SignalBus.apply_stats.connect(_on_apply_stats)
	SignalBus.set_paranoia.connect(set_target_val)

func set_target_val(val: float):
	target_val = clampf(val, 0, 1)

func _set_size(percent: float):
	%ParanoiaMeter.value_set(percent*100)

func _process(delta: float) -> void:
	if abs(current_val - target_val) > target_delta:
		_set_size(current_val)
	
		current_val += speed * delta * (current_val - target_val)

func _on_apply_stats(stats: Stats, _is_mult : bool = false) -> void:
	set_target_val(target_val + stats.paranoia)
