extends TileMap

func get_boundary() -> Rect2:
	var used_rect := get_used_rect()
	used_rect.size *= cell_size
	return used_rect
