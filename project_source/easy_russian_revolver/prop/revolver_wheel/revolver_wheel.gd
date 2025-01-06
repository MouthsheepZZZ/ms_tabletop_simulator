class_name RevolverWheelComponent
extends Node

@export var revolver_wheel : Node3D
var angular_velocity := 0.0
var is_dragging := false


func _process(delta: float) -> void:
	if not is_dragging:
		angular_velocity = lerp(angular_velocity, 0.0, delta * 5.0)
		if not is_equal_approx(angular_velocity, 0.0):
			revolver_wheel.rotate_z(angular_velocity)


func drag_wheel(event : InputEventScreenDrag) -> void:
	is_dragging = true
	angular_velocity = -event.screen_relative.y
	revolver_wheel.rotate_z(angular_velocity)


func release_wheel() -> void:
	is_dragging = false
