extends Area2D

signal collected


func _on_Jewel_body_entered(body):
	set_deferred("monitoring", false)
	emit_signal("collected", self)
