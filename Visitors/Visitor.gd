extends KinematicBody2D

enum { IDLE, WALK }
enum face {UP, DOWN, LEFT, RIGHT}

export var acc_power = 500
export var max_speed = 100

onready var anim_player = $AnimationPlayer

var input_vec:Vector2
var state = IDLE
var facing = face.DOWN setget set_facing

const animations = {
	IDLE: {
		face.UP: "idle_up",
		face.DOWN: "idle_down",
		face.LEFT: "idle_left",
		face.RIGHT: "idle_right",
	},
	WALK: {
		face.UP: "run_up",
		face.DOWN: "run_down",
		face.LEFT: "run_left",
		face.RIGHT: "run_right",
	}
}

func _ready():
	pass


func _process(delta):
	get_input()
	update_face()

func get_input():
	input_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vec.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")


func update_face():
	if input_vec.x > 0:
		self.facing = face.RIGHT
	if input_vec.x < 0:
		self.facing = face.LEFT
	if input_vec.y > 0:
		self.facing = face.DOWN
	if input_vec.y < 0:
		self.facing = face.UP


func set_facing(new_face):
	if facing == new_face:
		return
	
	facing = new_face
	update_animation()


func update_animation():
	anim_player.play(animations[state][facing])
