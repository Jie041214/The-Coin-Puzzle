extends KinematicBody2D

var rotation_speed = 2.5
var dragging_left: bool = false # Is dragging using left click?
var dragging_right: bool = false # Is dragging using right click
var mouse_offset: Vector2 # The offset between the coin and mouse
var init_pos: Vector2 # The initial position of the coin
var init_rotation: float # The initial rotation of the coin
var original_z_index: int = 0 # Original z index of the coin
var is_dragging: bool = false

func _ready() -> void:
	original_z_index = z_index 
	# 創建材質的唯一實例，所以不會影響其他硬幣的shader parameter
	var unique_material = $Sprite.material.duplicate()
	$Sprite.material = unique_material

func _process(delta: float) -> void:
#	print(dragging_right)
	# 處理拖拽邏輯
	if dragging_left:
		drag(delta)
#		Globals.dragging_count = 1
	elif dragging_right:
		drag_without_collision()
#		Globals.dragging_count = 1
		z_index = original_z_index + 1  # 提高 Z index
		if Input.is_action_pressed("q"):
			rotation -= rotation_speed * delta
		elif Input.is_action_pressed("e"):
			rotation += rotation_speed * delta

	# 根据拖拽状态设置光标
	if Globals._get_is_dragging_coin():
		Input.set_custom_mouse_cursor(Globals.dragging_cursor, Input.CURSOR_ARROW, Vector2(18, 18))
	elif Input.get_current_cursor_shape() != 1: # 若鼠標不在按鈕上
		# 處理鼠標懸停狀態
		if Globals._get_is_hover_on_coin():
			Input.set_custom_mouse_cursor(Globals.hover_cursor, Input.CURSOR_ARROW, Vector2(18, 18))
		else:
			Input.set_custom_mouse_cursor(Globals.main_cursor, Input.CURSOR_ARROW, Vector2(18, 18))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and dragging_left and not event.is_pressed(): # 左鍵鬆開
			dragging_left = false
			Globals.dragging_count = 0
		if event.button_index == BUTTON_RIGHT and dragging_right and not event.is_pressed(): # 右鍵鬆開
			dragging_right = false
			# 處理碰撞邏輯
			yield(get_tree().create_timer(0.04), "timeout") # 防止硬幣還在移動時便已經完成碰撞判定
			if Globals._get_is_colliding():
				global_position = init_pos  # 碰撞時重置位置
				rotation = init_rotation  # 碰撞時重置旋轉角度
				SoundManager.play_colliding_sound()
			else:
				SoundManager.play_hit_table_sound()
			
			Globals.dragging_count = 0
			z_index = original_z_index  # 還原 Z index
			Globals.is_colliding = Globals._get_is_colliding()
			$Sprite.material.set_shader_param("flash_modifier", 0)

func _on_Draggable_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and !Globals._get_is_dragging_coin():
		if event.button_index == BUTTON_LEFT:
			dragging_left = event.is_pressed()
			Globals.dragging_count += 1
		if event.button_index == BUTTON_RIGHT:
			dragging_right = event.is_pressed()
			Globals.dragging_count += 1
			init_pos = global_position  # 更新初始位置
			init_rotation = rotation
#			if event.is_pressed():
#				SoundManager.play_pick_up()
		mouse_offset = global_position - get_global_mouse_position()

func drag(delta):
	var current_position: Vector2 = global_position 
	var mouse_position: Vector2 = get_global_mouse_position() + mouse_offset

	var distance: float = current_position.distance_to(mouse_position)
	var direction: Vector2 = current_position.direction_to(mouse_position)

	var speed: float = min(distance / delta, 1500)
	var velocity: Vector2 = direction * speed

	# warning-ignore:return_value_discarded
	move_and_slide(velocity)

func drag_without_collision():
	global_position = get_global_mouse_position() + mouse_offset
	if dragging_right:
		if Globals.colliding_count <= 0:
			$Sprite.material.set_shader_param("flash_color", Color(.1, .7, .1))
			$Sprite.material.set_shader_param("flash_modifier", 0.45)
		else:
			$Sprite.material.set_shader_param("flash_color", Color(.8, .1, .1))
			$Sprite.material.set_shader_param("flash_modifier", 0.5)

func _on_Coin_mouse_entered():
	Globals.hover_count += 1

func _on_Coin_mouse_exited():
	Globals.hover_count -= 1

func _on_Area2D_body_entered(body):
	if body.is_in_group("Puzzle"):
		Globals.colliding_count += 1

func _on_Area2D_body_exited(body):
	if body.is_in_group("Puzzle"):
		Globals.colliding_count -= 1

func _on_Area2D_area_entered(area):
	if area.is_in_group("CoinArea"):
		Globals.colliding_count += 1

func _on_Area2D_area_exited(area):
	if area.is_in_group("CoinArea"):
		Globals.colliding_count -= 1

