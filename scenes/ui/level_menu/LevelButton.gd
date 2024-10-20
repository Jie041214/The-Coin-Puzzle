tool
extends TextureButton

export var level_num: String = "1"
export var locked: bool = true setget _set_locked

signal level_selected

func _ready():
	$Label.text = str(level_num)
	
func _set_locked(value) -> void:
	locked = value
	if locked:
		level_locked()
	else:
		level_unlocked()
		
func level_locked() -> void:
	level_state(true)

func level_unlocked() -> void:
	level_state(false)

func level_state(value: bool) -> void:
	disabled = value

func _on_LevelButton_pressed():
	emit_signal("level_selected", level_num)
