extends MarginContainer

class_name Interactable_Preview

@onready var vbox: VBoxContainer = $VBoxContainer
@onready var background: ColorRect = $ColorRect

@onready var rows : Array[HBoxContainer] = [$VBoxContainer/Common, $VBoxContainer/Uncommon, $VBoxContainer/Rare, $VBoxContainer/Epic]

@onready var seps : Array[HSeparator] = [$VBoxContainer/HSeparator, $VBoxContainer/HSeparator2, $VBoxContainer/HSeparator3]

@onready var label: Label = $VBoxContainer/Label

@onready var label_1: Label = $VBoxContainer/Common/MarginContainer/Label
@onready var label_2: Label = $VBoxContainer/Uncommon/MarginContainer/Label
@onready var label_3: Label = $VBoxContainer/Rare/MarginContainer/Label
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
		var screen_dim = Vector2(1920, 1080)
		#global_position = get_global_mouse_position()
		var target_pos = get_global_mouse_position()
		
		if target_pos.x + size.x >= screen_dim.x:
			target_pos.x -= size.x
		
		if target_pos.y + size.y >= screen_dim.y:
			target_pos.y -= size.y
		
		global_position = target_pos

func check_setup(stat_bundle: Array[Stats] = [], result_index : int = -1, used_string : String = "") -> void:
	if inside_count <= 0:
		visible = false
		return
	visible = true
	if len(stat_bundle) == 4:
		_setup(stat_bundle, result_index, used_string)

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

func _setup(stat_bundle: Array[Stats], result_index : int = -1, used_string : String = "") -> void:
	var stats : Stats = stat_bundle[0]
	if(stats.paranoia > 0):
		%Paranoia1Arrow.texture = load("res://Assets/Icons/arrow_red_up.png")
	if(stats.paranoia <= 0):
		%Paranoia1Arrow.texture = load("res://Assets/Icons/arrow_green_down.png")
	if(stats.hunger > 0):
		%Hunger1Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.hunger <= 0):
		%Hunger1Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	if(stats.fun > 0):
		%Fun1Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.fun <= 0):
		%Fun1Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	if(stats.fun > 0):
		%Happiness1Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.fun <= 0):
		%Happiness1Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	
	stats = stat_bundle[1]
	if(stats.paranoia > 0):
		%Paranoia2Arrow.texture = load("res://Assets/Icons/arrow_red_up.png")
	if(stats.paranoia <= 0):
		%Paranoia2Arrow.texture = load("res://Assets/Icons/arrow_green_down.png")
	if(stats.hunger > 0):
		%Hunger2Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.hunger <= 0):
		%Hunger2Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	if(stats.fun > 0):
		%Fun2Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.fun <= 0):
		%Fun2Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	if(stats.fun > 0):
		%Happiness2Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.fun <= 0):
		%Happiness2Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	
	stats = stat_bundle[2]
	if(stats.paranoia > 0):
		%Paranoia3Arrow.texture = load("res://Assets/Icons/arrow_red_up.png")
	if(stats.paranoia <= 0):
		%Paranoia3Arrow.texture = load("res://Assets/Icons/arrow_green_down.png")
	if(stats.hunger > 0):
		%Hunger3Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.hunger <= 0):
		%Hunger3Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	if(stats.fun > 0):
		%Fun3Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.fun <= 0):
		%Fun3Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	if(stats.fun > 0):
		%Happiness3Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.fun <= 0):
		%Happiness3Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	
	stats = stat_bundle[3]
	if(stats.paranoia > 0):
		%Paranoia4Arrow.texture = load("res://Assets/Icons/arrow_red_up.png")
	if(stats.paranoia <= 0):
		%Paranoia4Arrow.texture = load("res://Assets/Icons/arrow_green_down.png")
	if(stats.hunger > 0):
		%Hunger4Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.hunger <= 0):
		%Hunger4Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	if(stats.fun > 0):
		%Fun4Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.fun <= 0):
		%Fun4Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	if(stats.fun > 0):
		%Happiness4Arrow.texture = load("res://Assets/Icons/arrow_up.png")
	if(stats.fun <= 0):
		%Happiness4Arrow.texture = load("res://Assets/Icons/arrow_down.png")
	
	if result_index != -1:
		#print(result_index)
		for i in range(4):
			if i == result_index:
				continue
			rows[i].hide()
		
		for sep in seps:
			sep.hide()
		if used_string != "":
			label.text = used_string
			label.show()
	else:
		for row in rows:
			row.show()
		for sep in seps:
			sep.show()
		label.hide()
	size = get_minimum_size()

func _ready() -> void:
	_init_setup()

func _init_setup() -> void:
	label_1.text = "%d%% Chance" % Rarity.COMMON
	label_2.text = "%d%% Chance" % Rarity.UNCOMMON
	label_3.text = "%d%% Chance" % Rarity.RARE
	label_4.text = "%d%% Chance" % Rarity.EPIC
	
	label_1.add_theme_color_override("font_color", COMMON_COLOR)
	label_2.add_theme_color_override("font_color", UNCOMMON_COLOR)
	label_3.add_theme_color_override("font_color", RARE_COLOR)
	label_4.add_theme_color_override("font_color", EPIC_COLOR)
