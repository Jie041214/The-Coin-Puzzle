extends Control

onready var start_button = $VBoxContainer/StartButton
onready var option_button = $VBoxContainer/OptionButton
onready var exit_button = $VBoxContainer/ExitButton

func _ready():
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("pressed", SoundManager, "play_click_button_sound")

func _on_StartButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/ui/level_menu/LevelMenu.tscn")

func _on_OptionButton_pressed():
	$SettingMenu.visible = true

func _on_ExitButton_pressed():
	get_tree().quit()
