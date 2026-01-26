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

enum Rarity
{
	COMMON = 90,
	UNCOMMON = 30,
	RARE = 15,
	EPIC = 05
}

var inside_count : int = 0
var current_inside : Interactable

var stats_1 : Stats
var stats_2 : Stats
var stats_3 : Stats
var stats_4 : Stats

func _process(_delta: float) -> void:
	if visible:
		position = get_local_mouse_position()

func check_setup(stat_bundle: Array[Stats]) -> void:
	if inside_count <= 0:
		visible = false
		return
	visible = true
	_setup(stat_bundle)

func _setup(stat_bundle: Array[Stats]) -> void:
	pass

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
