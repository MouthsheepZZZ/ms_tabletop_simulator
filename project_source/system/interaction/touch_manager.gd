extends Node3D

var multi_touch_test_results : Dictionary


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var test_result := get_touch_intersection(event.position)
		if not test_result.is_empty():
			multi_touch_test_results[event.index] = test_result
	
	if event is InputEventScreenTouch:
		_touch_press_detection(event)
	
	if event is InputEventScreenDrag:
		_touch_drag_detection(event)


func _touch_press_detection(event : InputEvent) -> void:
	var test_result : Dictionary = multi_touch_test_results[event.index]
	if test_result.is_empty():
		return
	
	var collider := test_result.collider as TouchableObject3D
	if collider == null:
		return
	if event.is_pressed():
		collider.try_to_touch_pressed()
	else:
		collider.try_to_touch_released()
		multi_touch_test_results[event.index] = {}


func _touch_drag_detection(event : InputEvent) -> void:
	var test_result : Dictionary = multi_touch_test_results[event.index]
	if test_result.is_empty():
		return
	
	var collider := test_result.collider as TouchableObject3D
	if collider == null:
		return
	print(collider)
	collider.try_to_touch_drag(event)


func get_touch_intersection(touch_pos) -> Dictionary:
	var current_cam = get_viewport().get_camera_3d()
	var params = PhysicsRayQueryParameters3D.new()
	params.from = current_cam.project_ray_origin(touch_pos)
	params.to = current_cam.project_position(touch_pos, 1000)
	
	var worldspace = get_world_3d().direct_space_state
	return worldspace.intersect_ray(params)
