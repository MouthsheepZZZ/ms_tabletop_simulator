class_name TouchableObject3D
extends Node3D

signal pressed
signal released
signal dragging(event : InputEventScreenDrag)

func try_to_touch_pressed() -> void:
	pressed.emit()


func try_to_touch_released() -> void:
	released.emit()


func try_to_touch_drag(event : InputEventScreenDrag) -> void:
	dragging.emit(event)
