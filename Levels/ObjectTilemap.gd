extends TileMap

var box_instance = preload("res://Objects/Box.tscn")

func _ready():
	hide()


func generate_objects():
	var generated_objs = []
	
	for cell_pos in get_used_cells():
		var cell_id = get_cellv(cell_pos)
		var cell_name = tile_set.tile_get_name(cell_id)
		var spawn_position = cell_pos * cell_size + cell_size * 0.5
		
		var obj:Node2D
		match cell_name:
			"box":
				obj = box_instance.instance()
		
		if obj != null:
			obj.global_position = spawn_position
			generated_objs.append(obj)
	
	return generated_objs
