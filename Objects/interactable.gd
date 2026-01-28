extends Area2D

class_name Interactable

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var highlight: ColorRect = $Highlight

@export var preview: Interactable_Preview

var stat_bundle : Array[Stats]
var result_index : int = -1

var hover_audio_key : String
var success_audio_key : String
var fail_audio_key : String

const nonhighlight_color : Color = Color(0x26ff0019)
const highlight_color : Color = Color(0x26ff0032)

const SPENT_COLOR : Color = Color(0x00000019)

var temp_shape : Shape2D

var _has_used : bool = false

func _ready() -> void:
	if temp_shape:
		collision.shape = temp_shape
		highlight.size = (temp_shape as RectangleShape2D).size
		highlight.position.x -= highlight.size.x / 2.0
		highlight.position.y -= highlight.size.y / 2.0
	
	highlight.color = nonhighlight_color

enum Rarity
{
	COMMON = 90,
	UNCOMMON = 30,
	RARE = 15,
	EPIC = 05
}

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click") and not _has_used and InputState.allow_input(InputState.State.LEVEL):
		_has_used = true
		highlight.color = SPENT_COLOR
		var rarities = Rarity.values()
		for i in range(4):
			var rare : int = rarities[i]
			if randi_range(0, 100) <= rare:
				_apply_values(stat_bundle[i])
				return
		# fallback value
		_apply_values(stat_bundle[0])

func _apply_values(stats: Stats) -> void:
	SignalBus.interact.emit()
	SignalBus.apply_stats.emit(stats, false)

func set_collision_shape(shape : Shape2D) -> void:
	if collision:
		collision.shape = shape
		highlight.size = (shape as RectangleShape2D).size
		
		highlight.position.x -= highlight.size.x / 2.0
		highlight.position.y -= highlight.size.y / 2.0
	else:
		temp_shape = shape

func _on_mouse_entered() -> void:
	preview.inside_count += 1
	preview.current_inside = self
	preview.check_setup(stat_bundle)
	if not _has_used:
		highlight.color = highlight_color
		# TODO: Play hover audio

func _on_mouse_exited() -> void:
	preview.inside_count -= 1
	preview.check_setup()
	if not _has_used:
		highlight.color = nonhighlight_color
