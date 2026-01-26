extends Area2D

class_name Interactable

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var highlight: ColorRect = $Highlight
@export var stats : Stats

@export var nonhighlight_color : Color
@export var highlight_color : Color

var temp_shape : Shape2D

var _has_used : bool = false

func _ready() -> void:
	if temp_shape:
		collision.shape = temp_shape
		highlight.size = (temp_shape as RectangleShape2D).size
		highlight.position.x -= highlight.size.x / 2.0
		highlight.position.y -= highlight.size.y / 2.0
	
	highlight.color = nonhighlight_color

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click") and not _has_used:
		_has_used = true
		_apply_values()

func _apply_values() -> void:
	SignalBus.apply_stats.emit(stats)

func set_collision_shape(shape : Shape2D) -> void:
	if collision:
		collision.shape = shape
		highlight.size = (shape as RectangleShape2D).size
		
		highlight.position.x -= highlight.size.x / 2.0
		highlight.position.y -= highlight.size.y / 2.0
	else:
		temp_shape = shape

func _on_mouse_entered() -> void:
	highlight.color = highlight_color
	print("enter")

func _on_mouse_exited() -> void:
	highlight.color = nonhighlight_color
	print("exit")
