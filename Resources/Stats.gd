extends Resource
class_name Stats 

@export var hunger : float
@export var fun : float
@export var happiness : float
@export var paranoia : float

enum Stat
{
	HAPPINESS,
	HUNGER,
	FUN,
	PARANOIA
}

func _init(hunger_ : float = 0.0, fun_ : float = 0.0, happiness_ : float = 0.0, paranoia_ : float = 0.0) -> void:
	hunger = hunger_
	fun = fun_
	happiness = happiness_
	paranoia = paranoia_
