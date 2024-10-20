extends Node2D
class_name LevelParent

onready var detected_area = $DetectedArea
onready var pennies = $Pennies

signal game_finished

var main_cursor = preload("res://assets/graphics/cursors/pointer_b_shaded.png")
# puzzle裏的coin數量
var detected_coin_count: int = 0

func _ready():
	Input.set_custom_mouse_cursor(main_cursor, Input.CURSOR_ARROW, Vector2(18, 18))
	
func _process(_delta):
	get_is_game_finished()

# 檢測游戲是否結束
func get_is_game_finished():
	# 更新detected_coin_count
	for body in detected_area.get_overlapping_bodies():
		if body.is_in_group("Coin"):
			detected_coin_count += 1
	
	# 游戲勝利
	if detected_coin_count == pennies.get_child_count() and Globals._get_can_finish():
		Input.set_custom_mouse_cursor(main_cursor, Input.CURSOR_ARROW, Vector2(18, 18))
		# 通知Level.gd游戲結束
		emit_signal("game_finished")
	detected_coin_count = 0

