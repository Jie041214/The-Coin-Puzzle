extends Node2D

var highest_level: int

export var level_count = 9 #有多少關卡

onready var finish_menu = $UI/FinishMenu
onready var lash_level_finish_menu = $UI/LashLevelFinishMenu

onready var puzzle = get_tree().get_nodes_in_group("Puzzle")[0]

func _ready():
	_load()
	# 如果Puzzle發出game_finished信號，則遊戲結束
	puzzle.connect("game_finished", self, "_on_TestLevel_game_finished")
	if get_next_level() <= level_count:
		finish_menu.next_level = "res://scenes/levels/Level" + str(get_next_level()) + ".tscn"

#func _process(_delta):
#	# For testing
#	if Input.is_action_just_pressed("ui_down"):
#		_on_TestLevel_game_finished()
		
# 遊戲結束
func _on_TestLevel_game_finished():
	SoundManager.play_level_complete_sound()
	
	# 如果不是最後一關或目前小於highest_level， 就更新存檔裏的highestLevel
	if (finish_menu.next_level != "" and get_next_level() > highest_level): 
		var config = ConfigFile.new()
		config.set_value("Level", "highestLevel", get_next_level())
		config.save("user://settings.cfg")
	
	if (finish_menu.next_level != ""):
		finish_menu.visible = true
	else: # 如果是最後一關，則顯示lash_level_finish_menu(沒有next level button)
		lash_level_finish_menu.visible = true
	get_tree().paused = true

# 獲取下一關是第幾關
func get_next_level() -> int:
	return int(get_tree().current_scene.name.substr(5)) + 1
	
# 從存檔中讀取highest_level，若存檔不存在，則highest_level為1
func _load():
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	
	if result == OK:
		highest_level = config.get_value("Level", "highestLevel")
	else:
		highest_level = 1
