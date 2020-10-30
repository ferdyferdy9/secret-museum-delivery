extends Node

func _ready():
	for n in $ObjectTilemap.generate_objects():
		add_child(n)
