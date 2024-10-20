extends CanvasLayer

onready var resolution_button = $"%ResolutionButton"
onready var full_screen_checkbox = $"%FullScreenCheckbox"
onready var master_volume_h_slider = $"%MasterVolumeHSlider"

signal show_pause_menu

func _ready():
	init()
	
func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		self.hide()
	

func _on_BackButton_pressed():
	self.hide()

func init():
	# Resolution
	resolution_button.add_item("1280x720")
	resolution_button.add_item("1536x864")
	resolution_button.add_item("1600x900")
	resolution_button.add_item("1920x1080")
	resolution_button.select(Globals.resolution_index)
	resolution_button.disabled = Globals.is_fullscreen
	
	# Fullscreen
	full_screen_checkbox.pressed = Globals.is_fullscreen
	
	# Audio
	master_volume_h_slider.value = Globals.volume

func _on_MasterVolumeHSlider_value_changed(value):
	SoundManager.set_volume(value)
	if self.visible == true:
		SoundManager.play_click_button_sound()
	Globals.volume = value

func _on_ResolutionButton_item_selected(index):
	match index:
		0:
			OS.window_size = Vector2(1280, 720)
		1:
			OS.window_size = Vector2(1536, 864)
		2:
			OS.window_size = Vector2(1600, 900)
		3:
			OS.window_size = Vector2(1920, 1080)
	SoundManager.play_click_button_sound()
	Globals.resolution_index = index
	OS.center_window()


func _on_CheckBox_toggled(button_pressed):
	SoundManager.play_click_checkbox_sound()
	resolution_button.disabled = button_pressed
	OS.window_fullscreen = button_pressed
	Globals.is_fullscreen = button_pressed

func _on_BackButton_back():
	emit_signal("show_pause_menu")
