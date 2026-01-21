extends Node2D

class_name MapNode

@export var neighbors : Array[MapNode] = []

var map_position : Vector2

func set_node_position(pos: Vector2) -> void:
	position = pos
	map_position = pos
