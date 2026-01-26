extends Resource

class_name Interactable_Data

const INTERACTABLE = preload("uid://w5wknmm2d2dw")

@export var is_background : bool = false

@export var odds : float = 0.0
@export var shape : RectangleShape2D
@export var position : Vector2
@export var stats : Stats
@export var texture : CompressedTexture2D
@export var texture_position : Vector2
@export var texture_scale : Vector2

@export var nonhighlight_color : Color
@export var highlight_color : Color
