extends CanvasLayer

func resume():
	get_tree().paused = false
	SoundManager.bgm.stream_paused = false

func pause():
	get_tree().paused = true
	SoundManager.bgm.stream_paused = true
	$"%GameInstruction".visible = false

func _process(_delta):
	if Input.is_action_just_pressed("esc") and !get_tree().paused: # 暫停游戲
		self.visible = true
		Input.set_custom_mouse_cursor(Globals.main_cursor, Input.CURSOR_ARROW, Vector2(18, 18))
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused: # 關閉設置菜單或取消暫停
		if $"%SettingMenu".visible == false:
			resume()
			self.visible = false
		else:
			$"%SettingMenu".visible = false
			self.visible = true

func _on_Resume_pressed():
	resume()
	self.visible = false

func _on_Restart_pressed():
	resume()
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _on_Settings_pressed():
	self.visible = false
	$"%SettingMenu".visible = true

func _on_Quit_pressed():
	resume()
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/ui/MainMenu.tscn")
