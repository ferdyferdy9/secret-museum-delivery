extends RigidBody2D

onready var anim_tree = $AnimationTree

var target:RigidBody2D

func _ready():
	anim_tree.active = true


func _process(delta):
	update_face()
	update()


func _draw():
	if target == null:
		return
	
	draw_line(Vector2.ZERO, target.global_position - global_position, Color.black)


func add_item(item:Node2D):
	if item.get_parent():
		item.get_parent().remove_child(item)
	$ItemStackPosition.add_child(item)
	item.global_position = $ItemStackPosition.global_position - $ItemStackPosition.get_child_count() * 8


func _physics_process(delta):
	if target == null:
		return
	
	if target.global_position.distance_squared_to(global_position) > 400:
		var desired_vec:Vector2 = (target.global_position - global_position).normalized() * 20
		var desired_position:Vector2 = target.global_position - desired_vec
		
		var force = lerp(global_position, desired_position, 0.1) - global_position
		apply_central_impulse(force)
		target.apply_central_impulse(-force * mass)


func update_face(): 
	anim_tree.set("parameters/facing/blend_position", linear_velocity.normalized())
