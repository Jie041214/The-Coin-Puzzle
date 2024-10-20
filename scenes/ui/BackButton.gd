extends TextureButton

signal back


func _on_BackButton_pressed():
	emit_signal("back")
	


func _on_BackButton_mouse_entered():
	self.rect_scale = Vector2(1.2, 1.2)
	$BackToolTip.show()

func _on_BackButton_mouse_exited():
	self.rect_scale = Vector2(1, 1)
	$BackToolTip.hide()
