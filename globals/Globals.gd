# Globals.gd
extends Node

var main_cursor = preload("res://assets/graphics/cursors/pointer_b_shaded.png")
var hover_cursor = preload("res://assets/graphics/cursors/hand_small_open.png")
var dragging_cursor = preload("res://assets/graphics/cursors/hand_small_closed.png")
var button_hover_cursor = preload("res://assets/graphics/cursors/hand_small_point.png")

var hover_count: int = 0 # 全局懸浮計數器
var dragging_count: int = 0 # 全局拖拽計數器
var colliding_count: int = 0 # 金幣是否發生了碰撞
var is_colliding: bool = false # 僅用於判斷是否可以結束遊戲

var resolution_index = 3
var is_fullscreen = true
var volume = 30

func _ready():
	Input.set_custom_mouse_cursor(main_cursor, Input.CURSOR_ARROW, Vector2(18, 18))
	Input.set_custom_mouse_cursor(button_hover_cursor, Input.CURSOR_IBEAM, Vector2(18, 18))
	Input.set_custom_mouse_cursor(hover_cursor, Input.CURSOR_POINTING_HAND, Vector2(18, 18))
	
# 鼠標是否懸浮在金幣上
func _get_is_hover_on_coin():
	return hover_count > 0

# 是否在拖拽金幣
func _get_is_dragging_coin():
	return dragging_count > 0
	
# 金幣是否發生碰撞
func _get_is_colliding():
	return colliding_count > 0

# 遊戲能否結束
func _get_can_finish():
	return !_get_is_dragging_coin() and !is_colliding

