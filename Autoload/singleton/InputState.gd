extends Node

class_name InputState

enum State
{
	MAP,
	LEVEL,
	WAIT
}

static var Instance : InputState

static var current_state : State = State.MAP

static func allow_input(state : State) -> bool:
	return state == current_state

static func set_state(state: State, delay : float = 0.5) -> void:
	current_state = State.WAIT
	if Instance:
		await Instance.get_tree().create_timer(delay).timeout
	current_state = state

func _ready() -> void:
	Instance = self
