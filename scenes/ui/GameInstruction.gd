extends CanvasLayer


func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		self.hide()
