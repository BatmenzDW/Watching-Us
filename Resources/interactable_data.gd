extends Resource

class_name Interactable_Data

const INTERACTABLE = preload("uid://w5wknmm2d2dw")

@export var is_background : bool = false
@export var children_interactables : Array[Interactable_Data] = []

@export var odds : float = 0.0
@export var shape : RectangleShape2D
@export var position : Vector2
@export var stat_bundle : Array[Stats]

@export var texture : CompressedTexture2D
@export var texture_position : Vector2
@export var texture_scale : Vector2

@export var hover_audio_key : String
@export var success_audio_key : String
@export var fail_audio_key : String
