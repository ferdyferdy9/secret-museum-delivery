extends TileMap

const packedScenes = {
	"box": preload("res://Objects/Box.tscn"),
	"player": preload("res://Player/Player.tscn"),
	"jewel": preload("res://Objects/Jewel.tscn")
}

func _ready():
	hide()


func generate_objects():
	var generated_objs = {}
	
	for cell_pos in get_used_cells():
		var cell_id = get_cellv(cell_pos)
		var cell_name = tile_set.tile_get_name(cell_id)
		var spawn_position = cell_pos * cell_size + cell_size * 0.5
		
		if packedScenes.has(cell_name):
			var obj = packedScenes[cell_name].instance()
			obj.global_position = spawn_position
			
			if not generated_objs.has(cell_name):
				generated_objs[cell_name] = []
			generated_objs[cell_name].append(obj)
	
	return generated_objs
