extends Control

var highest_level: int

func _ready():
	_load()
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("pressed", SoundManager, "play_click_button_sound")
	for level_btn in get_tree().get_nodes_in_group("LevelButton"): # 將已解鎖關卡的locked = false
		if level_btn.get_index() + 1 <= highest_level:
			level_btn.locked = false
			level_btn.connect("level_selected", self, "_on_level_changed")
	

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
	# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/ui/MainMenu.tscn")

func _on_level_changed(level_num):
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/levels/Level" + level_num + ".tscn")


func _on_BackButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/ui/MainMenu.tscn")

# 從存檔中讀取highest_level，若存檔不存在，則highest_level為1
func _load():
	var config = ConfigFile.new()
	var result = config.load("user://settings.cfg")
	
	if result == OK:
		highest_level = config.get_value("Level", "highestLevel")
	else:
		highest_level = 1

