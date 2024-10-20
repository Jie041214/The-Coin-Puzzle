extends Node

onready var bgm = $BGM
onready var click_button = $SFX/ClickButton
onready var click_checkbox = $SFX/ClickCheckbox
onready var level_complete = $SFX/LevelComplete
onready var hit_table = $SFX/HitTable
onready var place_with_colliding = $SFX/PlaceWithColliding
onready var pick_up = $SFX/PickUp

func get_volume() -> float:
	return db2linear(AudioServer.get_bus_volume_db(0))
	
func set_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear2db(value) / 3)

func play_click_button_sound():
	if !click_button.playing:
		click_button.play()

func play_click_checkbox_sound():
	if !click_checkbox.playing:
		click_checkbox.play()

func play_level_complete_sound():
	if !level_complete.playing:
		level_complete.play()

func play_hit_table_sound():
	hit_table.play()

func play_colliding_sound():
	place_with_colliding.play()
	
func play_pick_up():
	place_with_colliding.play()
