extends KinematicBody2D

signal player_busted

export var wander_max_distance = 50
export var max_speed = 400

onready var anim_player = $AnimationPlayer

var wonder_target:Vector2
var velocity:Vector2

func _ready():
	randomize()
	wonder_target = global_position


func _process(delta):
	if abs(velocity.angle_to(Vector2.RIGHT)) < PI*0.25:
		anim_player.play("idle_right")
	if abs(velocity.angle_to(Vector2.LEFT)) < PI*0.25:
		anim_player.play("idle_left")
	if abs(velocity.angle_to(Vector2.UP)) < PI*0.25:
		anim_player.play("idle_up")
	if abs(velocity.angle_to(Vector2.DOWN)) < PI*0.25:
		anim_player.play("idle_down")
	
	print(velocity.angle_to(Vector2.RIGHT))
	
	if velocity.length_squared() != 0:
		$FOV.rotation = velocity.angle()


func _physics_process(delta):
	go_to_desired_pos()
	velocity = move_and_slide(velocity, Vector2.ZERO, false, 4, 0, false)


func go_to_desired_pos():
	velocity = wonder_target - global_position
	if velocity.length_squared() > max_speed * max_speed:
		velocity = wonder_target.normalized() * max_speed


func _on_WanderTimer_timeout():
	var offset:Vector2
	
	offset.x = rand_range(-1, 1) * wander_max_distance
	offset.y = rand_range(-1, 1) * wander_max_distance
	
	wonder_target = global_position + offset


func _on_Area2D_body_entered(body):
	emit_signal("player_busted")
