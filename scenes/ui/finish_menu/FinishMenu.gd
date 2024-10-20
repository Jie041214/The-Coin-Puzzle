extends CanvasLayer

export var next_level: String

func _ready():
	pass

func _on_HomeButton_pressed():
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/ui/MainMenu.tscn")

func _on_NextLevelButton_pressed():
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().change_scene(next_level)

func _on_RetryButton_pressed():
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _on_HomeButton_mouse_entered():
	$HomeToolTip.show()

func _on_HomeButton_mouse_exited():
	$HomeToolTip.hide()

func _on_NextLevelButton_mouse_entered():
	$NextLevelToolTip.show()

func _on_NextLevelButton_mouse_exited():
	$NextLevelToolTip.hide()

func _on_RetryButton_mouse_entered():
	$RetryToolTip.show()

func _on_RetryButton_mouse_exited():
	$RetryToolTip.hide()
