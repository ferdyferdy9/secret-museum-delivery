extends Node

onready var ysort = $YSort

const cart_scene = preload("res://Player/Cart.tscn")

var player

func _ready():
	generate()
	create_cart()


func generate():
	var objs = $ObjectTilemap.generate_objects()
	
	for tile_name in objs:
		for node in objs[tile_name]:
			ysort.add_child(node)
	
	player = objs["player"][0]


func create_cart():
	var cart = cart_scene.instance()
	cart.global_position = player.global_position
	cart.target = player
	ysort.add_child(cart)
