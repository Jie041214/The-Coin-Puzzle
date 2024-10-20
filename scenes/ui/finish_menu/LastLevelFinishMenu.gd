extends CanvasLayer

func _on_HomeButton_pressed():
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/ui/MainMenu.tscn")

func _on_RetryButton_pressed():
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _on_HomeButton_mouse_entered():
	$HomeToolTip.show()

func _on_HomeButton_mouse_exited():
	$HomeToolTip.hide()

func _on_RetryButton_mouse_entered():
	$RetryToolTip.show()

func _on_RetryButton_mouse_exited():
	$RetryToolTip.hide()
