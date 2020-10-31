extends KinematicBody2D

signal player_busted

export var wander_max_distance = 10
export var max_speed = 400

onready var anim_player = $AnimationPlayer

var wonder_target:Vector2
var velocity:Vector2

func _process(delta):
	if velocity.x > 0:
		anim_player.play("idle_right")
	if velocity.x < 0:
		anim_player.play("idle_left")
	if velocity.y > 0:
		anim_player.play("idle_down")
	if velocity.y < 0:
		anim_player.play("idle_up")


func _physics_process(delta):
	go_to_desired_pos()
	velocity = move_and_slide(velocity)


func go_to_desired_pos():
	velocity = global_position - wonder_target
	if velocity.length_squared() > max_speed * max_speed:
		velocity = wonder_target.normalized() * max_speed


func _on_WanderTimer_timeout():
	var offset:Vector2
	
	offset.x = randf() * wander_max_distance
	offset.y = randf() * wander_max_distance
	
	wonder_target = global_position + offset


func _on_Area2D_area_entered(area):
	emit_signal("player_busted")
