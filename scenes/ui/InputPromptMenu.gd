extends CanvasLayer


func _ready():
	pass

func _process(_delta):
	if get_tree().paused == true:
		self.visible = false
	else:
		self.visible = true
