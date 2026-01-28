extends MarginContainer

class_name Interactable_Preview

@onready var paranoia_1: TextureRect = $VBoxContainer/Common/HBoxContainer/MarginContainer/Paranoia
@onready var hunger_1: TextureRect = $VBoxContainer/Common/HBoxContainer/MarginContainer2/Hunger
@onready var fun_1: TextureRect = $VBoxContainer/Common/HBoxContainer/MarginContainer3/Fun
@onready var happiness_1: TextureRect = $VBoxContainer/Common/HBoxContainer/MarginContainer4/Happiness
@onready var label_1: Label = $VBoxContainer/Common/MarginContainer/Label

@onready var paranoia_2: TextureRect = $VBoxContainer/Uncommon/HBoxContainer/MarginContainer/Paranoia
@onready var hunger_2: TextureRect = $VBoxContainer/Uncommon/HBoxContainer/MarginContainer2/Hunger
@onready var fun_2: TextureRect = $VBoxContainer/Uncommon/HBoxContainer/MarginContainer3/Fun
@onready var happiness_2: TextureRect = $VBoxContainer/Uncommon/HBoxContainer/MarginContainer4/Happiness
@onready var label_2: Label = $VBoxContainer/Uncommon/MarginContainer/Label

@onready var paranoia_3: TextureRect = $VBoxContainer/Rare/HBoxContainer/MarginContainer/Paranoia
@onready var hunger_3: TextureRect = $VBoxContainer/Rare/HBoxContainer/MarginContainer2/Hunger
@onready var fun_3: TextureRect = $VBoxContainer/Rare/HBoxContainer/MarginContainer3/Fun
@onready var happiness_3: TextureRect = $VBoxContainer/Rare/HBoxContainer/MarginContainer4/Happiness
@onready var label_3: Label = $VBoxContainer/Rare/MarginContainer/Label

@onready var paranoia_4: TextureRect = $VBoxContainer/Epic/HBoxContainer/MarginContainer/Paranoia
@onready var hunger_4: TextureRect = $VBoxContainer/Epic/HBoxContainer/MarginContainer2/Hunger
@onready var fun_4: TextureRect = $VBoxContainer/Epic/HBoxContainer/MarginContainer3/Fun
@onready var happiness_4: TextureRect = $VBoxContainer/Epic/HBoxContainer/MarginContainer4/Happiness
@onready var label_4: Label = $VBoxContainer/Epic/MarginContainer/Label

const COMMON_COLOR : Color = Color(0xb0b0b0ff)
const UNCOMMON_COLOR : Color = Color(0x0be600ff)
const RARE_COLOR : Color = Color(0x00b4e0ff)
const EPIC_COLOR : Color = Color(0xbb00e0ff)

const POS_COLOR : Color = Color.CHARTREUSE
const NEUT_COLOR : Color = Color.DARK_GRAY
const WEAK_NEG_COLOR : Color = Color.YELLOW
const MID_NEG_COLOR : Color = Color.ORANGE
const STRONG_NEG_COLOR : Color = Color.RED

enum Rarity
{
	COMMON = 90,
	UNCOMMON = 30,
	RARE = 15,
	EPIC = 05
}

var inside_count : int = 0
var current_inside : Interactable

func _process(_delta: float) -> void:
	if visible:
		global_position = get_global_mouse_position()

func check_setup(stat_bundle: Array[Stats] = []) -> void:
	if inside_count <= 0:
		visible = false
		return
	visible = true
	if len(stat_bundle) == 4:
		_setup(stat_bundle)

func _get_color(val:float, inv:bool=false) -> Color:
	if inv:
		val = -val
	
	if val > 0:
		return POS_COLOR
	
	if val == 0:
		return NEUT_COLOR
	
	if val >= -0.1:
		return WEAK_NEG_COLOR
	
	if val >= -0.2:
		return MID_NEG_COLOR
	
	return STRONG_NEG_COLOR

func _setup(stat_bundle: Array[Stats]) -> void:
	var stats : Stats = stat_bundle[0]
	paranoia_1.modulate = _get_color(stats.paranoia, true)
	hunger_1.modulate = _get_color(stats.hunger)
	fun_1.modulate = _get_color(stats.fun)
	happiness_1.modulate = _get_color(stats.happiness)
	
	stats = stat_bundle[1]
	paranoia_2.modulate = _get_color(stats.paranoia, true)
	hunger_2.modulate = _get_color(stats.hunger)
	fun_2.modulate = _get_color(stats.fun)
	happiness_2.modulate = _get_color(stats.happiness)
	
	stats = stat_bundle[2]
	paranoia_3.modulate = _get_color(stats.paranoia, true)
	hunger_3.modulate = _get_color(stats.hunger)
	fun_3.modulate = _get_color(stats.fun)
	happiness_3.modulate = _get_color(stats.happiness)
	
	stats = stat_bundle[3]
	paranoia_4.modulate = _get_color(stats.paranoia, true)
	hunger_4.modulate = _get_color(stats.hunger)
	fun_4.modulate = _get_color(stats.fun)
	happiness_4.modulate = _get_color(stats.happiness)

func _ready() -> void:
	_init_setup()

func _init_setup() -> void:
	label_1.text = "%d%%" % Rarity.COMMON
	label_2.text = "%d%%" % Rarity.UNCOMMON
	label_3.text = "%d%%" % Rarity.RARE
	label_4.text = "%d%%" % Rarity.EPIC
	
	label_1.add_theme_color_override("font_color", COMMON_COLOR)
	label_2.add_theme_color_override("font_color", UNCOMMON_COLOR)
	label_3.add_theme_color_override("font_color", RARE_COLOR)
	label_4.add_theme_color_override("font_color", EPIC_COLOR)
