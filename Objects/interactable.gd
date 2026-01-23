extends Area2D

class_name Interactable

@export var stats : Stats

var _has_used : bool = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click") and not _has_used:
		_has_used = true
		_apply_values()

func _apply_values() -> void:
	SignalBus.apply_stats.emit(stats)
