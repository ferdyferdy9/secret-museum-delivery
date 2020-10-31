extends Area2D

signal collected

func _on_Jewel_area_entered(area):

	set_deferred("monitoring", false)
	emit_signal("collected", self)
