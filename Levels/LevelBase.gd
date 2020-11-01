extends Node

export(PackedScene) var next_level

onready var ysort = $YSort

const cart_scene = preload("res://Player/Cart.tscn")

var cart
var player
var total_to_win:int = 99
var total_collected:int

func _ready():
	generate()
	create_cart()


func generate():
	var objs = $ObjectTilemap.generate_objects()
	
	for tile_name in objs:
		for node in objs[tile_name]:
			if tile_name in ["mineral", "jewel"]:
				node.connect("collected", self, "on_treasure_collected")
			if tile_name == "visitor":
				node.connect("player_busted", self, "on_player_busted")
			
			ysort.add_child(node)
	
	player = objs["player"][0]
	total_to_win = objs["mineral"].size() + objs["jewel"].size()


func create_cart():
	cart = cart_scene.instance()
	cart.global_position = player.global_position
	cart.target = player
	ysort.add_child(cart)


func _on_WinArea_body_entered(body):
	if total_collected >= total_to_win:
		get_tree().change_scene_to(next_level)


func on_treasure_collected(obj):
	cart.add_item(obj)
	total_collected+=1


func on_player_busted():
	get_tree().reload_current_scene()
