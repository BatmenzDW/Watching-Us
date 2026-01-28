extends Resource

class_name Location_Index

@export var location_lookup : Dictionary[String, Location_Data] = {}

func get_(key : String) -> Location_Data:
	return location_lookup[key]

func contains(key : String) -> bool:
	return location_lookup.has(key)

func keys() -> Array[String]:
	return location_lookup.keys()
