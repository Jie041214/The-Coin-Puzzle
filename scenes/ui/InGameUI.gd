extends CanvasLayer

onready var volume = $Volume

var muted = false
var volume_on_icon = preload("res://assets/ui/Prinbles_Asset_Robin (v 1.1) (9_5_2023)/svg/Icon/SoundOn.svg")
var volume_off_icon = preload("res://assets/ui/Prinbles_Asset_Robin (v 1.1) (9_5_2023)/svg/Icon/SoundOff.svg")

func _ready():
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("pressed", SoundManager, "play_click_button_sound")

func _on_Retry_pressed():
	# warning-ignore:return_value_discarded

	get_tree().reload_current_scene()
func _on_Volume_pressed():
	muted = !muted
	if muted:
		AudioServer.set_bus_mute(0, true)
		volume.texture_normal = volume_off_icon
	else:
		AudioServer.set_bus_mute(0, false)
		volume.texture_normal = volume_on_icon

func _on_Settings_pressed():
	get_tree().paused = true
	$SettingMenu.visible = true
	SoundManager.bgm.stream_paused = true
	
func _on_SettingMenu_show_pause_menu():
	$PauseMenu.visible = true

func _on_Instruction_pressed():
#	$GameInstruction.show()
	pass


func _on_Retry_mouse_entered():
	$Retry.rect_scale = Vector2(1.2, 1.2)
	$RetryToolTip.show()

func _on_Retry_mouse_exited():
	$Retry.rect_scale = Vector2(1, 1)
	$RetryToolTip.hide()

func _on_Settings_mouse_entered():
	$Settings.rect_scale = Vector2(1.2, 1.2)
	$SettingsToolTip.show()

func _on_Settings_mouse_exited():
	$Settings.rect_scale = Vector2(1, 1)
	$SettingsToolTip.hide()
	
func _on_Volume_mouse_entered():
	$Volume.rect_scale = Vector2(1.2, 1.2)
	$VolumeToolTip.show()

func _on_Volume_mouse_exited():
	$Volume.rect_scale = Vector2(1, 1)
	$VolumeToolTip.hide()

func _on_Instruction_mouse_entered():
	$Instruction.rect_scale = Vector2(1.2, 1.2)
	$GameInstruction.show()
#	$IntructionToolTip.show()

func _on_Instruction_mouse_exited():
	$Instruction.rect_scale = Vector2(1, 1)
	$GameInstruction.hide()
#	$IntructionToolTip.hide()

