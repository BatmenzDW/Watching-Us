extends Node2D

class_name Location

@onready var background: Sprite2D = $Background
@onready var preview: Interactable_Preview = %Preview

func load_data(data : Interactable_Data, is_child : bool = false):
	var interactable : Interactable
	var sprite : Sprite2D
	
	if not data.is_background and data.odds < 1.0:
		if randf() <= data.odds: # random chance to spawn
			return
	
	if !background and data.is_background and not is_child:
		background = Sprite2D.new()
		background.name = "Background"
		add_child(background)
	
	interactable = data.INTERACTABLE.instantiate()
	add_child(interactable)
	interactable.set_collision_shape(data.shape)
	interactable.position = data.position
	
	interactable.stat_bundle = data.stat_bundle
	interactable.result_texts = data.result_texts
	
	interactable.hover_audio_key = data.hover_audio_key
	interactable.use_audio_key = data.use_audio_key
	
	interactable.preview = preview
	
	interactable.highlight.color = interactable.nonhighlight_color
	
	for child in data.children_interactables:
		load_data(child, true)
	
	if is_child:
		return
	
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

func unload() -> void:
	print("Unload")
	var nodes_to_remove = get_tree().get_nodes_in_group("location_elements")
	print("Unloading ", nodes_to_remove.size(), " nodes")
	for node in nodes_to_remove:
		node.queue_free()
