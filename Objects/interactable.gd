extends Area2D

class_name Interactable

@export var hunger_value : float
@export var fun_value : float
@export var happiness_value : float
@export var paranoia_value : float

var _has_used : bool = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click") and not _has_used:
		_has_used = true
		_apply_values()

func _apply_values() -> void:
	SignalBus.apply_stats.emit(hunger_value, fun_value, happiness_value, paranoia_value)
