extends Node2D

class_name Location

@export var interactables : Array[Interactable_Data]

@onready var background: Sprite2D = $Background

func _ready() -> void:
	for data in interactables:
		load_data(data)

func load_data(data : Interactable_Data):
	var interactable : Interactable
	var sprite : Sprite2D
	
	if not data.is_background and data.odds < 1.0:
		if randf() > data.odds: # random chance to spawn
			return
	
	if !background and data.is_background:
		background = Sprite2D.new()
		background.name = "Background"
		add_child(background)
	
	interactable = data.INTERACTABLE.instantiate()
	add_child(interactable)
	interactable.set_collision_shape(data.shape)
	interactable.position = data.position
	interactable.stats = data.stats
	
	interactable.highlight_color = data.highlight_color
	interactable.nonhighlight_color = data.nonhighlight_color
	interactable.highlight.color = data.nonhighlight_color
	
	if not data.is_background:
		sprite = Sprite2D.new()
		interactable.add_child(sprite)
	
	if data.is_background:
		background.texture = data.texture
		background.position = data.texture_position
		background.scale = data.texture_scale
	else:
		sprite.texture = data.texture
		sprite.position = data.texture_position
		sprite.scale = data.texture_scale
